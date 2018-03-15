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

router.post('/login', function (req, res) {
  var user = {};
  var userName = req.body.userName;
  var password = req.body.password;
  mysql.query('select * from Account where userName = ?', [userName], function (err, row, result) {
    if (!err) {
      user.error = 0;
      user['data'] = 'User registered successfully!';
      jwt.sign({row:row[0]}, 'secretkey', function (err, token) {
        user['token'] = token;
        user['userName'] = row[0].userName;
        user['password'] = row[0].password;
        user['fullName'] = row[0].fullName;
        user['email'] = row[0].email;
        user['tel'] = row[0].tel;
        res.status(400).json(user);
      });
    } else {
      appData['data'] = 'Error Occured!';
      res.status(400).json(user);
    }
  });
});

function verifyToken() {

}
module.exports = router;
