#!/usr/bin/env bash

# set color variables
GREEN='\e[32m'
GREEN_REVERSE='\e[32;7m'
RED='\e[31m'
YELLOW='\e[33m'
ELASTIC='\e[36;1;45m'
ENDC='\e[0m'

# initial print to terminal
echo ""
echo -e "${GREEN}Setting Things Up...${ENDC} ☕☕☕"
echo ""
sleep .5

# check for dbt packages
if [ ! -d "./transformation/dbt_packages" ]; then
    echo -e "${YELLOW}Installing dbt Packages...${ENDC} ☕☕☕"
    echo ""
    sleep .5
    ( cd transformation; dbt deps )
else
    echo -e "${GREEN}dbt packages are installed... ✔${ENDC}"
    echo ""
    sleep .5
fi

# setup terminal
apt update -y
apt install dos2unix wget unzip -y --no-install-recommends
apt install curl -y
curl https://install.duckdb.org | sh
pip install -r ./transformation/requirements.txt
find .devcontainer/ -type f -print0 | xargs -0 dos2unix
cp .devcontainer/bash/.bashrc ~/.bashrc
cp .devcontainer/bash/.git-completion.bash ~/.git-completion.bash
cp .devcontainer/bash/.git-prompt.sh ~/.git-prompt.sh
source ~/.bashrc

# setup git
git config pull.rebase false

echo -e "${GREEN_REVERSE}Setup Complete!${ENDC}"
echo ""
echo -e "${GREEN}Available tools:${ENDC}"
echo -e "  • dbt (for data transformation)"
echo -e "  • DuckDB (for data analysis)"
echo -e "  • Python (for data processing)"
echo ""
echo -e "${GREEN}To get started:${ENDC}"
echo -e "  1. ${YELLOW}cd transformation${ENDC} (navigate to dbt project)"
echo -e "  2. ${YELLOW}dbt run${ENDC} (run dbt models)"
echo -e "  3. ${YELLOW}dbt test${ENDC} (run dbt tests)"
echo -e "  4. ${YELLOW}dbt docs generate && dbt docs serve${ENDC} (generate and serve documentation)"
echo ""
echo -e "${GREEN}For data export to PowerBI:${ENDC}"
echo -e "  • Use DuckDB CLI to export data: ${YELLOW}duckdb database.db \"COPY table_name TO 'output.csv' (HEADER, DELIMITER ',')\"${ENDC}"
echo -e "  • Or use Python scripts to export data in your preferred format"
echo ""

exit
