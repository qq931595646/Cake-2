// 引入express
const express = require("express");
// 引入连接池
const pool = require("../pool");
// 创建路由器
var router = express.Router();

// 获取购物车的信息
router.get("/get_cart", (req, res) => {
  // 用户的id
  var user_id = req.query.user_id;

  if (!user_id) {
    res.send({ code: 400, msg: "未登录,请先登录" });
    return;
  }
  // 购物车页面需要的商品信息,降序排序
  var sql = `SELECT pname,pic,size,cake_spec.price,is_state,style,fruit,
              else_message,repertory,count FROM (cake_cart INNER JOIN cake_product
              ON cake_cart.user_id=? AND cake_cart.product_id=cake_product.pid)
              LEFT JOIN cake_spec ON cake_cart.sid=cake_spec.sid ORDER BY
              cake_cart.cid  DESC`;
  pool.query(sql, [user_id], (err, result) => {
    if (err) throw err;
    if (result.length > 0) {
      res.send({ code: 200, data: result });
    } else {
      res.send({ code: 400, msg: "购物车为空,请先添加商品" });
    }
  })
});

// 修改购物车表的信息 (要传入用户id,商品id,规格的id,购买该商品的数量)
router.post("/set_cart", (req, res) => {
  var user_id = req.body.user_id;
  var product_id = req.body.product_id;
  var sid = req.body.sid;
  var count = req.body.count;

  if (!user_id) {
    res.send({ code: 400, msg: "用户没有登录" });
    return;
  }

  var sql = "UPDATE cake_cart SET count=? WHERE user_id=? AND product_id=? AND sid=?";
  count = Number(count);
  if (count.toString() == "NaN") {
    res.send({ code: 400, msg: "数量只能是数字" });
    return;
  }
  pool.query(sql, [count, user_id, product_id, sid], (err, result) => {
    if (err) throw err;
    if (result.affectedRows > 0) {
      res.send({ code: 200, msg: "购物车表更新成功" });
    } else {
      res.send({ code: 200, msg: "购物车表更新失败" });
    }
  })

});

// 购物车表信息删除











module.exports = router;