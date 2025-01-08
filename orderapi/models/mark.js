const { DataTypes } = require("sequelize");
const sequelize = require("../services/database/db");

const Mark = sequelize.define("marca", {
  cd_marca: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    allowNull: false,
    autoIncrement: true
  },
  ds_marca: {
    type: DataTypes.STRING(100),
    allowNull: false,
    set(value) {
      this.setDataValue("ds_marca", value.toUpperCase());
    },
  },
  st_ativo: {
    type: DataTypes.STRING(1),
    allowNull: false,
    defaultValue: "S",
    set(value) {
      this.setDataValue("st_ativo", value.toUpperCase());
    },
  },
}, {
    tableName: "marca",
    timestamps: false,
  });

module.exports = Mark;
