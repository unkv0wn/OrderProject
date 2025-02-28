const express = require("express");
const OrderItem = require("../models/orderItem");
const Order = require("../models/order"); // Importa o modelo Order
const router = express.Router();

// Função para atualizar o valor total do pedido
async function UpdateTotalValue(pedidoId) {
    try {
        const total = await OrderItem.sum('vl_total', {
            where: {
                id_pedido: pedidoId
            }
        });

        await Order.update(
            { valor_total: total || 0 }, // Se não houver itens, define como 0
            { where: { id_pedido: pedidoId } }
        );
    } catch (error) {
        console.error('Erro ao atualizar o valor total do pedido:', error);
    }
}

router.post("/", async (req, res) => {
    // Atribui valor default de 0 para desconto se não for enviado
    const { id_pedido, id_produto, quantidade, vl_unitario, desconto = 0 } = req.body;

    // Lista de campos obrigatórios
    const requiredFields = ['id_pedido', 'id_produto', 'quantidade', 'vl_unitario'];

    // Valida se algum campo obrigatório está faltando
    for (let field of requiredFields) {
        if (!req.body[field]) {
            return res.status(400).send({
                message: `O campo ${field} é obrigatório.`,
            });
        }
    }

    try {
        // Cria o item do pedido
        await OrderItem.create({
            id_pedido,
            id_produto,
            quantidade,
            vl_unitario,
            desconto,
            vl_total: (quantidade * vl_unitario) - desconto, // Calcula o valor total
        });

        // Atualiza o valor total do pedido
        await UpdateTotalValue(id_pedido);

        return res.status(201).send({
            message: "Item do pedido cadastrado com sucesso!",
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            message: "Falha ao processar a requisição",
        });
    }
});

// Rota para deletar um item do pedido
router.delete("/:id", async (req, res) => {
  const { id } = req.params;

  try {
      const orderItem = await OrderItem.findByPk(id);
      if (!orderItem) {
          return res.status(404).send({ message: "Item do pedido não encontrado." });
      }

      await OrderItem.destroy({
          where: { id_itempedido: id }
      });

      await UpdateTotalValue(orderItem.id_pedido);
      return res.status(200).send({
          message: "Item do pedido deletado com sucesso!",
      });
  } catch (error) {
      console.error(error);
      return res.status(500).send({
          message: "Falha ao processar a requisição: " + error,
      });
  }
});

// Rota para listar items de um pedido
router.get("/listitem/:id", async (req, res) => {
    try {
      const { id } = req.params;
  
      // Buscar os itens do pedido no banco de dados
      const data = await OrderItem.findAll({
        where: {
          id_pedido: id
        }
      });
  
      // Processar os dados para garantir que os números sejam retornados corretamente
      const formattedData = data.map(item => {
        return {
          ...item.dataValues, // Pega todos os campos do item
          quantidade: parseFloat(item.quantidade), // Converter para float
          vl_unitario: parseFloat(item.vl_unitario), // Converter para float
          desconto: parseFloat(item.desconto), // Converter para float
          vl_total: parseFloat(item.vl_total) // Converter para float
        };
      });
  
      // Enviar a resposta com os dados processados
      res.status(200).send(formattedData);
    } catch (error) {
      console.log(error);
      res.status(500).send({
        message: "Erro ao processar requisição"
      });
    }
  });
  

module.exports = router;