<template>
  <div  class="in-coder-panel">
    <el-select class="code-mode-select" v-model="mode"
               @change="changeMode">
      <el-option v-for="mode in modes"
                 :key="mode.value" :label="mode.label" :value="mode.value">
      </el-option>
    </el-select>
    <div></div>
    <textarea ref="textarea" @change="submitTextarea"></textarea>
  </div>
</template>

<script type="text/ecmascript-6">
// 引入全局实例
import _CodeMirror from 'codemirror'
// 加载bus实现组件通信
import bus from '../../utils/bus';
// 核心样式
import 'codemirror/lib/codemirror.css'
// 引入主题后还需要在 options 中指定主题才会生效
import 'codemirror/theme/cobalt.css'
//import 'codemirror/theme/idea.css'
import '../../assets/css/idea.css'

// 需要引入具体的语法高亮库才会有对应的语法高亮效果
// codemirror 官方其实支持通过 /addon/mode/loadmode.js 和 /mode/meta.js 来实现动态加载对应语法高亮库
// 但 vue 貌似没有无法在实例初始化后再动态加载对应 JS ，所以此处才把对应的 JS 提前引入
import 'codemirror/mode/javascript/javascript.js'
import 'codemirror/mode/css/css.js'
import 'codemirror/mode/xml/xml.js'
import 'codemirror/mode/clike/clike.js'
import 'codemirror/mode/markdown/markdown.js'
import 'codemirror/mode/python/python.js'
import 'codemirror/mode/r/r.js'
import 'codemirror/mode/shell/shell.js'
import 'codemirror/mode/sql/sql.js'
import 'codemirror/mode/swift/swift.js'
import 'codemirror/mode/vue/vue.js'

// 尝试获取全局实例
const CodeMirror = window.CodeMirror || _CodeMirror

export default {
  name: 'CodemirrorApp',
  title: 'edit',
  props: {
    // 外部传入的内容，用于实现双向绑定
    value: String,
    // 外部传入的语法类型
    language: {
      type: String,
      default: null
    }
  },
  data () {
    return {
        //自适应高度
        screenHeight: document.body.clientHeight,
      // 内部真实的内容
      code: '',
      // 默认的语法类型
      mode: 'text/x-java',
      // 编辑器实例
      coder: null,
      // 默认配置
      options: {
        // 缩进格式
        tabSize: 4,
        // 主题，对应主题库 JS 需要提前引入
        theme: 'idea',
        // 显示行号
        lineNumbers: true,
        autoRefresh: true,
        line: true,
        styleActiveLine: true,
        styleSelectedText: false,
        foldGutter: true,
        gutters: ['CodeMirror-linenumbers', 'CodeMirror-foldgutter'],
        highlightSelectionMatches: { showToken: /\w/, annotateScrollbar: true },
        hintOptions: {
          // 当匹配只有一项的时候是否自动补全
          completeSingle: true
        },
        // 快捷键 可提供三种模式 sublime、emacs、vim
        // keyMap: 'sublime'
      },
      // 支持切换的语法高亮类型，对应 JS 已经提前引入
      // 使用的是 MIME-TYPE ，不过作为前缀的 text/ 在后面指定时写死了
      modes: [
      {
        value: 'x-java',
        label: 'Java'
      },{
        value: 'x-python',
        label: 'Python'
      }
      // ,
      // {
      //   value: 'css',
      //   label: 'CSS'
      // }, {
      //   value: 'javascript',
      //   label: 'Javascript'
      // }, {
      //   value: 'html',
      //   label: 'XML/HTML'
      // },{
      //   value: 'x-objectivec',
      //   label: 'Objective-C'
      // },{
      //   value: 'x-rsrc',
      //   label: 'R'
      // }, {
      //   value: 'x-sh',
      //   label: 'Shell'
      // }, {
      //   value: 'x-sql',
      //   label: 'SQL'
      // }, {
      //   value: 'x-swift',
      //   label: 'Swift'
      // }, {
      //   value: 'x-vue',
      //   label: 'Vue'
      // }, {
      //   value: 'markdown',
      //   label: 'Markdown'
      // }
      ]
    }
  },
  mounted () {
    //获取初始化code
    bus.$on('titleCodeEnd-msg', msg => {
      console.log("titleCodeEnd:",msg)
      this.code=msg
      this.coder.setValue(this.value || this.code)
    });

    // 初始化
    this._initialize()
    const that = this
    window.onresize = () => {
    return (() => {
       window.screenHeight = document.body.clientHeight
       that.screenHeight = window.screenHeight
    })()
  }
  },
  methods: {

    setCode(code){
      this.code = code;
      this.coder.setValue(this.value || this.code);
      const _this = this;
      setTimeout(function() {
        _this.coder.refresh();
      }, 1);
    },
    submitTextarea(){
      console.log(this.textarea);
      // 通过bus发送信息
      bus.$emit('textarea', this.textarea);

    },

    // 初始化
    _initialize () {
      
      console.log("code::",this.code)

      // 初始化编辑器实例，传入需要被实例化的文本域对象和默认配置
      this.coder = CodeMirror.fromTextArea(this.$refs.textarea, this.options)
      // 编辑器赋值
      this.coder.setValue(this.value || this.code)

      // 支持双向绑定
      this.coder.on('change', (coder) => {
        this.code = coder.getValue()
        
        if (this.$emit) {
          //console.log('input change!!!')
          bus.$emit('input', this.code)
        }
      })

      // 尝试从父容器获取语法类型
      if (this.language) {
        // 获取具体的语法类型对象
        const modeObj = this._getLanguage(this.language)

        // 判断父容器传入的语法是否被支持
        if (modeObj) {
          this.mode = modeObj.label
        }
      }
    },
    // 获取当前语法类型
    _getLanguage (language) {
      // 在支持的语法类型列表中寻找传入的语法类型
      return this.modes.find((mode) => {
        // 所有的值都忽略大小写，方便比较
        const currentLanguage = language.toLowerCase()
        const currentLabel = mode.label.toLowerCase()
        const currentValue = mode.value.toLowerCase()

        // 由于真实值可能不规范，例如 java 的真实值是 x-java ，所以讲 value 和 label 同时和传入语法进行比较
        return currentLabel === currentLanguage || currentValue === currentLanguage
      })
    },
    // 更改模式
    changeMode (val) {
      // 修改编辑器的语法配置
      this.coder.setOption('mode', `text/${val}`)

      // 获取修改后的语法
      const label = this._getLanguage(val).label.toLowerCase()

      // 允许父容器通过以下函数监听当前的语法值
      bus.$emit('language-change', label)
    }
  },
  watch: {
      screenHeight (val) {
        // 为了避免频繁触发resize函数导致页面卡顿，使用定时器
        if (!this.timer) {
          // 一旦监听到的screenWidth值改变，就将其重新赋给data里的screenWidth
          this.screenHeight = val
          this.timer = true
          let that = this
          setTimeout(function () {
            // 打印screenWidth变化的值
            console.log(that.screenHeight)
            that.timer = false
          }, 400)
        }
      }
    }
}
</script>

<style lang="stylus" rel="stylesheet/stylus">
  .in-coder-panel
    flex-grow 1
    display flex
    position relative
    
    .CodeMirror
    
      flex-grow 1
      z-index 1
      height 100%
      left -20px
      .CodeMirror-code
        line-height 19px
        

    .code-mode-select
      position absolute
      z-index 2
      right 10px
      top 10px
      max-width 130px
</style>
