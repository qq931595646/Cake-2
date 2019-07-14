<template>
  <div class="total">
    <!-- 未登录状态下 -->
    <div class="not_login" v-if="uphone==''">
      <div class="logo">
        <img src="../../public/images/avatar.png" alt />
      </div>
      <mt-button class="myButton" @click="login">登录</mt-button>
    </div>
    <!-- 登录状态下 -->
    <div class="is_login" v-if="uphone!=''">
      <div class="avatar_wrap">
        <router-link to="#" class="logo">
          <img src="../../public/images/avatar.png" alt />
        </router-link>
      </div>
      <div class="info">
        <span class="phone" v-text="uphone"></span>
      </div>
    </div>

    <div class="order">
      <div class="own">
        <p class="section_title">我的订单</p>
        <a href="javascript:;">待付款</a>
        <a href="javascript:;">待发货</a>
        <a href="javascript:;">待收获</a>
        <a href="javascript:;">我的订单</a>
      </div>
    </div>
    <div class="service">
      <div class="own">
        <p class="section_title">我的服务</p>
        <a href="javascript:;" class="birth">生日助手</a>
        <a href="javascript:;" class="detail">个人资料</a>
        <a href="javascript:;" class="card">储值卡专享兑换券</a>
        <a href="javascript:;" class="leclub">LECLUB</a>
        <a href="javascript:;" class="online">在线客服</a>
        <a href="javascript:;" class="ticket">我的发票</a>
        <a href="javascript:;" class="our">关于我们</a>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      uphone: ""
    };
  },
  created() {
    var uid = sessionStorage.getItem("uid");
    console.log(uid);
    if (uid) {
      this.axios.post("/user/own", `uid=${uid}`).then(result => {
        console.log(result);
        this.uphone = result.data.data[0].uname;
      });
    }
  },
  methods: {
    login() {
      // 跳转到登陆页
      this.$router.push("/Login");
    }
  }
};
</script>
<style scoped>
.total {
  background: #f5f5f5;
}
.not_login {
  text-align: center;
  background: #fff;
  margin-bottom: 15px;
}
.logo {
  margin-top: 20px;
}
.logo img {
  width: 65px;
  height: 65px;
}
.myButton {
  width: 70px;
  height: 30px;
  background: #a38d6b;
  color: #fff;
  font-size: 12px;
  margin-top: 10px;
}
.order {
  font: 13px "Hiragino Sans GB", STFangsong, "Microsoft YaHei", Helvetica,
    STXihei, Arial, serif !important;
  background: #fff;
}
.service {
  font: 13px "Hiragino Sans GB", STFangsong, "Microsoft YaHei", Helvetica,
    STXihei, Arial, serif !important;
  background: #fff;
}
.section_title {
  padding: 10px;
}
.own {
  margin-bottom: 10px;
  overflow: hidden;
  margin: 10px 20px;
  background: #fff;
}
.own a {
  position: relative;
  float: left;
  width: 25%;
  height: 25px;
  text-align: center;
  margin: 10px 0;
  color: #000;
  padding-top: 40px;
}
.own a::before {
  content: "";
  position: absolute;
  width: 1.2rem;
  height: 1.2rem;
  background: url(../../public/images/icons.png) no-repeat center;
  -webkit-background-size: 2rem 2rem;
  background-size: 6rem 6rem;
  top: 50%;
  margin-top: -0.2rem;
  left: 50%;
  margin-left: -0.4rem;
  top: 0.24rem;
}

.own a:nth-of-type(1):before {
  background-position: -0.26rem -0.08rem;
}
.own a:nth-of-type(2):before {
  background-position: -1.36rem -0.08rem;
}
.own a:nth-of-type(3):before {
  background-position: -2.5rem -0.08rem;
}
.own a:nth-of-type(4):before {
  background-position: -3.6rem -0.08rem;
}
.own a.birth:before {
  background-position: -5.16rem -0.08rem;
}
.own a.detail:before {
  background-position: -2.5rem, 4.1rem;
}
.own a.card:before {
  background-position: -0.12rem -1.23rem;
}

.own a.our:before {
  background-position: -1rem, 0rem;
}
.own a.leclub:before {
  background-position: -1.32rem -1.24rem;
}
.own a.online:before {
  background-position: -3.9rem -1.24rem;
}
.own a.ticket:before {
  background-position: -4.9rem -1.24rem;
}
.own a.our:before {
  background-position: -1.3rem -2.4rem;
}
.is_login {
  overflow: hidden;
  clear: both;
  margin-top: 20px;
  margin-left: 20px;
}
.avatar_wrap {
  float: left;
}
.info {
  float: left;
  width: 75%;
  position: relative;
  margin-top: 15px;
  margin-left: 10px;
}
.info .phone {
  font-size: 14px;
}
</style>
