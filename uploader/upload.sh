SERVER=http://localhost:8888/v1

curl -X PUT ${SERVER}/accounts/arpit73 \
     -d '{"data": {"password": "s3cr3t"}}' \
     -H 'Content-Type:application/json'

BUCKET=main-workspace # (or just ``main`` in Dev)
COLLECTION=psl
RECORD=`uuidgen`
FILEPATH=/home/arpit/Development/moz/dafsa_gen/attachments/etld_data.inc
BASIC_AUTH=arpit73:s3cr3t


curl -s ${SERVER}/ -u $BASIC_AUTH | jq .user

curl -X POST ${SERVER}/buckets/${BUCKET}/collections/${COLLECTION}/records/${RECORD}/attachment \
     -H 'Content-Type:multipart/form-data' \
     -F attachment=@$FILEPATH \
     -u $BASIC_AUTH




