#!/bin/bash

dropmc () {
  collection_name=$1

  if test -z $collection_name; then
    echo Collection name is required
    return
  fi

  curl --request POST \
    --url "$MILVUS_ENDPOINT/v2/vectordb/collections/drop" \
    --header "Authorization: Bearer root:$MILVUS_ROOT_PASSWORD" \
    --header "Content-Type: application/json" \
    -d "{
       \"dbName\": \"test\",
       \"collectionName\": \"$1\"
    }" -s | json_pp
}

describemc () {
  collection_name=$1

  if test -z $collection_name; then
    echo Collection name is required
    return
  fi

  curl --request POST \
    --url "$MILVUS_ENDPOINT/v2/vectordb/collections/describe" \
    --header "Authorization: Bearer root:$MILVUS_ROOT_PASSWORD" \
    --header "Content-Type: application/json" \
    -d "{
       \"dbName\": \"test\",
       \"collectionName\": \"$1\"
    }" -s | json_pp
}
