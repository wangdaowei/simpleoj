import Vue from 'vue';
import Router from 'vue-router';
import ProblemList from "@/components/page/ProblemList";
import ProblemDetail from "@/components/page/ProblemDetail";
import SubmitHistory from "@/components/page/SubmitHistory";
// 引入路由插件
Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/',
      redirect: '/components/page/ProblemList',
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
      name:'ProblemList',
      component:ProblemList
    },{
      path:'/components/page/ProblemDetail',
      name:'ProblemDetail',
      component:ProblemDetail
    },{
      path:'/components/page/SubmitHistory',
      name:'SubmitHistory',
      component:SubmitHistory
    }
  ],
});