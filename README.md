# Description 
This project serves as a comprehensive demonstration of Keycloak integration, showcasing its deployment and usage across various components. The repository includes the following key features:

- *Keycloak Operator Installation*: Automate the deployment and management of Keycloak within the cluster. It install
- *In-Cluster Postgres Database*: Configure an internal Postgres database to serve as the backend for Keycloak. Not suitable for production usage. It uses transient storage for demo purposes. 
- *Keycloak server installation*. Ingress Controller with General Certificate: Utilize the default ingress controller's certificate to secure Keycloak's passthrough route.
ReactJS Application Integration: Demonstrate the usage of a ReactJS application authenticated via the CSA realm and webauth client.
- *Realm Management Scripts*: Includes scripts for importing and exporting Keycloak realms using the Operator CRD and OpenShift resources.
- *Database Backup & Restore*: Provides scripts to facilitate the backup and restoration of the Postgres database associated with Keycloak.

More information about the installation files in the [README](install/README.md) file of the install folder in this repository. 

# Keycloak operator installation

From the terminal -or just copying the YAML between `cat` and `EOF` and creating them OpenShift Web Console- issue the following command:

```console
cat <<EOF | oc apply -f - 
apiVersion: v1
kind: Namespace
metadata:
  name: keycloak-operator
spec: {}
---
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
  annotations:
    olm.providedAPIs: Keycloak.v2alpha1.k8s.keycloak.org,KeycloakRealmImport.v2alpha1.k8s.keycloak.org
  generation: 1
  name: keycloak-operator-group
  namespace: keycloak-operator
spec:
  targetNamespaces:
  - keycloak-operator
---
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  labels:
    operators.coreos.com/rhbk-operator.keycloak: ""
  name: rhbk-operator
  namespace: keycloak-operator
spec:
  channel: stable-v24
  installPlanApproval: Automatic
  name: rhbk-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace
  startingCSV: rhbk-operator.v24.0.6-opr.1
EOF
```
# In-Cluster Postgres Database
Just for demo purposes. Not suitable for production. The following definitions creates a StatefulSet hosting a PostgreSQL database:

```console
cat <<EOF | oc create -f -
apiVersion: v1
kind: Namespace
metadata:
  name: keycloak-postgres
spec: {}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgresql-db
  namespace: keycloak-postgres
spec:
  serviceName: postgresql-db-service
  selector:
    matchLabels:
      app: postgresql-db
  replicas: 1
  template:
    metadata:
      labels:
        app: postgresql-db
    spec:
      containers:
        - name: postgresql-db
          image: postgres:15
          volumeMounts:
            - mountPath: /data
              name: cache-volume
          env:
            - name: POSTGRES_USER
              value: testuser
            - name: POSTGRES_PASSWORD
              value: testpassword
            - name: PGDATA
              value: /data/pgdata
            - name: POSTGRES_DB
              value: keycloak
      volumes:
        - name: cache-volume
          emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: postgres-db
  namespace: keycloak-postgres
spec:
  selector:
    app: postgresql-db
  type: ClusterIP
  ports:
  - port: 5432
    targetPort: 5432
EOF
```

# Keycloak server installation
The keycloak server will be deployed at the  address `https://oauth-${PROJECT_NAME}${WILDCARD_ADDRESS}` where `PROJECT_NAME` is the `keycloak-operator` namespace and `WILDCARD_ADDRESS` is the suffix for the default route addresses (At `openshiftapps.com` in ROSA clusters). The TLS certificate is extracted form the `default-ingress-cert` secret located in the namespace `openshift-ingress`. This certificate contains as Subject Alternative Name the wildcard address for the default routes, therefore Keycloak will be able to decrypt the traffic signed with the public certificate at the SSL layer. Credentials for DB access -created in a previous step- are provided and stored into the secret `keycloak-database-secret`. 

```console
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
```

For using the Wildcard certificate signed with a public CA, we could use instead: 

