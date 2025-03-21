#!/bin/bash

# Request the user for the URL to scan
echo -n "Enter URL to scan: "
read TARGET_URL
OUTPUT_FILE="zap_scan_results.txt"

echo "Starting OWASP ZAP scan on $TARGET_URL..."

# Run the ZAP Baseline Scan and save the results to the file without outputting to the console
sudo docker run --rm -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t "$TARGET_URL" > "$OUTPUT_FILE" 2>&1

FAIL_NEW_COUNT=$(grep -o 'FAIL-NEW: [0-9]*' "$OUTPUT_FILE" | awk '{print $2}' | tr -d '[:space:]')
FAIL_INPROG_COUNT=$(grep -o 'FAIL-INPROG: [0-9]*' "$OUTPUT_FILE" | awk '{print $2}' | tr -d '[:space:]')
WARN_NEW_COUNT=$(grep -o 'WARN-NEW: [0-9]*' "$OUTPUT_FILE" | awk '{print $2}' | tr -d '[:space:]')
WARN_INPROG_COUNT=$(grep -o 'WARN-INPROG: [0-9]*' "$OUTPUT_FILE" | awk '{print $2}' | tr -d '[:space:]')
INFO_COUNT=$(grep -o 'INFO: [0-9]*' "$OUTPUT_FILE" | awk '{print $2}' | tr -d '[:space:]')
IGNORE_COUNT=$(grep -o 'IGNORE: [0-9]*' "$OUTPUT_FILE" | awk '{print $2}' | tr -d '[:space:]')
PASS_COUNT=$(grep -o 'PASS: [0-9]*' "$OUTPUT_FILE" | awk '{print $2}' | tr -d '[:space:]')

# If no counts are found, set them to 0
FAIL_NEW_COUNT=${FAIL_NEW_COUNT:-0}
FAIL_INPROG_COUNT=${FAIL_INPROG_COUNT:-0}
WARN_NEW_COUNT=${WARN_NEW_COUNT:-0}
WARN_INPROG_COUNT=${WARN_INPROG_COUNT:-0}
INFO_COUNT=${INFO_COUNT:-0}
IGNORE_COUNT=${IGNORE_COUNT:-0}
PASS_COUNT=${PASS_COUNT:-0}

# Display the results
echo "Scan completed. Found vulnerabilities:"
echo "FAIL-NEW: $FAIL_NEW_COUNT"
echo "FAIL-INPROG: $FAIL_INPROG_COUNT"
echo "WARN-NEW: $WARN_NEW_COUNT"
echo "WARN-INPROG: $WARN_INPROG_COUNT"
echo "INFO: $INFO_COUNT"
echo "IGNORE: $IGNORE_COUNT"
echo "PASS: $PASS_COUNT"
