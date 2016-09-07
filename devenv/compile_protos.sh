#!/bin/bash

set -e
set -x

# Compile proto files required by fabric
protoc --go_out=plugins=grpc:$GOPATH/src /usr/include/google/protobuf/timestamp.proto
protoc --go_out=plugins=grpc:$GOPATH/src /usr/include/google/protobuf/empty.proto

# Compile protos in the proto folder
cd $GOPATH/src/github.com/TarantulaTechnology/fabric/protos
protoc --go_out=plugins=grpc:. *.proto


# Compile core protos
cd $GOPATH/src/github.com/TarantulaTechnology/fabric/core/
for f in $(find $GOPATH/src/github.com/TarantulaTechnology/fabric/core/  -name '*.proto'); do
	protoc --proto_path=$GOPATH/src/github.com/TarantulaTechnology/fabric/core/ --go_out=plugins=grpc:. $f
done

# Compile consensus protos
cd $GOPATH/src/github.com/TarantulaTechnology/fabric/consensus/
for f in $(find $GOPATH/src/github.com/TarantulaTechnology/fabric/consensus/  -name '*.proto'); do
	protoc --proto_path=$GOPATH/src/github.com/TarantulaTechnology/fabric/consensus/ --go_out=plugins=grpc:. $f
done

# Compile membership services protos
cd $GOPATH/src/github.com/TarantulaTechnology/fabric/membersrvc/
for f in $(find $GOPATH/src/github.com/TarantulaTechnology/fabric/membersrvc/  -name '*.proto'); do
	protoc --proto_path=$GOPATH/src/github.com/TarantulaTechnology/fabric/membersrvc/ --go_out=plugins=grpc:. $f
done
