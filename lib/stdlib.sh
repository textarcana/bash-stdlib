#!/usr/bin/env bash

# Copyright 2010-2019 Noah Sussman New Media, LLC

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

set -Eeuo pipefail

# Standard library of bash functions and helpers.

# Write log-formatted error messages
function log {
    echo "$(date --iso=s):ERROR:$@"
}

# Send error messages
function err {
    echo "ERROR:$@"
    exit 1
}

# Show line numbers of errors.
function handle_error {
    local retval=$?
    local line=$1
    log " ${line}: $BASH_COMMAND"
    exit $retval
}

trap 'handle_error "$?: ${BASH_SOURCE[0]}:$LINENO"' ERR
