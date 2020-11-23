<template>
  <div id="tableV" ref="tableV">
  <el-table
      :data="tableData"
      style="width:fit-content;margin-top: 50px;margin-left: 100px">
    <el-table-column
        prop="titleId"
        label="#"
        width="80">
    </el-table-column>
    <el-table-column
        prop="titleName"
        label="题名"
        width="280">
    </el-table-column>
    <el-table-column
        prop="passRate"
        label="通过率"
        width="100">
    </el-table-column>
    <el-table-column
        prop="titleLevel"
        label="难度"
        width="100"
    >
    </el-table-column>
    <el-table-column
        fixed="right"
        label="操作"
        width="100">
      <template slot-scope="scope">
        <router-link
            :to="{
        name:'ProblemDetail',
        // params: {
        //     problemId: scope.row.titleId, // orderNum : this.searchData.orderNo
        // },
        query: {
           problemId: scope.row.titleId, // orderNum : this.searchData.orderNo
        }
         }">
        <el-button @click="handleClick(scope.row)" type="text" size="small">查看</el-button>
        </router-link>
      </template>
    </el-table-column>
  </el-table>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "ProblemList",
  data(){return{
    tableData:[]
  }
  },
  methods:{
    handleClick(row) {
      console.log(row);
      localStorage.setItem('problemId',row.titleId);
    }
  },
  mounted(){
    const _this = this
    
    //axios.get('http://106.55.166.98:10089/title/findAll/').then(function(resp){
    axios.get('http://localhost:8181/title/findAll/').then(function(resp){
      console.log(resp)
      _this.tableData = resp.data
    })
  },
}

</script>

<style scoped>
el-table-column{
  height: 20px;
}
</style>