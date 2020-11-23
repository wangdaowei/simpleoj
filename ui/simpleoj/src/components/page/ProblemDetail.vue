<template>
  <div style="width: 100%;height: 100%">
      <el-container ref="app1" style="height: 100%">
        <div id="left" class="overflow" ref="left">
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
                    <span  v-html="problemDetail.errorInfo"></span>
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
                    <span> {{ problemDetail.titleInput }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="输出:" name="9">
                <div>
                    <span> {{ problemDetail.output }}</span>
                </div>
            </el-collapse-item>

            <el-collapse-item title="预期结果:" name="10">
                <div>
                    <span> {{ problemDetail.titleExpectOutput }}</span>
                </div>
            </el-collapse-item>

            
        </el-collapse>
        </div>
        <div ref="middle" id="middle"></div>
        <div id="right" ref="right">
        <el-container style="height: 100%">
          <el-main style="background-color: bisque;height:80%"><CodemirrorApp /></el-main>

          <el-footer style="background-color: dodgerblue;float: bottom;height: 20%">
            <div ><el-button class="submitButon" @click="submitTitle()" type="primary" icon="el-icon-s-promotion">提交</el-button></div>
            <div></div>
          </el-footer>
        </el-container>
        </div>
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
      problemId:-1,
      problemDetail:{},
      activeNames:['1','2','3','4'],
      //url:'http://106.55.166.98:10089',
      url:'http://localhost:8181',
      input:'',
      language: 'java',
      titleCodeEndJava: '',
      errorCode: '',
      submitResult: ''
    }
  },
  mounted() {
    
    this._initTitle()
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

    this.resizeContent();
  },
  methods:{
    submitDialog(){
      if(this.errorCode==0){
        if(this.submitResult=="通过"){
          this.submitSuccess();
        }else if(this.submitResult=="解答错误"){
          this.submitWarning();
        }
      }else{
        if(this.submitResult=="编译错误"){
          this.submitError();
        }
      }

    },

    submitSuccess() {
        this.$notify({
          title: '通过',
          message: '恭喜您成功通过本题。',
          type: 'success',
          duration: 0
        });
      },

    submitWarning() {
        this.$notify({
          title: '解答错误',
          message: '编译运行成功，但是结果与预期不符。',
          type: 'warning',
          duration: 0
        });
      },

    submitError() {
        this.$notify.error({
          title: '编译错误',
          message: '编译未通过，请结合左侧报错信息进行修改。',
          duration: 0
        });
      },

    _initTitle ( ) {
      this.problemId = parseInt(this.$route.query.problemId);
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
      _this.titleCodeEndJava=resp.data.titleCodeEndJava

      bus.$emit('titleCodeEndJava', _this.titleCodeEndJava)

    });

    },

    resizeContent(){
      var resize = this.$refs.middle;
      var left = this.$refs.left;
      var right = this.$refs.right;
      var box = this.$refs.app1.$el;
      resize.onmousedown = function(e){

        var startX = e.clientX;
        resize.left = resize.offsetLeft;

        document.onmousemove = function(e){
          var endX = e.clientX;

          var moveLen = resize.left + (endX - startX);
          var maxT = box.clientWidth - resize.offsetWidth;
          if(moveLen<200) moveLen = 200;
          if(moveLen>maxT-400) moveLen = maxT-400;

          resize.style.left = moveLen;
          left.style.width = moveLen + "px";
          right.style.width = (box.clientWidth - moveLen - 5) + "px";
          console.log("movLen:" , moveLen)
        }
        document.onmouseup = function(evt){
          evt.stopPropagation()
          document.onmousemove = null;
          document.onmouseup = null;
          resize.releaseCapture && resize.releaseCapture();
        }
        resize.setCapture && resize.setCapture();
        return false;
      };
    },

  submitTitle(){
      const _this = this;
      console.log(this.input)
      axios.post(this.url+'/title/submit/',{
        //选题
        titleId: this.problemId,
        titleExpectOutput: this.problemDetail.titleExpectOutput,
        titleInput: this.problemDetail.titleInput,
        //输入内容  pre+input  是最终 t.java
        input: this.input,
        titleCodePreJava: this.problemDetail.titleCodePreJava,

        language: this.language
      })
          .then(function(res){
            console.log(res.data);
            console.log(res.data.errorCode);

            console.log(res.data.errorCode);
            _this.problemDetail.output=res.data.output;
            _this.problemDetail.errorInfo=res.data.errorInfo;
            _this.problemDetail.compileTime=res.data.compileTime;
            _this.problemDetail.runTime=res.data.runTime;
            _this.problemDetail.submitStatus=res.data.submitResult;

            _this.errorCode=res.data.errorCode;
            _this.submitResult=res.data.submitResult;

            _this.submitDialog();


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
#left{
  background-color: aquamarine;
  width: 50%;
  height: 100%;
}

.overflow{
  overflow: auto;
}

#middle{
  cursor: col-resize;
  height:100%;
  position: relative;
  width: 3px;
  background-color: lightcoral;
}

#right{
  width: 50%;
  height: 100%;
  position: relative;
}
#app1{
  height: 100%;
  width: 100%;
}
</style>