```console
  echo "*** Get the TLS certificate from HAProxy router"
  oc get -oyaml \
    -n openshift-ingress \
    $(oc get secret -n openshift-ingress -oNAME | grep primary-cert-bundle) \
    | yq eval '.metadata.name=env(SECRET_NAME) 
      | del(.metadata.namespace) 
      | del(.metadata.uid) 
      | del(.metadata.resourceVersion) 
      | del(.metadata.creationTimestamp)' - > ${TMP_TLS_CERT_YAML}
```

For waiting until the Keycloak Server is up and running we can run the command: 

```console
oc wait \
    -n keycloak-operator \
    --for=condition=ready \
    --timeout=300s \
    keycloak keycloak-server
```

# ReactJS Application Integration
By the usage of `keycloak-js` npm package, the ReactJS based application can be authenticated against the oauth endpoint raised in previous steps. The configuration of the realm is located in the App.js file: 

```js
let initOptions = {
  url: OAUTH_ENDPOINT,
  realm: 'csa',
  clientId: 'webauth',
  onLoad: 'check-sso', // check-sso | login-required
  KeycloakResponseType: 'code',
  // silentCheckSsoRedirectUri: (window.location.origin + "/silent-check-sso.html")
}
```
To install the client, please refer to the folder [keycloak-client](install/keycloak-client). 


# Realm Management
Realms configuration are located in the associated Keycloak backend database. It's possible to manage realms either by performing backup and restore on the target database or by exporting and importing realm configuration with the by Keycloak provided took kc.sh or even partially exporting realm definitions from the Keycloak GUI. 

## Import and Export realms from OpenShift with CLI and Web tools
For importing a Realm into a Keycloak instance in OpenShift, the CRD `KeycloakRealmImport` installed by the RHBK operator can be used. The only steps to perform is to put the realm definition in the .spec.realm key of the CRD. In this example, it's shown how to retrieve a realm definition json file from a Job in a similar way that the CRD `KeycloakRealmImport`does and how to import by using the same CRD. 

For exporting a realm definition with users, the following job uses the kc.sh tool and stores it in a file in at `/tmp/export-with-users.json` within the container. A configuration variable `REALM_TO_EXPORT` at container level indicates which realm is the one to export. After the export is done, the whole realm definition is dumped in the container stdout after a mark, which will be identified in a later step to get the JSON definition of the realm. 

In the [realm-mgmt-cli](realm-mgmt-cli) folder there are scripts to export and import from an OpenShift cluster:

- Export: `./export.sh <realm-name>`. The realm must exists and a valid session must be available with the `oc` tool.
- Import: `./import.sh <realm-definition-file.json>`. A valid session must be available with the `oc` tool.


## Database Backup and Restore steps

In this example, the database is located in a pod with transient storage, therefore, everything get lost after restart, which it's useful for demo purposes but obviously not intended for production scenarios. 

By using `pg_dump` and `psql` it would be possible to backup and restore the database and all associated Keycloak configuration. 

For backing-up the data.

```console
oc exec -n keycloak-postgres postgresql-db-0 \
    -- pg_dump -U testuser -d keycloak > keycloak-backup.sql
```

For restoring the data:

```console
oc exec -n keycloak-postgres postgresql-db-0 -i \
    -- psql -U testuser keycloak < keycloak-backup.sql
```

### Recreate the built-in admin with the default initial password

1. Scale down the pods by setting `'instances: 0'` in the `Keycloak` CR.

2. Database queries:

   For checking the admin user:
  
   ```sql
   SELECT id,username FROM user_entity WHERE username='admin';
   ``` 

   Delete associated credentials:

   ```sql
   DELETE FROM credential WHERE user_id IN (
       SELECT id,username FROM user_entity WHERE username='admin');
   ```

   Delete associated role mappings: 

   ```sql
   DELETE FROM user_role_mapping WHERE user_id IN (
      SELECT id,username FROM user_entity WHERE username='admin');
   ```

   Delete User: 
   
   ```sql
   DELETE FROM user_entity WHERE id IN (
       SELECT id,username FROM user_entity WHERE username='admin');
   ```

3. Scale it back up by setting `'instances: X'` in the `Keycloak` CR. Optionally after the pod is `"Ready (1/1)"` scale it up to the desired amount of instances if more than one.
