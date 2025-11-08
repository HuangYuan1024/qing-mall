<template>
  <div>
   
    <el-form :model="searchForm" ref="searchForm" class="search_box" size="medium">
      <el-row :gutter="20">
        <el-col :span="5">
          <el-form-item label="商品类型" label-width="80px">
           
             <el-select v-model="searchForm['category'+ (index+1)+'Id']" placeholder="请选择商品品牌" v-for="(item,index) in categoryList" :key="index" v-if="index==0">
              <el-option
                v-for="(item,cindex) in item"
                :key="cindex"
                :label="item.name"
                :value="item.id"
                @click.native="handleChange(item,index+1)"
              ></el-option>
            </el-select>

          </el-form-item>
        </el-col>
         <el-col :span="3" v-for="(item,index) in categoryList" :key="index" v-if="index>0">
          <el-form-item label="" label-width="0">
             <el-select v-model="searchForm['category'+ (index+1)+'Id']" placeholder="请选择商品品牌" >
              <el-option
                v-for="(item,cindex) in item"
                :key="cindex"
                :label="item.name"
                :value="item.id"
                @click.native="handleChange(item,index+1)"
              ></el-option>
            </el-select>

          </el-form-item>
        </el-col>
        <el-col :span="5">
          <el-form-item label="商品品牌" label-width="80px">
            <el-select v-model="searchForm.brandId" placeholder="请选择商品品牌">
              <el-option
                v-for="(item,index) in brandList"
                :key="index"
                :label="item.name"
                :value="item.id"
                @click.native="changeBrand(item)"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="5">
          <el-form-item label="搜索内容" label-width="80px">
            <el-input v-model="searchForm.name" placeholder="商品名称" class="keywordbox"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="3">
          <el-form-item>
            <el-button type="primary" @click="onSubmit" size="small">搜索</el-button>
            <el-button @click="resetForm" size="small">重置</el-button>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
    <div class="table_btnbox">
      <el-button size="medium" type="warning" @click="doEdit('1')">创建商品</el-button>
    </div>
     <el-row>
    <el-col :span="24">
      <el-tabs v-model="status" type="card" @tab-click="handleClick">
        <el-tab-pane
          v-for="item in statusList"
          :key="item.value"
          :name="item.value"
          :label="item.label"
        ></el-tab-pane>
      </el-tabs>
    </el-col>
    </el-row>

    <el-table
      class="tablebox"
      ref="multipleTable"
      :data="tableData"
      tooltip-effect="dark"
      @selection-change="handleSelectionChange"
    >
      <el-table-column min-width="30%" type="selection"></el-table-column>
      <el-table-column prop="id" label="编号" min-width="80"></el-table-column>
      <el-table-column min-width="60" prop="image" label="商品图片">
        <template slot-scope="scope">
          <div>
            <div>
              <thumbnails
                :thumbnail-img="scope.row.image"
                :thumbnail-id="scope.row.productId "
                :img-index="imgIndex"
                @get-index="getIndexFn"
              ></thumbnails>
              <p style="margin-top:5px;">{{scope.row.storeName}}</p>
            </div>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="name" label="商品名称" min-width="120"></el-table-column>
      <el-table-column prop="price" label="价格" min-width="80"></el-table-column>
      <el-table-column prop="isMarketable" label="是否上架" min-width="80">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.isMarketable" @change="changeState(scope.row)"></el-switch>
        </template>
      </el-table-column>

      <el-table-column prop="saleNum" label="销量" min-width="80"></el-table-column>
      <el-table-column prop="status" label="审核状态" min-width="80">
        <template slot-scope="scope">
          <div class="status_box">
            <el-tag type="info" v-if="scope.row.status=='1'">已审核</el-tag>
            <el-tag type="info" v-else>未审核</el-tag>
          </div>
        </template>
      </el-table-column>

      <el-table-column label="操作" min-width="120">
        <template slot-scope="scope">
          <div>
            <div class="table_btn">
              <el-button size="small" type="primary" plain @click.native="doExamine(scope.row)">审核</el-button>
            </div>
            <div class="table_btn">
              <el-button
                size="small"
                type="primary"
                plain
                @click.native="doEdit('2',scope.row)"
              >编辑</el-button>
            </div>
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
    <!--审核-->
    <el-dialog
      class="dialog-block"
      title="商品审核"
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
          <el-form-item label="商品名称：" prop="name" size="medium">
            <p>{{infoForm.name}}</p>
            <!-- <el-input v-model="infoForm.name"></el-input> -->
          </el-form-item>
          <el-form-item label="审核结果：" prop="instruction" style="margin-bottom:16px">
            <el-radio v-model="infoForm.status" label="1">审核通过</el-radio>
            <el-radio v-model="infoForm.status" label="0">审核不通过</el-radio>
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
    </el-dialog>
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
      status:"",
      statusList:[
        {value:"0",label:"全部列表"},
        {value:"1",label:"已上架"},
        {value:"2",label:"未上架"},
        {value:"3",label:"待审核"},
        {value:"4",label:"未通过"},
      ],
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
        brandId: "",
        category1Id: "",
        category2Id: "",
        category3Id: "",
        name: "",
        page: "1",
        pagesize: Pl.pageSize
      },
      categoryIds: [],
      bigimgIndex: "", //大图片的key
      bigimgShow: false, //是否显示大图片
      tableData: [],
      imgIndex: null,
      categoryList: [], //商品分类
      brandList: [], //品牌
      visibleDialog: false,
      infoForm: {
        id: "",
        name: "",
        status: "1"
      }
    };
  },
  created: function() {
    let that = this;
    this.$nextTick(function() {
      this.getCategory(0);
      this.getBrand();
      var formData = this.searchForm;
      this.postData(formData);
    });
  },
  watch: {},
  methods: {
    /**
     * @description 修改上下架
     */
    changeState(row) {
      let api = "";
      if (!!row.isMarketable) {
        api = "productPutApi";
      } else {
        api = "productPullApi";
      }
      API[api]({ id: row.id }).then(
        res => {
          this.$message({
            message: `商品${row.isMarketable ? "上架" : "下架"}成功`,
            type: "success"
          });
          var formData = this.searchForm;
          this.postData(formData);
        },
        () => {}
      );
    },
    /**
     * @description 获取商品分类
     */
    getCategory(id) {
      let that = this;
      API.categoryListApi({id:id})
        .then(result => {
          if (result.data.code == "20000") {
             console.log(this.categoryList)
            this.categoryList.push(result.data.data||[])
            console.log(this.categoryList)
          }
        })
        .catch(function(error) {
          that.$serverErrMsg();
        });
    },
    /**
     * @description 获取商品品牌
     */
    getBrand() {
      let that = this;
      API.categoryBrandApi({})
        .then(result => {
          if (result.data.code == "20000") {
            this.brandList = result.data.data;
          }
        })
        .catch(function(error) {
          that.$serverErrMsg();
        });
    },
    /**
     * @description 选择品牌
     */
    changeBrand() {},
    /**
     * @description 选择分类
     */
    handleChange(row,level) {
      let that = this;
      if(level<3){
            API.categoryListApi({id:row.id})
            .then(result => {
              if (result.data.code == "20000") {
                let data=result.data.data
                if(data.length<1){
                    that.hasChild = true
                    
                }else{
                    var item1 = data;
                    Vue.set(that.categoryList, level, item1);
                }
              }

              
            }).catch(function(error) {
              that.$serverErrMsg();
            });
      }
      var list = [];
      that.categoryList.forEach(function(v, e) {
          if (e < level) {
              list.push(v);
          }else{
            //清空选择的值
            that.searchForm["category"+(e+1)+"Id"]=""
          }
      });
      that.categoryList = list;
    },
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
     * @description 选择
     */
    handleSelectionChange(val) {
      var that = this;
      that.singleMultipleSelection = [];
      that.multivariantMultipleSelection = [];
      if (val.length > 0) {
        var list = []; //批量编辑需要
        that.pubStatus = true;
        val.forEach(function(item) {
          if (item.publishStatus == 0) {
            that.pubStatus = false; //批量待发布需要判断
          }
          list.push(item.productId);
          if (item.saleType == "1" || item.saleType == 1) {
            that.singleMultipleSelection.push(item.productId);
          } else if (item.saleType == "2" || item.saleType == 2) {
            that.multivariantMultipleSelection.push(item.productId);
          }
        });
      }
      this.multipleSelection = list;
    },
    /**
     * @description 状态选择
     */
    handleClick(tab, event) {
      console.log(tab.name)
      this.searchForm.page = 1;
      if(tab.name=="0"){
          this.searchForm.status ="";
          var formData = this.searchForm;
          this.postData(formData);
      }else if(tab.name=="1"){

        this.searchForm.status = "";
        this.searchForm.isMarketable="1"
        var formData = this.searchForm;
        this.postData(formData);
      }else if(tab.name=="2"){

        this.searchForm.status = "";
        this.searchForm.isMarketable="0"
        var formData = this.searchForm;
        this.postData(formData);
      }else if(tab.name=="3"){

        this.searchForm.status = "0";
        this.searchForm.isMarketable=""
        var formData = this.searchForm;
        this.postData(formData);
      }else if(tab.name=="4"){

        this.searchForm.status = "2";
        this.searchForm.isMarketable=""
        var formData = this.searchForm;
        this.postData(formData);
      }
    },

    /**
     * @description 列表
     */
    postData(formData) {
      let that = this;
      API.spuSearchApi(formData)
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
     * @description 点击缩略图获取大图片的key
     */
    getIndexFn(v) {
      this.imgIndex = v;
    },
    bigimgShowFn(e) {
      if (!this.bigimgShow) {
        //如果未显示就显示
        this.bigimgShow = true;
      } else {
        //如果已显示，则如果点击的图片与上次相同则隐藏，不相同则显示
        if (this.bigimgIndex == e) {
          this.bigimgShow = false;
        } else {
          this.bigimgShow = true;
        }
      }
      this.bigimgIndex = e;
    },
    /**
     * @description 审核
     */
    doExamine(row) {
      this.infoForm.name = row.name;
      this.infoForm.id = row.id;
      this.visibleDialog = true;
    },
    /**
     * @description 编辑
     */
    doEdit(productType, row={}) {
      var that = this;
      this.$router.push({
        path: "/pro_edit",
        query: {
          id: row.id,
          type: productType,
        }
      });
    },
    /**
     * @description 批量删除
     */
    batchdelFn() {
      var that = this;
      var productIds = "";
      if (that.multipleSelection.length > 0) {
        productIds = that.multipleSelection.join(",");
        that.doDelete(productIds);
      } else {
        that.$errMsg("请选择至少一个商品");
        return false;
      }
    },
    /**
     * @description 删除
     */
    doDelete(id) {
      var that = this;
      that
        .$confirm("确认删除选中的商品数据吗?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        })
        .then(() => {
          var data = {
            id: id
          };
          API.logicDeleteApi(data)
            .then(result => {
              console.log(result);
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
      this.searchForm.pagesize = val;
      var formData = this.searchForm;
      this.postData(formData);
    },
    /**
     * @description 重置
     */
    resetForm() {
      var that=this
       var list = [];
      that.categoryList.forEach(function(v, e) {
          if (e < 1) {
              list.push(v);
          }
      });
      that.categoryList = list;
      console.log(that.categ)
      this.searchForm = {
        brandId: "",
        category1Id: "",
        name: "",
        page: "1",
        pagesize: Pl.pageSize
      };
      let formData=this.searchForm
      this.postData(formData);
    },
    /**
     * @description 搜索
     */
    onSubmit() {
      var formData = this.searchForm;
      this.postData(formData);
    },
    /**
     * @description 审核
     */
    onSaveData() {
      this.$refs.infoForm.validate(valid => {
        if (valid) {
          this.loading = true;
          let formData = this.infoForm;
          API.productAuditApi(formData)
            .then(res => {
              this.loading = false;
              this.$message({
                message: "操作成功",
                type: "success"
              });
              this.onReactForm(true);
            })
            .catch(err => {
              this.loading = false;
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
      this.visibleDialog = false;
      if (refresh) {
        var formData = this.searchForm;
        this.postData(formData);
      }
    }
  }
};
</script>