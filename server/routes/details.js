// 引入express
const express = require("express");
// 引入连接池
const pool = require("../pool");
// 创建路由器
var router = express.Router();

// 商品分类的路由
router.get("/classify", (req, res) => {
  var sql = "SELECT cname,series,pic FROM cake_catalogue";
  pool.query(sql, (err, result) => {
    if (err) throw err;
    if (result.length > 0) {
      res.send({ code: 200, data: result });
    } else {
      res.send({ code: 400, msg: "获取失败" });
    }
  })
});

// 商品详情的路由
router.get("/details", (req, res) => {
  // 商品的id
  var pid = req.query.pid;
  var output = {
    product: [],
    spec: []
  };

  // 获取商品详情的信息
  var sql = `SELECT cake_product.pid,pname,price,pic,sales_volume,read_num,
              details_pic FROM cake_product INNER JOIN cake_pic ON 
              cake_product.pid=? AND cake_pic.pid=?`;
  pool.query(sql, [pid, pid], (err, result) => {
    if (err) throw err;
    output.product = result;

    // 获取商品规格的信息
    var sql = `SELECT sid,size,cake_spec.price,is_state,style,fruit,else_message,
                repertory FROM cake_product INNER JOIN cake_spec ON 
                cake_product.pid=? AND cake_spec.pid=?`;
    pool.query(sql, [pid, pid], (err, result) => {
      if (err) throw err;
      output.spec = result;
      res.send({ code: 200, data: output });
    })
  })
})



module.exports = router;