#!/usr/bin/env bash
set -euo pipefail

site_dir="/var/www/kavistore"
source_file="$site_dir/products.json"
target_file="$site_dir/latest-products.json"
temp_file="$site_dir/latest-products.json.tmp"

jq '{
  updated_at: (now | todateiso8601),
  products: [.products[:12][] | {
    id,
    code,
    title,
    price_kzt,
    image,
    updated_at
  }]
}' "$source_file" > "$temp_file"

chmod 0644 "$temp_file"
mv "$temp_file" "$target_file"
