printf "Adding admin and proxy configuration \n"

echo "matrix_nginx_proxy_base_domain_serving_enabled: $1" >> ./inventory/host_vars/matrix.chatnerservices.ch/vars.yml
echo "matrix_synapse_admin_enabled: $2" >> ./inventory/host_vars/matrix.chatnerservices.ch/vars.yml
echo "matrix_synapse_ext_password_provider_shared_secret_auth_enabled: $3" >> ./inventory/host_vars/matrix.chatnerservices.ch/vars.yml
echo "matrix_synapse_ext_password_provider_shared_secret_auth_shared_secret: $4" >> ./inventory/host_vars/matrix.chatnerservices.ch/vars.yml

printf "DONE!\n"
