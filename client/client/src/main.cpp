#include <service.pb.h>
#include <service.grpc.pb.h>

#include "sqlite3.h"

#include <grpc/grpc.h>
#include <grpcpp/create_channel.h>

#include <cstdlib>
#include <iostream>
#include <thread>
#include <vector>

constexpr const char * CREATE_TABLE_STATEMENT = R"(
  CREATE TABLE IF NOT EXISTS shop (
  id integer primary key,
  clothes_id integer,
  clothes_name varchar(256),
  brand_name varchar(256),
  category_name varchar(256),
  quantity integer,
  size_name varchar(256)
);
)";

struct Row {
  int ClothesId{};
  std::string ClothesName{};
  std::string BrandName{};
  std::string CategoryName{};
  int Quantity{};
  std::string SizeName{};
};

std::vector<Row> ReadDatabase(std::string const & fileName)
{
  sqlite3 *db;
  int err = sqlite3_open(fileName.c_str(), &db);
  if (err != 0) {
    std::cerr << "Couldn't open a database" << std::endl;
  }

  std::vector<Row> rows;
  sqlite3_exec(db, "SELECT * FROM shop", [](void *ctx, int argc, char **argv, char** names) -> int{
    auto * rows = reinterpret_cast<std::vector<Row> *>(ctx);
    Row row{
      .ClothesId = atoi(argv[1]),
      .ClothesName = std::string(argv[2]),
      .BrandName = std::string(argv[3]),
      .CategoryName = std::string(argv[4]),
      .Quantity = atoi(argv[5]),
      .SizeName = std::string(argv[6])
    };
    rows->push_back(row);
    return 0;
  }, &rows, nullptr);

  sqlite3_close(db);
  return rows;
}

int main(int argc, char* argv[])
{
 for (;;) {
  auto rows = ReadDatabase(std::getenv("SQL_PATH"));
  auto channel = grpc::CreateChannel(std::getenv("GRPC_CONNECTION"), grpc::InsecureChannelCredentials());

  auto stub = proto::DatabaseExporter::NewStub(channel);
  grpc::ClientContext context;

  auto CreateRow = [](Row data)
  {
    proto::Row row;
    row.set_clothesid(data.ClothesId);
    row.set_clothesname(data.ClothesName);
    row.set_brandname(data.BrandName);
    row.set_quantity(data.Quantity);
    row.set_categoryname(data.CategoryName);
    row.set_sizename(data.SizeName);
    return row;
  };
  std::cout << "Sending rows N: " << rows.size() << std::endl;

  proto::Status resp;
  auto writer = stub->UploadRows(&context, &resp);
  for (auto const & row : rows) {
    auto res = writer->Write(CreateRow(row));
    if (!res) {
      std::cout << "Something wrong with the stream" << std::endl;
    }
  }
  writer->WritesDone();
  auto status = writer->Finish();
  std::cout << status.error_code() << " " << status.error_message() << " " << status.error_details() << std::endl;

  std::this_thread::sleep_for(std::chrono::seconds(5));
 }

  return 0;
}
