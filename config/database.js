const { Sequelize } = require('sequelize');

// Replace with your actual database configuration
const sequelize = new Sequelize('database_development', 'root', 
'password_sql', {
  host: 'localhost',
  dialect: 'postgres', // Or 'mysql', 'sqlite', 'mariadb', 'mssql'
});

module.exports = sequelize;


