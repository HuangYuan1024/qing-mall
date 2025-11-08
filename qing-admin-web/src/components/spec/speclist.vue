<template>
  <div>
    <el-form :model="searchForm" ref="searchForm" class="search_box" size="medium">
      <el-row :gutter="20">
        <el-col :span="6">
          <el-form-item label="搜索内容" label-width="80px">
            <el-input v-model="searchForm.name" placeholder="规格名称" class="keywordbox"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <el-button type="primary" @click="onSubmit" size="small">搜索</el-button>
            <el-button @click="resetForm" size="small">重置</el-button>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <div class="table_btnbox">
      <el-button size="medium" type="warning" @click="doEdit('1')">添加规格</el-button>
    </div>
    <el-table
      class="tablebox"
      ref="multipleTable"
      :data="tableData"
      tooltip-effect="dark"
    >
      <el-table-column min-width="30%" type="selection"></el-table-column>
      <el-table-column prop="name" label="规格名称" min-width="80"></el-table-column>
 
      <el-table-column prop="options" label="规格选项" min-width="120"></el-table-column>
     

      <el-table-column label="操作" min-width="120">
        <template slot-scope="scope">
          <div>
           
            <!-- <div class="table_btn">
              <el-button
                size="small"
                type="primary"
                plain
                @click.native="doEdit('2',scope.row)"
              >编辑</el-button>
            </div> -->
            <div class="table_btn">
              <el-button size="small" type="primary" plain @click.native="doDelete(scope.row.id)">删除</el-button>
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
    <specEdit @refresh="onSubmit" :visible.sync="visibleDialog" :data="data"></specEdit>
  </div>
</template>

<script>
import Vue from "vue";
import thumbnails from "@/components/global/thumbnails";
import specEdit from "./specEdit";
import Pl from "@/api/api_public";
import API from "@/api/api_basic";
export default {
  components: {
    thumbnails: thumbnails, //缩略图板块
    specEdit,
  },
  data() {
    return {
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
        name: "",
        page: "1",
        size: Pl.pageSize
      },
      tableData: [],
      visibleDialog: false,
      data:{},
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
     * @description 列表
     */
    postData(formData) {
      let that = this;
      API.specListApi(formData)
        .then(result => {
          console.log(result.data);
          if (result.data.code == "20000") {
            this.tableData =
              (result.data.data.records &&
                Array.isArray(result.data.data.records) &&
                result.data.data.records.map(item => {
                  item.isMarketable == "1"
                    ? (item.isMarketable = true)
                    : (item.isMarketable = false);
                  return item;
                })) ||
              [];
            that.totalNum = result.data.data.total;
          } else {
            that.$errMsg(result.data.message);
          }
        })
        .catch(function(error) {
          that.$serverErrMsg();
        });
    },
   
    /**
     * @description 编辑
     */
    doEdit(type,row={}) {
      this.data=row
      this.visibleDialog = true;
    },
  
    /**
     * @description 删除
     */
    doDelete(id) {
      var that = this;
      that
        .$confirm("确认删除选中的规格数据吗?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        })
        .then(() => {
          var data = {
            id: id
          };
          API.specDeleteApi(data)
            .then(result => {
              if (result.data.code == "20000") {
                that.$successMsg("删除成功");
                var formData = this.searchForm;
                this.postData(formData);
              } else {
                that.$errMsg(result.data.message, "删除失败");
              }
            })
            .catch(function(error) {
              that.$serverErrMsg();
            });
        })
        .catch(() => {
          console.log("已取消");
        });
    },
    handleCurrentChange(val) {
      this.searchForm.page = val;
      var formData = this.searchForm;
      this.postData(formData);
    },
    handleSizeChange(val) {
      this.searchForm.size = val;
      var formData = this.searchForm;
      this.postData(formData);
    },
    /**
     * @description 重置
     */
    resetForm() {
      this.searchForm = {
        name: "",
        page: "1",
        size: Pl.pageSize
      };
      this.postData(this.searchForm);
    },
    /**
     * @description 搜索
     */
    onSubmit(refresh) {
      if(refresh){
        var formData = this.searchForm;
       this.postData(formData);
      }
      this.visibleDialog=false
    },
    
    
  }
};
</script>