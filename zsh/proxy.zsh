pr() {
    if (( $# != 2 )); then
        print -u2 'Usage: pr {start|status|stop} <ssh-host>'
        return 2
    fi

    local action=$1
    local ssh_host=$2
    local local_port=${LOCAL_PROXY_PORT:-7897}
    local remote_port=${REMOTE_PROXY_PORT:-17897}
    local socket="${TMPDIR:-/tmp}/proxy-${USER:-user}-${ssh_host}.sock"

    case $action in
        start | status | stop) ;;
        *)
            print -u2 'Usage: pr {start|status|stop} <ssh-host>'
            return 2
            ;;
    esac

    case $ssh_host in
        *[!A-Za-z0-9._-]* | '')
            print -u2 "Invalid SSH host: $ssh_host"
            return 2
            ;;
    esac

    case "$local_port:$remote_port" in
        *[!0-9:]* | :* | *:)
            print -u2 'Proxy ports must be numeric.'
            return 2
            ;;
    esac

    case $action in
        start)
            if command ssh -S "$socket" -O check "$ssh_host" &>/dev/null; then
                print "Proxy tunnel for $ssh_host is already running."
                return
            fi
            if ! command nc -z 127.0.0.1 "$local_port"; then
                print -u2 "No local proxy is listening on 127.0.0.1:$local_port."
                return 1
            fi

            [[ ! -S $socket ]] || command rm -f "$socket"
            command ssh -M -S "$socket" -fNT \
                -o ControlPersist=no \
                -o ExitOnForwardFailure=yes \
                -o ServerAliveInterval=15 \
                -o ServerAliveCountMax=3 \
                -R "127.0.0.1:${remote_port}:127.0.0.1:${local_port}" \
                "$ssh_host" || return
            print "Remote proxy: http://127.0.0.1:$remote_port"
            ;;
        status)
            if command ssh -S "$socket" -O check "$ssh_host" &>/dev/null; then
                print "Proxy tunnel for $ssh_host is running."
            else
                print "Proxy tunnel for $ssh_host is stopped."
                return 1
            fi
            ;;
        stop)
            if ! command ssh -S "$socket" -O check "$ssh_host" &>/dev/null; then
                print "Proxy tunnel for $ssh_host is already stopped."
                return
            fi
            command ssh -S "$socket" -O exit "$ssh_host" >/dev/null
            print 'Proxy tunnel stopped.'
            ;;
    esac
}

pon() {
    export http_proxy="http://127.0.0.1:${REMOTE_PROXY_PORT:-17897}"
    export https_proxy="$http_proxy"
}

poff() {
    unset http_proxy https_proxy
}
