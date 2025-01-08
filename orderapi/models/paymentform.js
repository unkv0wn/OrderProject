const { DataTypes } = require('sequelize');
const sequelize = require('../services/database/db');

const PaymentForm = sequelize.define('formapagto', {
    cd_forma: {
        type: DataTypes.STRING(3),
        primaryKey: true,
        allowNull: false,
        set(value) {
            this.setDataValue('cd_forma', value.toUpperCase());
        }
    },
    ds_forma: {
        type: DataTypes.STRING(100),
        allowNull: false,
        set(value) {
            this.setDataValue('ds_forma', value.toUpperCase());
        }
    },
    st_ativo: {
        type: DataTypes.STRING(1),
        allowNull: false,
        defaultValue: 'S',
        set(value) {
            this.setDataValue('st_ativo', value.toUpperCase());
        }
    }, 
}, {
    tableName: 'formapagto',
    timestamps: false  
});

module.exports = PaymentForm;
