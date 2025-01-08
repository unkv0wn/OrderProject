const express = require("express");
const Mark = require("../models/mark");
const router = express.Router();
const { Sequelize } = require("sequelize");

router.post("/", async (req, res) => {
  const { ds_marca } = req.body;

  try {
    if (!ds_marca) {
      return res.status(409).send({
        message: "Os Campos não podem estar vazios.",
      });
    }

    // Verificação no banco para ver se a marca já existe
    const verify = await Mark.findOne({
      where: {
        ds_marca: ds_marca.toUpperCase(),
      },
    });

    if (verify) {
      return res.status(409).send({
        message: "Marca já cadastrada",
      });
    }

    await Mark.create({
      ds_marca: ds_marca,
    });

    return res.status(201).send({
      message: "Marca cadastrada com sucesso!",
    });
  } catch (error) {
    console.log(error);
    // Caso o erro seja de violação de unicidade
    if (error instanceof Sequelize.UniqueConstraintError) {
      return res.status(409).json({
        message: "Já existe uma marca cadastrada",
      });
    }

    return res.status(500).json({
      message: "Falha ao processar a requisição",
    });
  }
});

// Puxando todos as marcas cadastradas
router.get("/", async (req, res) => {
  try {
    const data = await Mark.findAll({});

    return res.status(200).send(data);
  } catch (error) {
    return res
      .status(500)
      .json({ message: "Falha ao processar requisicao" + error });
  }
});

//Puxando marca pelo ID
router.get("/:id", async (req, res) => {
  try {
    const {id} = req.params;

    const data =  await Mark.findAll({
      where: {
        cd_marca: id,
        st_ativo: "S"
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
