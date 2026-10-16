
#!/usr/bin/env bash

URL="https://markets.coinpedia.org/"

# Capture the HTTP status code and response time separately.
RESULT=$(curl -sSL -o /dev/null \
  --connect-timeout 10 \
  --max-time 30 \
  -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/131.0.0.0 Safari/537.36" \
  -w "%{http_code} %{time_total}" \
  "$URL") || {
    echo "❌ Request failed: $URL"
    exit 1
  }

HTTP_CODE=$(echo "$RESULT" | awk '{print $1}')
RESPONSE_TIME=$(echo "$RESULT" | awk '{print $2}')

echo "URL: $URL"
echo "HTTP status: $HTTP_CODE"
echo "Response time: ${RESPONSE_TIME}s"

if [[ ! "$HTTP_CODE" =~ ^[0-9]{3}$ ]] || [[ "$HTTP_CODE" == "000" ]]; then
  echo "❌ Invalid HTTP response"
  exit 1
fi

if (( 10#$HTTP_CODE >= 200 && 10#$HTTP_CODE < 400 )); then
  echo "✅ $URL is UP (HTTP $HTTP_CODE, ${RESPONSE_TIME}s)"
  exit 0
else
  echo "❌ $URL returned HTTP $HTTP_CODE"
  exit 1
fi

