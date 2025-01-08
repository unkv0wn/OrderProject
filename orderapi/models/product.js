const { DataTypes } = require("sequelize");
const sequelize = require("../services/database/db");

const Product = sequelize.define("produto", {
  id_produto: {
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
      },
  },
  cd_unidade: {
    type: DataTypes.STRING,
    allowNull: false,
    references: {
      model: 'unidade', 
      key: 'cd_unidade', 
    },
  },
  cd_marca: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'marca', 
      key: 'cd_marca', 
    },
  },
  vl_preco: {
    type: DataTypes.DECIMAL(10, 2), 
    allowNull: false,
  },
  nr_codbarras: {
    type: DataTypes.STRING(60), 
    allowNull: true,
    defaultValue: '0'
  },
  st_status: {
    type: DataTypes.STRING(1), 
    allowNull: false,
    defaultValue: "S",
  },
}, {
  tableName: "produto",
  timestamps: false, 
});

module.exports = Product;