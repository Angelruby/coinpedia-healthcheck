
#!/bin/bash
# Simple health check for Coinpedia Markets

URL="https://markets.coinpedia.org/"

RESULT=$(curl -s -L -o /dev/null \
  --connect-timeout 10 \
  --max-time 20 \
  -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/131.0.0.0 Safari/537.36" \
  -w "%{http_code} %{time_total}" "$URL")

STATUS=$(echo "$RESULT" | awk '{print $1}')
TIME=$(echo "$RESULT" | awk '{print $2}')

if [[ "$STATUS" =~ ^[0-9]{3}$ ]] && [ "$STATUS" -eq 200 ]; then
  echo "✅ $URL is UP (HTTP $STATUS, ${TIME}s)"
else
  echo "❌ $URL returned HTTP ${STATUS:-000} (${TIME:-unknown}s)"
  exit 1
fi
