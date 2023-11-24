#!/bin/sh
# Root CA
openssl genrsa -out root-ca.key 2048
openssl req -new -x509 -sha256 -key root-ca.key -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=root" -out root-ca.pem -days 730
# Admin cert
openssl genrsa -out admin-c1-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in admin-c1-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out admin.key
openssl req -new -key admin.key -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=A" -out admin-c1.csr
openssl x509 -req -in admin-c1.csr -CA root-ca.pem -CAkey root-ca.key -CAcreateserial -sha256 -out admin.pem -days 730
# Node cert 1
openssl genrsa -out node1-c1-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in node1-c1-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out node1.key
openssl req -new -key node1.key -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=opensearch-node1" -out node1-c1.csr
echo 'subjectAltName=DNS:opensearch-node1' > node1-c1.ext
openssl x509 -req -in node1-c1.csr -CA root-ca.pem -CAkey root-ca.key -CAcreateserial -sha256 -out node1.pem -days 730 -extfile node1-c1.ext
# Node cert 2
openssl genrsa -out node2-c1-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in node2-c1-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out node2.key
openssl req -new -key node2.key -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=opensearch-node2" -out node2-c1.csr
echo 'subjectAltName=DNS:opensearch-node2' > node2-c1.ext
openssl x509 -req -in node2-c1.csr -CA root-ca.pem -CAkey root-ca.key -CAcreateserial -sha256 -out node2.pem -days 730 -extfile node2-c1.ext
# Node3 cert
openssl genrsa -out node3-c1-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in node3-c1-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out node3.key
openssl req -new -key node3.key -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=opensearch-node3" -out node3-c1.csr
echo 'subjectAltName=DNS:opensearch-node3' > node3-c1.ext
openssl x509 -req -in node3-c1.csr -CA root-ca.pem -CAkey root-ca.key -CAcreateserial -sha256 -out node3.pem -days 730 -extfile node3-c1.ext

# rnode1 cert
openssl genrsa -out rnode1-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in rnode1-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out rnode1.key
openssl req -new -key rnode1.key -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=opensearch-rnode1" -out rnode1.csr
echo 'subjectAltName=DNS:opensearch-rnode1' > rnode1.ext
openssl x509 -req -in rnode1.csr -CA root-ca.pem -CAkey root-ca.key -CAcreateserial -sha256 -out rnode1.pem -days 730 -extfile rnode1.ext


# Cleanup
rm admin-c1-key-temp.pem
rm admin-c1.csr
rm node1-c1-key-temp.pem
rm node1-c1.csr
rm node1-c1.ext
rm node2-c1-key-temp.pem
rm node2-c1.csr
rm node2-c1.ext
rm node3-c1-key-temp.pem
rm node3-c1.csr
rm node3-c1.ext
rm rnode1-key-temp.pem
rm rnode1.csr
rm rnode1.ext
