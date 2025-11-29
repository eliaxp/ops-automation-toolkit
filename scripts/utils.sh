#!/bin/bash

# Common utility functions - source this in other scripts

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if port is in use
port_in_use() {
    lsof -i :"$1" >/dev/null 2>&1
}

# Get public IP
get_public_ip() {
    curl -s ifconfig.me || curl -s icanhazip.com || echo "Not available"
}

# Check disk space percentage
check_disk_space() {
    local path="${1:-/}"
    df -h "$path" | awk 'NR==2 {print $5}' | sed 's/%//'
}

# Create directory if missing
ensure_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        log_info "Created directory: $1"
    fi
}

# Backup file before editing
backup_file() {
    if [ -f "$1" ]; then
        cp "$1" "${1}.bak.$(date +%Y%m%d_%H%M%S)"
        log_info "Backed up: ${1}.bak.$(date +%Y%m%d_%H%M%S)"
    fi
}

