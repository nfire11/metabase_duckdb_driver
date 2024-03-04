#!/bin/bash
cd $(dirname $0) 
DRIVER_PATH=$(pwd)

cd ../metabase

clojure \
  -Sdeps '{ :aliases {:duckdb { :extra-deps {org.duckdb/duckdb_jdbc {:mvn/version "0.10.0"}} com.metabase/duckdb-driver {:local/root "'${DRIVER_PATH}'"} {metabase/metabase-core {:local/root "../metabase"}
                metabase/build-drivers {:local/root "../metabase/bin/build-drivers"}} }}}'  \
  -X:build:duckdb \
  build-drivers.build-driver/build-driver! \
  "{:driver :duckdb, :project-dir \"${DRIVER_PATH}\", :target-dir \"${DRIVER_PATH}/target\"}"
 
cd "${DRIVER_PATH}"
