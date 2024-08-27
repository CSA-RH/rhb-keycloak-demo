#!/usr/bin/python
import requests # type: ignore
import argparse
import os
import configparser
import urllib3 # type: ignore

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


## Parse arguments
parser = argparse.ArgumentParser(
    prog="kc-api-get.py",     
    description="A sample CLI tool for retrieving realm list, clients, users, client-scopes groups and roles in JSON format from a Keycloak REST API.",
    epilog="Red Hat Customer Success Architects sample code")

parser.add_argument(
    "config", 
    nargs='?',  
    help="Configures the access to the Keycloak API for the client admin-cli")

parser.add_argument(
    "--realm", 
    help="Select the realm",
    required=False)

list_of_resources = ["clients", "client-scopes", "users", "groups", "roles"]
parser.add_argument(
    "--resource", 
    help="Query resource information from realm selected",
    required=False, 
    choices=list_of_resources)
args = parser.parse_args()

if (args.realm and args.resource is None):
    parser.error("--realm option requires --resource.")

if (args.realm is None and args.resource):
    parser.error("--resource requires to set a realm with --realm.")

# Configure the CLI
CONFIG_FILE = "./.config"
config_obj = configparser.ConfigParser()

if os.path.isfile(CONFIG_FILE): 
   with open(CONFIG_FILE, "r") as file_object:
    config_obj.read_file(file_object)
    kc_url=config_obj.get("API", "url")
    client_secret=config_obj.get("API", "client_secret")
else: 
    if args.config is None: 
        print("Run 'kc-api-get.py config' first to configure Keycloak REST API Access.")
        exit(1)

if args.config:
    print("Configure KC API Get samples CLI for the admin-cli client")
    kc_url_input = input("- Keycloak URL[" + kc_url + "]: ")
    if kc_url_input != "": 
        kc_url = kc_url_input
    client_secret_input = input("- Client Secret[" + client_secret + "]: ")
    if client_secret_input != "":
        client_secret = client_secret_input
    config_obj["API"] = {"url": kc_url, "client_secret": client_secret}
    with open(CONFIG_FILE, "w") as file_obj:
        config_obj.write(file_obj)
    exit(0)

# Retrieve Bearer token from requests
headers={"Content-Type":"application/x-www-form-urlencoded"}
data = {
    "grant_type": "client_credentials",
    "client_id": "admin-cli",
    "client_secret": client_secret }

token_url="{}/realms/master/protocol/openid-connect/token".format(kc_url)
response = requests.post(
    url=token_url,
    headers=headers, 
    data=data, 
    verify=False)

# Set the Authorization header to the Bearer token retrieved
access_token=response.json()['access_token']
headers={
    "Content-Type":"application/json", 
    "Authorization": "Bearer {}".format(access_token)}

if args.resource is None:
    query_url = "{}/admin/realms/?briefRepresentation=true".format(kc_url)
else:
    query_url =  "{base_url}/admin/realms/{realm}/{resource}".format(
        base_url=kc_url, 
        realm=args.realm, 
        resource=args.resource)

# Perform the API call
response = requests.get(
    url=query_url, 
    headers = headers, 
    verify=False)

# Print raw respose
print(response.text)