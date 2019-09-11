#!/bin/sh

# Thanks to https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
curl --silent "https://api.github.com/repos/$1/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/'
