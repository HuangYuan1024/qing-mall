<template>
	<div class="loadingtext">
		<el-form :model="infoForm" :rules="rules" ref="infoForm" label-width="150px" class="infoFormbox ">
        
            <el-card class="box-card productinfo_box">
                <div slot="header" class="clearfix">
                    <span>商品信息</span>
                </div>
                 <el-form-item label="商品分类" prop="categoryName" style="width:100%;">
                    <el-input v-model="infoForm.categoryName" placeholder="必填项" size="medium" style="width:217px;" disabled="disabled"></el-input>
                    <span class="table_btn" style="margin-left:10px;" @click="changecateFn">选择分类</span>
                     <span class="changhint" v-show="infoForm.categoryName==''&&hint">请先选择商品分类</span>
                </el-form-item>
                 <el-form-item label="商品标题" prop="name" style="width:80%;"> 
                    <div class="ttbox">
                         <el-input v-model="infoForm.name" placeholder="" size="medium" >
                         </el-input>
                    </div>
                </el-form-item>
                <el-form-item label="简介" prop="intro" style="width:80%;"> 
                    <div class="ttbox">
                         <el-input v-model="infoForm.intro" placeholder="" size="medium" >
                          </el-input>
                    </div>
                </el-form-item>
                <!-- <el-form-item label="商品SKU" prop="productSku">
                    <el-input v-model="infoForm.productSku" placeholder="字母，数字或符号（'_','-','/','\','#','*'）" size="medium" class="wid">
                        <template slot="append"><el-button @click="skuRuleShowFn">修改规则</el-button></template>
                    </el-input>
                    <span :style="productSkuNumberFn>40?'color:red;':''">{{productSkuNumberFn}}</span>/40
                   
                </el-form-item> -->
                
			
                <el-form-item label="品牌" prop="brandId">
                     <el-select v-model="infoForm.brandId" placeholder="请选择品牌" size="medium" @change="changeBrand">
                        <el-option v-for="item in brandList" :key="item.id" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>
              
                
            </el-card>
            <el-card class="box-card">
                <div slot="header" class="clearfix">
                    <span>属性信息</span>
                </div>
                <specBlock :dataId="infoForm.categoryThreeId" @on-submit="getSpecFn" :infoDetail="infoDetail"></specBlock>
             </el-card>
             
             <div>
                 <img-block @on-imglist="getImgList" :infoImg="infoImg"></img-block>
             </div>
           
         
             <el-card class="box-card">
                 <div slot="header" class="clearfix">
                    <span>描述信息</span>
                </div>
                 <editor v-model="infoForm.content" :editorData="infoForm.content"></editor>
              
            </el-card>
         
            
        </el-form>
        <div class="table_btnbox">
            <el-button type="primary" @click="submitForm(1)" :loading="loading">提交</el-button>
            <el-button type="primary" plain @click="resetForm()">重置</el-button>
		</div>
        <el-dialog
        title="选择分类"
        :visible.sync="catedialogVisible"
        width="890px">
        <!-- <category-list :data-categorypathid="categoryPathId" :data-browsepathname="browsePathName" @on-catedetail="getcatedetailFn" :data-categoryid="infoForm.categoryId" :data-category-name="categoryName" @on-cancel="cancelFn"></category-list> -->
        <categoryList @on-catedetail="getCategory" :dataIds="dataIds" :dataNames="nameList" @on-cancel="onCancel"></categoryList>
   
        </el-dialog>
       
        
	</div>
</template>
<script>
import Vue from "vue";
import API from "@/api/api_basic";
import draggable from "vuedraggable";
import categoryList from "@/components/global/categorylist";
import specBlock from "./specBlock";
import imgBlock from "@/components/global/imgblock";
import editor from "@/components/global/editor";


