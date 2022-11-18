FROM bitnami/kubectl:1.25.3 as kubectl
FROM alpine:3.14
RUN apk add --no-cache bash && mkdir -p /app
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/
COPY scripts/chaos-monkey-script.sh /app
RUN chmod +x /app/chaos-monkey-script.sh && \
    addgroup --gid 1001 -S monkey-kill && \
    adduser -G monkey-kill --shell /bin/false --disabled-password -H --uid 1001 monkey-kill && \
    chown -R monkey-kill:monkey-kill /app
USER monkey-kill
ENTRYPOINT ["/app/chaos-monkey-script.sh"]