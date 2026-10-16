#!/bin/bash
# Simple health check for Coinpedia Markets
URL="https://markets.coinpedia.org/"
 
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL"  -w "%{http_code} %{time_total}" )

if [ "$STATUS" -eq 200 ]; then
  echo "✅ $URL is UP (HTTP $STATUS)"
else
  echo "❌ $URL is DOWN or has issues (HTTP $STATUS)"
  exit 1
fi
