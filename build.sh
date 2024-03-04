#!/bin/bash
cd $(dirname $0) 
DRIVER_PATH=$(pwd)

cd ../metabase

clojure \
  -Sdeps '{:aliases
 {:build
  {:extra-deps {metabase/metabase-core {:local/root "../metabase"}
                metabase/build-drivers {:local/root "../metabase/bin/build-drivers"}}
   :exec-fn    build-drivers.build-driver/build-driver!
   :exec-args  {:driver      :duckdb
                :project-dir "."
                :target-dir  "./target"}}}}'  \
  -X:build:duckdb \
  build-drivers.build-driver/build-driver! \
  "{:driver :duckdb, :project-dir \"${DRIVER_PATH}\", :target-dir \"${DRIVER_PATH}/target\"}"
 
cd "${DRIVER_PATH}"
