import Vue from 'vue';
import Router from 'vue-router';
import ProblemList from "@/components/page/ProblemList";
import ProblemDetail from "@/components/page/ProblemDetail";
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
    {
      path:'/components/page/ProblemList',
      component:ProblemList
    },{
      path:'/components/page/ProblemDetail',
      name:'ProblemDetail',
      component:ProblemDetail
    }
  ],
});