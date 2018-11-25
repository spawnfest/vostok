#!/bin/sh
#
set -e

git archive master static -o vostok.zip
mix escript.build
zip -ur vostok.zip vostok
