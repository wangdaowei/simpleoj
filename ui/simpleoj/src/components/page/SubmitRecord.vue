<template>
  <div ref="submtRcrdV">
    <el-table
        :data="submitRecord"
        style="width: 100%"
        height="250">
      <el-table-column
          prop="problemId"
          label="题号"
          width="80"
          v-if="show"
      >
      </el-table-column>
      <el-table-column
          prop="submitTime"
          label="提交时间"
          width="150">
        <template slot-scope="scope">{{scope.row.submitTime | dateFormat}}</template>
      </el-table-column>
      <el-table-column
          prop="judgeResult"
          label="提交结果"
          width="120">
      </el-table-column>
      <el-table-column
          prop="usedTime"
          label="运行时间"
          width="120">
      </el-table-column>
      <el-table-column
          prop="usedMemory"
          label="内存消耗"
          width="120">
      </el-table-column>
      <el-table-column
          prop="language"
          label="语言"
          width="120">
      </el-table-column>
      <el-table-column
          fixed="right"
          label="操作"
          width="100">
        <template slot-scope="scope">
          <el-button @click="handleClick(scope.row)" type="text" size="small">查看</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "SubmitRecord",
  data(){
    return{
      submitRecord: [],
      show: true,
      problemId: -1,//显示全部
      url:'http://localhost:8181',
    }

  },
  methods:{
    handleClick(row) {
      console.log(row);
    },
    setProblemId(problemID){
      console.log("probleID:", problemID);
      this.problemId = problemID;
      this.show = false;
      this.refreshSubmission();
    },
    refreshSubmission(){
      let _this = this;
      if(this.problemId>0){
        axios.get(this.url+'/submission/getSubmissionByProblem/',{
          params: {
            titleId: this.problemId
          }}).then(function(resp){
          console.log("resp:",resp);
          _this.submitRecord = resp.data;
        });
      }else{
        console.log("getAllRecords");
      }
    }
  },
  mounted() {

  }
}
</script>

<style scoped>

</style>