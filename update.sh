#!/bin/bash
set -e

TAG="$1"
if [ -z "$TAG" ]; then
	echo "Usage: $0 <tag>"
	exit 1
fi

mkdir -p tmp
TRAP_EXIT() {
	popd
}
pushd ./tmp

wget "https://github.com/napisani/proctmux/releases/download/$TAG/proctmux-darwin-arm64.tar.gz"
wget "https://github.com/napisani/proctmux/releases/download/$TAG/proctmux-darwin-amd64.tar.gz"

# Calculate SHA256 checksums
echo "ARM64 SHA256:"
ARM=$(shasum -a 256 proctmux-darwin-arm64.tar.gz | awk '{print $1}')
echo "$ARM"

echo "AMD64 SHA256:"
AMD=$(shasum -a 256 proctmux-darwin-amd64.tar.gz | awk '{print $1}')
echo "$AMD"

cat ../Formula/proctmux.rbtemplate |
	sed "s/ARM64_SHA256_PLACEHOLDER/$ARM/" |
	sed "s/AMD64_SHA256_PLACEHOLDER/$AMD/" |
	sed "s/TAG_PLACEHOLDER/$TAG/g" >../Formula/proctmux.rb

rm -rf ./*
