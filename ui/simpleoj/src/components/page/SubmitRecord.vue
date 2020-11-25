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
    <el-dialog
        title="提交详情"
        :visible.sync="dialogVisible"
        class="pub_dialog"
    >

      <CodemirrorApp ref="codeMirror" />

    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";
import CodemirrorApp from "@/components/page/Codemirror";

export default {
  name: "SubmitRecord",
  components: {CodemirrorApp},
  data(){
    return{
      submitRecord: [],
      show: true,
      problemId: -1,//显示全部
      url:'http://localhost:8181',
      dialogVisible: false
    }

  },
  methods:{
    handleClick(row) {
      console.log(row);
      this.dialogVisible = true;
      if(this.$refs.codeMirror) {
        this.$refs.codeMirror.setCode(row.code);
      }

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
/* 使顶部进行吸顶 */
.top {
  position: sticky;
  position: -webkit-sticky;
  top: 20px;
}
/* 表单大小设置 */
.el-dialog {
  margin: 0 auto !important;
  height: 80%;
  overflow: hidden;
}
.el-dialog__body {
  position: absolute;
  left: 0;
  top: 54px;
  bottom: 70px;
  right: 0;
  padding: 0;
  z-index: 1;
  overflow: hidden;
  overflow-y: auto;
}
/**表单 确定和取消 按钮的位置 */
.el-dialog__footer {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
}
/* 表单输入框的大小 */
.el-input {
  width: 50%;
}

/* 弹出框滚动条 */
/* 设置滚动条的样式 */
/**解决了滚动条之间发生错位的现象 */
::-webkit-scrollbar {
  width: 10px !important;
  height: 10px !important;
  border-radius: 5px;
}
::-webkit-scrollbar-thumb {
  border-radius: 5px;
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.2);
  /* 滚动条的颜色 */
  background-color: #e4e4e4;
}
</style>