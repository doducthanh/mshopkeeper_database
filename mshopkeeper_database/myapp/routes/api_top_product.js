var express = require('express');
var router = express.Router();
var mysql = require('./database');
var jwt = require('jsonwebtoken');

// top sản phẩm bán chạy trong ngày tai 1 chi nhanh
let topProductInDay = function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    let shopID = req.headers.shopid;
    console.log(shopID);
    let sql = "SELECT model.modelName, table2.count, model.modelID"
              + " FROM model, (SELECT *, COUNT(*) AS count"
              + " FROM item"
              + " WHERE dateSell = current_date"
              + " GROUP BY item.modelID) AS table2"
              + " WHERE model.modelID = table2.modelID"
              + " AND model.shopID = "+shopID
    console.log(sql);
    mysql.query(mysql.format(sql), function (err, result) {
      if (!err) {
        res.status(200).json(result);
      }
    });
  } catch(e) {
    console.log("error");
  } finally {

  }
}
// top sản phẩm bán chạy trong tuần tại 1 chi nhánh
let topProductInWeek = function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    let shopID = req.headers.shopid;
    console.log(shopID);
    let sql = "SELECT model.modelName, table2.count, model.modelID"
              + " FROM model, (SELECT *, COUNT(*) AS count"
              + " FROM item"
              + " WHERE dateSell between (select DATE_ADD(CURRENT_DATE, INTERVAL(1-DAYOFWEEK(CURRENT_DATE)) DAY)) and (select DATE(NOW() + INTERVAL (7 - DAYOFWEEK(NOW())) DAY))"
              + " GROUP BY item.modelID) AS table2"
              + " WHERE model.modelID = table2.modelID"
              + " AND model.shopID = "+shopID
    console.log(sql);
    mysql.query(mysql.format(sql), function (err, result) {
      if (!err) {
        res.status(200).json(result);
      }
    });
  } catch(e) {
    console.log("error");
  } finally {

  }
}
// top sản phẩm bán chạy trong tháng tại 1 chi nhánh
let topProductInMonth = function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    let shopID = req.headers.shopid;
    console.log(shopID);
    let sql = "SELECT model.modelName, table2.count, model.modelID"
              + " FROM model, (SELECT *, COUNT(*) AS count"
              + " FROM item"
              + " WHERE AND dateSell between (SELECT DATE_SUB(CURRENT_DATE, INTERVAL DAYOFMONTH(CURRENT_DATE)-1 DAY)) and (SELECT LAST_DAY(CURRENT_DATE))"
              + " GROUP BY item.modelID) AS table2"
              + " WHERE model.modelID = table2.modelID"
              + " AND model.shopID = "+shopID
    console.log(sql);
    mysql.query(mysql.format(sql), function (err, result) {
      if (!err) {
        res.status(200).json(result);
      }
    });
  } catch(e) {
    console.log("error");
  } finally {

  }
}

// top sản phẩm bán chạy trong ngày tai 1 chi nhanh
let allTopProductInDay = function (req, res) {
  let shopID = req.headers.shopid;
  console.log(shopID);
  let sql = "SELECT model.modelName, table2.color, table2.size, table2.count "
              + "FROM model, (SELECT *, COUNT(*) AS count "
                            + "FROM item, shop "
                            + "WHERE status = 1 AND dateSell = current_date AND shopID = " + shopID
                            + " OR shop.parentShopID = " + shopID
                            + " GROUP BY SKUCode"
                            + " ORDER BY COUNT(*)) as table2 "
              + " WHERE model.modelID = table2.modelID";
  console.log(sql);
  mysql.query(mysql.format(sql), function (err, result) {
    if (!err) {
      res.status(200).json(result);
    }
  });
}
// top sản phẩm bán chạy trong tuần tại 1 chi nhánh
let allTopProductInWeek = function (req, res) {
  let shopID = req.headers.shopid;
  let sql = "SELECT model.modelName, table2.color, table2.size, table2.count "
              + "FROM model, (SELECT *, COUNT(*) AS count"
                            + "FROM item, shop "
                            + "WHERE status = 1 AND shopID = " + shopID
                            + " OR shop.parentShopID = " + shopID
                            + " AND dateSell between (select DATE_ADD(CURRENT_DATE, INTERVAL(1-DAYOFWEEK(CURRENT_DATE)) DAY)) and (select DATE(NOW() + INTERVAL (7 - DAYOFWEEK(NOW())) DAY))"
                            + " GROUP BY SKUCode + ORDER BY COUNT(*)) as table2 "

              + " WHERE model.modelID = table2.modelID";
  console.log(sql);
  mysql.query(mysql.format(sql), function (err, result) {
    if (!err) {
      res.status(200).json(result);
    }
  });
}
// top sản phẩm bán chạy trong tháng tại 1 chi nhánh
let allTopProductInMonth = function (req, res) {
  let shopID = req.headers.shopid;
  let sql = "SELECT model.modelName, table2.color, table2.size , table2.count"
              + "FROM model, (SELECT *, COUNT(*) AS count"
                            + "FROM item, shop "
                            + "WHERE status = 1 AND shopID = " + shopID
                            + " OR shop.parentShopID = " + shopID
                            + " AND dateSell between (SELECT DATE_SUB(CURRENT_DATE, INTERVAL DAYOFMONTH(CURRENT_DATE)-1 DAY)) and (SELECT LAST_DAY(CURRENT_DATE))"
                            + " GROUP BY SKUCode ORDER BY COUNT(*) ) as table2 "
              + " WHERE model.modelID = table2.modelID";
  mysql.query(mysql.format(sql), function (err, result) {
    if (!err) {
      res.status(200).json(result);
    }
  });
}
module.exports.topProductInDay = topProductInDay;
module.exports.topProductInWeek = topProductInWeek;
module.exports.topProductInMonth = topProductInMonth;
module.exports.allTopProductInDay = allTopProductInDay;
module.exports.allTopProductInWeek = allTopProductInWeek;
module.exports.allTopProductInMonth = allTopProductInMonth;