import { SlowBuffer } from "buffer";
export default {
    components: {
        draggable,
        categoryList, //分类
        specBlock, //多变种
        imgBlock, //图片板块
        editor,
    },
    data() {

        return {
            brandList: [], //品牌列表
            tableData: [], //多变种信息
            variationThemeInput: [],
            loading: false,
            loading2: false,
            loading1: false,
            catedialogVisible: false, //分类弹框
            dataIds:[],
            nameList:[],
            infoForm: {
                brandId: "", //品牌
                intro: "",
                categoryOneId: "",
                categoryTwoId: "",
                categoryThreeId: "",
                freightId: "",
                image: "",
                images: "",
                content: "",
                name: "",
                sn: "",
                attributeList: {},
                categoryName:"",
            },
            skuList: [],
            rules: {
                // categoryId: [{
                //     required: true,
                //     message: "请选择分类"
                // }],

                name: [{
                    required: true,
                    message: "请填写商品标题",
                }],
                brandId: [{
                    required: true,
                    message: "请选择品牌"
                }],
            },
            infoDetail:{},
            infoImg:{
                images:[],
                image:""
            },
            hint:false,
        };
    },
    created: function() {
        let that = this;
        this.$nextTick(function() {
            let {type,id}=this.$route.query
            if(type=="1"){
                this.catedialogVisible=true
            }
            if(type=="2"&&id!==""){
                this.catedialogVisible=false
                this.getDetail(id)
            }

        });
    },

    watch: {

    },



    methods: {
        changeBrand(){
            if(this.infoForm.categoryName==""){
                this.hint=true
            }
        },
         /**
         * @description 获取分类id
         */
            init(id){

                let promise=new Promise((resolve,reject)=>{
                    API.categoryListApi({id:id})
                    .then(result => {
                    if (result.data.code == "20000") {
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
         * @description 获取详情
         */
        async getDetail(id) {
            let that = this;
            API.spuGoodsApi({ id: id })
                .then(result => {
                    if (result.data.code == "20000") {
                        that.infoDetail = result.data.data;
                        Object.keys(that.infoForm).forEach((key)=>{
                            Object.assign(that.infoForm,that.infoDetail.spu)
                        })
                        //根据分类id获取分类名字
                        this.infoImg={
                            images:that.infoForm.images&&that.infoForm.images.split(",")||[],
                            image:that.infoForm.image
                        }
                        let ids=[0,that.infoForm.categoryOneId,that.infoForm.categoryTwoId,that.infoForm.categoryThreeId]
                        this.dataIds=ids
                        this.getBrand(ids[3])
                      
                        let list=[]
                        let index=0
                        async function cateFn(){
                            let data=await that.init(ids[index])
                            if(data.length>0){
                            let num=ids[index]
                            for(let i=0;i<data.length;i++){
                                if(data[i].id==ids[index+1]){
                                    list.push(data[i].name)
                                    that.nameList=list
                                    that.infoForm.categoryName=list.join(">")
                                    break
                                }
                            }
                            index++
                            if(index<ids.length){
                                cateFn()
                            }
                            }
                        }
                        cateFn()
                    }
                })
                .catch(function(error) {
                    that.$serverErrMsg();
                });
        },
        /**
         * @description 选择分类 获取参数
         */
        getCategory(ids, nameList) {
            this.infoForm.categoryName = nameList.join(">")
            this.catedialogVisible = false
            this.getBrand(ids[2])
            this.infoForm.categoryOneId = ids[0]
            this.infoForm.categoryTwoId = ids[1]
            this.infoForm.categoryThreeId = ids[2]
            console.log(this.infoForm.categoryThreeId)
        },
        /**
         * @description 获取商品品牌
         */
        getBrand(id) {
            let that = this;

            API.brandCategoryApi({ id: id })
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
         * @description 属性信息
         */
        getSpecFn(
            table, variationThemeInput
        ) {
           
            this.tableData = table;
            this.variationThemeInput = variationThemeInput
        },
        /**
         * @description 保存商品
         */
        submitForm(type) {
            var that = this;

            this.$refs.infoForm.validate(valid => {
                if (valid) {
                    let skuList = []
                    this.tableData.forEach((item, index) => {
                        let obj = {
                            id:item.id,
                            num: item.num,
                            price: item.price,
                            image: item.image,
                            images:that.infoForm.images,
                        }
                        let skuAttribute={}
                        this.variationThemeInput.forEach((th,n)=>{
                            skuAttribute[th.name]=item.descartesName[n]
                        })
                        obj.skuAttribute=JSON.stringify(skuAttribute)
                        skuList.push(obj)
                    })
                    let formData = {}
                    formData.spu = this.infoForm
                    let attributeList ={}
                     this.variationThemeInput.map((item) => {
                        attributeList[item.name] = item.value
                    })
                    formData.spu.attributeList = JSON.stringify(attributeList)
                    formData.skus = skuList
                    

                    API.spuSaveApi(formData)
                        .then(result => {
                            if (result.data.code == "20000") {
                                that.$successMsg("保存成功");
                                setTimeout(function() {
                                    that.loading = false;
                                    that.loading1 = false;
                                    that.$router.push({
                                        path: "/pro_productlist"
                                    });
                                }, 1000);
                            } else {
                                that.loading = false;
                                that.loading1 = false;
                                that.$errMsg(result.data.message, "保存失败");
                            }
                        })
                        .catch(function(error) {
                            that.loading = false;
                            that.loading1 = false;
                            that.$serverErrMsg();
                        });
                } else {
                    that.$errMsg("信息填写不正确");
                }
            });
        },
        /**
         * @description 重置
         */
        resetForm(formName) {
            this.$refs[formName].resetFields();
        },

        getImgList(imgList, imgMain) {
            //图片
            this.infoForm.image = imgMain;
            this.infoForm.images = imgList.join(",");
        },
        changeProId(v) {
            this.infoForm.standardProductIdType = v;
        },



    }
}</script>

<style>
    
   .input-with-select .el-select .el-input {
    width: 130px;
  }
   
</style>