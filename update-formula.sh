#!/bin/bash
set -e

# Simple script to update spotinfo Homebrew formula
# Usage: ./update-formula.sh [version]
# If no version provided, fetches the latest release

echo "🍺 Updating spotinfo Homebrew formula..."

# Get latest release version if not provided
if [ -z "$1" ]; then
    echo "Fetching latest release version..."
    VERSION=$(curl -s https://api.github.com/repos/alexei-led/spotinfo/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
    # Remove 'v' prefix if present
    VERSION="${VERSION#v}"
else
    VERSION="$1"
fi

echo "Updating to version: $VERSION"

# Create temp directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download assets and calculate SHA256
echo "Downloading release assets..."
for asset in spotinfo_darwin_amd64 spotinfo_darwin_arm64 spotinfo_linux_amd64 spotinfo_linux_arm64; do
    echo "  Downloading $asset..."
    curl -sL -o "$asset" "https://github.com/alexei-led/spotinfo/releases/download/${VERSION}/${asset}"
done

# Calculate SHA256
echo "Calculating SHA256 checksums..."
SHA_DARWIN_AMD64=$(shasum -a 256 spotinfo_darwin_amd64 | cut -d' ' -f1)
SHA_DARWIN_ARM64=$(shasum -a 256 spotinfo_darwin_arm64 | cut -d' ' -f1)
SHA_LINUX_AMD64=$(shasum -a 256 spotinfo_linux_amd64 | cut -d' ' -f1)
SHA_LINUX_ARM64=$(shasum -a 256 spotinfo_linux_arm64 | cut -d' ' -f1)

echo "Checksums calculated:"
echo "  Darwin AMD64: $SHA_DARWIN_AMD64"
echo "  Darwin ARM64: $SHA_DARWIN_ARM64"
echo "  Linux AMD64:  $SHA_LINUX_AMD64"
echo "  Linux ARM64:  $SHA_LINUX_ARM64"

# Go back to original directory
cd - > /dev/null
rm -rf "$TEMP_DIR"

# Update formula
FORMULA_PATH="Formula/spotinfo.rb"
echo "Updating formula..."

# Create backup
cp "$FORMULA_PATH" "${FORMULA_PATH}.backup"

# Update version
sed -i.tmp "s/version \".*\"/version \"${VERSION}\"/" "$FORMULA_PATH"

# Update SHA256 values
sed -i.tmp "/darwin_amd64/,/sha256/ s/sha256 \".*\"/sha256 \"${SHA_DARWIN_AMD64}\"/" "$FORMULA_PATH"
sed -i.tmp "/darwin_arm64/,/sha256/ s/sha256 \".*\"/sha256 \"${SHA_DARWIN_ARM64}\"/" "$FORMULA_PATH"
sed -i.tmp "/linux_amd64/,/sha256/ s/sha256 \".*\"/sha256 \"${SHA_LINUX_AMD64}\"/" "$FORMULA_PATH"
sed -i.tmp "/linux_arm64/,/sha256/ s/sha256 \".*\"/sha256 \"${SHA_LINUX_ARM64}\"/" "$FORMULA_PATH"

# Clean up temp files
rm -f "${FORMULA_PATH}.tmp"

echo "✅ Formula updated successfully!"
echo ""
echo "Next steps:"
echo "  1. Review changes: git diff Formula/spotinfo.rb"
echo "  2. Test locally: brew install --build-from-source Formula/spotinfo.rb"
echo "  3. Commit: git add Formula/spotinfo.rb && git commit -m 'Update spotinfo to $VERSION'"
echo "  4. Push: git push"
echo ""
echo "Backup saved at: ${FORMULA_PATH}.backup"