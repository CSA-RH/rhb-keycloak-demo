# Get the realm definition to import
export REALM_FILE_TO_IMPORT=$1
if [ -z ${REALM_FILE_TO_IMPORT} ]; then 
    echo No realm file definition has been provided. Example usage:
    echo " import.sh realm-file.json"
    exit 1
else 
    echo "Realm file $REALM_FILE_TO_IMPORT to import"
fi
export OUTPUT_FOLDER=./output/import-$(date +%Y%m%d%H%M%S)
# Create output folder
echo Creating folder $OUTPUT_FOLDER
mkdir -p $OUTPUT_FOLDER
echo Transforming Realm JSON definition to YAML
cat $REALM_FILE_TO_IMPORT \
    | yq -P > $OUTPUT_FOLDER/realm-definition.yaml
# Compose YAML importer 
echo Creating realm importer CRD
export REALM_YAML_FILE=$OUTPUT_FOLDER/realm-definition.yaml
yq '. | .spec.realm=load(strenv(REALM_YAML_FILE))' importer-header.yaml \
    > ./$OUTPUT_FOLDER/realm-importer.yaml
echo Create realm importer in OpenShift
oc create -f ./$OUTPUT_FOLDER/realm-importer.yaml