# TEST: Check with certificate signed by OpenShift PrivateCA
export PROJECT_NAME=keycloak-operator
oc project $PROJECT_NAME
export TLS_SECRET_NAME=general-tls-secret
export TLS_SECRET_EXISTS=$(oc get secret ${TLS_SECRET_NAME} --ignore-not-found | wc -l)
export TMP_TLS_CERT_YAML=/tmp/cluster-cert.yaml
export TMP_TLS_CERT_CRT=/tmp/cluster-cert.crt
if [ $TLS_SECRET_EXISTS -eq 0 ]; then
  echo "*** Get the TLS certificate from HAProxy router"
  oc get -oyaml \
    -n openshift-ingress \
    secret/default-ingress-cert  \
    | yq eval '.metadata.name=env(TLS_SECRET_NAME) 
      | del(.metadata.namespace) 
      | del(.metadata.uid) 
      | del(.metadata.resourceVersion) 
      | del(.metadata.creationTimestamp)' - > ${TMP_TLS_CERT_YAML}
  oc apply -f ${TMP_TLS_CERT_YAML}
  cat ${TMP_TLS_CERT_YAML} \
  | yq eval '.data."tls.crt"' \
  | base64 -d > $TMP_TLS_CERT_CRT
  rm ${TMP_TLS_CERT_YAML}
else
  echo "*** Get the TLS certificate from the existing secret"
  oc get secret $TLS_SECRET_NAME \
    -ojsonpath='{.data.tls\.crt}'  \
    | base64 -d >  ${TMP_TLS_CERT_CRT}
fi
echo "*** Get the wildcard address form the general cert"
export WILDCARD_ADDRESS=$(openssl x509 -in $TMP_TLS_CERT_CRT -noout -ext subjectAltName \
  | grep DNS \
  | cut -d ':' -f 2)
rm ${TMP_TLS_CERT_CRT}
export OAUTH_ENDPOINT=oauth-${PROJECT_NAME}${WILDCARD_ADDRESS//\*}
echo "    OAUTH_ENDPOINT=${OAUTH_ENDPOINT}"
export DB_SECRET_NAME=keycloak-database-secret
export DB_SECRET_EXISTS=$(oc get secret ${DB_SECRET_NAME} --ignore-not-found | wc -l)
echo "*** Create the PG database secret"
if [ $TLS_SECRET_EXISTS -eq 0 ]; then
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
else
  echo "    Secret already present"
fi
export KEYCLOAK_NAME=keycloak-server
export KEYCLOAK_EXISTS=$(oc get keycloak ${KEYCLOAK_NAME} --ignore-not-found | wc -l)
echo "*** Create the Keycloak server"
if [ $TLS_SECRET_EXISTS -eq 0 ]; then  
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
else
  echo "    Server already present"
fi