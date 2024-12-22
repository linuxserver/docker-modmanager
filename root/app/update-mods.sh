#!/usr/bin/with-contenv bash
# shellcheck shell=bash

# Main script loop
if [[ -e "/var/run/docker.sock" ]] || [[ -n "${DOCKER_HOST}" ]]; then
    # Mods provided via Docker
    echo "[mod-init] Searching all containers for DOCKER_MODS..."
    for CONTAINER in $(docker ps -q); do
        CONTAINER_MODS=$(docker inspect "${CONTAINER}" | jq -r '.[].Config.Env | to_entries | map(select(.value | match("DOCKER_MODS="))) | .[].value')
        CONTAINER_NAME=$(docker inspect "${CONTAINER}" | jq -r .[].Name | cut -d '/' -f2)
        if [[ -n ${CONTAINER_MODS} ]]; then
            CONTAINER_MODS=$(awk -F '=' '{print $2}' <<< "${CONTAINER_MODS}")
            for CONTAINER_MOD in $(tr '|' '\n' <<< "${CONTAINER_MODS}"); do
                if [[ "${DOCKER_MODS}" =~ ${CONTAINER_MOD} ]]; then
                    echo "[mod-init] ${CONTAINER_MOD} already in mod list, skipping"
                else
                    echo "[mod-init] Found new mod ${CONTAINER_MODS} for container ${CONTAINER_NAME}"
                    DOCKER_MODS="${DOCKER_MODS}|${CONTAINER_MOD}"
                    DOCKER_MODS="${DOCKER_MODS#|}"
                fi
            done
        fi
    done
fi

if [[ -n "${DOCKER_MODS+x}" ]]; then
    printf %s "true" > /run/s6/container_environment/MODMANAGER_MODONLY
    printf %s "${DOCKER_MODS}" > /run/s6/container_environment/DOCKER_MODS
    exec /docker-mods
else
    echo "[mod-init] (ERROR) Could not find any mods in the DOCKER_MODS environment variable or via Docker"
fi
