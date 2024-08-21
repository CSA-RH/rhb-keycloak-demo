# Realm information

Realm name to be installed by a database dump located in `data` folder: `csa` 

KC initial admin password: `94d2702f5c7b48adb8dcf829e7662585`

# Users in csa realm

`garbanzo` / `test`

`garbanzo1` / `test`

`newgarbanzo` / `testtest`

# Installation instructions

Namespaces `keycloak-operator`, `keycloak-database` and `keycloak-client` must not be present. 

For creating server objects, execute the script `./deploy-server.sh`. It may be necessary to add execution permissions with `chmod +x deploy-server.sh` and `chmod +x delete-server.sh` (For deleting the server objects from the cluster)

For creating client objects, go to keycloack-client and execute the script `deploy.sh`. For deleting `delete.sh`. Similary to server objects, it may be necessary to add execution permissions with `chmod +x deploy.sh` and `chmod +x delete.sh`.