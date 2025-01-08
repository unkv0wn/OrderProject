const { Sequelize } = require('sequelize');

const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
  host: process.env.DB_HOST,  
  dialect: 'postgres',   
  logging: false,
  port: process.env.DB_PORT  
});

module.exports = sequelize;