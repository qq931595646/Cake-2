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
      res.send({
        code: 200,
        data: result
      });
    } else {
      res.send({
        code: 400,
        msg: "获取失败"
      });
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

  if (!pid) {
    res.send({
      code: 400,
      msg: "没有该商品"
    });
    return;
  }

  // 进入了这个商品的详情 浏览量加1
  var sql = "SELECT read_num FROM cake_product WHERE pid=?";
  pool.query(sql, [pid], (err, result) => {
    if (err) throw err;
    // 先查询出原先的浏览量
    var read_num = parseInt(result[0].read_num);
    // 修改浏览量加1
    var sql2 = "UPDATE cake_product SET read_num=? WHERE pid=?";
    pool.query(sql2, [read_num + 1, pid], (err, result) => {
      if (err) throw err;
      // 修改成功后返回商品信息
      if (result.affectedRows > 0) {
        // 获取商品详情的信息
        var sql = `SELECT cake_product.pid,pname,price,pic,sales_volume,
read_num,details_pic FROM cake_product INNER JOIN 
cake_pic ON cake_product.pid=? AND cake_pic.pid=?`;
        pool.query(sql, [pid, pid], (err, result) => {
          if (err) throw err;
          output.product = result;

          // 获取商品规格的信息
          var sql = `SELECT sid,size,cake_spec.price,is_state,style,fruit,
else_message,repertory FROM cake_product INNER JOIN 
cake_spec ON cake_product.pid=? AND cake_spec.pid=?`;
          pool.query(sql, [pid, pid], (err, result) => {
            if (err) throw err;
            output.spec = result;
            res.send({
              code: 200,
              data: output
            });
          })
        });
      }
    })
  });
});



module.exports = router;