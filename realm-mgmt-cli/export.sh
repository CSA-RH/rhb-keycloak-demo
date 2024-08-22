export OUTPUT_FOLDER=./output/export-$(date +%Y%m%d%H%M%S)
# Create output folder
echo Creating folder $OUTPUT_FOLDER
mkdir -p $OUTPUT_FOLDER
# Get realm name to export from parameters
REALM_TO_EXPORT=$1
if [ -z ${REALM_TO_EXPORT} ]; then 
    echo "Default REALM csa to export"
    REALM_TO_EXPORT=csa
else 
    echo "Realm $REALM_TO_EXPORT to export"
fi
EXPORT_JOB_YAML=$OUTPUT_FOLDER/job-export.yaml
cat <<EOF > $EXPORT_JOB_YAML
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
EXPORT_JOB_CREATION_OUTPUT=$(kubectl create -f $EXPORT_JOB_YAML -o json)
EXPORT_JOB_NAME=$(echo "$EXPORT_JOB_CREATION_OUTPUT" | jq -r '.metadata.name')
echo "Waiting the job $EXPORT_JOB_NAME to complete"
oc wait --for=condition=complete --timeout=600s job $EXPORT_JOB_NAME
echo "Extracting Realm definition from the job $EXPORT_JOB_NAME"
oc logs job/$EXPORT_JOB_NAME \
    | sed -n '/%%%%%%%%%%/,$p' \
    | tail -n +2  > $OUTPUT_FOLDER/realm-definition.json
echo "Done"
echo "------------------------------------"
echo "Generated export realm definition at $OUTPUT_FOLDER/realm-definition.json"
echo "------------------------------------"