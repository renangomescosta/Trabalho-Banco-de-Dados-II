#!/bin/bash

docker stop trabalho
sleep 1
docker rm trabalho
sleep 1
docker run --name trabalho -e POSTGRES_PASSWORD=123 -p 5432:5432 -d postgres
sleep 1
docker cp ~/Documentos/bd_2 trabalho:/tmp/meus_scripts_sql
sleep 1

PGPASSWORD=123 docker exec -it trabalho psql -U postgres -d postgres -f /tmp/meus_scripts_sql/criar_banco.sql
PGPASSWORD=123 docker exec -it trabalho psql -U postgres -d postgres -f /tmp/meus_scripts_sql/popula_banco.sql
#psql -h localhost -p 5432 -U postgres -d postgres
