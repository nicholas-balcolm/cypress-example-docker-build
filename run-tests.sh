#!/bin/sh
set -x
docker build -t test-results --target test-results ./e2e/ \
&& container_id=$(docker create test-results echo) \
&& docker cp $container_id:/test-results.tar.gz ./ \
&& docker rm $container_id