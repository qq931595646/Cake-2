<template>
  <div class="page-navbar">
    <mt-navbar class="page-part" v-model="selected">
      <mt-tab-item id="1">
        <span class="top_btn">同城配送</span>
      </mt-tab-item>
      <mt-tab-item id="2">
        <span class="top_btn">到店自取</span>
      </mt-tab-item>
    </mt-navbar>
    <mt-tab-container v-model="selected">
      <mt-tab-container-item id="1">
        <div class="site">
          <span>请选择收货地址</span>
          <span class="right">&gt;</span>
        </div>
        <div class="myshop">
          <span>门店名称：××蛋糕</span>
          <span>门店电话：0000-00000000</span>
          <span
            class="line_height"
          >配送门店：1.地址：越秀区侨光路8号华厦大厦B座7楼达内&nbsp;2.营业时间：8:30-18:00 每周一至周五公休。3.蛋糕预约三年起，请填写预约时间。</span>
        </div>
        <div class="sub">
          <span class="noborder">预约专用</span>
          <div @click="showDateTimePicker">
            <i>*&nbsp;</i>
            <span>预&nbsp;约&nbsp;日&nbsp;期</span>
            <span class="right">{{time}}&nbsp;&gt;</span>
          </div>
          <mt-field label="备注："></mt-field>
        </div>
        <div class="product">
          <img src="../../public/images/product/64sd78f5465sda41105.jpg" alt />
          <span class="product_details">
            <span class="product_title">提拉米苏</span>
            <span>尺寸：8寸</span>
            <span>×1</span>
          </span>
          <span class="price">￥268</span>
        </div>
        <div class="method">
          <span class="pay">
            <span>支付方式</span>
            <span class="right">请选择&nbsp;&gt;</span>
          </span>
          <span>
            <span>运费</span>
            <span class="right pay_site">请先选择收货地址</span>
          </span>
        </div>
      </mt-tab-container-item>
      <mt-tab-container-item id="2"></mt-tab-container-item>
    </mt-tab-container>
    <div class="bottom">
      <span class="money">总计：¥268</span>
      <label class="submit">提交订单</label>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      selected: "1",
      pickerValue: "",
      time: ""
    };
  },
  created() {
    var time = new Date();
    var year = time.getFullYear();
    var month = time.getMonth() + 1;
    var date = time.getDate();
    var current = year + "-" + month + "-" + date;
    var hours = time.getHours();
    var minutes =
      time.getMinutes() < 10 ? "0" + time.getMinutes() : time.getMinutes();
    var second =
      time.getSeconds() < 10 ? "0" + time.getSeconds() : time.getSeconds();
    this.time =
      year +
      "-" +
      month +
      "-" +
      date +
      " " +
      hours +
      ":" +
      minutes +
      ":" +
      second;
  },
  methods: {
    showDateTimePicker() {
      if (!this.dateTimePicker) {
        this.dateTimePicker = this.$createDatePicker({
          title: "Date Time Picker",
          min: new Date(2008, 7, 8, 8, 0, 0),
          max: new Date(2022, 9, 20, 20, 59, 59),
          value: new Date(),
          columnCount: 6,
          onSelect: this.selectHandle,
          onCancel: this.cancelHandle
        });
      }

      this.dateTimePicker.show();
    },
    selectHandle(date, selectedVal, selectedText) {
      // this.$createDialog({
      //   type: "warn",
      //   content: `Selected Item: <br/> - date: ${date} <br/> - value: ${selectedVal.join(
      //     ", "
      //   )} <br/> - text: ${selectedText.join(" ")}`,
      //   icon: "cubeic-alert"
      // }).show();
      this.time =
        selectedText[0] +
        "-" +
        selectedText[1] +
        "-" +
        selectedText[2] +
        " " +
        selectedText[3] +
        ":" +
        selectedText[4] +
        ":" +
        selectedText[5];
    }
    // cancelHandle() {
    //   this.$createToast({
    //     type: "correct",
    //     txt: "Picker canceled",
    //     time: 1000
    //   }).show();
    // }
  }
};
</script>
<style>
body {
  background: #f9f9f9;
}
.page-navbar {
  /* margin-top: 20px; */
}
.page-part {
  border-bottom: 1px solid #ccc;
}
.page-navbar .mint-tab-item-label {
  font-size: 16px;
}

.top_btn {
  display: inline-block;
}
.right {
  float: right;
}
.site {
  display: block;
  height: 35px;
  font-size: 16px;
  margin-top: 2px;
  color: #3e3e3e;
  line-height: 35px;
  background-color: #fff;
  padding: 0 10px 0 10px;
}
.myshop {
  /* line-height: 35px; */
  margin-top: 10px;
  background-color: #fff;
  color: #3e3e3e;
  padding: 5px 10px 0 10px;
  font-size: 14px;
}
.myshop span {
  display: block;
  margin-top: 10px;
  padding-bottom: 10px;
}
.line_height {
  line-height: 17px;
}
.sub {
  display: block;
  background-color: #fff;
  color: #3e3e3e;
  padding: 0 10px 0 10px;
  margin-top: 10px;
}
.sub > span {
  display: block;
  /* padding: 5px 10px 0 10px; */
  height: 35px;
  line-height: 35px;
  border-bottom: 1px solid #ddd;
  font-size: 14px;
}
.sub > div {
  display: block;
  /* padding: 5px 10px 0 10px; */
  height: 35px;
  line-height: 35px;
  border-bottom: 1px solid #ddd;
  font-size: 14px;
}
.sub i {
  color: #f00;
}
.sub .noborder {
  border: 0;
}
.product {
  position: relative;
  border-bottom: 1px solid #ddd;
  font-size: 14px;
  padding: 0 10px 0 10px;
  margin-top: 10px;
  background-color: #fff;
  color: #5558;
}
.product img {
  width: 95px;
  height: 90px;
  padding-top: 10px;
  padding-bottom: 10px;
}
.product_title {
  color: #3e3e3e;
  font-size: 16px;
  margin-bottom: 5px;
}
.product_details {
  position: absolute;
  top: 10px;
  left: 110px;
}
.product_details span {
  display: block;
  line-height: 25px;
}
.price {
  position: absolute;
  color: #e1465b;
  top: 72px;
  right: 10px;
}
.method {
  margin-top: 10px;
  background-color: #fff;
  color: #3e3e3e;
  font-size: 14px;
}
.method > span {
  display: block;
  line-height: 35px;
  border-bottom: 1px solid #ddd;
  padding: 0px 10px 0 10px;
}
.pay_site {
  color: #5558;
}
.bottom {
  position: fixed;
  bottom: 0;
  padding: 0px 10px 0 10px;
}
.money {
  display: inline-block;
  font-size: 16px;
  margin-bottom: 10px;
  line-height: 10px;
  color: #ff5150;
}
.submit {
  position: relative;
  display: inline-block;
  text-align: center;
  width: 120px;
  line-height: 50px;
  background: #fe7951 !important;
  color: #fff;
  font-size: 14px;
  left: 161px;
}
</style>
