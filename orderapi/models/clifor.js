const { DataTypes, Sequelize } = require("sequelize");
const sequelize = require("../services/database/db");

const Clifor = sequelize.define('clifor',
  {
    id_clifor: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      allowNull: false,
      autoIncrement: true,
    },
    ds_nome: {
      type: DataTypes.STRING(100),
      allowNull: false,
      set(value) {
        this.setDataValue("ds_nome", value.toUpperCase());
      }
    },
    nr_cpf: {
      type: DataTypes.STRING(20),
      allowNull: false,
    },
    dt_nascimento: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    dt_cadastro: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: Sequelize.fn("NOW"),
    },
    cd_logradouro: {
      type: DataTypes.STRING(10),
      allowNull: false,
    },
    ds_rua: {
      type: DataTypes.STRING(200),
      allowNull: false,
      set(value) {
        this.setDataValue("ds_rua", value.toUpperCase());
      },
    },
    nr_rua: {
      type: DataTypes.STRING(60),
      allowNull: false,
    },
    ds_complemento: {
      type: DataTypes.STRING(200),
      allowNull: false,
      set(value) {
        this.setDataValue("ds_complemento", value.toUpperCase());
      },
    },
    ds_bairro: {
      type: DataTypes.STRING(200),
      allowNull: false,
      set(value) {
        this.setDataValue("ds_bairro", value.toUpperCase());
      },
    },
    ds_cidade: {
      type: DataTypes.STRING(100),
      allowNull: false,
      set(value) {
        this.setDataValue("ds_cidade", value.toUpperCase());
      },
    },
    cd_cep: {
      type: DataTypes.STRING(100),
      allowNull: false,
    },
    st_ativo: {
      type: DataTypes.STRING(1),
      allowNull: false,
      defaultValue: "S",
      set(value) {
        this.setDataValue("st_ativo", value.toUpperCase());
      },
    },
  },
  {
    tableName: "clifor",
    timestamps: false,
  }
);

module.exports = Clifor;
