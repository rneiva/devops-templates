#!/usr/bin/env bash
###################
# aws-sm-values-export.sh
###################

set -o errexit
set -o nounset
set -o pipefail

# Variables Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Functions Logs
function log() {
  echo
  echo -e "➡ ${GREEN}${1}${NC}"
  echo
}

function log_success() {
  echo
  echo -e "✅ ${GREEN}${1}${NC}"
  echo
}

function log_warn() {
  echo
  echo -e "⚠️ ${YELLOW}${1}${NC}"
  echo
}

function log_error() {
  echo
  echo -e "⛔ ${RED}ERROR: ${1}${NC}"
  echo
}

# Functions
print_usage() {
    echo "Usage: $0 -e <ENV> -r <REGION> -o <DIR_OUT> -s <DIR_SECRETS> [--clean] [--values|--arns]"
    echo ""
    echo "Example - Secrets: $0 -e dev -r us-east-2 -o out -s secrets --clean --values"
    echo "Example - ARNs: $0 -e dev -r us-east-2 -o out -s secrets --arns"
    echo ""
}

get_sm_values() {
    if [ "$CLEAN" = true ]; then
        echo "Cleaning previously generated JSON files..."
        rm -rf "${DIR_SECRETS}/${ENV}"
    fi

    echo "Running get_sm_values with the following parameters:"
    echo "ENV: $ENV"
    echo "REGION: $REGION"
    echo "DIR_OUT: $DIR_OUT"
    echo "DIR_SECRETS: $DIR_SECRETS"
    echo "CLEAN: $CLEAN"
    echo ""

    aws secretsmanager list-secrets --region "${REGION}" | jq -r '.SecretList[].Name' > "${DIR_OUT}/${ENV}-sm-list.text"
    log_success "Secrets list generated successfully"

    if [ ! -s "${DIR_OUT}/${ENV}-sm-list.text" ]; then
        log_error "Secrets list is empty"
        exit 1
    fi

    while read -r line; do
        secret_name=$(basename $line)
        
        mkdir -p "${DIR_SECRETS}/${ENV}/${secret_name}"
        if [ $? -ne 0 ]; then
            log_error "Error: Failed to create directory ${DIR_SECRETS}/${ENV}/${secret_name}"
            exit 1
        fi

        aws_secret_value=$(aws secretsmanager get-secret-value --region "${REGION}" --secret-id "$line" --query SecretString --output text)

        if [ -n "$aws_secret_value" ]; then
            if jq '.' <<< "$aws_secret_value" &>/dev/null; then
                reformatted_json=$(echo "$aws_secret_value" | jq '.')
                echo "$reformatted_json" > "${DIR_SECRETS}/${ENV}/${secret_name}/secret.json"
                log_success "Secret values for $line have been saved"
            else
                log_warn "Warning: Secret for $line is not valid JSON and will not be saved."
            fi
        else
            log_error "Failed to retrieve the secret for $line or it's empty"
        fi
    done < "${DIR_OUT}/${ENV}-sm-list.text"
}


get_sm_arns(){
    ARN_LIST=$(aws secretsmanager list-secrets --region "${REGION}" --query 'SecretList[].ARN')
    echo "${ARN_LIST}" | jq -r '.[]' > "${DIR_OUT}/${ENV}-sm-arns-list.json"
    log_success "ARNs list generated successfully."
}

# Main
while getopts ":e:r:o:s:-:" opt; do
    case $opt in
        e)
            ENV="$OPTARG"
            ;;
        r)
            REGION="$OPTARG"
            ;;
        o)
            DIR_OUT="$OPTARG"
            ;;
        s)
            DIR_SECRETS="$OPTARG"
            ;;
        -)
            case $OPTARG in
                clean)
                    CLEAN=true
                    ;;
                values)
                    OPTION="values"
                    ;;
                arns)
                    OPTION="arns"
                    ;;
                *)
                    print_usage
                    exit 1
                    ;;
            esac
            ;;
        *)
            print_usage
            exit 1
            ;;
    esac
done

if [ -z "$ENV" ] || [ -z "$REGION" ] || [ -z "$DIR_OUT" ] || [ -z "$DIR_SECRETS" ] || [ -z "$DIR_SECRETS" ]; then
    print_usage
    exit 1
fi

case "$OPTION" in
    values)
        get_sm_values
        ;;
    arns)
        get_sm_arns
        ;;
    *)
        print_usage
        exit 1
        ;;
esac