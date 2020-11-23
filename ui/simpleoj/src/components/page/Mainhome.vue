<template>
  <!-- 首页组件 -->
  <div>
    <!-- 行布局容器 gutter属性为栅格间隔 -->
    <el-row :gutter="24">
      <!-- 列布局容器 Element UI 将一行分为 24列，通过 span来表示占据的列数的份额-->
      <el-col :span="12">
        <!-- 左侧一半展示试题 -->
         <el-select v-model="value" class="titleSelect" @change="selectTitleChange" placeholder="请选择题目">
            <el-option
            v-for="item in options"
            :key="item.titleId"
            :label="item.titleId+'、'+item.titleName"
            :value="item.titleId">
            </el-option>
        </el-select>

        <!-- 题目信息 -->
        <el-collapse  class="el-collapse" v-model="activeNames" >
            <el-collapse-item  title="题目：" name="1">
                <div>
                    <span> {{ selectedTitle.titleName }}</span>
                </div>
                <div>
                    <span> {{ selectedTitle.titleDescribe }}</span>
                </div>
            </el-collapse-item>
            <el-collapse-item title="题目难度：" name="2">
                <div>
                    <span> {{ selectedTitle.titleLevel }}</span>
                </div>
            </el-collapse-item>
            <el-collapse-item title="描述1:" name="3">
                <div>
                    <span> {{ selectedTitle.titleExample }}</span>
                </div>
           </el-collapse-item>
            <el-collapse-item title="描述2:" name="4">
                <div>
                    <span> {{ selectedTitle.titleExample2 }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="提交状态:" name="5">
                <div>
                    <span> {{ selectedTitle.submitStatus }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="报错信息:" name="11">
                <div>
                    <span> {{ selectedTitle.errorInfo }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="编译耗时:（ms）" name="6">
                <div>
                    <span> {{ selectedTitle.compileTime }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="运行耗时:（ms）" name="7">
                <div>
                    <span> {{ selectedTitle.runTime }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="输入:" name="8">
                <div>
                    <span> {{ selectedTitle.input }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="输出:" name="9">
                <div>
                    <span> {{ selectedTitle.output }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="预期结果:" name="10">
                <div>
                    <span> {{ selectedTitle.rightOutput }}</span>
                </div>
            </el-collapse-item>

            
        </el-collapse>
      </el-col>

      
      <!-- 编辑器及提交信息 -->
      <el-col :span="12">
            <div id="Codemirrorapp" >
                <CodemirrorApp />
            </div>

            <el-button class="submitButon" @click="submitTitle()" type="primary" icon="el-icon-s-promotion">提交</el-button>
      </el-col>


    </el-row>
  </div>
</template>

<script>
  import bus from '../../utils/bus';
  import CodemirrorApp from './Codemirror.vue';
  import axios from 'axios';
  //import Vue from 'vue';
  export default {
    name: 'dashboard',
    data() {

    
      return {
        url:'http://localhost:10089',
        language: 'java',
        //试题栏激活列表
        activeNames: ['1','2','3','4'],
        input: '',
        selectedTitleId: '',
        test: 'ceshishuju',
        options: [],
        outMessage:'',
        value: '',
        labelPosition: 'right',
        formLabelAlign: {
          name: '',
          region: '',
          type: ''
        },
        selectedTitle: {
            titleId: '',
            titleName: '',
            titleLevel: '',
            titleDescribe: '',
            titleExample: '',
            titleExample2: '',
            submitStatus:'',
            input:'',
            output:'',
            rightOutput:'',
            compileTime:'',
            runTime:'',
            errorInfo:''
        },

      };
    },
    components: {
        CodemirrorApp,
    },
    computed: {
      
    },
    // 在创建vue对象时，当html渲染之前就触发，只会触发一次；
    created() {

    },
    // activated,deactivated这两个生命周期函数一定是要在使用了keep-alive组件后才会有的
    // 在vue对象存活的情况下，进入当前存在activated()函数的页面时，一进入页面就触发
    activated() {

    },
    // 退出当前存在deactivated()函数页面时触发
    deactivated() {
      // 清除事件监听
      window.removeEventListener('resize', this.renderChart);
      // 清除监听
      bus.$off('collapse', this.handleBus);
    },
    mounted(){
        const _this = this
        axios.get(this.url+'/title/findAll/').then(function(resp){
            console.log(resp)
            _this.options = resp.data
        })

        //获取编辑框输入的字符
        bus.$on('input', msg => {
            //console.log(msg)
            this.input=msg
        });

        
        //获取选择的语音种类
        bus.$on('language-change', msg => {
            console.log(msg)
            this.language=msg
        });
    },
    methods: {

        selectTitleChange(){
            this.selectedTitle=this.options[this.value-1]
            this.activeNames=['1','2','3','4']


        },

        submitTitle(){
            const _this = this;
            if(this.selectedTitle.titleId==''){
              alert("请先选择题目再提交！");
              return;
            }
            console.log(this.input)
            axios.post(this.url+'/title/submit/',{
              //选题
              titleId: this.selectedTitle.titleId,
              //输入内容
              input: this.input,
              language: this.language
            })
            .then(function(res){
              console.log(res.data);
              console.log(res.data.errorCode);
              _this.selectedTitle.output=res.data.output;
              _this.selectedTitle.errorInfo=res.data.errorInfo;
              _this.selectedTitle.compileTime=res.data.compileTime;
              _this.selectedTitle.runTime=res.data.runTime;
              
              //Vue.set(_this.selectedTitle,"output",res.data.output);
              _this.activeNames=['5','6','7','8','9','10','11'];
              
            })
            .catch(function(err){
              console.log(err);
            });
        },
    },
  };
</script>

<style scoped>
    .submitButon{
        float: right;
        margin-right: 50px;
    }
  .el-row {
    margin-bottom: 20px;
  }

  .grid-content {
    display: flex;
    align-items: center;
    height: 100px;
  }

  .grid-cont-right {
    flex: 1;
    text-align: center;
    font-size: 14px;
    color: #999;
  }

  .grid-num {
    font-size: 30px;
    font-weight: bold;
  }

  .grid-con-icon {
    font-size: 50px;
    width: 100px;
    height: 100px;
    text-align: center;
    line-height: 100px;
    color: #fff;
  }

  .grid-con-1 .grid-con-icon {
    background: rgb(45, 140, 240);
  }

  .grid-con-1 .grid-num {
    color: rgb(45, 140, 240);
  }

  .grid-con-2 .grid-con-icon {
    background: rgb(100, 213, 114);
  }

  .grid-con-2 .grid-num {
    color: rgb(45, 140, 240);
  }

  .grid-con-3 .grid-con-icon {
    background: rgb(242, 94, 67);
  }

  .grid-con-3 .grid-num {
    color: rgb(242, 94, 67);
  }

  .user-info {
    display: flex;
    align-items: center;
    padding-bottom: 20px;
    border-bottom: 2px solid #ccc;
    margin-bottom: 20px;
  }

  .user-avator {
    width: 120px;
    height: 120px;
    border-radius: 50%;
  }

  .user-info-cont {
    padding-left: 50px;
    flex: 1;
    font-size: 14px;
    color: #999;
  }

  .user-info-cont div:first-child {
    font-size: 30px;
    color: #222;
  }

  .user-info-list {
    font-size: 14px;
    color: #999;
    line-height: 25px;
  }

  .user-info-list span {
    margin-left: 70px;
  }

  .mgb20 {
    margin-bottom: 20px;
  }

  .todo-item {
    font-size: 14px;
  }

  .todo-item-del {
    text-decoration: line-through;
    color: #999;
  }

  .schart {
    width: 100%;
    height: 300px;
  }
  .el-collapse{
      margin-left: 10px;
  }

  .titleSelect{
      margin-left: 10px;
      width: 400px;
  }

</style>