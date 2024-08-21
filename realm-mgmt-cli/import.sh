export OUTPUT_FOLDER=./output/$(date +%Y%m%d%H%M%S)
# Create output folder
echo Creating folder $OUTPUT_FOLDER
mkdir -p $OUTPUT_FOLDER
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
export REALM_YAML_FILE=$OUTPUT_FOLDER/realm-definition.yaml
yq '. | .spec.realm=load(strenv(REALM_YAML_FILE))' importer-header.yaml \
    > ./$OUTPUT_FOLDER/realm-importer.yaml
echo Create realm importer in OpenShift
oc apply -f ./$OUTPUT_FOLDER/realm-importer.yaml