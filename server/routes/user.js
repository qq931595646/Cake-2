// 引入express
const express = require("express");
// 引入连接池
const pool = require("../pool");
// 创建路由器
var router = express.Router();

// 用户注册 有正则验证
router.post("/reg", (req, res) => {
  var phone = req.body.phone;
  var upwd = req.body.upwd;

  var reg1 = /^1[3-9]\d{9}$/; // 手机号码的正则表达式
  if (!reg1.test(phone)) {
    res.send({ code: 400, msg: "手机号格式不正确" });
    return;
  }
  // 不能纯英文字母,不能纯数字,不能有空格的8到16位密码
  var reg2 = /\s|^[a-zA-Z]{8,16}$|^\d{8,16}$/;
  // true 密码格式不正确,  false 密码格式正确
  if (reg2.test(upwd)) {
    res.send({ code: 400, msg: "密码格式不正确" });
    return;
  }

  var sql = "SELECT phone FROM cake_user WHERE phone=?";
  pool.query(sql, [phone], (err, result) => {
    if (err) throw err;
    if (result.length > 0) {
      console.log(123)
      res.send({ code: 400, msg: "该手机号已经注册" });
    } else {
      var sql2 = "INSERT INTO cake_user VALUE(NULL,NULL,?,md5(?),DEFAULT,DEFAULT)";
      pool.query(sql2, [phone, upwd], (err, result) => {
        if (err) throw err;
        if (result.affectedRows > 0) {
          res.send({ code: 200, msg: "注册成功" });
        } else {
          res.send({ code: 400, msg: "注册失败" });
        }
      })
    }
  })

});


// 用户登录 要传入 手机号和密码
router.post("/login", (req, res) => {
  var phone = req.body.phone;
  var upwd = req.body.upwd;

  if (!phone) {
    res.send({ code: 400, msg: "手机号不能为空" });
    return;
  }
  if (!upwd) {
    res.send({ code: 400, msg: "密码不能为空" });
    return;
  }

  var sql = "SELECT uid,uname,phone FROM cake_user WHERE phone=? AND upwd=md5(?)";
  pool.query(sql, [phone, upwd], (err, result) => {
    if (err) throw err;
    if (result.length > 0) {
      // session 的登陆id
      req.session.uid = result[0].uid;
      console.log(req.session.uid)
      res.send({ code: 200, msg: result[0] });
    } else {
      res.send({ code: 400, msg: "用户名或密码错误" });
    }
  })
})



module.exports = router;