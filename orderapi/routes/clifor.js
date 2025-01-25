const express = require("express");
const clifor = require("../models/clifor");
const { Sequelize } = require("sequelize");
const router = express.Router();

router.post("/", async (req, res) => {
  const {
    ds_nome,
    nr_cpf,
    dt_nascimento,
    cd_logradouro,
    ds_rua,
    nr_rua,
    ds_complemento,
    ds_bairro,
    ds_cidade,
    cd_cep,
  } = req.body;

  try {
    const verify = await clifor.findOne({
      where: { nr_cpf },
    });

    if (verify) {
      return res
        .status(409)
        .json({ message: "Cliente já cadastrado com esse CPF." });
    }

    // Criando o novo registro na tabela "clifor"
    await clifor.create({
      ds_nome,
      nr_cpf,
      dt_nascimento,
      cd_logradouro,
      ds_rua,
      nr_rua,
      ds_complemento,
      ds_bairro,
      ds_cidade,
      cd_cep,
    });

    return res.status(201).json({ message: "Cliente cadastrado com sucesso!" });
  } catch (error) {
    console.error(error);
    return res
      .status(500)
      .json({ message: "Falha ao processar a requisição." });
  }
});

//Puxando todos  os clientes
router.get("/", async (req, res) => {
  const data = await clifor.findAll({
    where: {
      st_ativo: "S",
    },
  });

  res.status(200).send(data);
});

//Puxando Cliente pelo id_clifor
router.get("/:id", async (req, res) => {
  try {
    const {id} = req.params;

    const data =  await clifor.findAll({
      where: {
        id_clifor: id,
        st_ativo: "S"
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
