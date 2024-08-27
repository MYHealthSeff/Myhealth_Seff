const { DataTypes } = require('sequelize');
const dbConfig = require('../config/config'); // Corrected path
const bcrypt = require('bcryptjs');

// Assuming that the Sequelize instance is exported from config/config.js
const sequelize = new dbConfig.development.sequelize(); 

const User = sequelize.define('User', {
  username: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
});

User.beforeCreate(async (user) => {
  const salt = await bcrypt.genSalt(10);
  user.password = await bcrypt.hash(user.password, salt);
});

module.exports = User;
