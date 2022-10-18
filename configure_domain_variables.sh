printf "Adding admin and proxy configuration \n"

echo "matrix_domain: $1" >> ./inventory/host_vars/matrix.chatner.app/vars.yml
echo "matrix_homeserver_implementation: $2" >> ./inventory/host_vars/matrix.chatner.app/vars.yml
echo "matrix_homeserver_generic_secret_key: \"$3\"" >> ./inventory/host_vars/matrix.chatner.app/vars.yml
echo "matrix_ssl_lets_encrypt_support_email: \"$4\"" >> ./inventory/host_vars/matrix.chatner.app/vars.yml

printf "DONE! \n"
