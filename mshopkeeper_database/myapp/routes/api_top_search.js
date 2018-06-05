var express = require('express');
var router = express.Router();
var mysql = require('./database');
var jwt = require('jsonwebtoken');

let topSearch = function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    console.log(json);
    json = json['row'];
    let shopID = json['shopID'];
    console.log(shopID);
    let sql = "SELECT *, COUNT(*) as count"
              +" FROM seach"
              +" WHERE shopID = " + shopID
              +" GROUP BY SKUCode"
    console.log(sql);
    mysql.query(mysql.format(sql), function (err, result) {
      console.log(result);
      res.status(200).send(result);
    });
  } catch(e) {
    console.log("error");
  } finally {

  }
}
module.exports = topSearch;
