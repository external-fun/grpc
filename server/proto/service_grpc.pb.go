// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.2.0
// - protoc             v3.21.12
// source: proto/service.proto

package proto

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.32.0 or later.
const _ = grpc.SupportPackageIsVersion7

// DatabaseExporterClient is the client API for DatabaseExporter service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type DatabaseExporterClient interface {
	UploadRows(ctx context.Context, opts ...grpc.CallOption) (DatabaseExporter_UploadRowsClient, error)
}

type databaseExporterClient struct {
	cc grpc.ClientConnInterface
}

func NewDatabaseExporterClient(cc grpc.ClientConnInterface) DatabaseExporterClient {
	return &databaseExporterClient{cc}
}

func (c *databaseExporterClient) UploadRows(ctx context.Context, opts ...grpc.CallOption) (DatabaseExporter_UploadRowsClient, error) {
	stream, err := c.cc.NewStream(ctx, &DatabaseExporter_ServiceDesc.Streams[0], "/proto.DatabaseExporter/UploadRows", opts...)
	if err != nil {
		return nil, err
	}
	x := &databaseExporterUploadRowsClient{stream}
	return x, nil
}

type DatabaseExporter_UploadRowsClient interface {
	Send(*Row) error
	CloseAndRecv() (*Status, error)
	grpc.ClientStream
}

type databaseExporterUploadRowsClient struct {
	grpc.ClientStream
}

func (x *databaseExporterUploadRowsClient) Send(m *Row) error {
	return x.ClientStream.SendMsg(m)
}

func (x *databaseExporterUploadRowsClient) CloseAndRecv() (*Status, error) {
	if err := x.ClientStream.CloseSend(); err != nil {
		return nil, err
	}
	m := new(Status)
	if err := x.ClientStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

// DatabaseExporterServer is the server API for DatabaseExporter service.
// All implementations must embed UnimplementedDatabaseExporterServer
// for forward compatibility
type DatabaseExporterServer interface {
	UploadRows(DatabaseExporter_UploadRowsServer) error
	mustEmbedUnimplementedDatabaseExporterServer()
}

// UnimplementedDatabaseExporterServer must be embedded to have forward compatible implementations.
type UnimplementedDatabaseExporterServer struct {
}

func (UnimplementedDatabaseExporterServer) UploadRows(DatabaseExporter_UploadRowsServer) error {
	return status.Errorf(codes.Unimplemented, "method UploadRows not implemented")
}
func (UnimplementedDatabaseExporterServer) mustEmbedUnimplementedDatabaseExporterServer() {}

// UnsafeDatabaseExporterServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to DatabaseExporterServer will
// result in compilation errors.
type UnsafeDatabaseExporterServer interface {
	mustEmbedUnimplementedDatabaseExporterServer()
}

func RegisterDatabaseExporterServer(s grpc.ServiceRegistrar, srv DatabaseExporterServer) {
	s.RegisterService(&DatabaseExporter_ServiceDesc, srv)
}

func _DatabaseExporter_UploadRows_Handler(srv interface{}, stream grpc.ServerStream) error {
	return srv.(DatabaseExporterServer).UploadRows(&databaseExporterUploadRowsServer{stream})
}

type DatabaseExporter_UploadRowsServer interface {
	SendAndClose(*Status) error
	Recv() (*Row, error)
	grpc.ServerStream
}

type databaseExporterUploadRowsServer struct {
	grpc.ServerStream
}

func (x *databaseExporterUploadRowsServer) SendAndClose(m *Status) error {
	return x.ServerStream.SendMsg(m)
}

func (x *databaseExporterUploadRowsServer) Recv() (*Row, error) {
	m := new(Row)
	if err := x.ServerStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

// DatabaseExporter_ServiceDesc is the grpc.ServiceDesc for DatabaseExporter service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var DatabaseExporter_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "proto.DatabaseExporter",
	HandlerType: (*DatabaseExporterServer)(nil),
	Methods:     []grpc.MethodDesc{},
	Streams: []grpc.StreamDesc{
		{
			StreamName:    "UploadRows",
			Handler:       _DatabaseExporter_UploadRows_Handler,
			ClientStreams: true,
		},
	},
	Metadata: "proto/service.proto",
}
