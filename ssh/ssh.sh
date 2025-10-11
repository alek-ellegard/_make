#!/usr/bin/env bash
set -euo pipefail

SSH_CONFIG="${HOME}/.ssh/config"
ENV_FILE="${ENV_FILE:-.env}"

# operations
OP="${1:-}"
shift || true

source_env() {
  if [[ ! -f "$ENV_FILE" ]]; then
    echo "error: $ENV_FILE not found" >&2
    exit 1
  fi
  set -a
  source "$ENV_FILE"
  set +a
}

add_host() {
  source_env

  # validate required vars
  : "${VPS:?'VPS not set'}"

  # determine which IP to use (prefer PUBLIC_IP, fallback to PRIVATE_IP, allow SSH_IP override)
  local ip="${SSH_IP:-${PUBLIC_IP:-${PRIVATE_IP:?'No IP address found'}}}"

  local host="${VPS}"
  local user="${SSH_USER:-${USER:-ec2-user}}"
  local identity="${SSH_IDENTITY:-/Users/alek/.ssh/caesari/aws/alek-rsa.pub.pem}"

  # check if host exists
  if grep -q "^Host ${host}$" "$SSH_CONFIG" 2>/dev/null; then
    echo "Host '${host}' already exists in SSH config" >&2
    exit 0
  fi

  # append new host
  cat >>"$SSH_CONFIG" <<EOF

Host ${host}
    HostName ${ip}
    User ${user}
    IdentityFile ${identity}
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOF

  echo "Added SSH host: ${host} -> ${ip} (user: ${user})"
}

read_host() {
  local host="${1:?'Host name required'}"

  if [[ ! -f "$SSH_CONFIG" ]]; then
    echo "error: SSH config not found" >&2
    exit 1
  fi

  # extract host block
  awk -v host="$host" '
        /^Host / { 
            in_block = ($2 == host)
            if (in_block) print
            next
        }
        in_block && /^[[:space:]]/ { print }
        in_block && /^$/ { exit }
        /^Host / && in_block { exit }
    ' "$SSH_CONFIG"
}

get_property() {
  local host="${1:?'Host name required'}"
  local prop="${2:?'Property name required'}"

  read_host "$host" | awk -v prop="$prop" '
        tolower($1) == tolower(prop) { print $2; exit }
    '
}

list_hosts() {
  if [[ ! -f "$SSH_CONFIG" ]]; then
    echo "error: SSH config not found" >&2
    exit 1
  fi

  awk '/^Host / && $2 !~ /\*/ { print $2 }' "$SSH_CONFIG"
}

case "$OP" in
add)
  add_host
  ;;
read)
  read_host "$@"
  ;;
get)
  get_property "$@"
  ;;
list)
  list_hosts
  ;;
*)
  cat >&2 <<EOF
Usage: $0 <operation> [args]

Operations:
    add                 Add host from .env to SSH config
    read <host>         Read full host configuration
    get <host> <prop>   Get specific property (HostName, User, etc)
    list                List all configured hosts
    
Environment:
    ENV_FILE            Path to .env file (default: ./.env)
    SSH_IDENTITY        Override identity file path
    SSH_IP              Force specific IP (overrides PUBLIC_IP/PRIVATE_IP logic)
    SSH_USER            Override user (default: from .env USER or ec2-user)
EOF
  exit 1
  ;;
esac
