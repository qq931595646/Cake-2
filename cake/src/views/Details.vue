<template>
  <div class="container">
    <!-- .icon-fenxiang -->
    <h1 style="font-size:24px;text-align:center">商品详情</h1>
    <!-- 大图 -->
    <div style="margin:0.25rem 0">
      <img :src="`http://127.0.0.1:7000/${list.pic}`" alt />
    </div>
    <!-- 简介 -->
    <div class="intro">
      <div class="intro-head">
        <span class="price">￥159~468</span>
        <span class="pname" v-text="list.pname"></span>
      </div>
      <div class="fengxiang">
        <div class="iconfont">&#xe608;</div>
        <p>分享</p>
      </div>
      <div class="clearfix countAll">
        <span v-text="`销量：${list.sales_volume}`"></span>
        <span>
          库存:
          <i>472</i>件
        </span>
        <span v-text="`浏览量：${list.read_num}`"></span>
      </div>
    </div>
    <div style="height:0.27rem;width:100%;background-color:#ddd;margin:0"></div>
    <div class="spec">
      请选择 &nbsp;尺寸
      <i>&gt;</i>
    </div>
    <div style="height:0.27rem;width:100%;background-color:#ddd;margin:0"></div>
    <div class="Tabbar">
      <mt-button class="toggle active" size="small" @click.native.prevent="active = 'tab1'">商品详情</mt-button>
      <mt-button class="toggle" size="small" @click.native.prevent="active = 'tab2'">商品评论</mt-button>
    </div>
    <mt-tab-container v-model="active">
      <mt-tab-container-item id="tab1">
        <img :src="`http://127.0.0.1:7000/${list.details_pic}`" alt />
      </mt-tab-container-item>
      <mt-tab-container-item id="tab2">
        <mt-button size="small" @click.native.prevent="active = ''">全部</mt-button>
        <mt-button size="small" @click.native.prevent="active = ''">有图</mt-button>
        <mt-button size="small" @click.native.prevent="active = ''">好评</mt-button>
        <mt-button size="small" @click.native.prevent="active = ''">中评</mt-button>
        <mt-button size="small" @click.native.prevent="active = ''">差评</mt-button>
      </mt-tab-container-item>
    </mt-tab-container>
    <div style="position:fixed;bottom:0;width:100%">
      <ul class="gat-nav">
        <li class="li-nav">
          <i class="iconfont">&#xe604;</i>
          <span>首页</span>
        </li>
        <li class="li-nav">
          <i class="iconfont">&#xe602;</i>
          <span>收藏</span>
        </li>
        <li class="buy">
          <span class="add-cart">加入购物车</span>
          <span class="now-buy">立即购买</span>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    // name:"Tabbar"
    return {
      active: "tab1",
      list: []
    };
  },
  props: ["pid"],
  created() {
    this.axios
      .get("/product/details", { params: { pid: this.pid } })
      .then(result => {
        console.log(result.data.data.product);
        this.list = result.data.data.product[0];
      });
  },
  methods: {}
};
</script>
<style scoped>
.clearfix::before {
  content: "";
  clear: both;
  display: block;
}
.clearfix::after {
  content: "";
  clear: both;
  display: block;
}
img {
  width: 100%;
}
i {
  font-style: normal;
}
/*  */
.container {
  font-size: 0.4rem;
}
/* 产品简介 */
.intro {
  margin: 0.2rem 0.2rem;
}
.intro .intro-head {
  text-align: left;
  float: left;
}
.intro .fengxiang {
  text-align: center;
  margin: 0.4rem 0.4rem 0 0;
  float: right;
}
.intro .fengxiang p {
  margin-top: 0.1rem;
  letter-spacing: 1px;
  color: #585757;
  font-size: 0.21rem;
}
.intro .intro-head span {
  margin: 0.3rem 0;
  font-weight: 600;
  display: block;
}
.intro .intro-head span.price {
  color: brown;
}
.countAll {
  text-align: center;
}
.countAll span {
  font-size: 0.21rem;
  color: #585757;
}
.countAll span:nth-child(1) {
  float: left;
}
.countAll span:nth-child(3) {
  float: right;
}
/* 尺寸 */
.spec {
  padding: 0.4rem;
}
.spec i {
  float: right;
  font-size: 0.5rem;
  color: #585757;
}
/* 详情/评论 */
.Tabbar {
  justify-content: space-around;
  display: flex;
}
.toggle {
  background: #fff;
  box-shadow: none;
  border-radius: 0;
  outline: none;
  color: #333;
  font-size: 0.5rem;
  height: 50px;
}
.Tabbar .active {
  border-bottom: 2px solid #ea5454;
}
/* 底部导航 */
.gat-nav {
  width: 100%;
  height: 1.3rem;
  background-color: #fff;
  border-top: 2px solid #ccc;
  padding: 0.05rem 0;
  font-size: 0.1rem;
}
.gat-nav li {
  float: left;
  text-align: center;
}
.gat-nav li.li-nav {
  margin: 0.27rem 0 0 0.4rem;
}
.gat-nav li i {
  margin-bottom: 0.08rem;
  display: block;
}
.gat-nav li.buy {
  float: right;
  margin-right: 0.3rem;
}
.gat-nav li.buy span {
  display: inline-block;
  height: 1rem;
  color: #fff;
  margin-top: 6px;
  font-size: 0.4rem;
  line-height: 1rem;
  text-align: center;
}
.gat-nav li.buy span.add-cart {
  width: 4rem;
  background: #ff9a7c;
  border-radius: 0.53rem 0 0 0.53rem;
}
.gat-nav li.buy span.now-buy {
  width: 3rem;
  background: #fe7951;
  border-radius: 0 0.53rem 0.53rem 0;
}
</style>