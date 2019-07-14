<template>
  <div>
    <div>
      <mt-tab-container v-model="active">
        <!-- 首页 -->
        <mt-tab-container-item id="myIndex">
          <div class="myIndexBotton" style="text-align: center;;width:100%">
            <h1 style="margin:10px auto">首页</h1>
            <!-- 搜索 -->
            <div class="mySearch">
              <mt-search autofocus></mt-search>
            </div>
            <!-- 产品导航 -->
            <div class="product-nav">
              <div class="list-nav" @click="detail">
                <i class="iconfont">&#xe6be;</i>
                <span class="list-menu">蛋糕</span>
              </div>
              <div class="list-nav" @click="detail">
                <i class="iconfont">&#xe666;</i>
                <span class="list-menu">甜点</span>
              </div>
              <div class="list-nav" @click="detail">
                <i class="iconfont">&#xe613;</i>
                <span class="list-menu">小食</span>
              </div>
              <div class="list-nav" @click="detail">
                <i class="iconfont">&#xe601;</i>
                <span class="list-menu">礼盒</span>
              </div>
            </div>
            <!-- 推荐 -->
            <router-link to="#">
              <img src="images/product/64sd78f5465sda4170.jpg" />
            </router-link>
            <!-- 公告 -->
            <div class="gonggao">
              <p class="iconfont">
                <span class="up">
                  <i class="iconfont">&#xe61a;</i>
                </span>
                <span to="#" class="slide">
                  <i>店铺营业时间为：8:30-18:00,对每一份甜点心怀敬意,为保证最佳赏味,请提前预约制作。</i>
                </span>
              </p>
            </div>
            <mt-swipe :auto="3000" :defaultIndex="0" :show-indicators="true">
              <mt-swipe-item>
                <router-link to="#">
                  <img src="images/product/64sd78f5465sda414.png" alt />
                </router-link>
              </mt-swipe-item>
              <mt-swipe-item>
                <router-link to="#">
                  <img src="images/product/64sd78f5465sda4170.jpg" alt />
                </router-link>
              </mt-swipe-item>
              <mt-swipe-item>
                <router-link to="#">
                  <img src="images/product/64sd78f5465sda4171.jpg" alt />
                </router-link>
              </mt-swipe-item>
              <mt-swipe-item>
                <router-link to="#">
                  <img src="images/product/64sd78f5465sda4159.jpg" alt />
                </router-link>
              </mt-swipe-item>
              <mt-swipe-item>
                <router-link to="#">
                  <img src="images/product/64sd78f5465sda4121.jpg" alt />
                </router-link>
              </mt-swipe-item>
            </mt-swipe>
            <!-- 小食 -->
            <div class="snack-list clearfix">
              <span class="snack-title">小食</span>
              <router-link to="###" class="product-more">更多</router-link>
            </div>
            <div class="snack-list clearfix">
              <ul>
                <li class="snack-item" v-for="(item,i) of product_list" :key="i">
                  <router-link :to="`/Details/${item.pid}`">
                    <img :src="`http://127.0.0.1:7700/${item.pic}`" alt />
                    <span class="title" v-text="item.pname"></span>
                    <span class="price" v-text="item.price"></span>
                  </router-link>
                </li>
              </ul>
            </div>
            <div style="height:1.464rem;"></div>
            <!-- index -->
          </div>
        </mt-tab-container-item>
        <!-- 分类 -->
        <mt-tab-container-item id="myProduct" :style="`height:${resizeHeight}px`">
          <classify></classify>
        </mt-tab-container-item>
        <!-- 购物车 -->
        <mt-tab-container-item id="myCart">
          <cart></cart>
        </mt-tab-container-item>
        <!-- 个人中心 -->
        <mt-tab-container-item id="me" :style="`height:${resizeHeight}px`">
          <own></own>
        </mt-tab-container-item>
      </mt-tab-container>

      <!-- 底部 -->
      <mt-tabbar v-model="active" fixed>
        <mt-tab-item id="myIndex">
          <!-- <img slot="icon" src="images/1.jpg" /> -->
          <span slot="icon" class="iconfont myicon">&#xe604;</span>首页
        </mt-tab-item>
        <mt-tab-item id="myProduct">
          <span slot="icon" class="iconfont myicon">&#xe632;</span>所有商品
        </mt-tab-item>
        <mt-tab-item id="myCart">
          <span slot="icon" class="iconfont myicon">&#xe611;</span>购物车
        </mt-tab-item>
        <mt-tab-item id="me">
          <span slot="icon" class="iconfont myicon">&#xe615;</span>个人中心
        </mt-tab-item>
      </mt-tabbar>
    </div>
  </div>
