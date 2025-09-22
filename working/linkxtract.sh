#!/bin/bash

# Usage: ./extract_pdf_links_from_html.sh <input.html> [output_file]

if [ -z "$1" ]; then
  echo "Usage: $0 <input.html> [output_file]"
  exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${2:-pdf_links.txt}"

if [ ! -f "$INPUT_FILE" ]; then
  echo "[-] File not found: $INPUT_FILE"
  exit 1
fi

echo "[*] Extracting PDF links from: $INPUT_FILE"

# Extract lines that contain http://...pdf
# Use grep with extended regex (-E) and only matched parts (-o)
grep -Eo 'http://[^"]+\.pdf' "$INPUT_FILE" | sort -u >"$OUTPUT_FILE"

if [ -s "$OUTPUT_FILE" ]; then
  echo "[+] Found PDF links:"
  cat "$OUTPUT_FILE"
  echo "[+] Saved to: $OUTPUT_FILE"
else
  echo "[-] No PDF links found."
fi
