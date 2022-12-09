#!/bin/ash

# logging
log() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S') | \033[37m\033[1mINFO\033[0m  ] $*"
}
warning() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S') | \033[33m\033[1mWARN\033[0m  ] $*"
}
error() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S') | \033[31m\033[1mERROR\033[0m ] $*"
}

#               |    |    |
#              )_)  )_)  )_)
#             )___))___))___)\
#            )____)____)_____)\\
#          _____|____|____|____\\\__
# ---------\                   /---------
#   ^^^^^ ^^^^^^^^^^^^^^^^^^^^^
#     ^^^^      ^^^^     ^^^    ^^
#          ^^^^      ^^^

echo
echo -e "\033[33m\033[1m \033[36m\\/\033[33m\033[1m           |    |    |    \033[36m\\/           \033[0m"
echo -e "\033[33m\033[1m             )_)  )_)  )_)        \033[36m\\/       \033[0m"
echo -e "\033[33m\033[1m            )___))___))___)\\             \033[0m"
echo -e "\033[33m\033[1m   \033[36m\\/\033[33m\033[1m      )____)____)_____)\\\\          \033[0m"
echo -e "\033[33m\033[1m         _____|____|____|____\\\\\\__     \033[0m"
echo -e "\033[36m\033[1m---------\033[33m\033[1m\\     blek! Sail    /\033[36m\033[1m---------  \033[0m"
echo -e "\033[36m\033[1m  ^^^^^ ^^^^^^^^^^^^^^^^^^^^^             \033[0m"
echo -e "\033[36m\033[1m    ^^^^      ^^^^     ^^^    ^^          \033[0m"
echo -e "\033[36m\033[1m         ^^^^      ^^^                    \033[0m"
echo ''
echo '------------------------------------------'
echo ''

log "Loading \033[33m\033[1mblek! Sail\033[0m startup scripts..."

if [ -n "$(find "/docker-entrypoint.d" -maxdepth 0 -type d -empty 2>/dev/null)" ] | [ ! -d "/docker-entrypoint.d" ]; then
   error "No scripts found. Aborting."
   exit
fi

# run startup scripts
find "/docker-entrypoint.d/" -follow -type f -print | sort -V | while read -r f; do
    if [ -x "$f" ]; then
        log "Loading $f"
        echo
        . "$f"
        log "$f exited"
    else
        log "Ingoring $f, not executable"
    fi
done

log "Done loading startup scripts, entering standby mode"

touch /var/log/stdout_log

tail -n+1 -F /var/log/nginx/access.log | xargs -I {} echo -e "[$(date '+%Y-%m-%d %H:%M:%S') | \033[37m\033[1mINFO\033[0m  ] [\033[36m\033[1mN\033[0m] {}" & \
tail -n+1 -F /var/log/nginx/error.log | xargs -I {} echo -e "[$(date '+%Y-%m-%d %H:%M:%S') | \033[31m\033[1mERROR\033[0m ] [\033[36m\033[1mN\033[0m] {}" & \
tail -n+1 -F /var/log/stdout_log | xargs -I {} log "{}" &

log "Executing startup command \"$@\""
exec "$@" > /var/log/stdout_log 2>&1
