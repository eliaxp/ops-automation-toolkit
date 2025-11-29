#!/bin/bash

# Quick system health check - disk, memory, load, services, and connectivity

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== System Health Check ===${NC}\n"

check_disk() {
    echo -e "${BLUE}1. Disk Usage:${NC}"
    df -h | grep -E '^/dev' | while read -r line; do
        USAGE=$(echo "$line" | awk '{print $5}' | sed 's/%//')
        MOUNT=$(echo "$line" | awk '{print $6}')
        if [ "$USAGE" -gt 80 ]; then
            echo -e "  ${RED}⚠${NC} $MOUNT: ${USAGE}% used"
        elif [ "$USAGE" -gt 60 ]; then
            echo -e "  ${YELLOW}⚠${NC} $MOUNT: ${USAGE}% used"
        else
            echo -e "  ${GREEN}✓${NC} $MOUNT: ${USAGE}% used"
        fi
    done
}

check_memory() {
    echo -e "\n${BLUE}2. Memory:${NC}"
    if command -v free &> /dev/null; then
        TOTAL_MEM=$(free -h | grep Mem | awk '{print $2}')
        USED_MEM=$(free -h | grep Mem | awk '{print $3}')
        AVAIL_MEM=$(free -h | grep Mem | awk '{print $7}')
        PERCENT=$(free | grep Mem | awk '{printf "%.0f", ($3/$2) * 100}')
        
        echo -e "  Total: $TOTAL_MEM"
        echo -e "  Used: $USED_MEM"
        echo -e "  Available: $AVAIL_MEM"
        
        if [ "$PERCENT" -gt 90 ]; then
            echo -e "  Status: ${RED}Critical${NC} ($PERCENT% used)"
        elif [ "$PERCENT" -gt 70 ]; then
            echo -e "  Status: ${YELLOW}High${NC} ($PERCENT% used)"
        else
            echo -e "  Status: ${GREEN}Normal${NC} ($PERCENT% used)"
        fi
    fi
}

check_load() {
    echo -e "\n${BLUE}3. System Load:${NC}"
    if [ -f /proc/loadavg ]; then
        LOAD=$(cat /proc/loadavg | awk '{print $1}')
        CORES=$(nproc)
        LOAD_PERCENT=$(echo "$LOAD $CORES" | awk '{printf "%.0f", ($1/$2) * 100}')
        
        echo -e "  Load Average (1min): $LOAD"
        echo -e "  CPUs: $CORES"
        
        if [ "$LOAD_PERCENT" -gt 100 ]; then
            echo -e "  Status: ${RED}Overloaded${NC}"
        elif [ "$LOAD_PERCENT" -gt 70 ]; then
            echo -e "  Status: ${YELLOW}High${NC}"
        else
            echo -e "  Status: ${GREEN}Normal${NC}"
        fi
    fi
}

check_services() {
    echo -e "\n${BLUE}4. Critical Services:${NC}"
    SERVICES=("ssh" "docker" "nginx" "apache2")
    
    for service in "${SERVICES[@]}"; do
        if systemctl is-active --quiet "$service" 2>/dev/null; then
            echo -e "  ${GREEN}✓${NC} $service: Active"
        elif systemctl list-unit-files | grep -q "^${service}"; then
            echo -e "  ${YELLOW}○${NC} $service: Inactive"
        fi
    done
}

check_connectivity() {
    echo -e "\n${BLUE}5. Connectivity:${NC}"
    if ping -c 1 -W 2 8.8.8.8 &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} Internet: Connected"
    else
        echo -e "  ${RED}✗${NC} Internet: No connection"
    fi
    
    if command -v curl &> /dev/null; then
        if curl -s --max-time 5 https://www.google.com &> /dev/null; then
            echo -e "  ${GREEN}✓${NC} DNS: Working"
        else
            echo -e "  ${YELLOW}⚠${NC} DNS: Possible issue"
        fi
    fi
}

check_disk
check_memory
check_load
check_services
check_connectivity

echo -e "\n${GREEN}Done${NC}"

