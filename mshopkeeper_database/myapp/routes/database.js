var mysql = require('mysql');

var database = mysql.createConnection({
  host: "localhost",
  user: "thanh",
  password: "123",
  database: "mshopkeeper_database"
});

database.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");


});

module.exports = database;
