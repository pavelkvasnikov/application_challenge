#!/bin/bash

set -e
BUNDLE_IGNORE_CONFIG=1 bundle install

exec "/bin/bash"
