#!/bin/bash
# Update the catalog index file by listing all scripts in the catalog directory

# Change to script directory
cd "$(dirname "$0")" || exit 1

# Path to catalog directory and index file
CATALOG_DIR="catalog"
INDEX_FILE="$CATALOG_DIR/index"

# Ensure catalog directory exists
if [ ! -d "$CATALOG_DIR" ]; then
    echo "Error: catalog directory not found"
    exit 1
fi

# Create new index by listing all files in catalog dir except 'index' itself
(cd "$CATALOG_DIR" && find . -type f -not -name 'index' -not -name '.*' | sed 's/^\.\///' | sort) > "$INDEX_FILE"

# Show the updated index
echo "Updated index file contains:"
cat "$INDEX_FILE"

# If git is available, show changes
if command -v git >/dev/null 2>&1; then
    echo -e "\nGit status:"
    git status "$INDEX_FILE"
    
    echo -e "\nTo commit and push changes:"
    echo "git add $INDEX_FILE"
    echo "git commit -m 'Update catalog index'"
    echo "git push"
fi

