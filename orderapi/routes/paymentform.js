const express = require("express");
const PaymentForm = require("../models/paymentform");
const { Sequelize } = require("sequelize");
const router = express.Router();

router.post("/", async (req, res) => {
  const { cd_forma, ds_forma } = req.body;

  try {
    if (!cd_forma || !ds_forma) {
      return res.status(400).send({
        message: "Os campos nao pode estarem vazios.",
      });
    }

    const verify = await PaymentForm.findOne({
      where: {
        cd_forma: cd_forma.toUpperCase(),
      },
    });

    if (verify) {
      return res.status(409).send({
        message: "Forma de  pagamento ja cadastrada",
      });
    }

    await PaymentForm.create({
      cd_forma,
      ds_forma,
    });

    return res.status(201).send("Forma de Pagamento cadastrada com sucesso!");
  } catch (error) {
    if (error instanceof Sequelize.UniqueConstraintError) {
      return res.status(409).json({
        message: "Já existe uma forma de pagamento com este código.",
      });
    }

    return res.status(500).json({ message: "Falha ao processar requisicao" });
  }
});

router.get("/", async (req, res) => {
  try {
    const data = await PaymentForm.findAll({});

    return res.status(200).send(data);
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Falha ao processar requisicao" + error });
  }
});

//Puxando pedido pelo ID
router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params;

    const data = await PaymentForm.findAll({
      where: {
        cd_forma: id.toUpperCase(),
      },
    });

    if (data.length === 0) {
      return res.status(404).send({
        message: "Id nao encontrado.",
      });
    }

    res.status(200).send({ data });
  } catch (error) {
    console.log(error);
    res.status(500).send({
      message: "Erro ao processar informação",
    });
  }
});

module.exports = router;
