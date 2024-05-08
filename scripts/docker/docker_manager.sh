#!/bin/bash

show_menu() {
    local INPUT=/tmp/input.$$
    dialog --title "Docker" \
        --ok-label "Select" \
        --cancel-label "Exit" \
        --menu "Choose one of the following options:" 15 60 8 \
        1 "Start Containers" \
        2 "Start Containers (detached mode)" \
        3 "Stop Containers" \
        4 "Build Images" \
        5 "Reset Docker" \
        2>$INPUT

    menuitem=$(<"$INPUT")

    rm $INPUT 2>/dev/null
    sleep 0.1
    clear

    case $menuitem in
    1) docker_start ;;
    2) docker_start_detached ;;
    3) docker_stop ;;
    4) docker_build ;;
    5) docker_reset ;;
    esac
}

docker_start() {
    echo -e "\nStarting Docker Compose...\n"
    docker compose up
}

docker_start_detached() {
    echo -e "\nStarting Docker Compose...\n"
    docker compose up --detach
}

docker_stop() {
    echo -e "\nStopping Docker Compose...\n"
    docker compose down
}

docker_build() {
    docker compose build --no-cache --force-rm
}

docker_reset() {
    clear
    dialog --title "Reset Docker" \
        --yesno "Are you sure you want to reset Docker?" 7 60
    if [ $? -eq 0 ]; then
        clear
        sleep 0.1

        docker stop $( docker ps -a -q) 2>/dev/null
        docker rm $( docker ps -a -q) 2>/dev/null

        docker volume rm $( docker volume ls -qf dangling=true) 2>/dev/null
        docker image rm $( docker images -q) 2>/dev/null
        docker rmi $( docker images -q) 2>/dev/null

        yes | docker volume prune -a 2>/dev/null
        yes | docker network prune -a 2>/dev/null
        yes | docker images prune -a 2>/dev/null

        clear

        echo -e "\nDocker has been reset.\n"
    fi
}

clear
sleep 0.1
show_menu