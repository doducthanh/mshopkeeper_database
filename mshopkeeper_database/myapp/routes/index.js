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
  mysql.query(query, function (err, row) {
    if (!err && (row.length > 0)) {
      var user = {};
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
        user['tokenType'] = token.type;
        res.status(200).json(user);
        var decode = jwt.decode(token, {complete: true});
        //parser token
        console.log(decode.payload['row']['userName']);
      });
    } else {
      var user = {};
      user['data'] = 'Error Occured!';
      res.status(500).json(user);
    }
  });
});

//API lấy tất cả model
router.get ('/get_all_model', function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    json = json['row'];
    var query = mysql.format('select * from model where shopID = ?',[json['shopID']]);
    mysql.query(query, function (error, row) {
      if (!error) {
        res.status(200).json(row);
      } else {
        var result;
        result['data'] = 'Error Occured!'
        res.status(500).json(result);
      }
    });
  } catch (e) {
    console.log('error token');
    res.status(500).json({error:'token expire'});
  } finally {

  }
});

// API lấy model theo thời gian
router.get ('/get_model_for_time', function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    json = json['row'];
    var query = mysql.format('select * from model where shopID = ? order by dateOfEntry DESC limit 100',[json['shopID']]);
    mysql.query(query, function (error, row) {
      if (!error) {
        res.status(200).json(row);
      } else {
        var result;
        result['data'] = 'Error Occured!'
        res.status(500).json(result);
      }
    });
  } catch (e) {
    console.log('error token');
    res.status(500).json({error:'token expire'});
  } finally {

  }
});

// API lấy model bán chạy
router.get ('/get_model_best_sale', function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    json = json['row'];
    var query = mysql.format('select * from model where shopID = ? order by saleCount DESC limit 2',[json['shopID']]);
    mysql.query(query, function (error, row) {
      if (!error) {
        res.status(200).json(row);
      } else {
        var result;
        result['data'] = 'Error Occured!'
        res.status(500).json(result);
      }
    });
  } catch (e) {
    console.log('error token');
    res.status(500).json({error:'token expire'});
  } finally {

  }
});

//API lấy model khuyến mại
router.get('/get_model_promotion', function (req, res) {
  var token = req.headers.authorization;
  try {
    var json = jwt.verify(token, 'secretkey');
    json = json['row'];
    var query = mysql.format('select * from model where shopID = ? and isPromotion = yes',[json['shopID']]);
    mysql.query(query, function (error, row) {
      if (!error) {
        res.status(200).json(row);
      } else {
        var result;
        result['data'] = 'Error Occured!'
        res.status(500).json(result);
      }
    });
  } catch (e) {
    console.log('error token');
    res.status(500).json({error:'token expire'});
  } finally {

  }
});

//API search model theo key
router.post('/search_model', function (req, res) {
  var token = req.headers.authorization;
  var keyWord = req.body.keyword;
  try {
    var json = jwt.verify(token, 'secretkey');
    json = json['row'];
    var query = mysql.format("select * from model where shopID = 3 and modelName like '%"+keyWord+"%'");
    console.log(query);
    mysql.query(query, function (error, row) {
      if (!error) {
        res.status(200).json(row);
      } else {
        var result;
        res.status(500).json({eror: "error"});
      }
    });
  } catch (e) {
    console.log('error token');
    res.status(500).json({error:'token expire'});
  } finally {

  }
});

// API lấy chi tiết sản phẩm
router.get('/detail_item', function (req, res) {
  var token = req.headers.authorization;
  var modelID = req.headers.modelid;
  console.log(modelID);
  try {
    var json = jwt.verify(token, 'secretkey');
    var query = mysql.format('select * from item, shop where modelID = ? and item.shopID = shop.shopID', [modelID]);
    console.log(query);
    mysql.query(query, function (error, row) {
      if (!error) {
        var result = {};
        var arrayColor = new Set();
        var arraySize = new Set();
        //lấy dữ liẹu mảng về size và color
        for (var i = 0; i < row.length; i++) {
          arrayColor.add(row[i]['color']);
          arraySize.add(row[i]['size']);
        }
        result['arrayColor'] = [...arrayColor];
        result['arraySize'] = [...arraySize];
        result['row'] = row;
        res.status(200).json(result);
      } else {
        var result;
        result['data'] = 'Error Occured!';
        res.status(500).json(result);
      }
    });
  } catch (e) {
    console.log('error token');
    res.status(500).json({error:'token expire'});
  } finally {

  }
})

//API thay đổi mật khẩu
router.post('/change_password', function (req, res) {
  var token = req.headers.authorization;
  var newPass = req.body.newpassword;
  try {
    var json = jwt.verify(token, 'secretkey');
    json = json['row'];
    var query = mysql.format('update account set password = ? where shopID = ? and userID = ?', [newPass, json['shopID'], json['userID']]);
    console.log(query);
    mysql.query(query, function (error, row) {
      if (!error) {
        var result = {};
        var arrayColor = new Set();
        var arraySize = new Set();
        //lấy dữ liẹu mảng về size và color
        for (var i = 0; i < row.length; i++) {
          arrayColor.add(row[i]['color']);
          arraySize.add(row[i]['size']);
        }
        result['arrayColor'] = [...arrayColor];
        result['arraySize'] = [...arraySize];
        result['row'] = row;
        res.status(200).json(result);
      } else {
        var result;
        result['data'] = 'Error Occured!';
        res.status(500).json(result);
      }
    });
  } catch (e) {
    console.log('error token');
    res.status(500).json({error:'token expire'});
  } finally {

  }
});

//API lấy lại mật khẩu
router.get('/get_password', function (req, res) {
  var shopCode = req.headers.companycode;
  var userName = req.headers.username;
  console.log(shopCode);
  var query = mysql.format('select password from account where shopID = (select shopID from shop where shopCode = ?) and userName = ?', [shopCode, userName]);
  console.log(query);
  mysql.query(query, function (error, result) {
    if (!error && result.length > 0) {
      res.status(400).json({password: result[0].password});
    } else {
      res.status(500).json({message: 'error infor'});
    }
  });
});

function verifyToken(token){
  jwt.verify(token, 'verify', function (err, decode) {
    console.log(decode);
  });
};
module.exports = router;
