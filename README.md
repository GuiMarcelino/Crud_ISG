README.md
---

# Projeto CRUD de Usuários/Comentários/Posts com Autenticação

## Índice

- [Requisitos](#requisitos)
- [Instalação e Configuração](#instalação-e-configuração)
- [Executando o Projeto](#executando-o-projeto)
- [Postman Collection](#postman-collection)

---

## Descrição

Este projeto é uma aplicação Rails que permite a criação, leitura, atualização e exclusão de usuários. Além disso, possui autenticação de usuários através de JSON Web Tokens (JWT).

---

## Requisitos

- Ruby 3.1.0
- Rails 7.0.6
- PostgreSQL 12.x

---

## Instalação e Configuração

1. **Clone o repositório:**

    ```
    git clone https://github.com/GuiMarcelino/Crud_ISG.git
    ```

2. **Navegue até o diretório do projeto:**

    ```
    cd Crud_ISG
    ```

3. **Instale as dependências:**

    ```
    bundle install
    ```

4. **Configure o banco de dados:**

    ```
    rails db:create
    rails db:migrate
    ```

5. **Execute o Seed para criar dados iniciais:**

    ```
    rails db:seed
    ```

---

## Executando o Projeto

Inicie o servidor Rails:

```
rails server
```

Agora você pode acessar o projeto em `http://localhost:3000`.

---

## Postman Collection

Para testar todas as rotas disponíveis, você pode importar o arquivo `Crud_User_Postman_Collection.json` no Postman.

---

