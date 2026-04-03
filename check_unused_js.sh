#!/bin/bash
# Path to your built site and your source JS
SITE_DIR="_site"
JS_SRC_DIR="assets/js"

echo "Scanning for unused JS files..."
UNUSED_COUNT=0

for file in $(find $JS_SRC_DIR -name "*.js"); do
  FILENAME=$(basename "$file")
  # Check if the filename exists in any HTML/JS file in the built site
  if ! grep -rq "$FILENAME" "$SITE_DIR"; then
    echo "❌ UNUSED: $file is not referenced in the build."
    UNUSED_COUNT=$((UNUSED_COUNT + 1))
  fi
done

if [ $UNUSED_COUNT -ne 0 ]; then
  echo "Found $UNUSED_COUNT potentially useless JS files."
  # Exit with 0 if you just want a warning, or 1 to fail the build
  exit 0 
else
  echo "✅ All JS files are in use."
fi
