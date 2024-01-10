#!/bin/bash

# Hosts file location
HOSTS_FILE_PATH="/etc/hosts"

# IP address for host
IP="127.0.0.1"

# Hostname to add
HOST_NAME="local.mycorp.app"

# Line that would be added to the hosts file
HOST_LINE="$IP\t$HOST_NAME"


# Create SSL certificate if doesn't exist
if  [[ ! -e ./local.mycorp.app-key.pem ]] && [[ ! -e ./local.mycorp.app.pem ]];
  then
    if [[ "$OSTYPE" == "darwin"* ]]; 
      then
        brew instal mkcert nss;

    elif [[ "$OSTYPE" == "linux-gnu"* ]]; 
      then
        sudo apt update && sudo apt install libnss3-tools mkcert --fix-missing;
        
    elif [[ "$OSTYPE" == "darwin"* ]]; 
      then
        brew instal mkcert nss;

    elif [[ "$OSTYPE" == "msys" ]]; 
      then
        choco install mkcert;
    
    elif [[ "$OSTYPE" == "win32" ]];
      then
        choco install mkcert;
    fi

    mkcert -install;
    mkcert local.mycorp.app;
fi

if [ -n "$(grep $HOST_NAME $HOSTS_FILE_PATH)" ]
  then
    echo "$HOST_NAME already exists"
else
  echo "Adding $HOST_NAME to $HOSTS_FILE_PATH...";
  sudo -- sh -c -e "echo '$HOST_LINE' >> $HOSTS_FILE_PATH";

  if [ -n "$(grep $HOST_NAME $HOSTS_FILE_PATH)" ]
    then
      echo "$HOST_NAME was added succesfully:";
      echo "$(grep $HOST_NAME $HOSTS_FILE_PATH)";
  else
      echo "Failed to add $HOST_NAME";
      exit 111;
  fi
fi
