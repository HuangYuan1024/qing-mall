<template>
  <el-dialog
    class="dialog-block"
    :title="infoForm.id ? '编辑品牌' : '新增品牌'"
    :visible.sync="visible"
    @open="handleShow"
    @close="onReactForm()"
    width="640px"
    :close-on-click-modal="false"
    :append-to-body="true"
  >
    <div>
      <el-form
        :model="infoForm"
        ref="infoForm"
        :rules="rules"
        label-width="118px"
        label-position="left"
        class="dialog-form"
      >
         <el-form-item label="商品分类：" prop="categoryName" style="width:100%;">
              <el-input v-model="infoForm.categoryName" placeholder="必填项" size="medium" style="width:217px;" disabled="disabled"></el-input>
              <span class="table_btn" style="margin-left:10px;" @click="changecateFn">选择分类</span>
          </el-form-item>
        <el-form-item label="品牌名称" prop="name" size="medium">
          <el-input
            v-model="infoForm.name"
            placeholder="请输入"
          ></el-input>
        </el-form-item>
        <el-form-item label="品牌首字母" prop="letter" size="medium">
          <el-input
            v-model="infoForm.letter"
            maxlength="1"
            show-word-limit
            placeholder="请输入"
          ></el-input>
        </el-form-item>
        <el-form-item label="品牌logo" prop="instruction" style="margin-bottom:16px">
            <!-- <el-upload
            class="avatar-uploader"
            action=""
             :http-request="function(){}"
            :show-file-list="false"
            :before-upload="uploadProImg">
            <img v-if="infoForm.image" :src="infoForm.image" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload> -->
          <p>只能上传jpg/png格式的图片，大小不超过2M</p>
          <uploadImg @on-submit="onSubmit" :data-img="infoForm.image" :isBtn="false" :imgSize="2"></uploadImg>
        </el-form-item>
        
      </el-form>
    </div>
    <div slot="footer" class="dialog-footer text-c">
      <el-button
        type="button"
        size="medium"
        @click="onReactForm(false,'click')"
        style="background:#fafafa;"
      >取 消</el-button>
      <el-button type="primary" size="medium" :loading="loading" @click="onSaveData()">保 存</el-button>
    </div>
    
      <categoryList @on-catedetail="getCategory" :dataIds="dataIds" :dataNames="nameList" @on-cancel="onCancel" :visible.sync="catedialogVisible" ref="cate"></categoryList>

  </el-dialog>
</template>

<script>
import axios from 'axios'
import API from "@/api/api_basic";
import uploadImg from "@/components/global/uploadImg";
import categoryList from "@/components/global/categoryCheckbox";

export default {
  components:{
    uploadImg,
    categoryList
  },
  props:{
    visible:Boolean,
    data:{
      type:Object,
      default:()=>{}
    }
  },
  data() {
    var checkScore = (rule, value, callback) => {
      if (!/^[1-9]\d{0,3}$/.test(value)) {
        callback(new Error("请输入正整数，最大9999"));
      } else {
        callback();
      }
    };
    return {
       catedialogVisible: false,
       dataIds:[],
      nameList:[],
      loading: false,
      infoForm: {
        id: "",
        image: "",
        letter: "",
        name: "",
        seq: null,
        categories:[],
      },
      rules: {
        name: [{ required: true, message: "请填写品牌名称" }],
       
      },

    };
  },
  watch: {
    "infoForm.classIds": {
      handler() {
        if (this.infoForm.classIds && this.infoForm.classIds.length > 0) {
          this.infoForm.rootId = this.infoForm.classIds[0] || "";
          this.infoForm.parentId = this.infoForm.classIds[1] || "";
          if (this.infoForm.score == 0) {
            this.infoForm.score = "";
          }
        }
      }
    }
  },
  mounted() {
  },
  methods: {
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
       uploadProImg(file) {
      var that = this;
      var type = file.type;
      var size = file.size;
      const isJPG =
        type === "image/jpeg" || type === "image/png" || type === "image/gif";
      const isLt2M = size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error("上传图片必须是JPG/GIF/PNG/BMP 格式");
        return false;
      }
      if (!isLt2M) {
        this.$message.error("单张图片大小不应超过2M");
        return false;
      }

      
      let fd = new FormData();
      fd.append("file", file);
      axios.post(that.$fileApi, fd).then(res => {
        if (res.data.code === "000") {
          that.$successMsg(res.data.message);
          that.infoForm.image = res.data.imgUrl;
        } else {
          that.$errMsg(res.data.message);
        }
      });
    },
    onSubmit(img){
      this.infoForm.image=img
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
            api = "brandEditApi";
            
          } else {
            api = "brandAddApi";
          }
          formData = this.infoForm;
          if (formData.rootId == -2) {
            formData.score = "";
          }
          formData.state ? (formData.state = 1) : (formData.state = 2);
          API[api](formData)
            .then(result => {
              if(result.data.code=="20000"){
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
      this.$nextTick(()=>{
        if (this.data.id) {
        API.brandDetailApi(this.data).then(res => {
          Object.keys(this.infoForm).forEach(
            key => (this.infoForm[key] = res.data.data[key])
          );
         
        });
      }
      })
     
    },
    /**
     * @description 取消，关闭弹窗
     * @param {boolean} refresh 列表页是否重新请求
     */
    onReactForm(refresh = false, type) {

      // 重置页面数据
      this.$data.infoForm = this.$options.data().infoForm;
      // 移除校验结果
      this.$nextTick(() => {
        this.$refs.infoForm.clearValidate();
      });
      
     this.$emit('update:visible', false);
      if (refresh) {
        this.$emit("refresh");
      }
    }
  }
};
</script>

<style lang="scss" scpoed>
 .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>