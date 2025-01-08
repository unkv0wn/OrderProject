const express = require("express");
const Order = require("../models/order");
const router = express.Router();

router.post("/", async (req, res) => {
  const { id_clifor, cd_forma } = req.body;

  try {
    if (!id_clifor || !cd_forma) {
      return res.status(400).send({
        message: "Os Campos nao pode estarem vazios.",
      });
    }

    await Order.create({
      id_clifor,
      cd_forma,
    });

    return res.status(201).send({
      message: "Pedido cadastrado com sucesso!",
    });
  } catch (error) {

    console.log(error)

    return res.status(500).json({
      message: "Falha ao processar requisicao",
    });
  }
});

router.get("/", async (req, res) => {
  try {
    const data = await Order.findAll({});

    return res.status(200).send(data);
  } catch (error) {
    return res.status(500).send({
      message: "Falha ao processar requisicao" + error,
    });
  }
});

//Puxando pedido pelo ID
router.get("/:id", async (req, res) => {
  try {
    const {id} = req.params;

    const data =  await Order.findAll({
      where: {
        id_pedido: id,
      }
    });

    if ( data.length === 0) {
      return res.status(404).send({
        message: "Id nao encontrado."
      })
    }

    res.status(200).send({data})
  } catch (error) {
    console.log(error);
    res.status(500).send({
      message: "Erro ao processar informação"
    })
  }  
})

module.exports = router;
