#!/usr/bin/env bash

NAME="mssql-secret"
PASSWORD=""
DESIREDPASSWORDLENGTH=8

# colors
RED='\033[0;31m'
NC='\033[0m' # no color

# create secret for database access
GET_PASSWORD() {
  echo -e "\n Enter a password (Length > $DESIREDPASSWORDLENGTH, UPPERCASE, lowercase): "

  read -r PASSWORD

  if [[ ${#PASSWORD} -le DESIREDPASSWORDLENGTH ]]; then
    echo -e "${RED}\n Password is less than DESIREDPASSWORDLENGTH characters${NC}"

    GET_PASSWORD
  elif [[ ! $PASSWORD =~ [^a-zA-Z0-9] ]]; then
    echo -e "${RED}\n Password must contain UPPERCASE, lowercase letters, base-10 digits and/or non-alphanumeric symbols${NC}"

    GET_PASSWORD
  fi
}

GET_PASSWORD

# delete any secrets file with the same name
if kubectl delete secrets $NAME; then
  echo -e "\n Secret Successfully Deleted"
else
  echo -e "${RED}\n Secret Does Not Exist${NC}"
fi

# create secret
if kubectl create secret generic $NAME --from-literal=SA_PASSWORD="${PASSWORD}"; then
  echo -e "\n Secret Successfully Created \n"

  echo -e "\n Name of secret: $NAME \n"

  kubectl get secrets
else
  echo -e "${RED}\n Failed \n${NC}"
fi

# restart database deployment
kubectl rollout restart deployment mssql-deployment
