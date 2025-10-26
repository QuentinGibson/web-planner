#!/bin/bash
while IFS= read -r path; do
  lowercase=$(echo "$path" | tr '[:upper:]' '[:lower:]')
  dir=$(dirname "$lowercase")
  mkdir -p "images/passives/$dir"
  curl -s -o "images/passives/${lowercase}.png" "https://poe.ninja/poe2-assets/cdn/2/passives/${lowercase}.png"
done < all_icon_paths.txt
echo "Download complete"
