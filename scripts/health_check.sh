#!/bin/bash
# Simple health check for Coinpedia Markets
URLS=(
     "https://markets.coinpedia.org/"
     "https://markets.coinpedia.org/bitcoin/"
)

for URL in "${URLS[@]}"; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL" )
  
    if [ "$STATUS" -eq 200 ]; then
      echo "✅ $URL is UP (HTTP $STATUS)"
    else
      echo "❌ $URL is DOWN or has issues (HTTP $STATUS)"
    fi
done   
