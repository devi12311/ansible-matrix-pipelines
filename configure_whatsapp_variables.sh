printf "Adding whatsapp configuration \n"

echo "matrix_mautrix_whatsapp_enabled: $1" >> ./inventory/host_vars/matrix.chatner.ch/vars.yml
echo "matrix_mautrix_whatsapp_container_image_self_build: $2" >> ./inventory/host_vars/matrix.chatner.ch/vars.yml
echo "matrix_mautrix_whatsapp_container_image_self_build_repo: \"$3\"" >> ./inventory/host_vars/matrix.chatner.ch/vars.yml
echo "matrix_mautrix_whatsapp_container_image_self_build_branch: \"$4\"" >> ./inventory/host_vars/matrix.chatner.ch/vars.yml

printf "DONE!\n"
