#!/bin/bash
set -o errexit
openssl req -x509 -new -newkey rsa:2048 -out cert.pem -keyout key.pem -days 1825  -nodes -subj "/CN=cyber cyber cyber fake CA" -extensions v3_ca -config cross.cnf

openssl x509 -text -noout -in cert.pem
