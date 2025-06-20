#!/bin/bash

docker stop trabalho
sleep 3
docker rm trabalho
sleep 3
docker run --name trabalho -e POSTGRES_PASSWORD=123 -p 5432:5432 -d postgres
sleep 3
docker cp ~/Documentos/bd_2 trabalho:/tmp/meus_scripts_sql
sleep 3

PGPASSWORD=123 docker exec -it trabalho psql -U postgres -d postgres -f /tmp/meus_scripts_sql/Inicializa/criar_banco.sql
PGPASSWORD=123 docker exec -it trabalho psql -U postgres -d postgres -f /tmp/meus_scripts_sql/Inicializa/popula_banco.sql
PGPASSWORD=123 docker exec -it trabalho psql -U postgres -d postgres

# \timing
