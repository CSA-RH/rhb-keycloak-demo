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
Realms configuration are located in the associated Keycloak backend database. It's possible to manage realms either by performing backup and restore on the target database or by exporting and importing realm configuration with the by Keycloak provided took kc.sh. 

## Import and Export realms from OpenShift with CLI and Web tools
As an example, the following job uses the kc.sh tool for exporting a realm with users and storing it in a file in at `/tmp/export-with-users.json` file. A configuration variable `REALM_TO_EXPORT` at container level indicates which realm is the one to export. After the export it sets a mark to be identified in a later step to get the JSON definition of the realm. 

```console
# Define in this variable the realm name to export
export REALM_TO_EXPORT=csa 
cat <<EOF | oc apply -f -
kind: Job
apiVersion: batch/v1
metadata:
  generateName: cat-realm-users-exporter-  
  namespace: keycloak-operator  
spec:
  parallelism: 1
  completions: 1
  backoffLimit: 6  
  template:
    metadata:
      labels:        
        test: keycloak-realm-exporter-v2
    spec:
      volumes:
        - name: keycloak-tls-certificates
          secret:
            secretName: general-tls-secret
            defaultMode: 420
            optional: false        
      containers:
        - resources:
            limits:
              memory: 2Gi
            requests:
              memory: 1700Mi
          name: keycloak
          command:
            - /bin/bash
          env:
            - name: KC_HOSTNAME
              value: oauth-keycloak-operator.apps.rosa.rosa-csa-02.vwa4.p3.openshiftapps.com
            - name: KC_HTTP_PORT
              value: '8080'
            - name: KC_HTTPS_PORT
              value: '8443'
            - name: KC_HTTPS_CERTIFICATE_FILE
              value: /mnt/certificates/tls.crt
            - name: KC_HTTPS_CERTIFICATE_KEY_FILE
              value: /mnt/certificates/tls.key
            - name: KC_DB
              value: postgres
            - name: KC_DB_USERNAME
              valueFrom:
                secretKeyRef:
                  name: keycloak-database-secret
                  key: username
            - name: KC_DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: keycloak-database-secret
                  key: password
            - name: KC_DB_URL_HOST
              value: postgres-db.keycloak-postgres.svc
            - name: KC_PROXY_HEADERS
              value: xforwarded
            - name: KEYCLOAK_ADMIN
              valueFrom:
                secretKeyRef:
                  name: keycloak-server-initial-admin
                  key: username
                  optional: false
            - name: KEYCLOAK_ADMIN_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: keycloak-server-initial-admin
                  key: password
                  optional: false
            - name: KC_TRUSTSTORE_PATHS
              value: '/var/run/secrets/kubernetes.io/serviceaccount/ca.crt,/var/run/secrets/kubernetes.io/serviceaccount/service-ca.crt'
            - name: KC_CACHE
              value: local
            - name: KC_HEALTH_ENABLED
              value: 'false'
            - name: REALM_TO_EXPORT   
              value: ${REALM_TO_EXPORT:-csa}   # <-------------------- THE REALM TO EXPORT 
          ports:
            - name: https
              containerPort: 8443
              protocol: TCP
            - name: http
              containerPort: 8080
              protocol: TCP
          imagePullPolicy: Always
          startupProbe:
            httpGet:
              path: /health/started
              port: 8443
              scheme: HTTPS
            timeoutSeconds: 1
            periodSeconds: 1
            successThreshold: 1
            failureThreshold: 600
          volumeMounts:
            - name: keycloak-tls-certificates
              mountPath: /mnt/certificates
          terminationMessagePolicy: File
          image: 'registry.redhat.io/rhbk/keycloak-rhel9@sha256:af27c26422aa7f56cfa0c615216b84d581932ad99751fe77893fa67b6c2742c2'
          args:
            - '-c'
            - /opt/keycloak/bin/kc.sh --verbose build && /opt/keycloak/bin/kc.sh export --users realm_file --realm \${REALM_TO_EXPORT} --file /tmp/export-with-users.json && echo "%%%%%%%%%%" && cat /tmp/export-with-users.json
      restartPolicy: Never
      terminationGracePeriodSeconds: 30
  completionMode: NonIndexed
  suspend: false
EOF
```

After the previous job finalizes, it would be possible to extract the definition, convert it to a YAML file and integrate it into a KeycloakRealmImporter CRD to be created. 

```console
export OUTPUT_FOLDER=$(date +%Y%m%d%H%M%S)
# Create output folder
echo Creating folder $OUTPUT_FOLDER
mkdir $OUTPUT_FOLDER
# Get realm definition in YAML
echo Extracting Realm Definition from...
export EXPORT_POD=$(oc get pods --sort-by=.metadata.creationTimestamp -oname \
        | grep "cat-realm-users-exporter" \
        | tac \
        | head -1)  
echo ... pod: $EXPORT_POD
oc logs $EXPORT_POD \
    | sed -n '/%%%%%%%%%%/,$p' \
    | tail -n +2  > $OUTPUT_FOLDER/realm-definition.json
echo Transforming Realm JSON definition to YAML
cat $OUTPUT_FOLDER/realm-definition.json \
    | yq -P > $OUTPUT_FOLDER/realm-definition.yaml
# Compose YAML importer 
echo Creating realm importer CRD
export IMPORTER_HEADER_YAML=/tmp/importer-header.yaml
cat <<EOF > $IMPORTER_HEADER_YAML
kind: KeycloakRealmImport
apiVersion: k8s.keycloak.org/v2alpha1
metadata:
  generateName: realm-importer-
  labels:
    app: sso
  namespace: keycloak-operator
spec:
  keycloakCRName: keycloak-server
  realm: {}
EOF
export REALM_YAML_FILE=$OUTPUT_FOLDER/realm-definition.yaml
yq '. | .spec.realm=load(strenv(REALM_YAML_FILE))' $IMPORTER_HEADER_YAML \
    > ./$OUTPUT_FOLDER/realm-importer.yaml
echo Create realm importer in OpenShift
oc apply -f ./$OUTPUT_FOLDER/realm-importer.yaml
```

If a JSON file is already available -for instance, via the Realm Settings export functionality- instead of picking the file from the job, use the file as input for the transformation to YAML and the composition of the importer. For instance (it only shows the YAML file, does not create the CRD) 

```console
export REALM_JSON_FILE=~/Downloads/realm-export.json
export REALM_YAML_FILE=./realm-export-$(date +%Y%m%d%H%M%S).yaml
echo Transforming Realm JSON definition to YAML
cat $REALM_JSON_FILE | yq -P > REALM_YAML_FILE
echo Creating realm importer CRD
export REALM_YAML_FILE=$OUTPUT_FOLDER/realm-definition.yaml
yq '. | .spec.realm=load(strenv(REALM_YAML_FILE))' importer-header.yaml 
```

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

### Deleting the built-in admin

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
