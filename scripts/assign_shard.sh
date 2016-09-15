#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: assign_shard [index] [node] [shard_count]"
  exit 1;
fi

INDEX=$1
NODE=$2
SHARD_COUNT=$3

echo "Routing index $INDEX to node $NODE for $SHARD_COUNT shards";

for i in `seq 1 $SHARD_COUNT`; do
  echo "Moving shard $i";

  curl -XPOST 'https://logs.storj.io:9900/_cluster/reroute' -d "{
      \"commands\": [{
          \"allocate\": {
              \"index\": \"$INDEX\",
              \"shard\": $i,
              \"node\": \"$NODE\",
              \"allow_primary\": 1
          }
      }]
  }"
done
