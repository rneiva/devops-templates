#!/usr/bin/env bash
###################
# tg-handler.sh
###################

set -o errexit
set -o nounset
set -o pipefail

# Variables Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Variables
dev_folder="<aws_dev_region_folder>"
dr_folder="<aws_dr_region_folder>"
dir_path="<path to infra>"
folder_dir="<path to infra/<environment>"
folder_list=()
service_list=("service") # Name of the service in double quotes separated by space

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
copyFolders() {
  rm -rf $dir_path/$dr_folder/service-*
  source_directory="$dir_path/$dev_folder"
  target_directory="$dir_path/$dr_folder"
  if [ -d "$source_directory" ] && [ -d "$target_directory" ]; then
    for service in "${service_list[@]}"; do
      if [ -d "$source_directory/secrets-service-$service" ]; then
        cp -r "$source_directory/secrets-service-$service" "$target_directory/"
        log_success "Secret service folder for $service copied successfully."
      else
        log_warn "Secret service folder for $service not found."
      fi
      if [ -d "$source_directory/ecs-service-$service" ]; then
        cp -r "$source_directory/ecs-service-$service" "$target_directory/"
        log_success "ECS Service folder for $service copied successfully."
      else
        log_warn "ECS Service folder for $service not found."
      fi
    done
  else
    log_error "Source or destination directory does not exist."
  fi
}

changingFolders(){
    while IFS= read -r -d '' folder; do
        folder_list+=("$folder")
    done < <(find "$folder_dir" -type d -name "service-*" -print0)

    for folder_path in "${folder_list[@]}"; do
        folder_name=$(basename "$folder_path")
        new_folder_name="ecs-service-$folder_name"
        mv "$folder_path" "$folder_dir/$dr_folder/$new_folder_name"
    done

log_success "Folders renamed successfully."
}

removeTGCache(){
    folder_path="$dir_path/$dr_folder"
    find "$folder_path" -type d -name ".terragrunt-cache" -exec rm -rf {} +
    find "$folder_path" -type f -name ".terraform.lock.hcl" -exec rm -f {} +
log_success "Terragrunt cache removed successfully."
}

creatingSecrets(){
cd "$dir_path/$dr_folder"
for dir in secrets-*/; do
    cd "$dir"
    terragrunt apply --auto-approve --terragrunt-non-interactive
    cd ..
done
}

creatingEcsService(){
cd "$dir_path/$dr_folder"
for dir in ecs-service-*/; do
    cd "$dir"
    terragrunt apply --auto-approve
    cd ..
done
}

destroyServices(){
cd "$dir_path/$dr_folder"
for dir in ecs-service-*/; do
    cd "$dir"
    terragrunt destroy --auto-approve
    cd ..
done
}

# Menu
menu(){
    options=("Copy folders" "Change folder names" "Create Secrets" "Create ECS service" "Destroy services" "Remove terragrunt cache" "Quit")
    cmd=(dialog --clear --backtitle "Select an option" --menu "Choose an option:" 15 40 10)
    for option in "${options[@]}"; do
      cmd+=( "${option}" "" )
    done

    choice=$("${cmd[@]}" 2>&1 >/dev/tty)

    case $choice in
      "Copy folders")
        copyFolders
        ;;
      "Change folder names")
        changingFolders
        ;;
      "Create Secrets")
        creatingSecrets
        ;;
      "Create ECS service")
        creatingEcsService
        ;;
      "Destroy services")
        destroyServices
        ;;
      "Remove terragrunt cache")
        removeTGCache
        ;;
      "Quit")
        clear
        exit 1
        ;;
      *)
        log_error "Invalid option. Please select a valid option."
        ;;
    esac
}

menu
