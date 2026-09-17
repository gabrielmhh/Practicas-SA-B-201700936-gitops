#!/bin/sh
apk add --no-cache curl tar
curl -L https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.27.1/kubeseal-0.27.1-linux-amd64.tar.gz -o kubeseal.tar.gz
tar -xzf kubeseal.tar.gz
install -m 755 kubeseal /usr/local/bin/kubeseal

for svc in auth-service account-service notification-service transaction-service; do
  if [ -f /workspace/deploy/\/templates/secret.yaml ]; then
    # Sanitize templating and create static secret
    sed -e "s/{{ include \".*\" . }}/sa-\-prod-\/g" \
        -e "s/{{ .Release.Namespace }}/sa-p8-prod/g" \
        -e "/{{-.*}}/d" \
        /workspace/deploy/\/templates/secret.yaml > /workspace/deploy/\/templates/secret_static.yaml
        
    kubeseal --format yaml --cert /workspace/cert.pem < /workspace/deploy/\/templates/secret_static.yaml > /workspace/deploy/\/templates/sealedsecret.yaml
    rm /workspace/deploy/\/templates/secret_static.yaml
    rm /workspace/deploy/\/templates/secret.yaml
  fi
done
