# Aula Microserviço

Este projeto é um exemplo de aplicação de microserviço utilizando Flask e PostgreSQL.

## Propósito

Este Repositorio foi criado para ensinar os alunos da UniFAAT a trabalharem com microserviço em Python.

## Estrutura do Projeto

├── InfraBD/ # Contem a os arquivos docker para subir o Banco de Dados<br>
│ ├── northwind.sql # SQL utilizado para criar o Banco e as tabelas utilizadas no projeto<br> 
│ ├── Dockerfile # arquivo docker para inicializar o postgre<br>
│ └── [Readme.md](InfraBD/Readme.md) # Instruções para inicializar o banco no docker
├── app/ # Pasta com o projeto python<br>
│ ├── Util/ # Utilitários e modulos Python<br>
│ │ ├── bd.py # Arquivo python com função para conectar no Banco de Dados<br>
│ │ └── paramsBD.yml # Arquico com as configurações para conexão com o Banco de Dados<br>
│ ├── crudCateg.py # MicroServiso de CRUD de Categorias<br>
│ └── [Readme.md](app/Readme.md) # Instruções para inicializar o APP
├── docker-compose.yml # define a configuração para dois serviços: app e db.
├── Dockerfile # define a configuração para construir uma imagem Docker para uma aplicação Flask.
└── Readme.md # Arquivo com instruções gerais

## Configuração

### Requisitos

- Python 3.x
- PostgreSQL

### Instalação

1. Clone o repositório:
    ```bash
    git clone <URL_DO_REPOSITORIO>
    cd AulaMicroservico-main
    ```

2. Crie um ambiente virtual e ative-o:
    ```bash
    python -m venv venv
    source venv/bin/activate  # No Windows use `venv\Scripts\activate`
    ```

3. Instale as dependências:
    ```bash
    pip install -r requirements.txt
    ```

4. Configure as variáveis de ambiente no arquivo `.env`:
    ```properties
    # Configurações do PostgreSQL
    POSTGRES_USER=postgres
    POSTGRES_PASSWORD=postgres
    POSTGRES_DB=app_database
    POSTGRES_PORT=5432
    # Configurações da aplicação Python
    FLASK_ENV=development
    FLASK_DEBUG=1
    APP_PORT=8000
    # Outras configurações
    LOG_LEVEL=INFO
    ```

## Execução

1. Inicie o servidor PostgreSQL.

2. Execute a aplicação Flask:
    ```bash
    flask run --port=$APP_PORT
    ```

3. Acesse a aplicação em `http://localhost:8000`.

## Como Rodar o Docker-Compose

Para rodar o projeto utilizando o Docker-Compose, siga os passos abaixo:

1. Certifique-se de que você tem o Docker e o Docker-Compose instalados na sua máquina.

2. No diretório raiz do projeto, remova a versão obsoleta do `docker-compose.yml`:

    ```powershell
    (Get-Content docker-compose.yml) -notmatch 'version:' | Set-Content docker-compose.yml
    ```

3. Execute o seguinte comando para parar e remover quaisquer contêineres existentes:

    ```sh
    docker-compose down
    ```

4. Remova o volume de dados do PostgreSQL (se necessário):

    ```sh
    docker volume rm AulaMicroservico_postgres_data
    ```

5. Execute o comando para iniciar os contêineres com o Docker-Compose:

    ```sh
    docker-compose up --build
    ```

6. O serviço Flask estará disponível em `http://localhost:5000` e o banco de dados PostgreSQL estará disponível na porta `5432`.

Esses passos irão construir e iniciar os contêineres definidos no `docker-compose.yml`, garantindo que o ambiente esteja configurado corretamente.

# Guia para Conectar ao Banco de Dados PostgreSQL

## Passos para Configuração

1. **Construir a Imagem Docker**

   Navegue até o diretório onde o arquivo `Dockerfile` está localizado e execute o comando abaixo para construir a imagem Docker:

   ```sh
   docker build -t meu_postgres .
   ```

2. **Executar o Contêiner Docker**

   ...existing code...

3. **Configurar o DBeaver**

   ...existing code...

## Solução de Problemas

### Erro: FATAL: autenticação do tipo senha falhou para o usuário "postgres"

Se você encontrar este erro, siga os passos abaixo para resolver:

1. **Verifique as Credenciais**

   Certifique-se de que as credenciais fornecidas estão corretas. As variáveis de ambiente devem estar configuradas corretamente no arquivo `.env`:

   ```properties
   POSTGRES_USER=postgres
   POSTGRES_PASSWORD=postgres
   POSTGRES_DB=app_database
   POSTGRES_PORT=5432
   ```

2. **Reinicie o Contêiner Docker**

   Pare e remova o contêiner existente, depois inicie um novo contêiner:

   ```sh
   docker-compose down
   docker-compose up --build
   ```

3. **Verifique os Logs do Contêiner**

   Verifique os logs do contêiner PostgreSQL para mais detalhes sobre o erro:

   ```sh
   docker logs <nome_do_conteiner>
   ```

4. **Acesse o Banco de Dados Manualmente**

   Tente acessar o banco de dados manualmente usando o comando `psql` para verificar se as credenciais estão funcionando:

   ```sh
   docker exec -it <nome_do_conteiner> psql -U postgres -d app_database
   ```

   Se conseguir acessar, o problema pode estar na configuração do cliente que você está usando (por exemplo, DBeaver).

5. **Verifique a Configuração do Cliente**

   Certifique-se de que o cliente (DBeaver) está configurado corretamente com as mesmas credenciais e porta que você definiu no Docker.

### Erro: Connection refused: getsockopt

Se você encontrar este erro, siga os passos abaixo para resolver:

1. **Verifique se o Contêiner Está em Execução**

   Certifique-se de que o contêiner Docker está em execução:

   ```sh
   docker ps
   ```

   Se o contêiner não estiver em execução, inicie-o:

   ```sh
   docker-compose up --build
   ```

2. **Verifique a Porta**

   Certifique-se de que a porta 5432 (ou a porta configurada) não está sendo usada por outro serviço. Você pode verificar isso com o comando:

   ```sh
   netstat -tuln | grep 5432
   ```

3. **Verifique as Configurações de Rede do Docker**

   Certifique-se de que o Docker está configurado para permitir conexões na porta 5432. Verifique as configurações de rede do Docker e ajuste se necessário.

4. **Verifique as Configurações do Firewall**

   Certifique-se de que o firewall da sua máquina não está bloqueando a porta 5432. Adicione uma regra no firewall para permitir conexões na porta 5432.

5. **Reinicie o Docker**

   Às vezes, reiniciar o Docker pode resolver problemas de conexão:

   ```sh
   sudo systemctl restart docker
   ```

6. **Verifique os Logs do Contêiner**

   Verifique os logs do contêiner PostgreSQL para mais detalhes sobre o erro:

   ```sh
   docker logs <nome_do_conteiner>
   ```

Se seguir esses passos não resolver o problema, verifique a documentação do Docker e do PostgreSQL para mais informações sobre como solucionar problemas de conexão.

## Contribuição

1. Faça um fork do projeto.
2. Crie uma nova branch (`git checkout -b feature/nova-feature`).
3. Faça commit das suas alterações (`git commit -am 'Adiciona nova feature'`).
4. Faça push para a branch (`git push origin feature/nova-feature`).
5. Crie um novo Pull Request.

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.