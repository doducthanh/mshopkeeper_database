var express = require('express');
var router = express.Router();
var mysql = require('./database');
var jwt = require('jsonwebtoken');

var getShop = router.get('/get_shop', function (req, res) {
  console.log(req);
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    json = json['row'];
    var sql = mysql.format("select * from shop where parentShopID = ?", [json['shopID']]);
    mysql.query(sql, function (error, row) {
      if (error) {
        res.status(500).json({error: "error"});
      } else {
         res.status(200).json(row);
      }
    });
  } catch (e) {

  } finally {

  }
});

module.exports = getShop
