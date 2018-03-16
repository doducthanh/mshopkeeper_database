var express = require('express');
var router = express.Router();
var mysql = require('./database');
var jwt = require('jsonwebtoken');
//create connection


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/list_all_food', function (req, res, next) {
  var query = 'select * from Branch';
  mysql.query(query, function (error, result) {
    //res.send(error)
    res.send(result);
  });
});

router.post('/insert_food', function (req, res, next) {
  res.send('ok request');
});

//API log in
router.post('/login', function (req, res) {
  var userName = req.body.userName;
  var password = req.body.password;
  var companyCode = req.headers['companycode'];
  var query = mysql.format('select * from account where shopID = (select shopID from shop where shopCode = ?) and userName = ? and password = ?',[companyCode, userName, password]);
  console.log(query);
  mysql.query(query, function (err, row, result) {
    if (!err) {
      var user = {};
      user.error = 0;
      user['data'] = 'User registered successfully!';
      jwt.sign({row:row[0]}, 'secretkey', function (err, token) {
        user['token'] = token;
        user['userID'] = row[0].userID;
        user['userName'] = row[0].userName;
        user['password'] = row[0].password;
        user['fullName'] = row[0].fullName;
        user['email'] = row[0].email;
        user['tel'] = row[0].tel;
        user['role'] = row[0].role;
        res.status(200).json(user);
        var decode = jwt.decode(token, {complete: true});
        //parser token
        console.log(decode.payload['row']['userName']);
      });
    } else {
      var user = {};
      user['data'] = 'Error Occured!';
      res.status(400).json(user);
    }
  });
});

//API lấy tất cả model
router.get ('/get_all_model', function (req, res) {
  console.log(req.headers);
  var token = req.headers['token'];
  console.log(token);
  //res.status(200).json(jwt.decode(req.body.authorization['row']));
});

function verifyToken(token){
  jwt.verify(token, 'verify', function (err, decode) {
    console.log(decode);
  });
};
module.exports = router;
