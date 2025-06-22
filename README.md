
# Análise e Otimização de Consultas SQL em Banco de Dados de Compras

Este projeto visa demonstrar a importância da otimização de consultas em um banco de dados PostgreSQL. Para isso, são fornecidos scripts para criação, população e teste de um banco de dados, bem como exemplos de consultas otimizadas e não otimizadas para comparação de desempenho.

## Estrutura do Projeto

````

.
├── Inicializa
│   ├── criar\_banco.sql
│   ├── Inicializa\_docker.sh
│   └── popula\_banco.sql
├── Otimizacao
│   ├── Vacuum.sql
│   └── View\_p\_compras\_mes.sql
├── README.md
├── Testes
│   ├── Escrita
│   │   ├── Altera\_quant\_produto.sql
│   │   ├── Aplica\_Desconto.sql
│   │   ├── Insere\_Cliente.sql
│   │   └── Insere\_compra.sql
│   └── Leitura
│       ├── Consulta\_Carne.sql
│       ├── Consulta\_Compra.sql
│       ├── Gastos\_mensais\_nao\_otimizado.sql
│       └── Gastos\_mensais\_Otimizado.sql

````

## Pré-requisitos

* **Docker:** Utilizado para criar e gerenciar o ambiente do banco de dados PostgreSQL. Certifique-se de que o Docker e o Docker Compose estejam instalados em sua máquina.
* **Dados:** Os dados necessários para popular o banco de dados não estão incluídos neste repositório. É preciso baixá-los do seguinte link e extrair os arquivos `.csv` para uma pasta chamada `DATA` na raiz do projeto:
    * [**Download dos Dados (Google Drive)**](https://drive.google.com/file/d/1jjqo6zOgBP-v7KUa4Z5c7WvjF4pNzFwm/view?usp=sharing)

    Após o download, a estrutura de diretórios deve ficar da seguinte forma:

    ```
    .
    ├── DATA
    │   ├── clientes.csv
    │   ├── compras.csv
    │   └── produtos.csv
    ├── Inicializa
    │   └── ...
    └── ...
    ```

## Como Utilizar

### 1. Inicialização do Banco de Dados

Para criar e popular o banco de dados, execute o script `Inicializa_docker.sh` a partir da raiz do projeto:

```bash
./Inicializa/Inicializa_docker.sh
````

Este script irá:

1. **Construir e subir um contêiner Docker** com uma instância do PostgreSQL.
2. **Executar `criar_banco.sql`**: Script que cria as tabelas `clientes`, `produtos` e `compras`.
3. **Executar `popula_banco.sql`**: Script que utiliza o comando `COPY` para importar os dados dos arquivos `.csv` (localizados na pasta `DATA`) para as tabelas recém-criadas.

### 2. Testes de Desempenho

Para avaliar o desempenho das consultas, utilize o script `calcula_tempo.sh`. Este script executa uma consulta SQL específica várias vezes e calcula o tempo médio de execução.

**Exemplo de uso:**

Para calcular o tempo médio das consultas, altere a consulta no arquivo abaixo e o execute:

```bash
./calcula_tempo.sh 
```
