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

# Show line numbers of errors.

function handle_error {
    local retval=$?
    local line=${1-}
    log_err " ${line}: $BASH_COMMAND"
    exit $retval
}

trap 'handle_error "$?: ${BASH_SOURCE[0]}:$LINENO"' ERR

# bail() is a function that exits the script even if called from
# within a function or subshell.

trap "exit 1" TERM

export TOP_PID=$$

bail(){
    kill -s TERM "$TOP_PID"
}

# Logging Functions

log(){
    echo "$(date --iso=s): INFO: $@"
}

log_debug(){
    echo "$(date --iso=s): DEBUG: $@"
}

log_warn(){
    echo "$(date --iso=s): WARN: $@"
}

log_err(){
    echo "$(date --iso=s): ERROR: $@"
}

log_critical(){
    echo "$(date --iso=s): CRITICAL: $@"
}

# Assertions

is_number() {
    integer_regex='^[0-9]+$'

    [[ ${1-} =~ $integer_regex ]]
}

is_uuid() {
    UUID_regex='^\s*[0-9a-fA-F]{8,8}-[0-9a-fA-F]{4,4}-[1-5][0-9a-fA-F]{3,3}-[89ab][0-9a-fA-F]{3,3}-[0-9a-fA-F]{12,12}\s*$'

    [[ "${1-}" =~ $UUID_regex ]]
}

is_sha1() {
    sha1_regex='^\s*[A-Fa-f0-9]{44,44}\s*$'

    [[ "${1-}" =~ $sha_regex ]]
}
