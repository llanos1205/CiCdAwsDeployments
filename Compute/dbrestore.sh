#!bin/bash
git clone
psql postgresql://<user>:<password>@<host>/<db> << EOF 
     CREATE DATABASE CoreDB;
     CREATE DATABASE Client_Template;
     CREATE USER testUser PASSWORD 'copaclacome'

EOF 

pg_restore -h $1 -U $2 -W -d CoreDB -f CiCdAwsDeployments/Compute/backuptesis -F c -O -s << EOF
altair1205 
EOF
pg_restore -h $1 -U $2 -W -d Client_Template -f CiCdAwsDeployments/Compute/backuptesis -F c -O -s << EOF
altair1205 
EOF