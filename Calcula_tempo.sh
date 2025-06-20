#!/bin/bash
#
# Script para executar uma consulta SQL múltiplas vezes e calcular o tempo médio.
#

# --- Configurações de Segurança do Script ---
# 'set -e' faz com que o script saia imediatamente se um comando falhar.
# 'set -u' trata variáveis não definidas como um erro.
set -eu

# --- Verificação de Dependências ---
if ! command -v bc &> /dev/null
then
    echo "Erro: O comando 'bc' não foi encontrado. Por favor, instale-o para continuar."
    echo "Num sistema Fedora/CentOS, use: sudo dnf install bc"
    exit 1
fi

# --- PASSO 1: Cole a sua consulta SQL aqui dentro das aspas ---
# Usei a consulta não otimizada de gastos mensais como exemplo.
SQL_QUERY="
SELECT * FROM Pessoa WHERE Endereco like '%PB%';


"

# --- Configuração do Benchmark ---
NUM_RUNS=10
TOTAL_TIME=0.0

echo "--- Iniciando benchmark para a consulta ---"
echo "Executando $NUM_RUNS vezes..."
echo "-------------------------------------"

# --- Loop de Execução ---
for i in $(seq 1 $NUM_RUNS)
do
    # Executa a query dentro do container Docker.
    # CORREÇÃO: Usamos um subshell `(echo ...; echo ...)` para passar os comandos de forma mais fiável.
    TIME_OUTPUT=$((echo '\timing'; echo "$SQL_QUERY") | PGPASSWORD=123 docker exec -i trabalho psql -U postgres -d postgres 2>&1)

    # Extrai apenas o valor numérico do tempo da linha "Time: XXX.XXX ms"
    TIME_MS=$(echo "$TIME_OUTPUT" | grep "Time:" | awk '{print $2}')

    if [[ -n "$TIME_MS" ]]; then
        echo "Execução $i: $TIME_MS ms"
        # Adiciona o tempo ao total usando 'bc' para aritmética de ponto flutuante
        TOTAL_TIME=$(echo "$TOTAL_TIME + $TIME_MS" | bc)
    else
        echo "Execução $i: Falha ao extrair o tempo."
        echo "Saída completa do psql:"
        echo "$TIME_OUTPUT"
        exit 1 # Sai do script se a extração do tempo falhar
    fi
done

# --- Cálculo e Exibição do Resultado Final ---
AVERAGE_TIME=$(echo "scale=3; $TOTAL_TIME / $NUM_RUNS" | bc)

echo "-------------------------------------"
echo "Benchmark concluído."
echo "Tempo total das $NUM_RUNS execuções: $TOTAL_TIME ms"
echo "Tempo médio de execução: $AVERAGE_TIME ms"

