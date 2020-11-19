<template>
  <div style="width: 100%;height: 100%">
    <el-container>
      <el-header style="background-color: #cccccc;height: 20px"><p>PROBLEM DETAIL:{{problemId}}</p></el-header>
      <el-container>
        <el-main style="background-color: aquamarine;height: 100%;width:0">
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
          <el-collapse-item title="描述1" name="3">
            <div>
              <span> {{ problemDetail.titleExample }}</span>
            </div>
          </el-collapse-item>
          <el-collapse-item title="描述2" name="3">
            <div>
              <span> {{ problemDetail.titleExample2 }}</span>
            </div>
          </el-collapse-item>

          <el-collapse-item title="提交状态" name="4">
            <div>
              <span> {{ problemDetail.submitStatus }}</span>
            </div>
          </el-collapse-item>

          <el-collapse-item title="输入" name="4">
            <div>
              <span> {{ problemDetail.input }}</span>
            </div>
          </el-collapse-item>

          <el-collapse-item title="输出" name="4">
            <div>
              <span> {{ problemDetail.output }}</span>
            </div>
          </el-collapse-item>

          <el-collapse-item title="预期结果" name="4">
            <div>
              <span> {{ problemDetail.rightOutput }}</span>
            </div>
          </el-collapse-item>
        </el-collapse>
        </el-main>
        <el-container style="width: 0">
          <el-main style="background-color: bisque;height: 100%"><CodemirrorApp /></el-main>
          <el-footer style="background-color: dodgerblue;height: 20%"></el-footer>
        </el-container>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import axios from "axios";
import CodemirrorApp from "@/components/page/Codemirror";

export default {
  name: "ProblemDetail",
  components: {CodemirrorApp},
  data(){
    return{
      problemId:"",
      problemDetail:{},
      activeNames:['1','2','3'],
    }
  },
  mounted() {
    this.problemId = this.$route.params.problemId;
    console.log("this.problemId", this.problemId);
    let param = {};
    param.titleId = this.problemId;
    const _this = this;
    axios.get('http://localhost:8181/title/findOne/',{
      params: {
        titleId: this.problemId
      }}).then(function(resp){
      console.log("resp:",resp);
      _this.problemDetail = resp.data
    })
  }
}
</script>

<style scoped>
.el-collapse{
  word-wrap: break-word;
  width: 100%;
}
</style>