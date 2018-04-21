var express = require('express');
var router = express.Router();
var mysql = require('./database');
var jwt = require('jsonwebtoken');

let getRevenue = function (req, res) {
  var shopID = req.headers.shopid;
  var sql = mysql.format("select * from item where shopID = ? and status = 1", [shopID]);
  console.log(sql);
  mysql.query(sql, function (err, result) {
    if (!err) {
      var json = {};
      var interest = 0;
      var capital = 0;
      for (var i = 0; i < result.length; i++) {
        interest = interest + result[i].unitPrice;
        capital = capital + result[i].cost;
      }
      json['thu'] = interest;
      json['chi'] = capital;
      json['lai'] = interest - capital;
      res.status(200).json(json);
    }
  });
}


module.exports = getRevenue;
