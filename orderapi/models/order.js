const { DataTypes, Sequelize } = require("sequelize");
const sequelize = require("../services/database/db");
const OrderItem = require("./orderItem"); // Ajuste o caminho conforme necessário

const Order = sequelize.define("pedido", {
  id_pedido: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    allowNull: false,
    autoIncrement: true
  },
  id_clifor: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'clifor', 
      key: 'id_clifor',
    }
  },
  cd_forma: {
    type: DataTypes.STRING(3),
    allowNull: false,
    references: {
      model: 'formapagto', 
      key: 'cd_forma',
    }
  },
  dt_emissao: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: Sequelize.fn("NOW"),
  },
  st_pedido: {
    type: DataTypes.STRING(1),
    allowNull: false,
    defaultValue: "0",
    set(value) {
      this.setDataValue("st_pedido", value.toUpperCase());
    }
  },
  valor_total: {
    type:  DataTypes.DECIMAL(10, 2),
    allowNull: false,
    defaultValue: 0
  },
}, {
  tableName: "pedido",
  timestamps: false
});

module.exports = Order;


/*
0 - Pendete
1 - Concluido
2 - Cancelado
*/