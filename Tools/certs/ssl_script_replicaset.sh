#!/bin/bash

SUBJ_ROOT="/C=US/ST=NSW/O=MADFATCAT/OU=MADCAT/CN=root";
SUBJ_CLIENT="/C=US/ST=NSW/O=MADFATCAT/OU=MADCAT/CN=client1";

echo "Generating SSL ..."
# root certificate
openssl genrsa -out rootCA.key 2048;
openssl req -x509 -new -nodes -key rootCA.key -days 365 -out rootCA.crt -subj "$SUBJ_ROOT";

# server certs
for i in `seq 1 3`;
do
	echo "Generating server cert ${i} ..."
    FILE_SERV="server${i}";
    HOSTNAME=$(hostname -f);
#	SUBJ_SERV="/C=US/ST=NSW/O=MADFATCAT/CN=${FILE_SERV}/CN=${HOSTNAME}";
	SUBJ_SERV="/C=US/ST=NSW/O=MADFATCAT/OU=MADCAT/CN=${FILE_SERV}";
	openssl genrsa -out ${FILE_SERV}.key 2048;
	openssl req -new -key ${FILE_SERV}.key -out $FILE_SERV.csr -subj "$SUBJ_SERV" ;
#    openssl x509 -req -in ${FILE_SERV}.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out ${FILE_SERV}.crt -days 365; 
    openssl x509 -req -in ${FILE_SERV}.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out ${FILE_SERV}.crt -days 365 -extfile <(printf "subjectAltName=DNS:${FILE_SERV}"); 
#    openssl x509 -req -in ${FILE_SERV}.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out ${FILE_SERV}.crt -days 365 -extfile <(printf "extendedKeyUsage=clientAuth,serverAuth\nsubjectAltName=DNS:${FILE_SERV}"); 
	cat ${FILE_SERV}.key ${FILE_SERV}.crt > ${FILE_SERV}.pem;
	openssl verify -CAfile rootCA.crt ${FILE_SERV}.pem;
done; 


# client certs
echo "Generating client cert ..."
openssl genrsa -out client.key 2048;
openssl req -new -key client.key -out client.csr -subj "$SUBJ_CLIENT";
openssl x509 -req -in client.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out client.crt -days 365 -extfile <(printf "keyUsage = digitalSignature\nextendedKeyUsage = clientAuth");
cat client.key client.crt > client.pem;
openssl verify -CAfile rootCA.crt client.pem;
echo "Done."
