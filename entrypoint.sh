#!/bin/sh
set -e
set -o pipefail

main() {
    approvedLabels=$INPUT_LABELS
    echo ${approvedLabels}

    labels=$(jq -r .pull_request.labels "$GITHUB_EVENT_PATH")
#    labels=$(jq -r .pull_request.labels "test.json");

    for row in $(echo "${labels}" | jq -r '.[] | @base64'); do
        _jq() {
         echo ${row} | base64 -d | jq -r ${1}
        }

       echo $(_jq '.name')
    done
}

main
