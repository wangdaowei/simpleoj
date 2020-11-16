import Vue from 'vue';
import Router from 'vue-router';
// 引入路由插件
Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/',
      redirect: '/mainhome',
    },
    {
      path: '/',
      component: () => import('../components/common/Home.vue'),
      meta: { title: '自述文件' },
      children: [
        {
          path: '/mainhome',
          component: () => import('../components/page/Mainhome.vue'),
          meta: { title: '系统首页' },
        },
      ],
    },
  ],
});