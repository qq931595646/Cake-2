// 引入express
const express = require("express");
// 引入连接池
const pool = require("../pool");
// 创建路由器
var router = express.Router();

router.get("/classify", (req, res) => {
  var sql = "SELECT cname,series,pic FROM cake_catalogue";
  pool.query(sql, (err, result) => {
    if (err) throw err;
    if (result.length > 0) {
      res.send({ code: 200, msg: result });
    } else {
      res.send({ code: 400, msg: "获取失败" });
    }
  })
})



module.exports = router;