const { DataTypes } = require('sequelize');
const sequelize = require('../services/database/db');

const UnitOfMeasurement = sequelize.define('unidademedida', {
    cd_unidade: {
        type: DataTypes.STRING(3),
        primaryKey:  true,
        allowNull:  false,
        set(value) {
            this.setDataValue('cd_unidade', value.toUpperCase());
        }
    },
    ds_unidade: {
        type: DataTypes.STRING(100),
        allowNull:  false,
        set(value) {
            this.setDataValue('ds_unidade', value.toUpperCase());
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
    tableName: 'unidademedida',
    timestamps: false  
});

module.exports = UnitOfMeasurement;