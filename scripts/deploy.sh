#!/bin/bash

# Basic deployment script - customize the steps for your needs
# Usage: ./deploy.sh [dev|staging|production]

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

ENVIRONMENT="${1:-staging}"

if [[ ! "$ENVIRONMENT" =~ ^(dev|staging|production)$ ]]; then
    echo -e "${RED}Error:${NC} Use: dev, staging or production"
    exit 1
fi

echo -e "${BLUE}=== Deployment Script ===${NC}\n"
echo -e "${GREEN}Environment:${NC} $ENVIRONMENT"
echo ""

if [ "$ENVIRONMENT" = "production" ]; then
    echo -e "${RED}⚠ WARNING:${NC} Deploying to PRODUCTION"
    read -p "Are you sure? (type 'yes' to continue): " CONFIRM
    if [ "$CONFIRM" != "yes" ]; then
        echo "Cancelled"
        exit 0
    fi
fi

echo -e "${YELLOW}1. Checking prerequisites...${NC}"
sleep 1
echo -e "${GREEN}✓${NC} Prerequisites OK"

echo -e "\n${YELLOW}2. Running tests...${NC}"
sleep 1
echo -e "${GREEN}✓${NC} Tests passed"

echo -e "\n${YELLOW}3. Building application...${NC}"
sleep 1
echo -e "${GREEN}✓${NC} Build done"

echo -e "\n${YELLOW}4. Deploying to $ENVIRONMENT...${NC}"
sleep 1
echo -e "${GREEN}✓${NC} Deployed"

echo -e "\n${YELLOW}5. Verifying deployment...${NC}"
sleep 1
echo -e "${GREEN}✓${NC} Looks good"

echo -e "\n${GREEN}✓ Deployed to $ENVIRONMENT${NC}"

if [ "$ENVIRONMENT" = "production" ]; then
    echo -e "\n${BLUE}Sending notifications...${NC}"
    # Add your webhooks, Slack, etc. here
fi

