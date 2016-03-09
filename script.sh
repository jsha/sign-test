#!/bin/bash
set -o errexit
set -o xtrace

# Truncate the database. Without this, we get a segfault, not sure why.
> database.txt

openssl req -x509 -new -newkey rsa:2048 -out root.pem -keyout root-key.pem -days 1825  -nodes -subj "/CN=cyber cyber cyber fake CA" -extensions v3_ca -config root.cnf

openssl x509 -text -noout -in root.pem

openssl req -new -newkey rsa:2048 -out cross.csr -keyout cross-key.pem -days 1825  -nodes -subj "/CN=intermediate cy" -extensions v3_ca -config cross.cnf

openssl ca -in cross.csr -out cross.pem -days 1825 -notext -md sha256 -extensions v3_ca -config cross.cnf -name default_ca -batch -subj "/CN=intermediate cy"

openssl x509 -text -noout -in cross.pem

openssl req -new -newkey rsa:2048 -out ee.csr -keyout ee-key.pem -days 1825  -nodes -extensions v3_ca -config ee.cnf -subj "/CN=localhost"
openssl ca -in ee.csr -out ee.pem -days 365 -notext -md sha256  -extensions v3_ca -config ee.cnf -name default_ca -batch

openssl s_server -accept 7443 -www -key ee-key.pem -cert ee.pem

#openssl x509 -text -noout -in cert.pem
