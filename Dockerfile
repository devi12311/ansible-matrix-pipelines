FROM ubuntu:18.04

ARG ANSIBLE_CORE_VERSION_ARG "2.9.27"
ARG ANSIBLE_LINT "5.4.0"
ENV ANSIBLE_LINT ${ANSIBLE_LINT}
ENV ANSIBLE_CORE ${ANSIBLE_CORE_VERSION_ARG}

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get install -y python3.8 python3.8-dev python3-pip sshpass git openssh-client libhdf5-dev libssl-dev libffi-dev && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN python3.8 -m pip install --upgrade pip cffi && \
    pip install ansible && \
    pip install mitogen==0.2.10 jmespath && \
    pip install --upgrade pywinrm && \
    rm -rf /root/.cache/pip

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

WORKDIR matrix

COPY . matrix

ARG DOMAIN_NAME
ARG REMOTE_SERVER_HOST
ARG REMOTE_SERVER_USER
ARG REMOTE_SERVER_PASSWORD

ARG MATRIX_DOMAIN
ARG MATRIX_HOMESERVER_IMPLEMENTATION
ARG MATRIX_HOMESERVER_GENERIC_SECRET_KEY
ARG MATRIX_SSL_LETS_ENCRYPT_SUPPORT_EMAIL

ARG MATRIX_POSTGRES_ENABLED
ARG MATRIX_SYNAPSE_DATABASE_HOST
ARG MATRIX_SYNAPSE_DATABASE_USER
ARG MATRIX_SYNAPSE_DATABASE_PASSWORD
ARG MATRIX_SYNAPSE_DATABASE_DATABASE

ARG MATRIX_NGINX_PROXY_BASE_DOMAIN_SERVING_ENABLED
ARG MATRIX_SYNAPSE_ADMIN_ENABLED
ARG MATRIX_SYNAPSE_EXT_PASSWORD_PROVIDER_SHARED_SECRET_AUTH_ENABLED
ARG MATRIX_SYNAPSE_EXT_PASSWORD_PROVIDER_SHARED_SECRET_AUTH_SHARED_SECRET

ARG MATRIX_MAUTRIX_WHATSAPP_ENABLED
ARG MATRIX_MAUTRIX_WHATSAPP_CONTAINER_IMAGE_SELF_BUILD
ARG MATRIX_MAUTRIX_WHATSAPP_CONTAINER_IMAGE_SELF_BUILD_REPO
ARG MATRIX_MAUTRIX_WHATSAPP_CONTAINER_IMAGE_SELF_BUILD_BRANCH

RUN chmod +x entrypoint.sh
RUN ./entrypoint.sh $DOMAIN_NAME $REMOTE_SERVER_HOST $REMOTE_SERVER_USER $REMOTE_SERVER_PASSWORD

RUN chmod +x configure_domain_variables.sh
RUN ./configure_domain_variables.sh $MATRIX_DOMAIN $MATRIX_HOMESERVER_IMPLEMENTATION $MATRIX_HOMESERVER_GENERIC_SECRET_KEY $MATRIX_SSL_LETS_ENCRYPT_SUPPORT_EMAIL

RUN chmod +x configure_database_variables.sh
RUN ./configure_database_variables.sh $MATRIX_POSTGRES_ENABLED $MATRIX_SYNAPSE_DATABASE_HOST $MATRIX_SYNAPSE_DATABASE_USER $MATRIX_SYNAPSE_DATABASE_PASSWORD $MATRIX_SYNAPSE_DATABASE_DATABASE

RUN chmod +x configure_proxy_and_admin_variables.sh
RUN ./configure_proxy_and_admin_variables.sh $MATRIX_NGINX_PROXY_BASE_DOMAIN_SERVING_ENABLED $MATRIX_SYNAPSE_ADMIN_ENABLED $MATRIX_SYNAPSE_EXT_PASSWORD_PROVIDER_SHARED_SECRET_AUTH_ENABLED $MATRIX_SYNAPSE_EXT_PASSWORD_PROVIDER_SHARED_SECRET_AUTH_SHARED_SECRET

RUN chmod +x configure_whatsapp_variables.sh
RUN ./configure_whatsapp_variables.sh $MATRIX_MAUTRIX_WHATSAPP_ENABLED $MATRIX_MAUTRIX_WHATSAPP_CONTAINER_IMAGE_SELF_BUILD $MATRIX_MAUTRIX_WHATSAPP_CONTAINER_IMAGE_SELF_BUILD_REPO $MATRIX_MAUTRIX_WHATSAPP_CONTAINER_IMAGE_SELF_BUILD_BRANCH

#CMD ["ansible-playbook --inventory inventory/hosts setup.yml --tags=setup-all"]
#CMD ["ansible-playbook --inventory inventory/hosts setup.yml --tags=start"]
#CMD ["ansible-playbook", "setup.yml", "--inventory","inventory/hosts","--tags=setup-all"]
#CMD ["ansible-playbook", "setup.yml", "--inventory","inventory/hosts","--tags=start"]

