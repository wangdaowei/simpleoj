<template>
  <el-table
      :data="tableData"
      style="width: 80%;margin-top: 50px;margin-left: 100px"
      :row-class-name="tableRowClassName">
    <el-table-column
        prop="titleId"
        label="#"
        width="80">
    </el-table-column>
    <el-table-column
        prop="titleName"
        label="题名"
        width="180">
    </el-table-column>
    <el-table-column
        prop="passRate"
        label="通过率"
        width="180">
    </el-table-column>
    <el-table-column
        prop="titleLevel"
        label="难度">
    </el-table-column>
    <el-table-column
        fixed="right"
        label="操作"
        width="100">
      <template slot-scope="scope">
        <router-link
            :to="{
        name:'ProblemDetail',
        params: {
            problemId: scope.row.titleId, // orderNum : this.searchData.orderNo
        },
        // query: {
        //    key: 'value', // orderNum : this.searchData.orderNo
        // }
         }">
        <el-button @click="handleClick(scope.row)" type="text" size="small">查看</el-button>
        </router-link>
      </template>
    </el-table-column>
  </el-table>
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

    }
  },
  mounted(){
    const _this = this
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