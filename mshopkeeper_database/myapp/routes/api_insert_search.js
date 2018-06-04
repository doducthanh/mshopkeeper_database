var express = require('express');
var router = express.Router();
var mysql = require('./database');
var jwt = require('jsonwebtoken');

let insertSearch = function (req, res) {
  var token = req.headers.authorization;
  var skucode = req.body.skucode;
  try {
    var json = jwt.verify(token, 'secretkey');
    console.log(json);
    json = json['row'];
    let shopID = json['shopID'];
    console.log(shopID);
    let sql = "INSERT INTO seach (SKUCode, shopID, date) VALUES ('"+skucode+"', "+shopID+", CURRENT_DATE)";
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
module.exports = insertSearch;
