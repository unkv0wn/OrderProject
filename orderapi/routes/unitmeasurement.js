const express = require("express");
const UnitOfMeasurement = require("../models/unitmeasurement");
const sequelize = require("../services/database/db");
const router = express.Router();
const { Sequelize } = require("sequelize");

router.post("/", async (req, res) => {
  const { cd_unidade, ds_unidade } = req.body;

  try {
    if (!cd_unidade || !ds_unidade) {
      return res.status(400).send({
        message: "Os Campos nao pode estarem vazios.",
      });
    }

    const verify = await UnitOfMeasurement.findOne({
      where: {
        cd_unidade: cd_unidade.toUpperCase(),
      },
    });

    if (verify) {
      return res.status(409).send({
        message: "Unidade ja possui cadastrada",
      });
    }

    await UnitOfMeasurement.create({
      cd_unidade,
      ds_unidade,
    });

    return res.status(201).send({
      message: "Unidade de medida cadastrada com sucesso!",
    });
  } catch (error) {

    console.log(error)
    if (error instanceof Sequelize.UniqueConstraintError) {
      return res.status(409).json({
        message: "Já existe uma unidade de medida com este código.",
      });
    }

    return res.status(500).json({
      message: "Falha ao processar requisicao",
    });
  }
});

router.get("/", async (req, res) => {
  try {
    const data = await UnitOfMeasurement.findAll({});

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

    const data =  await UnitOfMeasurement.findAll({
      where: {
        cd_unidade: id.toUpperCase(),
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
