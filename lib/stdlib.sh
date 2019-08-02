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
    echo
    echo "ERROR:$@"
    echo
}

# Show line numbers of errors.
function handle_error {
    local retval=$?
    local line=$1
    log " ${line}: $BASH_COMMAND"
    exit $retval
}

trap 'handle_error "$?: ${BASH_SOURCE[0]}:$LINENO"' ERR

# Assertions

is_number() {
    integer_regex='^[0-9]+$'

    if [[ $1 =~ $integer_regex ]]
    then
        true
    else
        false
    fi
}

is_UUID() {
    UUID_regex='^\s*[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89ab][0-9a-fA-F]{3}-[0-9a-fA-F]{12}\s*$'

    if [[ "$1" =~ $UUID_regex ]]
    then
        true
    else
        false
    fi
}

is_sha() {
    sha_regex='^\s*[A-Fa-f0-9]{32}\s*$'

    if [[ "$1" =~ $sha_regex ]]
    then
        true
    else
        false
    fi
}
