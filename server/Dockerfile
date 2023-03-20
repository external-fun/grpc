FROM golang:1.20.2 AS build
WORKDIR app
COPY . ./
RUN go mod download
RUN go build -o /server ./server.go

FROM golang:1.20.2
WORKDIR /
COPY --from=build /server /server
ENTRYPOINT ["./server"]