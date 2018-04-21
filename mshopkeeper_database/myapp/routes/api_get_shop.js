var express = require('express');
var router = express.Router();
var mysql = require('./database');
var jwt = require('jsonwebtoken');

var getShop = function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    console.log(json);
    json = json['row'];
    var sql = mysql.format("select * from shop where parentShopID = ?", [json['shopID']]);
    console.log(sql);
    mysql.query(sql, function (error, row) {
      if (error) {
        res.status(500).json({error: "error"});
      }
      if (!error) {
        res.status(200).json(row);
      }
    });
  } catch (e) {
    console.log('verify error');
  } finally {
    console.log('end request');
  }
}

module.exports = getShop;
