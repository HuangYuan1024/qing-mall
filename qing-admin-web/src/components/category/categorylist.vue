<template>
  <div>
  
    <div class="table_btnbox">
      <el-button size="medium" type="primary" plain @click="onBack()"  v-if="this.id.length>0">返回</el-button>
      <el-button size="medium" type="primary" @click="onSubmit()" >刷新</el-button>
       <!-- <el-button size="medium" type="primary" @click="onAdd()" >添加</el-button> -->
    </div>

    <el-table
      class="tablebox"
      ref="multipleTable"
      :data="tableData"
      tooltip-effect="dark"
    >
      <el-table-column min-width="30%" type="selection"></el-table-column>
      <el-table-column prop="id" label="编号" min-width="80"></el-table-column>
     
      <el-table-column prop="name" label="分类名称" min-width="120"></el-table-column>
      <!-- <el-table-column prop="price" label="级别" min-width="80"></el-table-column>
      <el-table-column prop="goodsNum" label="商品数量" min-width="80">
      </el-table-column>

      <el-table-column prop="isMenu" label="是否导航" min-width="80">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.isMenu" disabled></el-switch>
        </template>
      </el-table-column>
       <el-table-column prop="isShow" label="是否显示" min-width="80">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.isShow" disabled></el-switch>
        </template>
      </el-table-column>
      <el-table-column prop="seq" label="排序" min-width="80">
      </el-table-column> -->

      <el-table-column label="操作" min-width="120" v-if="this.id.length!==2">
        <template slot-scope="scope">
          <div>
            <div class="table_btn">
              <el-button size="small" type="primary" plain @click.native="doNext(scope.row)">查看下级</el-button>
            </div>
            
          </div>
        </template>
      </el-table-column>
    </el-table>



    <div class="block page">
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page.sync="currentPage1"
        :page-sizes="pageSizes"
        :page-size="pageSize"
        :layout="pageLayout"
        :total="totalNum"
      ></el-pagination>
    </div>
   <!--添加-->
    <!-- <el-dialog
      class="dialog-block"
      title="添加商品分类"
      :visible.sync="visibleDialog"
      @close="onReactForm()"
      width="640px"
      :close-on-click-modal="false"
    >
      <div>
        <el-form
          :model="infoForm"
          ref="infoForm"
          label-width="118px"
          label-position="right"
          class="dialog-form"
        >
          <el-form-item label="分类名称：" prop="name" size="medium">
            <el-input v-model="infoForm.name"></el-input>
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
        <el-button type="primary" size="medium" :loading="loading" @click="onSaveData()">确定</el-button>
      </div>
    </el-dialog> -->
  </div>
</template>

<script>
import Vue from "vue";
import thumbnails from "@/components/global/thumbnails";
import Pl from "@/api/api_public";
import API from "@/api/api_basic";
export default {
  components: {
    thumbnails: thumbnails, //缩略图板块
  },
  data() {
    return {
      loading:false,
      checkAll: true,
      productType: "", //
      multipleSelection: [],
      singleMultipleSelection: [], //全选时的单品
      multivariantMultipleSelection: [], //全选时的多变种

      pageSizes: Pl.pageSizes,
      pageSize: Pl.pageSize,
      pageLayout: Pl.pageLayout,
      currentPage1: 1,
      totalNum: 0,
      searchForm: {
        id:0
      },
      tableData: [],
      visibleDialog: false,
      infoForm: {
        name: "",
      },
      id:[],//记录查看下级的ids
      addIds:[],//添加的ids
    };
  },
  created: function() {
    let that = this;
    this.$nextTick(function() {
    
      var formData = this.searchForm;
      this.postData(formData);
    });
  },
  watch: {},
  methods: {
    /**
     * @description 全选
     */
    handleCheckAllChange(val) {
      var that = this;
      if (!!val) {
        this.checkAll = false;
        that.checkedboxObj.forEach(function(item) {
          item.checkAll = false;
          item.arrlist.forEach(function(i) {
            i.checked = false;
          });
        });
      } else {
        this.checkAll = true;
        that.checkedboxObj.forEach(function(item) {
          item.checkAll = true;
          item.arrlist.forEach(function(i) {
            i.checked = true;
          });
        });
      }
    },

    /**
     * @description 列表
     */
    postData(formData) {
      let that = this;
      API.categoryListApi(formData)
        .then(result => {
          if (result.data.code == "20000") {
            this.tableData =result.data.data||[];
          
          } else {
            that.$errMsg(result.data.message);
          }
        })
        .catch(function(error) {
          that.$serverErrMsg();
        });
    },
 
    /**
     * @description 查看下一级
     */
    doNext(row) {
      this.id.push(this.searchForm.id)
      this.addIds.push(row.id)
      console.log(this.id)
       var formData = this.searchForm;
      formData.id=row.id
      this.postData(formData);
    },
    
   
    handleCurrentChange(val) {
      this.searchForm.page = val;
      var formData = this.searchForm;
      this.postData(formData);
    },
    handleSizeChange(val) {
      this.searchForm.pagesize = val;
      var formData = this.searchForm;
      this.postData(formData);
    },
    /**
     * @description 重置
     */
    resetForm() {
      this.searchForm = {
        id:0,
        page: "1",
        pagesize: Pl.pageSize
      };
      this.postData(formData);
    },
     /**
     * @description 返回
     */
    onBack(){
      this.searchForm.id=this.id[this.id.length-1]
      this.id.splice(this.id.length-1,1)
      var formData = this.searchForm;
      this.postData(formData);
    },
    // onAdd(){
    //   console.log(this.id)
    //   this.infoForm.parentId=this.id[this.id.length]
    //   this.visibleDialog=true
    // },
    /**
     * @description 搜索
     */
    onSubmit() {
      this.id=[]
      this.searchForm.id=0
      var formData = this.searchForm;
      this.postData(formData);
    },
    /**
     * @description 添加保存
     */
    // onSaveData() {
    //   this.$refs.infoForm.validate(valid => {
    //     if (valid) {
    //       this.loading = true;
    //       let formData = this.infoForm;
    //       API.categoryAddApi(formData)
    //         .then(res => {
    //           this.loading = false;
    //           this.$message({
    //             message: "操作成功",
    //             type: "success"
    //           });
    //           this.onReactForm(true);
    //         })
    //         .catch(err => {
    //           this.loading = false;
    //         });
    //     }
    //   });
    // },
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
      this.visibleDialog = false;
      if (refresh) {
        var formData = this.searchForm;
        this.postData(formData);
      }
    }
  }
};
</script>