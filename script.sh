#!/bin/bash
set -o errexit
openssl req -x509 -new -newkey rsa:2048 -out root.pem -keyout root-key.pem -days 1825  -nodes -subj "/CN=cyber cyber cyber fake CA" -extensions v3_ca -config root.cnf

openssl x509 -text -noout -in root.pem 

openssl req -new -newkey rsa:2048 -out cross.csr -keyout key.pem -days 1825  -nodes -subj "/CN=cyber cyber cyber fake CA" -extensions v3_ca -config cross.cnf

openssl ca -in cross.csr -out cross.pem -days 1825 -notext -md sha256  -extensions v3_ca -config cross.cnf -name default_ca -batch

#openssl x509 -text -noout -in cert.pem
