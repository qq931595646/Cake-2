// 引入express
const express = require("express");
// 引入连接池
const pool = require("../pool");
// 创建路由器
var router = express.Router();

// 需要一个参数,某个系列的id
router.get("/index", (req, res) => {
  // 哪个系列下的所有商品
  var cid = req.query.cid;
  var output = {
    carousel: [],
    product: []
  };

  if (!cid) {
    res.send({ code: 400, msg: "没有该系列的商品" });
    return;
  }

  // 获取首页轮播图片
  var sql = "SELECT img,title,pid FROM cake_index_carousel";
  pool.query(sql, (err, result) => {
    if (err) throw err;
    output.carousel = result;
    // 获取首页商品信息
    var sql2 = `SELECT cname,series,pid,pname,price,cake_product.pic,read_num 
                FROM cake_catalogue INNER JOIN cake_product ON 
                cake_catalogue.cid=? AND cake_product.cid=?`;
    pool.query(sql2, [cid, cid], (err, result) => {
      if (err) throw err;
      if (result.length > 0) {
        output.product = result;
        res.send({ code: 200, data: output });
      } else {
        res.send({ code: 400, msg: "没有该系列的商品" })
      }
    })
  })
});



module.exports = router;