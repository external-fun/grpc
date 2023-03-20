FROM gcc:latest as grpc-builder
ENV INSTALL_DIR=/grpc_exec/
ENV PATH="$INSTALL_DIR/bin:$PATH"
RUN apt update && apt install -y cmake protobuf-compiler build-essential autoconf libtool pkg-config
RUN git clone --recurse-submodules -b v1.52.0 --depth 1 --shallow-submodules https://github.com/grpc/grpc
WORKDIR /grpc/
RUN cmake -DgRPC_INSTALL=ON \
	  -DgRPC_BUILD_TESTS=OFF \
	  -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
	  -S . \
	  -B build && \
    cd build && \
    make -j 6 && \
    make install

FROM gcc:latest as deps
RUN apt update && apt install -y libsqlite3-dev sqlite3 cmake protobuf-compiler

FROM deps
COPY --from=grpc-builder /grpc_exec/ /grpc_exec/
COPY . /app
WORKDIR /app
ENV INSTALL_DIR=/grpc_exec/
ENV PATH="$INSTALL_DIR/bin:$PATH"
ENV SQL_PATH=/app/shop.db
RUN cmake --version
RUN cat script.sql | sqlite3 $SQL_PATH
RUN cmake -S . -B build
RUN cd build \
    && make -j6
RUN mv /app/build/client/client /usr/bin/
CMD ["client"]