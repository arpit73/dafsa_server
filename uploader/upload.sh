#!/bin/sh
# SERVER=https://kinto.dev.mozaws.net/v1
SERVER=http://3.14.70.33:8888/v1

curl -X PUT ${SERVER}/accounts/arpit73 \
     -d '{"data": {"password": "s3cr3t"}}' \
     -H 'Content-Type:application/json'

BUCKET=main
COLLECTION=public-suffix-list
RECORD=`uuidgen`
FILEPATH=/home/arpit/Development/moz/dafsa_gen/attachments/etld_data.inc
BASIC_AUTH=arpit73:s3cr3t


curl -X PUT ${SERVER}/buckets/${BUCKET} \
     -H 'Content-Type:application/json' \
     -u ${BASIC_AUTH}

curl -X PUT ${SERVER}/buckets/${BUCKET}/collections/${CID} \
     -H 'Content-Type:application/json' \
     -u ${BASIC_AUTH}

curl -s ${SERVER}/ -u $BASIC_AUTH | jq .user

curl -X POST ${SERVER}/buckets/${BUCKET}/collections/${COLLECTION}/records/${RECORD}/attachment \
     -H 'Content-Type:multipart/form-data' \
     -F attachment=@$FILEPATH \
     -u $BASIC_AUTH
