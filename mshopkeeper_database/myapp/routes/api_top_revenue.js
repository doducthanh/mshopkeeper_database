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
                                                    "WHERE shopID = "+ shopID + " OR parentShopID = "+ shopID + ")" + "and dateSell = current_date " +
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

let topRevenueInDay = function (req, res) {
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
                                                    "WHERE shopID = "+ shopID + " OR parentShopID = "+ shopID + ")" + "and dateSell = current_date " +
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
let topRevenueInWeek = function (req, res) {
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
                                                    "WHERE shopID = "+ shopID + " OR parentShopID = "+ shopID + ")"
                                                    + " AND dateSell between (select DATE_ADD(CURRENT_DATE, INTERVAL(1-DAYOFWEEK(CURRENT_DATE)) DAY)) and (select DATE(NOW() + INTERVAL (7 - DAYOFWEEK(NOW())) DAY))"
              + "GROUP BY shopID ORDER BY (unitPrice * COUNT(shopID)) ) AS shop2 " +
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
let topRevenueInMonth = function (req, res) {
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
                                                    "WHERE shopID = "+ shopID + " OR parentShopID = "+ shopID + ")"
                                                    + " AND dateSell between (SELECT DATE_SUB(CURRENT_DATE, INTERVAL DAYOFMONTH(CURRENT_DATE)-1 DAY)) and (SELECT LAST_DAY(CURRENT_DATE))"
              + "GROUP BY shopID ORDER BY (unitPrice * COUNT(shopID)) ) AS shop2 " +
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
