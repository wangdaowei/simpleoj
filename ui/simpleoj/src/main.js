// 将 main.js 修改为：
import Vue from 'vue';
import App from './App.vue';
import router from './router';
// 引入 Element UI
import ElementUI from 'element-ui';
// 单独引入样式文件
import 'element-ui/lib/theme-chalk/index.css';

// 执行 ElementUI
// main.js
Vue.use(ElementUI, { size: 'small', zIndex: 3000 });

Vue.config.productionTip = false;

new Vue({
  router,
  render: (h) => h(App),
}).$mount('#app');