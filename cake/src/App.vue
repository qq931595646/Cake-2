<template>
  <div id="app">
    <router-view v-on:show_footer="show_footer" />
    <!-- <my-footer v-if="footer_show"></my-footer> -->
  </div>
</template>
<script>
export default {
  data() {
    return {
      footer_show: true
    };
  },
  methods: {
    //是否显示底部
    show_footer: function(bool) {
      this.footer_show = bool;
    }
  }
};
</script>
<style >
@import "./assets/iconfont/iconfont.css";
</style>
<style>
</style>
