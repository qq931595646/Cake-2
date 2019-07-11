<template>
  <div class="cart">
    <div class="cart_box" v-for="(item,index) in list" :key="index">
      <!-- <h1 class="title">购物车</h1> -->
      <label for="input" @click="selected">
        <input type="checkbox" class="input" v-model="item.selected" />
        <span class="input_sp input_red" v-if="item.selected" @click="radios(index)"></span>
        <span class="input_sp" v-if="!item.selected" @click="radios(index)"></span>
      </label>

      <img class="img" src="../../public/images/曲奇.png" alt />
      <div>
        <span class="title_sp">
          <span>{{item.title}}</span>
          <span>({{item.weight}})</span>
        </span>
        <span class="state">
          <span class="state_s">状态: {{item.state}}</span>
          <span>尺寸: {{item.size}}</span>
        </span>
        <span class="sprice">¥{{item.money}}</span>
      </div>
      <div>
        <span class="btn">
          <span class="sbtn" @click="btn_minute(index)">-</span>
          <span class="btn_value" v-text="item.num"></span>
          <span class="sbtn" @click="btn_add(index)">+</span>
        </span>
      </div>
    </div>
    <div class="bottom">
      <label for="bottom_input" @change="selectAll">
        <input type="checkbox" id="bottom_input" />
        <span class="bottom_input"></span>
        <span class="all">全选</span>
      </label>
      <div class="count">
        <span class="money">
          <span>总计：¥{{money}}</span>
        </span>
        <span class="sum">
          <span>总数：{{num}}</span>
        </span>
      </div>
      <div class="bottom_right">
        <label class="delete">删除</label>
        <label class="close">结算</label>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      money: 0,
      num: 0,
      list: [
        {
          title: "蔓越莓软曲奇",
          weight: "300g",
          size: "8寸",
          state: "预定",
          money: 68,
          num: 1,
          selected: false
        },
        {
          title: "蔓越莓软曲奇",
          weight: "300g",
          size: "8寸",
          state: "预定",
          money: 68,
          num: 1,
          selected: false
        },
        {
          title: "蔓越莓软曲奇",
          weight: "300g",
          size: "8寸",
          state: "预定",
          money: 68,
          num: 1,
          selected: false
        }
      ]
    };
  },
  created() {
    // 需要公共的头部和尾部
    this.$emit("show_footer", false);
  },
  methods: {
    selectAll(e) {
      //全选按钮状态
      var cb = e.target.checked;
      //依据状态修改列表cb
      for (var item of this.list) {
        item.selected = cb;
      }
    },
    selected() {
      for (var item of this.list) {
        console.log(item.selected);
        if (item.selected != true) {
          this.isSelectAll = false;
          return;
        } else {
          this.isSelectAll = true;
        }
      }
    },
    hh: function() {
      var price = 0;
      var numb = 0;
      var list = this.list;
      for (var i = 0; i < list.length; i++) {
        if (list[i].selected) {
          price += list[i].num * list[i].money;
          numb += list[i].num;
        }
      }
      this.money = price;
      this.num = numb;
      // console.log(numb);
    },
    radios: function(index) {
      var list = this.list;
      list[index].selected = !list[index].selected;

      this.hh();

      // console.log(list[index].selected);
    },
    //添加
    btn_add: function(index) {
      var list = this.list;
      var num = list[index].num;
      num = num + 1;
      list[index].num = num;
      this.hh();
    },
    //减去
    btn_minute: function(index) {
      var list = this.list;
      var num = list[index].num;
      if (num > 1) {
        num = num - 1;
        list[index].num = num;
      }
      this.hh();
    },
    function() {
      var price = 0;
      var numb = 0;
      var list = this.list;
      for (var i = 0; i < list.length; i++) {
        if (list[i].selected) {
          price += list[i].num * list[i].money;
          numb += list[i].num;
        }
      }
      this.money = price;
      this.num = numb;
      // console.log(numb);
      // console.log(price);
    }
    // selectAll(e) {
    //   //全选按钮状态
    //   var cb = e.target.checked;
    // console.log(cb);
    //   //依据状态修改列表cb
    //   for (var item of this.list) {
    //     item.cb = cb;
    //   }
    // },
    // select() {
    //   for (var item of this.list) {
    //     if (item.cb != true) {
    //       this.isSelectAll = false;
    //       return;
    //     } else {
    //       this.isSelectAll = true;
    //     }
    //   }
    // }
  }
};
</script>
<style>
.cart {
  /* display: flex; */
  width: 100%;
  height: 600px;
  /* justify-content: space-between; */
  background-color: #f9f9f9;
}
.cart_box {
  display: flex;
  /* margin-top:20px; */
  width: 100%;
  background: #fff;
  height: 18%;
  /* justify-content: space-between; */
  /* align-items: center; */
}
.input,
#bottom_input {
  display: none;
}

.input_sp {
  display: block;
  width: 20px;
  height: 20px;
  border: 1px solid #7b7b7b;
  border-radius: 50%;
  margin: 45px 8px 0 8px;
}
.input_red {
  background: #f00;
}

.img {
  width: 100px;
  margin-top: 10px;
  margin-right: 10px;
  height: 90px;
}
.title_sp {
  display: block;
  font-size: 16px;
  color: #7b7b7b;
  margin-top: 14px;
}
.state {
  display: block;
  font-size: 14px;
  color: #adadad;
  margin-top: 10px;
}
.state_s{
  display: inline-block;
  margin-right:10px;
}
.sprice {
  display: block;
  font-size: 16px;
  color: #ff6464;
  margin-top: 20px;
}
.btn {
  display: block;
  margin-left: -50px;
  margin-top: 70px;
}
.sbtn {
  display: inline-block;
  text-align: center;
  line-height: 30px;
  width: 30px;
  height: 30px;
  background: #f7f7f7;
  color: #a3a3a3;
  font-size: 18px;
}

.btn_value {
  display: inline-block;
  text-align: center;
  line-height: 30px;
  width: 50px;
  height: 30px;
  background: #f7f7f7;
  font-size: 18px;
  color: #868686;
  margin: 0 2px 0 2px;
}

/* 底部样式 */
.bottom {
  position: fixed;
  justify-content: space-between;
  bottom: 100px;
  width: 100%;
  background: #fff;
  height: 50px;
}
.bottom_input {
  /* display: none; */
  display: inline-block;
  width: 20px;
  height: 20px;
  border: 1px solid #7b7b7b;
  border-radius: 50%;
  margin: 0px 5px 0 8px;
}
#bottom_input:checked + .bottom_input {
  background: #f00;
}
.all {
  display: inline-block;
  position: relative;
  bottom: 5px;
  font-size: 13px;
  color: #6c6c6c;
}
.money {
  display: block;
  font-size: 13px;
  margin-bottom: 10px;
  line-height: 10px;
  color: #ff5150;
}
.sum {
  display: block;
  font-size: 13px;
  color: #ff5150;
  line-height: 10px;
}
.count {
  display: inline-block;
  position: relative;
  top: 7px;
  margin-left: 10px;
  width: 100px;
  height: 40px;
}
.bottom_right {
  display: inline-block;
  position: relative;
  top: -4px;
  right: -44px;
  line-height: 50px;
}
.delete {
  display: inline-block;
  text-align: center;
  width: 80px;
  line-height: 50px;
  background: #ff9a7c !important;
  color: #fff;
  font-size: 13px;
}
.close {
  display: inline-block;
  text-align: center;
  width: 80px;
  line-height: 50px;
  background: #fe7951 !important;
  color: #fff;
  font-size: 13px;
}
</style>

