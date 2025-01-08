const { DataTypes } = require('sequelize');
const sequelize = require('../services/database/db');

const PublicPlace = sequelize.define('tipologradouro', {
    cd_logradouro: {
        type: DataTypes.STRING(10),
        primaryKey:  true,
        allowNull:  false,
        set(value) {
            this.setDataValue('cd_logradouro', value.toUpperCase());
        }
    },
    ds_logradouro: {
        type: DataTypes.STRING(200),
        allowNull:  false,
        set(value) {
            this.setDataValue('ds_logradouro', value.toUpperCase());
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
    tableName: 'tipologradouro',
    timestamps: false  
});

module.exports = PublicPlace;
