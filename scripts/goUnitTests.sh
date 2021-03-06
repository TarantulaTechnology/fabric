#!/bin/bash

set -e

echo -n "Obtaining list of tests to run.."
PKGS=`go list github.com/TarantulaTechnology/fabric/... | grep -v /vendor/ | grep -v /examples/`
echo "DONE!"

echo -n "Starting peer.."
CID=`docker run -dit -p 30303:30303 hyperledger/fabric-peer peer node start`
cleanup() {
    echo "Stopping peer.."
    docker kill $CID 2>&1 > /dev/null
}
trap cleanup 0
echo "DONE!"

echo "Running tests..."
go test -cover -p 1 -timeout=20m $PKGS
