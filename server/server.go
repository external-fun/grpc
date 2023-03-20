package main

import "C"
import (
	"database/sql"
	"fmt"
	"github.com/external-fun/grpc-server/api"
	"log"
	"net/http"
	"os"
	"strings"

	_ "github.com/lib/pq"
)

func main() {
	db, err := sql.Open("postgres", GetConnectionUrl(true))
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	go api.ListenAndServe(":7070", api.NewDatabaseExporterService(db))

	http.HandleFunc("/all", GetAll)
	http.HandleFunc("/clear", ClearAll)
	http.ListenAndServe(":8080", nil)
}

const SELECT_ALL_QUERY = `
SELECT Cl.name, B.name, quantity, C.name, S.name
FROM "Clothes" as Cl
INNER JOIN "Brand" B on B.id = Cl.brand_id
INNER JOIN "Record" R on Cl.id = R.clothes_id
INNER JOIN "Size" S on R.size_id = S.id
INNER JOIN "ClothesAndCategory" CAC on Cl.id = CAC.clothes_id
INNER JOIN "Category" C on CAC.category_id = C.id;
`

const CLEAR_ALL_QUERY = `TRUNCATE public."Size", public."Brand", public."Clothes", public."Size", public."Record", public."ClothesAndCategory", public."Category" CASCADE;`

type Record struct {
	ClothesName  string
	BrandName    string
	Quantity     int
	CategoryName string
	SizeName     string
}

func GetConnectionUrl(isLocal bool) string {
	dbPassword := os.Getenv("DB_PASSWORD")
	dbUser := os.Getenv("DB_USER")
	dbHost := os.Getenv("DB_HOST")

	const URL = "postgres://%s:%s@%s:5432/shop_db?sslmode=disable"

	return fmt.Sprintf(URL, dbUser, dbPassword, dbHost)
}

func ClearAll(w http.ResponseWriter, r *http.Request) {
	db, err := sql.Open("postgres", GetConnectionUrl(true))
	if err != nil {
		log.Println(err)
		w.WriteHeader(200)
		return
	}
	defer db.Close()

	_, err = db.Exec(CLEAR_ALL_QUERY)
	if err != nil {
		log.Println(err)
		w.WriteHeader(200)
		return
	}
}

func GetAll(w http.ResponseWriter, r *http.Request) {
	log.Print("Handling request")

	db, err := sql.Open("postgres", GetConnectionUrl(true))
	if err != nil {
		log.Println("Here, ", err)
		w.WriteHeader(200)
		return
	}
	defer db.Close()

	rows, err := db.Query(SELECT_ALL_QUERY)
	if err != nil {
		log.Println(err)
		w.WriteHeader(200)
		return
	}
	defer rows.Close()

	var records []string
	for rows.Next() {
		record := Record{}
		rows.Scan(&record.ClothesName, &record.BrandName, &record.Quantity, &record.CategoryName, &record.SizeName)

		records = append(records, fmt.Sprint(record))
	}

	log.Print("Ending")
	fmt.Fprintf(w, "%s", strings.Join(records, "\n"))
}
