#!/bin/bash

# Simple backup script - creates compressed backups and cleans up old ones
# Usage: ./backup.sh <source_dir> [destination_dir]

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SOURCE_DIR="${1:-}"
BACKUP_DIR="${2:-./backups}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}"

show_help() {
    echo "Usage: $0 <source_directory> [destination_directory]"
    echo ""
    echo "Examples:"
    echo "  $0 /var/www/html /backups"
    echo "  $0 /home/user/data"
    exit 1
}

if [ -z "$SOURCE_DIR" ]; then
    echo -e "${RED}Error:${NC} Need a source directory"
    show_help
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Error:${NC} '$SOURCE_DIR' doesn't exist"
    exit 1
fi

mkdir -p "$BACKUP_DIR"

echo -e "${BLUE}=== Backup Script ===${NC}\n"
echo -e "${GREEN}Source:${NC} $SOURCE_DIR"
echo -e "${GREEN}Destination:${NC} $BACKUP_DIR"
echo -e "${GREEN}Name:${NC} $BACKUP_NAME.tar.gz"
echo ""

echo -e "${YELLOW}Creating backup...${NC}"
tar -czf "${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")" 2>/dev/null

if [ $? -eq 0 ]; then
    BACKUP_SIZE=$(du -h "${BACKUP_DIR}/${BACKUP_NAME}.tar.gz" | cut -f1)
    echo -e "${GREEN}✓${NC} Backup done"
    echo -e "${GREEN}✓${NC} Size: $BACKUP_SIZE"
    echo -e "${GREEN}✓${NC} File: ${BACKUP_DIR}/${BACKUP_NAME}.tar.gz"
    
    # Remove backups older than 7 days
    echo -e "\n${YELLOW}Cleaning up old backups...${NC}"
    find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +7 -delete
    echo -e "${GREEN}✓${NC} Cleanup done"
else
    echo -e "${RED}✗${NC} Backup failed"
    exit 1
fi

echo -e "\n${GREEN}All done${NC}"

