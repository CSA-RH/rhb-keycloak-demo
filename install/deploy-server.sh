# Deploy database 
echo Creating KC postgres database Openshift resources
oc apply -f keycloak-postgres.yaml
# Import CSA realm and wait for completion
oc exec -n keycloak-postgres postgresql-db-0 -i \
    -- psql -U testuser keycloak < .data/keycloak-backup.sql
# Deploy operator 
echo Creating KC operator
oc apply -f keycloak-operator.yaml
# Deploy keycloak service and wait for completion
./keycloak-server.sh
echo "Waiting for the server to initialize..."
oc wait \
    -n keycloak-operator \
    --for=condition=ready \
    --timeout=300s \
    keycloak keycloak-server
# Create client
cd keycloak-client
./deploy.sh
cd ..
## Perform a backup 
# oc exec -n keycloak-postgres postgresql-db-0 -- pg_dump -U testuser -d keycloak > keycloak-backup.sql
## Restore backup from local file
# oc exec -n keycloak-postgres postgresql-db-0 -i -- psql -U testuser keycloak < keycloak-backup.sql
