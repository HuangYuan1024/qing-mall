<template>
  <div>
    <el-dialog
      class="dialog-block"
      :title="infoForm.id ? '编辑规格' : '新增规格'"
      :visible.sync="visible"
      @open="handleShow"
      @close="onReactForm()"
      width="640px"
      :close-on-click-modal="false"
    >
      <div>
        <el-form
          :model="infoForm"
          ref="infoForm"
          :rules="rules"
          label-width="118px"
          label-position="right"
          class="dialog-form"
        >
         <el-form-item label="商品分类：" prop="categoryName" style="width:100%;">
              <el-input v-model="infoForm.categoryName" placeholder="必填项" size="medium" style="width:217px;" disabled="disabled"></el-input>
              <span class="table_btn" style="margin-left:10px;" @click="changecateFn">选择分类</span>
          </el-form-item>
          <el-form-item label="规格名称：" prop="name" size="medium" style="width:95%;">
            <el-input v-model="infoForm.name" placeholder="请输入"></el-input>
          </el-form-item>
          <el-form-item label="规格选项：" prop="options" size="medium">
            <div v-for="(item,index) in optionsList" :key="index" class="item_input">
                <el-input type="text" v-model="item.name" placeholder="请输入" ></el-input>
                <i class="el-icon-circle-close" @click="delOptions(index)"></i>
            </div>
            
            <el-button @click="changeOptions">添加</el-button>
          </el-form-item>
        </el-form>
      </div>
      <div slot="footer" class="dialog-footer text-c">
        <el-button
          type="button"
          size="medium"
          @click="onReactForm(false)"
          style="background:#fafafa;"
        >取 消</el-button>
        <el-button type="primary" size="medium" :loading="loading" @click="onSaveData()">保 存</el-button>
      </div>
    </el-dialog>
    
    <categoryList @on-catedetail="getCategory" :dataIds="dataIds" :dataNames="nameList" @on-cancel="onCancel" :visible.sync="catedialogVisible" ref="cate"></categoryList>
  
  </div>
</template>

<script>
import axios from "axios";
import API from "@/api/api_basic";
import categoryList from "@/components/global/categoryCheckbox";
export default {
  components: {
    categoryList
  },
  props: {
    visible: Boolean,
    data: {
      type: Object,
      default: () => {}
    }
  },
  data() {
    return {
      
      catedialogVisible: false,
      dataIds:[],
      nameList:[],
      loading: false,
      infoForm: {
        id: "",
        options: "",
        name: "",
        seq: null,
        categoryName: "",
        categories:[]
      },
      rules: {
        name: [{ required: true, message: "请填写规格名称" }],
         categoryName: [{ required: true, message: "请选择分类" }]

      },
      id:0,
      optionsList:[{name:""}]
    };
  },
  watch: {},
  mounted() {},
  methods: {
    changeOptions(){
      let obj={
        name:""
      }
      this.$set(this.optionsList,this.optionsList.length,obj)
    },
    delOptions(index){
      console.log(index)
      this.optionsList.splice(index,1)
    },
      /**
     * @description 获取分类id
     */
     init(id){

           let promise=new Promise((resolve,reject)=>{
              API.categoryListApi({id:id})
              .then(result => {
              if (result.data.code == "20000") {
                  console.log(result.data)
                  let data =result.data.data||[];
                  resolve(data)
              } else {
                  this.$errMsg(result.data.message);
              }
              })
              .catch(function(error) {
                  reject(error)
                  this.$serverErrMsg();
              });
          })
          return promise
          
      },
  
    /**
     * @description 选择分类 取消
     */
    onCancel() {
      this.catedialogVisible = false;
    },
    /**
     * @description 选择分类（打开弹窗）
     */
    changecateFn() {
      var that = this;
      that.catedialogVisible = true;
    },
    /**
     * @description 选择分类 获取参数
     */
    getCategory(idsList) {
      let categories=[]
      let nameList=[]
      idsList.forEach((item)=>{
        let arr=item.split('&*$%#&')
        categories.push({id:arr[0]})
        nameList.push(arr[1])
      })
      this.nameList=nameList
      this.infoForm.categoryName=nameList.join(',')
      this.infoForm.categories =categories
      this.catedialogVisible = false;

    },

    /**
     * @description 提交
     */
    onSaveData() {
      this.$refs.infoForm.validate(valid => {
        if (valid) {
          this.loading = true;
          let api = "";
          let formData = {};
          if (this.infoForm.id) {
            api = "specEditApi";
          } else {
            api = "specAddApi";
          }
          formData = this.infoForm;
          formData.options=(this.optionsList.map((item)=>{
            return item.name
          }).filter(n=>n)||[]).join(",")
          API[api](formData)
            .then(result => {
              if (result.data.code == "20000") {
                this.loading = false;
                this.$message({
                  message: this.infoForm.id ? "编辑成功" : "新增成功",
                  type: "success"
                });
                this.onReactForm(true);
                this.$refs.cate.onOpen()
              }
            })
            .catch(err => {
              this.loading = false;
            });
        }
      });
    },
    /**
     * @description 显示弹窗(新增/编辑)
     * @param {object} data
     */
    
     handleShow() {
      let that=this
      this.$nextTick(() => {
        this.id=[0]
        if (this.data.id) {
          API.specDetailApi(this.data).then(res => {
            Object.keys(this.infoForm).forEach(
              key => (this.infoForm[key] = res.data.data[key])
            );
           that.optionsList=that.infoForm.options&&that.infoForm.options.split(",").map(item=>{
             let obj={}
             obj.name=item
             return obj
           })
           
              let list=[]
              let ids=[0]
                let index=0
               async function cateFn(){
                 
                 let data=await that.init(that.id)
                 if(data.length>0){
                   let num=Math.floor(Math.random()*(data.length))
                    list.push(data[num].name)
                    ids.push(data[num].id)
                    that.nameList=list
                    that.dataIds=ids
                     that.infoForm.categoryName=list.join(">")
                    that.id=data[num].id
                    index++
                    if(index<3){
                      cateFn()
                    }
                 }
               }
              cateFn()
             
            
          });
        }
      });
    },
    /**
     * @description 取消，关闭弹窗
     * @param {boolean} refresh 列表页是否重新请求
     */
    onReactForm(refresh = false) {
      // 重置页面数据
      this.$data.infoForm = this.$options.data().infoForm;
      // 移除校验结果
      this.$nextTick(() => {
        this.$refs.infoForm.clearValidate();
      });
      this.$emit("refresh");
      if (refresh) {
        this.$emit("refresh",true);
      }
    }
  }
};
</script>

<style lang="scss" scpoed>
.item_input{
  display: flex;
  margin-bottom:10px;
  &>i{
    font-size: 20px;
    color:#ccc;
    line-height: 36px;
    margin-left:10px;
  }
}
</style>