import Vue from 'vue'
import './cube-ui'
import App from './App.vue'
import router from './router'
import store from './store'
import 'amfe-flexible'

import MyFooter from './components/MyFooter'

Vue.component("my-footer", MyFooter);

// 完整引入mint-ui
import MintUI from 'mint-ui'
// 单引引入mint-ui样式
import 'mint-ui/lib/style.css'
// 将mint-ui注册vue
Vue.use(MintUI);
// 引入cube-ui
import Cube from 'cube-ui'
Vue.use(Cube)

import axios from 'axios'
Vue.prototype.axios = axios;
// 配置axios发送请求时保存session信息
axios.defaults.withCredentials = true
// 配置axios基础路径
axios.defaults.baseURL = "http://127.0.0.1:7700/"


Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
