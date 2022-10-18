printf "Adding database configuration \n"

echo "matrix_postgres_enabled: $1" >> ./inventory/host_vars/matrix.chatner.app/vars.yml
echo "matrix_synapse_database_host: \"$2\"" >> ./inventory/host_vars/matrix.chatner.app/vars.yml
echo "matrix_synapse_database_user: \"$3\"" >> ./inventory/host_vars/matrix.chatner.app/vars.yml
echo "matrix_synapse_database_password: \"$4\"" >> ./inventory/host_vars/matrix.chatner.app/vars.yml
echo "matrix_synapse_database_database: \"$5\"" >> ./inventory/host_vars/matrix.chatner.app/vars.yml

printf "DONE! \n"
