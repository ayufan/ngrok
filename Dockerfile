FROM alpine:edge

COPY . /go/src/ngrok
WORKDIR /go/src/ngrok

ENV TLS_KEY=**None** \
    TLS_CERT=**None** \
    CA_CERT=**None** \
    DOMAIN=**None** \
    TUNNEL_ADDR=:4443 \
    HTTP_ADDR=:80 \
    HTTPS_ADDR=:443 \
    AUTHTOKEN= \

ENTRYPOINT ["/go/src/ngrok/entrypoint.sh"]

CMD ["ngrokd", \
    "-tlsKey=/server.key", "-tlsCrt=/server.crt", \
    "-domain=${DOMAIN}", \
    "-httpAddr=${HTTP_ADDR}", \
    "-httpsAddr=${HTTPS_ADDR}", \
    "-tunnelAddr=${TUNNEL_ADDR}", \
    "-authtoken=${AUTHTOKEN}"]
