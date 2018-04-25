var express = require('express');
var router = express.Router();
var mysql = require('./database');
var jwt = require('jsonwebtoken');

let getAllRevenue = function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    console.log(json);
    json = json['row'];
    let shopID = json['shopID'];
    var sql = mysql.format("select * from item where shopID = ? or shopID = (select shopID from shop where parentShopID = ?) and status = 1", [shopID, shopID]);
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
    })
  } catch (e) {
    console.log('verify error');
  } finally {
    console.log('end request');
  }
}

module.exports = getAllRevenue;
