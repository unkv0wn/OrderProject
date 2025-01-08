# OrderProject

O **OrderProject** é uma API RESTful para controle de pedidos de uma empresa, com foco em aprendizado no processo de criação de APIs e integração com o front-end (Flutter) e o back-end.

## Tecnologias

- **Express**: Framework minimalista para Node.js, utilizado para criar a API RESTful.
- **Node.js**: Ambiente de execução para JavaScript no back-end.
- **PostgreSQL**: Banco de dados relacional utilizado para armazenar os dados dos pedidos e entidades relacionadas.
- **Docker**: Utilizado para a containerização da aplicação, facilitando o deploy e execução em diferentes ambientes.
- **Flutter**: Desenvolvimento de Interfaces Graficas com o Usuario.


### rotas de cadastros metodos POST

- clifor

```json
{
    "ds_nome": "João da Silva",
    "nr_cpf": "123.456.789-00",
    "dt_nascimento": "1990-05-20",
    "cd_logradouro": "R",
    "ds_rua": "Rua das Flores",
    "nr_rua": "123",
    "ds_complemento": "Apt 45",
    "ds_bairro": "Centro",
    "ds_cidade": "São Paulo",
    "cd_cep": "01000-000"
}
  ```

- Logradouro

```json
{
    "cd_logradouro": "R",
    "ds_logradouro": "Rua"
}
  ```

- Forma pagamento

```json
{
  "cd_forma": "BL",
  "ds_forma": "boleto"
}
```

- Unidade medida

```json
{
  "cd_unidade": "UN",
  "ds_unidade": "unidade"
}
```

- marca

```json
{
 "ds_marca": "MarcaX"
}
```

- Produto

```json
{
   "ds_nome": "Produto Exemplo",
   "cd_unidade": "UN",
   "cd_marca": 1,
   "vl_preco": 99.99
}
```

 - pedido

```json
{
  "id_clifor": 2,
  "cd_forma": "BL"
}
```

- item pedido

```json
{
 "id_pedido": 1,
 "id_produto": 1,
 "quantidade": 2,
 "vl_unitario": 150.00,
 "desconto": 30.00
}
```

### Consultas de metodos GET

  - Consulta Clientes
    - localhost:3000/clifor
  
  - Consultar Produtos
    - localhost:3000/product
  
  - Consutar Unidade de Medidas
    - localhost:3000/unitmeasurement
  
  - Consultar Formas de Pagamento
    - localhost:3000/paymentform

  - Consultar Logradouro
    - localhost:3000/publicplace

  - Consultar Marcas
    - localhost:3000/mark

  - Consultar Pedidos
    -  localhost:3000/order

  [#] Consulta GET atraves do seu ID

  - Consultar Items do Pedido pelo id
    - localhost:3000/orderitem/list/${id_pedido}

  - Consulta Clientes
    - localhost:3000/clifor/${id}
  
  - Consultar Produtos
    - localhost:3000/product/${id}
  
  - Consutar Unidade de Medidas
    - localhost:3000/unitmeasurement/${cd_unidade}
     - ex - localhost:3000/unitmeasurement/un

  - Consultar Formas de Pagamento
    - localhost:3000/paymentform/${cd_forma}
      - ex: - localhost:3000/paymentform/bl

  - Consultar Logradouro
    - localhost:3000/publicplace/${cd_logradouro}
      - ex: - localhost:3000/publicplace/r

  - Consultar Marcas
    - localhost:3000/mark${id}
  
### Rotas de deletar metodo DELETE

  - Deletar Item Pedido
    - localhost:3000/orderitem/list/${id}

### O Que fazer ?

  - [] Adicionar repositories e validadores
  - [] Funcao de alterar (marca, forma de pagamento, cliente, produto, logradouro, unidade de medida)

