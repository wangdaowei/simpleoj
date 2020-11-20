<template>
  <div style="width: 100%;height: 95%">
    <el-container style="height: 100%">
<!--      <el-header style="background-color: #cccccc;height: 20px"><p>PROBLEM DETAIL:{{problemId}}</p></el-header>-->
      <el-container style="height: 100%">
        <el-main style="background-color: aquamarine;width:0">
           <!-- 题目信息 -->
        <el-collapse  class="el-collapse" v-model="activeNames" >
            <el-collapse-item  title="题目：" name="1">
                <div>
                    <span> {{ problemDetail.titleName }}</span>
                </div>
                <div>
                    <span> {{ problemDetail.titleDescribe }}</span>
                </div>
            </el-collapse-item>
            <el-collapse-item title="题目难度：" name="2">
                <div>
                    <span> {{ problemDetail.titleLevel }}</span>
                </div>
            </el-collapse-item>
            <el-collapse-item title="描述1:" name="3">
                <div>
                    <span> {{ problemDetail.titleExample }}</span>
                </div>
           </el-collapse-item>
            <el-collapse-item title="描述2:" name="4">
                <div>
                    <span> {{ problemDetail.titleExample2 }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="提交状态:" name="5">
                <div>
                    <span> {{ problemDetail.submitStatus }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="报错信息:" name="11">
                <div>
                    <span> {{ problemDetail.errorInfo }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="编译耗时:（ms）" name="6">
                <div>
                    <span> {{ problemDetail.compileTime }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="运行耗时:（ms）" name="7">
                <div>
                    <span> {{ problemDetail.runTime }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="输入:" name="8">
                <div>
                    <span> {{ problemDetail.input }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="输出:" name="9">
                <div>
                    <span> {{ problemDetail.output }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="预期结果:" name="10">
                <div>
                    <span> {{ problemDetail.rightOutput }}</span>
                </div>
            </el-collapse-item>

            
        </el-collapse>
        </el-main>
        <el-container style="width: 0;">
          <el-main style="background-color: bisque;height:80%"><CodemirrorApp /></el-main>

          <el-footer style="background-color: dodgerblue;float: bottom;height: 20%">
            <el-button class="submitButon" @click="submitTitle()" type="primary" icon="el-icon-s-promotion">提交</el-button>
          </el-footer>
        </el-container>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import axios from "axios";
import CodemirrorApp from "@/components/page/Codemirror";
import bus from "@/utils/bus";

export default {
  name: "ProblemDetail",
  components: {CodemirrorApp},
  data(){
    return{
      problemId:"",
      problemDetail:{},
      activeNames:['1','2','3','4'],
      url:'http://localhost:8181',
      input:'',
      language: 'java'
    }
  },
  mounted() {
    this.problemId = this.$route.query.problemId;
    // this.problemId = localStorage.getItem('problemId'); //刷新数据可获取
    console.log("this.problemId", this.problemId);
    let param = {};
    param.titleId = this.problemId;
    const _this = this;
    axios.get(this.url+'/title/findOne/',{
      params: {
        titleId: this.problemId
      }}).then(function(resp){
      console.log("resp:",resp);
      _this.problemDetail = resp.data
    });

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
  methods:{
    submitTitle(){
	const _this = this;
      console.log(this.input)
      axios.post(this.url+'/title/submit/',{
        //选题
        titleId: this.problemId,
        //输入内容
        input: this.input,
        language: this.language
      })
          .then(function(res){
            console.log(res.data);
            console.log(res.data.description);
            console.log(res.data.errorCode);

            console.log(res.data.errorCode);
            _this.problemDetail.output=res.data.output;
            _this.problemDetail.errorInfo=res.data.errorInfo;
            _this.problemDetail.compileTime=res.data.compileTime;
            _this.problemDetail.runTime=res.data.runTime;
            
            //Vue.set(_this.problemDetail,"output",res.data.output);
            _this.activeNames=['5','6','7','8','9','10','11'];
          })
          .catch(function(err){
            console.log(err);
          });
    },
  }
}
</script>

<style scoped>
.el-collapse{
  word-wrap: break-word;
  width: 100%;
}
.submitButon{
  float: right;
  margin-right: 50px;
  width: fit-content;
}
</style>
