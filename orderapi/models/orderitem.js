const { DataTypes } = require("sequelize");
const sequelize = require("../services/database/db");

const OrderItem = sequelize.define('itempedido', {
    id_itempedido: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true
    },
    id_pedido: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: "pedido",
            key: "id_pedido"
        }
    },
    id_produto: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: "produto",
            key: "id_produto"
        }
    },
    quantidade: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
    },
    vl_unitario: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
    },
    desconto: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
        defaultValue: 0
    },
    vl_total: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
    }
}, {
    tableName: "itempedido",
    timestamps: false,
    hooks: {
        // Hook antes de salvar o item, para calcular o vl_total
        beforeSave: (orderItem) => {
                        // Garantir que o desconto seja 0 caso não tenha valor
                        if (orderItem.desconto === null || orderItem.desconto === undefined) {
                            orderItem.desconto = 0;
                        }
            // Calcular vl_total = (vl_unitario * quantidade) - desconto
            orderItem.vl_total = (orderItem.vl_unitario * orderItem.quantidade) - orderItem.desconto;
        }
    }
});

module.exports = OrderItem;
