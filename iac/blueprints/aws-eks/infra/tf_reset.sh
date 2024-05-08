#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
MAGENTA='\033[0;35m'
NC='\033[0m'

log() {
  echo
  echo -e "➡ ${GREEN}${1}${NC}"
  echo
}

log_success() {
  echo
  echo -e "✅ ${GREEN}${1}${NC}"
  echo
}

log_pavan() {
  echo
  echo -e "✅ ${MAGENTA}${1}${NC}"
  echo
}

log_warn() {
  echo
  echo -e "⚠️ ${YELLOW}${1}${NC}"
  echo
}

log_error() {
  echo
  echo -e "⚠️ ${RED}ERROR: ${1}${NC}"
  echo
}

getInput() {
  declare MESSAGE="${1}" DEFAULT="${2}"
  shift 2
  DEFAULT_MSG=""
  if [ -n "${DEFAULT}" ]; then
    DEFAULT_MSG=" [${DEFAULT}]"
  fi
  read -rp "${MESSAGE}""${DEFAULT_MSG}: " "$@" input </dev/tty
  if [[ -z "${input}" ]]; then
    echo "${DEFAULT}"
  else
    echo "${input}"
  fi
}

deleteTfContext(){
    local folder=(
      ".terraform"
      ".infracost"
    )
    local files=(
      "eks.tfplan"
      "terraform.tfstate"
      "terraform.tfstate.backup"
      ".terraform.lock.hcl"
      "terraform.log"
    )
    for folder in "${folder[@]}"; do
      if [[ -d "${folder}" ]]; then
        log "Deleting ${folder}..."
        rm -rf "${folder}"
      else
        log_warn "${folder} does not exist"
      fi
    done

    for file in "${files[@]}"; do
      if [[ -f "${file}" ]]; then
        log "Deleting ${file}..."
        rm -rf "${file}"
      else
        log_warn "${file} does not exist"
      fi
    done
  log_success "Terraform state and files were cleaned"
}

log_warn "This will destroy all the resources created by terraform. Are you sure you want to continue? (y/n)"
CONFIRM=$(getInput "Enter your choice" "y")

if [[ "${CONFIRM}" == "y" ]]; then
  deleteTfContext
  log "Initializing terraform..."
  sleep 1
  terraform init
  log_pavan "Terraform initialization completed! 🚀"
else
  log_error "Aborting - Please confirm with 'y' to run this script"
  exit 1
fi