</template>
<script>
// 导入需要的子组件(分类,购物车,个人中心)
import Classify from "./Classify.vue";
import Cart from "./Cart";
import Own from "./Own";
export default {
  data() {
    return {
      active: "myIndex",
      // 屏幕的高度
      resizeHeight: 650,
      // 轮播图的数据
      carousel_list: [],
      // 首页显示某个系列的商品数据
      product_list: []
    };
  },
  created() {
    // 屏幕可用区域变化时执行 (分类的高度需要与屏幕高度一样)
    this.resizeHeight = screen.availHeight;
    window.addEventListener("resize", () => {
      this.resizeHeight = screen.availHeight;
    });

    // 获取后台数据显示 需要传入某系列的cid
    var cid = 7;
    this.axios.get("/index/index", { params: { cid: cid } }).then(result => {
      console.log(result.data.data);
      var list = result.data.data;
      this.carousel_list = list.carousel;
      this.product_list = list.product;
    });
  },
  // 注册子组件
  components: {
    Classify: Classify,
    cart: Cart,
    own: Own
  },
  methods: {
    detail() {
      this.active = "myProduct";
    }
  }
};
</script>
<style scope>
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
/* 顶部食品类型 */
img {
  width: 95%;
}
.product-nav {
  margin: 0.28rem;
  text-align: center;
  display: flex;
}
.product-nav .list-nav {
  width: 24%;
  justify-content: space-around;
}
.product-nav .list-nav i {
  display: block;
  font-size: 1rem;
  margin-bottom: 0.2rem;
}
.product-nav .list-nav span.list-menu {
  font-size: 0.35rem;
  color: #333;
  display: block;
}
/* 公告 */
.gonggao {
  text-align: left;
  width: 95%;
  display: inline-block;
  overflow: hidden;
}
.gonggao p {
  display: inline-block;
  position: relative;
}
.gonggao span.up {
  width: 4%;
  background: #fff;
  color: #243f4c;
  overflow: hidden;
  vertical-align: middle;
  float: left;
}
.gonggao .slide {
  width: 96%;
  color: #795548;
  float: left;
  overflow: hidden;
}
.gonggao .slide i {
  font-style: normal;
  display: inline-block;
  animation: translatex 7s linear infinite;
  white-space: nowrap;
}
@keyframes translatex {
  0% {
    transform: translateX(0px);
  }
  100% {
    transform: translateX(-620px);
  }
}
/* 轮播 */
.mint-swipe {
  height: 200px !important;
  width: 100%;
}
/* classify */
.mem {
  height: 15.333333rem;
}
/* 小食 */
.snack-list {
  width: 95%;
  font-size: 0.45rem;
  margin: 0.28rem auto;
  box-sizing: border-box;
  letter-spacing: 1px;
}
/* 图片 */
.snack-item img {
  width: 110px;
  height: 110px;
}
.snack-list .snack-title {
  float: left;
  text-align: left;
  width: 50%;
}
.snack-list .product-more {
  width: 50%;
  text-align: right;
  float: right;
  color: #824e3b;
  font-size: 0.45rem;
}
.snack-list .snack-item {
  float: left;
  width: 33.3%;
  text-align: left;
}
.snack-item span {
  margin: 0.12rem 0;
  font-weight: 600;
  white-space: pre-wrap;
  font-size: 0.4rem;
  display: block;
}
.snack-item .title {
  color: #333;
}
.snack-item .price {
  color: crimson;
}
/* 搜索框的高 */
.mySearch {
  height: 52px;
}
.mint-searchbar {
  background-color: #efeff4 !important;
}
/* 取消的文字样式 */
.mySearch .mint-searchbar-cancel {
  font-size: 14px !important;
  color: #000 !important;
}
/* 搜索框的文字样式 */
.mySearch .mint-searchbar-core {
  font-size: 14px !important;
}
/* 底部icon图标 */
.myicon {
  font-size: 22px;
}
/* 底部选项卡的高度 */
.mint-tabbar.is-fixed {
  height: 1.464rem;
}
</style>