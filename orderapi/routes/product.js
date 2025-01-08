const express = require("express");
const Product = require("../models/product");
const { Sequelize } = require("sequelize");

const router = express.Router();

router.post("/", async (req, res) => {
  const { ds_nome, cd_unidade, cd_marca, vl_preco } = req.body;

  try {
    if (!ds_nome || !cd_unidade || !cd_marca || vl_preco === undefined) {
      return res.status(400).send({
        message: "Nome, unidade, marca e preço são obrigatórios.",
      });
    }

    const verify = await Product.findOne({
      where: {
        ds_nome: ds_nome.toUpperCase(),
      },
    });

    if (verify) {
      return res.status(409).send({
        message: "Produto ja possui um cadastro",
      });
    }

    await Product.create({
      ds_nome,
      cd_unidade,
      cd_marca,
      vl_preco,
    });

    return res.status(201).send({
      message: "Produto cadastrado com sucesso!",
    });
  } catch (error) {
    console.error(error);

    if (error instanceof Sequelize.UniqueConstraintError) {
      return res.status(409).json({
        message: "Já existe um produto cadastrado.",
      });
    }

    return res.status(500).json({
      message: "Falha ao processar a requisição",
    });
  }
});

router.get("/", async (req, res) => {
  try {
    const data = await Product.findAll({});

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

    const data =  await Product.findAll({
      where: {
        id_produto: id,
      }
    });

    if ( data.length === 0) {
      return res.status(404).send({
        message: "Id nao encontrado."
      })
    }

    res.status(200).send(data)
  } catch (error) {
    console.log(error);
    res.status(500).send({
      message: "Erro ao processar informação"
    })
  }  
})

module.exports = router;
