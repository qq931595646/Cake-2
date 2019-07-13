<template>
  <div>
    <div class="mySearch">
      <!-- 点击搜索框后要跳到一个新的组件页面 -->
      <mt-search autofocus v-model="value" :result="filterResult"></mt-search>
    </div>
    <!-- <h1>dsadsa</h1> -->
    <!-- 左侧边栏 -->
    <div class="let-tabbar">
      <div class="left-panel">
        <cube-scroll>
          <cube-tab-bar
            v-model="selectedLabel"
            :data="Object.keys(left_list).map(label => ({label}))"
            @change="changeHandler"
          ></cube-tab-bar>
        </cube-scroll>
      </div>
    </div>
    <!-- 右边 -->
    <div class="right-panel">
      <cube-scroll ref="scroll">
        <ul>
          <li v-for="(elem,i) in right_list" :key="i">
            <a href v-if="elem.series!='NULL'">
              <img src="images/1.png" />
              <span v-text="elem.series"></span>
            </a>
          </li>
        </ul>
      </cube-scroll>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      value: "",
      // 默认数据(搜索的关键字)
      defaultResult: ["蛋糕", "123", "1", "124567"],
      left_list: {},
      right_list: [],
      selectedLabel: ""
    };
  },
  created() {
    // 请求数据
    this.axios.get("product/classify").then(result => {
      // console.log(result.data.msg);
      var msg = result.data.msg;
      // 请求回来的数据格式不是我想要的数据格式要转成:
      // left_list: {蛋糕:[{name:"蛋糕",pic:"images/1.jspg"},...],...,...,}
      var obj_list = {};
      var obj_name = [];
      for (var i = 0; i < msg.length; i++) {
        // 如果这个对象名里没有东西就强行赋值为一个空数组
        if (obj_list[msg[i].cname] == undefined) {
          obj_list[msg[i].cname] = [];
        }
        // 拿到对象的属性名
        obj_name = Object.keys(obj_list);
        // 如果对象的属性名和数据里的分类名称一样就放进该对象里的数组里
        for (var name of obj_name) {
          if (name == msg[i].cname) {
            obj_list[name].push(msg[i]);
          }
        }
      }
      this.left_list = obj_list;
      // 加载第一个区域
      this.selectedLabel = Object.keys(this.left_list)[0];
      this.right_list = this.left_list[this.selectedLabel];
    });
  },
  methods: {
    changeHandler(label) {
      // 点击左边后换到别的区域
      this.right_list = this.left_list[label];
      // console.log(this.right_list);
    }
  },
  computed: {
    // 显示搜索的内容
    filterResult() {
      return this.defaultResult.filter(value =>
        new RegExp(this.value, "i").test(value)
      );
    }
  },
  watch: {
    selectedLabel(newV) {
      // console.log(newV);
    }
  }
};
</script>
<style lang="stylus" rel="stylesheet/stylus">
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

/* 左侧导航 */
.let-tabbar {
  position: absolute;
  top: 52px;
  left: 0;
  bottom: 0;
  width: 100px;
  background-color: #f9f9f9;
}

.cube-scroll-list-wrapper {
  .cube-tab-bar {
    flex-wrap: wrap;

    .cube-tab {
      width: 100%;
      flex-basis: unset;
      height: 40px;
      line-height: 40px;
      font-size: 14px;
      color: #555;

      &.cube-tab_active {
        background-color: #fff;
        color: #fe9170;

        &::after {
          content: '';
          display: block;
          border: 1px solid #fe9170;
        }
      }
    }
  }
}

.right-panel {
  position: absolute;
  top: 52px;
  left: 100px;
  right: 0;
  bottom: 0;
  background-color: #f9f9f9;

  ul {
    position: fixed;
    background-color: #fff;
    top: 0;
    left: 0;
  }

  li {
    float: left;
    margin-left: 19px;
    height: 100px;
    align-items: center;
    text-align: center;
    background-color: #fff;
    width: 24%;
    margin-bottom: 30px;
    // 单行文本超出部分隐藏
    white-space: nowrap;
    // text-overflow: ellipsis;
    // overflow: hidden;
    word-break: break-all;

    img {
      display: block;
      width: 100%;
    }

    span {
      font-size: 12px;
      color: #555;
    }
  }
}
</style>


