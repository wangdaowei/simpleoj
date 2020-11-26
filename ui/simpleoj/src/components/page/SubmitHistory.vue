<template>
  <el-table
    :data="tableData"
    style="width: 100%"
    :row-class-name="tableRowClassName">
    <el-table-column
      prop="IP"
      label="提交IP"
      width="180">
    </el-table-column>
    <el-table-column
      prop="title"
      label="题目"
      width="180">
    </el-table-column>
    <el-table-column
      prop="submitStatus"
      label="提交状态">
    </el-table-column>
    <el-table-column
      prop="compileTime"
      label="编译耗时">
    </el-table-column>
    <el-table-column
      prop="runTime"
      label="运行耗时">
    </el-table-column>
    <el-table-column
      prop="memory"
      label="消耗内存">
    </el-table-column>
    <el-table-column
      prop="errorInfo"
      label="错误信息">
    </el-table-column>
    <el-table-column
      prop="submitDate"
      label="提交日期">
    </el-table-column>
  </el-table>
</template>

<style>
  .el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #f0f9eb;
  }
</style>

<script>
  export default {
    methods: {
      // eslint-disable-next-line no-unused-vars
      tableRowClassName({row, rowIndex}) {
        if (rowIndex === 1) {
          return 'warning-row';
        } else if (rowIndex === 3) {
          return 'success-row';
        }
        return '';
      }
    },
    data() {
      return {
        tableData: [{
          IP: '192.168.43.139',
          title: '两数之和',
          submitStatus: '通过',
          compileTime: '528 ms',
          runTime: '50 ms',
          memory: '18556 kB',
          errorInfo: '',
          submitDate: '20201125',

        }, ]
      }
    }
  }
</script>