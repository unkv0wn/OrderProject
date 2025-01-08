const express = require("express");
const PublicPlace = require("../models/publicplace"); 
const router = express.Router();
const { Sequelize } = require("sequelize");

router.post("/", async (req, res) => {
  const { cd_logradouro, ds_logradouro } = req.body;

  try {
    if (!cd_logradouro || !ds_logradouro) {
      return res.status(400).send({
        message: "Os Campos não podem estar vazios.",
      });
    }

    const verify = await PublicPlace.findOne({
      where: {
        cd_logradouro: cd_logradouro.toUpperCase(),
      },
    });

    if (verify) {
      return res.status(409).send({
        message: "Logradouro já cadastrado",
      });
    }

    await PublicPlace.create({
      cd_logradouro,
      ds_logradouro,
    });

    return res.status(201).send({
      message: "Logradouro cadastrado com sucesso!",
    });
  } catch (error) {
    console.log(error);
    if (error instanceof Sequelize.UniqueConstraintError) {
      return res.status(409).json({
        message: "Já existe um Logradouro cadastrado",
      });
    }

    return res.status(500).json({
      message: "Falha ao processar a requisição",
    });
  }
});

router.get("/", async (req, res) => {
  try {
    const data = await PublicPlace.findAll({});

    return res.status(200).send(data);
  } catch (error) {
    return res.status(500).send({
      message: "Falha ao processar a requisição: " + error,
    });
  }
});

//Puxando pedido pelo ID
router.get("/:id", async (req, res) => {
  try {
    const {id} = req.params;

    const data =  await PublicPlace.findAll({
      where: {
        cd_logradouro: id.toUpperCase(),
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
