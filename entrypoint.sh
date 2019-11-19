#!/bin/sh
set -e
set -o pipefail

main() {
    approvedLabels=$INPUT_LABELS
    IFS=', ' read -r -a approvedLabels <<< "$approvedLabels"

    labels=$(jq -r .pull_request.labels "$GITHUB_EVENT_PATH")
#    labels=$(jq -r .pull_request.labels "test.json");

    approved=false
    for row in $(echo "${labels}" | jq -r '.[] | @base64'); do
        _jq() {
         echo ${row} | base64 -d | jq -r ${1}
        }

        label=$(_jq '.name')

        if [[ " ${approvedLabels[@]} " =~ " ${label} " ]]; then
            flag=true
        fi
    done
}

if (! ${flag}); then
    echo 'Pull request is not approved'
    exit 1
fi

main
