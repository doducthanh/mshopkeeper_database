var express = require('express');
var router = express.Router();
var mysql = require('./database');
var jwt = require('jsonwebtoken');

let topRevenue = function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    console.log(json);
    json = json['row'];
    let shopID = json['shopID'];
    console.log(shopID);
    let sql = "SELECT shopName, doanhthu " +
              "FROM shop, ( SELECT shopID, COUNT(shopID) , (unitPrice * COUNT(shopID)) AS doanhthu " +
                          "FROM item WHERE status = 1 AND " +
                                           "shopID IN (SELECT shopID " +
                                                    "FROM shop " +
                                                    "WHERE shopID = "+ shopID + " OR parentShopID = "+ shopID + ")" +
              "GROUP BY shopID ORDER BY (unitPrice * COUNT(shopID)) ) AS shop2 " +
              "WHERE shop.shopID = shop2.shopID ORDER BY doanhthu"
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

module.exports = topRevenue;
