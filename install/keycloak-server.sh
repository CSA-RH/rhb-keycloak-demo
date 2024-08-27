# --- Set the OpenShift project --- 
PROJECT_NAME=keycloak-operator
oc project $PROJECT_NAME

# --- Create private CA ---
## Regenerate output folder
rm -rf ./output
mkdir output

PRIVATE_CA_KEY=./output/privateCA.key
PRIVATE_CA_PEM=./output/privateCA.pem
## Create Private CA key
openssl genrsa -out ${PRIVATE_CA_KEY} 2048 
## Create Private CA Root Certificate
openssl req -x509 -new -nodes -key ${PRIVATE_CA_KEY} -sha256 -days 1825 -out ${PRIVATE_CA_PEM} \
    -subj "/C=ES/ST=Caribe/L=Macondo/O=ACME/OU=CSA/CN=PrivateCA for custom Certificates (Keycloak Demo)"

# --- Create Keycloak route certificate --- 
CERT_KEY=./output/cert.key
CERT_CSR=./output/cert.csr
CERT_CRT=./output/cert.crt

## Create Private Key for Keycloak route certificate
openssl genrsa -out ${CERT_KEY} 2048
## Create CSR 
openssl req -new -key ${CERT_KEY} -out ${CERT_CSR} \
  -subj "/C=ES/ST=Caribe/L=Macondo/O=ACME/OU=CSA/CN=Keycloak Demo certificate"

## Get the TLS certificate from HAProxy router
echo "*** Get the TLS certificate from HAProxy router"
TMP_TLS_CERT_YAML=./output/cluster-cert.yaml
TMP_TLS_CERT_CRT=./output/cluster-cert.crt
oc get -oyaml \
  -n openshift-ingress \
  $(oc get secret -n openshift-ingress -oNAME | grep primary-cert-bundle) \
  | yq - \
  | yq eval '.data."tls.crt"' \
  | base64 -d > $TMP_TLS_CERT_CRT
## Get the wildcard address form the general cert
echo "*** Get the wildcard address form the general cert"
WILDCARD_ADDRESS=$(openssl x509 -in $TMP_TLS_CERT_CRT -noout -ext subjectAltName \
  | grep DNS \
  | cut -d ':' -f 2 \
  | cut -d ',' -f 1)
rm ${TMP_TLS_CERT_CRT}
export OAUTH_ENDPOINT=oauth-${PROJECT_NAME}${WILDCARD_ADDRESS//\*}
echo "    OAUTH_ENDPOINT=${OAUTH_ENDPOINT}"
## Add Keycloak route to the certificate
CERT_EXT_TEMPLATE=./data/cert.ext
CERT_EXT=./output/cert.ext
cp $CERT_EXT_TEMPLATE $CERT_EXT
echo "DNS.1 = $OAUTH_ENDPOINT" >> $CERT_EXT
## Signing the certificate
openssl x509 -req -in ${CERT_CSR} \
  -CA ${PRIVATE_CA_PEM} -CAkey ${PRIVATE_CA_KEY} -CAcreateserial \
  -out ${CERT_CRT} -days 825 -sha256 -extfile ${CERT_EXT}
## Create TLS secret
TLS_SECRET_NAME=keycloak-route-tls-secret
oc create secret tls $TLS_SECRET_NAME \
  --cert=$CERT_CRT \
  --key=$CERT_KEY

# --- Create database secret ---
DB_SECRET_NAME=keycloak-database-secret
echo "*** Create the PG database secret"
cat <<EOF | oc apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: ${DB_SECRET_NAME}
  namespace: ${PROJECT_NAME}
type: Opaque
data:
  password: dGVzdHBhc3N3b3Jk
  username: dGVzdHVzZXI=
EOF

# --- Create keycloak server --- 
KEYCLOAK_NAME=keycloak-server
echo "*** Create the Keycloak server"
cat <<EOF | oc apply -f -
apiVersion: k8s.keycloak.org/v2alpha1
kind: Keycloak
metadata:
  name: ${KEYCLOAK_NAME}
  namespace: ${PROJECT_NAME}
spec:  
  ingress: 
    className: openshift-default
    enabled: true
  instances: 2
  hostname: 
    hostname: ${OAUTH_ENDPOINT}
  http: 
    tlsSecret: ${TLS_SECRET_NAME}
  db:
    vendor: postgres
    host: postgres-db.keycloak-postgres.svc
    usernameSecret:
      name: keycloak-database-secret
      key: username
    passwordSecret:
      name: keycloak-database-secret
      key: password
  proxy:
    headers: xforwarded # double check your reverse proxy sets and overwrites the X-Forwarded-* headers
EOF