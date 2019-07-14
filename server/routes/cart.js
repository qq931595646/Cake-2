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
  var sql = `SELECT pname,pic,cake_cart.cid,size,cake_spec.price,is_state,style,
              fruit,else_message,repertory,count FROM (cake_cart INNER JOIN 
              cake_product ON cake_cart.user_id=? AND cake_cart.product_id=
              cake_product.pid) LEFT JOIN cake_spec ON
              cake_cart.sid=cake_spec.sid ORDER BY cake_cart.cid  DESC`;
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

// 购物车表信息删除 (可多个删除,传入的参数格式为: 1,2,3 ...) 
router.post("/del_cart", (req, res) => {
  var cids = req.body.cids;

  if (!cids) {
    res.send({ code: 400, msg: "请先选择要删除的商品" });
    return;
  }
  var sql = `DELETE FROM cake_cart WHERE cid IN (${cids})`;
  pool.query(sql, [cids], (err, result) => {
    if (err) throw err;
    if (result.affectedRows > 0) {
      res.send({ code: 200, msg: "删除成功" });
    } else {
      res.send({ code: 400, msg: "删除失败" });
    }
  });
});

// 加入购物车路由 (需要参数用户id,商品id,规格id,数量)
router.post("add_cart", (req, res) => {
  var user_id = req.body.user_id;
  var product_id = req.body.product_id;
  var sid = req.body.sid;
  var count = req.body.count;

  if (!user_id) {
    res.send({ code: 400, msg: "未登录状态" });
    return;
  }

  // 先查询一下这个用户是否已经把该商品加入购物车
  var sql = `SELECT user_id,product_id,sid FROM cake_cart WHERE user_id=
              AND product_id=? AND sid=?`;
  pool.query(sql, [user_id, product_id, sid], (err, result) => {
    if (err) throw err;
    // 该用户购物车已有该商品,只修改该商品的数量
    if (result.length > 0) {
      var sql2 = `UPDATE cake_cart SET count=? WHERE user_id=
                  AND product_id=? AND sid=?`;
      pool.query(sql2, [count, user_id, product_id, sid], (err, result) => {
        if (err) throw err;
        if (res.affectedRows > 0) {
          res.send({ code: 200, msg: "购物车已有该商品,更新了商品数量" });
        } else {
          res.send({ code: 400, msg: "购物车已有该商品,购物车商品数量更新失败" });
        }
      })
    } else {
      // 没有该商品在购物车就创建该数据
      var sql3 = "INSERT INTO cake_cart SET ?";
      pool.query(sql3, [obj.body], (err, result) => {
        if (err) throw err;
        if (result.affectedRows > 0) {
          res.send({ code: 200, msg: "商品添加购物车成功" });
        } else {
          res.send({ code: 400, msg: "商品添加购物车失败" });
        }
      })
    }
  })
})










module.exports = router;