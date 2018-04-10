var express = require('express');
var router = express.Router();
var mysql = require('./database');
var jwt = require('jsonwebtoken');

var login_manager = router.post('/login_manager', function (req, res) {
  var userName = req.body.userName;
  var password = req.body.password;
  var companyCode = req.headers['companycode'];
  var query = mysql.format('select * from account where shopID = (select shopID from shop where shopCode = ?) and userName = ? and password = ? and role = 1',[companyCode, userName, password]);
  //console.log(query);
  mysql.query(query, function (err, row) {
    if (!err && (row.length > 0)) {
      var user = {};
      user['data'] = 'User registered successfully!';
      jwt.sign({exp: Math.floor(Date.now() / 1000) + 60*60*24 , row:row[0]}, 'secretkey', function (err, token) {
        user['token'] = token;
        user['userID'] = row[0].userID;
        user['userName'] = row[0].userName;
        user['password'] = row[0].password;
        user['fullName'] = row[0].fullName;
        user['email'] = row[0].email;
        user['tel'] = row[0].tel;
        user['role'] = row[0].role;
        user['tokenType'] = token.type;
        user['shopID'] = row[0].shopID;
        user['tokenStart'] = Math.floor(Date.now() / 1000);
        res.status(200).json(user);
        var decode = jwt.decode(token, {complete: true});
        //parser token
        //console.log(decode.payload['row']['userName']);
      });
    } else {
      var user = {};
      user['data'] = 'Error Occured!';
      res.status(204).json(user);
    }
  });
});

module.exports = login_manager
