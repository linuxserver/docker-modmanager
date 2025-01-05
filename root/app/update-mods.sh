#!/usr/bin/with-contenv bash
# shellcheck shell=bash

find_docker_mods() {
    # Mods provided via Docker
    if [[ "${2}" != "default" ]]; then
        MOD_STATE="(${2})"
        docker context create "${2}" --docker "host=${1}" >/dev/null 2>&1
    fi
    docker --context "${2}" ps -q >/dev/null 2>&1 || local DOCKER_MOD_CONTEXT_FAIL=true
    if [[ "${DOCKER_MOD_CONTEXT_FAIL}" == "true" ]]; then
        echo "[mod-init] (ERROR) Cannot connect to the Docker daemon at ${2}, skipping host"
        return
    fi
    echo -e "[mod-init] ${MOD_STATE:+${MOD_STATE} }Searching all containers in the ${2} context for DOCKER_MODS..."
    for CONTAINER in $(docker --context "${2}" ps -q); do
        CONTAINER_MODS=$(docker --context "${2}"  inspect "${CONTAINER}" | jq -r '.[].Config.Env | to_entries | map(select(.value | match("DOCKER_MODS="))) | .[].value')
        CONTAINER_NAME=$(docker --context "${2}"  inspect "${CONTAINER}" | jq -r .[].Name | cut -d '/' -f2)
        if [[ -n ${CONTAINER_MODS} ]]; then
            CONTAINER_MODS=$(awk -F '=' '{print $2}' <<< "${CONTAINER_MODS}")
            for CONTAINER_MOD in $(tr '|' '\n' <<< "${CONTAINER_MODS}"); do
                if [[ "${DOCKER_MODS}" =~ ${CONTAINER_MOD} ]]; then
                    echo -e "[mod-init] ${MOD_STATE:+${MOD_STATE} }${CONTAINER_MOD} already in mod list, skipping"
                else
                    echo -e "[mod-init] ${MOD_STATE:+${MOD_STATE} }Found new mod ${CONTAINER_MOD} for container ${CONTAINER_NAME}"
                    DOCKER_MODS="${DOCKER_MODS}|${CONTAINER_MOD}"
                    DOCKER_MODS="${DOCKER_MODS#|}"
                fi
            done
        fi
    done
    if [[ "${2}" != "default" ]]; then
        docker context rm "${2}" >/dev/null
    fi
}

# Main script loop
if [[ -e "/var/run/docker.sock" ]] || [[ -n "${DOCKER_HOST}" ]]; then
    find_docker_mods "${DOCKER_HOST:-docker.sock}" "default"
fi

if [[ -n "${DOCKER_MODS_EXTRA_HOSTS}" ]]; then
    for DOCKER_MOD_CONTEXT in $(echo "${DOCKER_MODS_EXTRA_HOSTS}" | tr '|' '\n'); do
        DOCKER_MOD_CONTEXT_NAME="${DOCKER_MOD_CONTEXT##*//}"
        DOCKER_MOD_CONTEXT_NAME="${DOCKER_MOD_CONTEXT_NAME%%:*}"
        find_docker_mods "${DOCKER_MOD_CONTEXT}" "${DOCKER_MOD_CONTEXT_NAME}"
    done
fi

if [[ -n "${DOCKER_MODS}" ]]; then
    printf %s "true" > /run/s6/container_environment/MODMANAGER_MODONLY
    printf %s "${DOCKER_MODS}" > /run/s6/container_environment/DOCKER_MODS
    exec /docker-mods
else
    echo -e "[mod-init] (ERROR) Could not find any mods in the DOCKER_MODS environment variable or via Docker"
fi
