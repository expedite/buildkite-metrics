#!/bin/bash
set -eu

go_pkg="github.com/buildkite/buildkite-metrics"
go_src_dir="/go/src/${go_pkg}"
version=$(awk -F\" '/const Version/ {print $2}' version/version.go)
dist_file="dist/buildkite-metrics-v${version}-lambda.zip"

docker run --rm -v "${PWD}:${go_src_dir}" -w "${go_src_dir}" eawsy/aws-lambda-go
mkdir -p dist/
mv handler.zip "$dist_file"

buildkite-agent artifact upload "$dist_file"
