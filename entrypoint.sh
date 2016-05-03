#!/bin/sh

set -e

if [ "${CA_CERT}" == "**None**" ]; then
    echo "Please specify CA_CERT"
    exit 1
fi

if [ "${TLS_KEY}" == "**None**" ]; then
    echo "Please specify TLS_KEY"
    exit 1
fi

if [ "${TLS_CERT}" == "**None**" ]; then
    echo "Please specify TLS_CERT"
    exit 1
fi

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please specify DOMAIN"
    exit 1
fi

echo -e "${CA_CERT}" > assets/client/tls/ngrokroot.crt
echo -e "${TLS_KEY}" > /server.key
echo -e "${TLS_CERT}" > /server.crt

export PATH="$PWD/bin:$PATH"

if [ ! -x bin/ngrokd ]; then
    make release-server release-client-cross
fi

cat > /root/.ngrok <<EOF
server_addr: ${TUNNEL_ADDR}
EOF

exec "$@"
