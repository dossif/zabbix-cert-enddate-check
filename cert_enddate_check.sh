#!/bin/bash
if [ -z "$1" ]; then echo "Example: $0 google.com:443"; exit 1; fi
host=$1
domain=$(echo $host | perl -ne '/(.*):/ && print $1')
cert_date=$(echo | openssl s_client -servername $domain -connect $host 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f 2)
cert_timestamp=$(date -d "$cert_date" "+%s")
now_timestamp=$(date -d now "+%s")
diff_in_days=$(((cert_timestamp-now_timestamp)/86400))
if [ $diff_in_days -lt 0 ]; then diff_in_days=0; fi
echo $diff_in_days
