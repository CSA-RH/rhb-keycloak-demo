# Create keycloak-client namespace
cat <<EOF | oc apply -f - 
apiVersion: v1
kind: Namespace
metadata:
  name: keycloak-client
spec: {}
EOF
# Create ImageStream for kc-client
cat <<EOF | oc apply -f -
apiVersion: image.openshift.io/v1
kind: ImageStream
metadata:
  name: kc-client
  namespace: keycloak-client
spec:
  lookupPolicy:
    local: true
EOF
# Create BuildConfig for kc-client
cat <<EOF | oc apply -f - 
apiVersion: build.openshift.io/v1
kind: BuildConfig
metadata:
  labels:
    build: kc-client
  name: kc-client
  namespace: keycloak-client
spec:
  output:
    to:
      kind: ImageStreamTag
      name: kc-client:latest
  source:
    binary: {}
    type: Binary
  strategy:
    dockerStrategy: 
      dockerfilePath: Dockerfile
    type: Docker
EOF
# Resources cleanup
rm -rf build node_modules package-lock.json .env
# Configure oauth endpoint for the client
export OAUTH_ENDPOINT=https://$(oc get route --selector app=keycloak -ojsonpath={.items[0].spec.host})
echo REACT_APP_OAUTH_ENDPOINT=${OAUTH_ENDPOINT} > .env
# Remove previous build objects
oc delete build -n keycloak-client --selector build=kc-client > /dev/null 
# Start build for kc-client
oc start-build -n keycloak-client kc-client --from-file .
# Follow the logs until completion 
oc logs -n keycloak-client $(oc get build -n keycloak-client --selector build=kc-client -oNAME) -f 
# Create deployment
oc create deploy -n keycloak-client kc-client --image=kc-client:latest 
# Create service
oc expose -n keycloak-client deploy/kc-client --port 8080
# Create route
cat <<EOF | oc apply -f - 
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  labels:
    app: kc-client
  name: kc-client
  namespace: keycloak-client 
spec:
  port:
    targetPort: 8080
  to:
    kind: Service
    name: kc-client
  tls: 
    termination: edge
EOF