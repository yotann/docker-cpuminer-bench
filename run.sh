#!/bin/sh

benchmark() {
    echo
    echo
    echo Benchmarking $1
    echo
    shift
    $@ & pid=$!
    sleep 60
    kill $pid
}

benchmark "wildkeccak (https://github.com/cryptozoidberg/cpuminer-multi)" ./cryptozoidberg --benchmark
benchmark "scrypt (https://github.com/pooler/cpuminer)" ./pooler -a scrypt --benchmark
benchmark "sha256d (https://github.com/pooler/cpuminer)" ./pooler -a sha256d --benchmark
benchmark "dcrypt (https://github.com/slimcoin/slimminer)" ./slimcoin --benchmark
