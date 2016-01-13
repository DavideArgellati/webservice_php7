#!/bin/bash

mkdir -p /mysqldumps
mysqldump -u root --all-databases | gzip > /mysqldumps/`date '+%m-%d-%Y'`.sql.gz
