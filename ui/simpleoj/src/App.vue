<template>
  <div ref="app" style="height: 100%">
    <div ref="menuV" style="height: fit-content">
    <el-menu
        ref="menu"
        class="el-menu-demo"
        router mode="horizontal"
        @select="handleSelect"
        background-color="#545c64"
        text-color="#fff"
        active-text-color="#ffd04b"
        style="padding-left: 100px"
    >
      <el-menu-item v-for="(item,i) in navList" :key="i" :index="item.name">
        <template slot="title">
          <i class="el-icon-s-platform"></i>
          <span> {{ item.navItem }}</span>
        </template>

      </el-menu-item>
    </el-menu>
    </div>
    <div id="contentV" style="height: 100%"><router-view></router-view></div>
  </div>
</template>
<script>

  export default {
    data(){
      return{
        navList:[
          {name:'/components/page/Main',navItem:'首页'},
          {name:'/components/page/ProblemList',navItem:'题库'},
          {name:'/components/page/',navItem:'提交记录'},
        ]}
    },
    components: {
      // 挂载Home组件

    },
    methods:{
      handleSelect(key, keyPath) {
        console.log(key, keyPath);
      }
    },
    mounted() {
      let me = this;
      // document.getElementById("contentV").style.height = ('#app').height()-('#menuV').height();
      console.log("height",me.$refs.menu.$el.clientHeight);
      console.log("appheight", me.$refs.app.offsetHeight);
      //特坑的高度设置
      document.getElementById('contentV').style.height = me.$refs.app.offsetHeight-me.$refs.menu.$el.clientHeight + "px";
    }
  };
</script>
<style>
  @import './assets/css/main.css';
  @import './assets/css/color-dark.css'; /*深色主题*/
  /*@import "./assets/css/theme-green/color-green.css";   浅绿色主题*/
</style>