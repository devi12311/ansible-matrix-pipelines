#!/bin/bash
printf "Initializing main files configuration...\n\n"

printf "Creating file------hosts------into inventory\n"
touch ./inventory/hosts
printf "DONE!\n"

printf "Write the main configurations into the file\n"

echo "[matrix_servers]" >> ./inventory/hosts
echo "$1 ansible_host=$2 ansible_ssh_user=$3 ansible_ssh_pass=$4" >> ./inventory/hosts
printf "DONE!\n"

printf "Creating chatner directory inside host_vars\n"
mkdir ./inventory/host_vars/matrix.chatner.app
printf "DONE!\n"


printf "Creating vars.yml inside matrix.chatner.ch folder \n"
touch ./inventory/host_vars/matrix.chatner.app/vars.yml
printf "DONE!\n"


