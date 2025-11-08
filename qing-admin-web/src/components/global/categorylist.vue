<template>
<div>
    <div id="cate">
       
        <div class="choosedtxt">已选择：
            <ul>
                <li v-for="(item,index) in nameList" :key="index">
                    <span>{{item}}</span>
                    <i v-if="index!==nameList.length-1">></i>
                </li>
            </ul>
           
          
        </div>
        <!-- <div style="text-align:center;">数据量大，加载中...</div> -->
        <ul class="cateblock" v-loading="loading">
            <li v-for="(item,index) in categorylistall" :key="index" :data-value="index" >
               
                <div class="cateitem" >
                    <dl class="catelist">
                        <!-- <dd v-for="category in item.list" :key="category.id" @click="categorylistFn(category,index+1)" :class="category.checked!==undefined&&category.checked==true?'active':''">
                            <span>{{category.name}}</span>
                            <i class="el-icon-arrow-right"></i>
                        </dd>
                        <dd v-for="category in item.list" :key="category.id" @click="chooseFn(category,index+1)" :class="category.checked!==undefined&&category.checked==true?'active':''">
                            <span>{{category.name}}</span>
                        </dd> -->
                        <dd v-for="category in item.list" :key="category.id" @click="changeCategory(category,index+1)"  :class="category.checked!==undefined&&category.checked==true?'active':''">
                            <span>{{category.name}}</span>
                            <i class="el-icon-arrow-right" v-if="index+1<3"></i>
                        </dd>
                    </dl>
                     <!-- <div v-if="item.searchData.length==0" style="margin-top:100px;text-align:center;color:#999;">暂无分类</div> -->
                </div> 
            </li>
        </ul>
        
        
    </div>     
    <div slot="footer" class="dialog-footer">
        <el-button @click="cancelFn">取 消</el-button>
        <el-button type="primary" @click="emitFn">确 定</el-button>
    </div>
   </div>
</template>

<script>
import Vue from "vue";
import API from "@/api/api_basic";
import Q from "q";
import { setInterval } from "timers";
export default {
    props: {
        dataIds:{
            type:Array,
            default:()=>[]
        },
        dataNames:{
            type:Array,
            default:()=>[]
        },
    },
    data() {
        return {
            loading: false,
            categorylistall: [], //分类list
            nameList: [], //父级分类名称集合数组
            categoryItem: {}, //选中的分类
            hasChild: true,
            ids:[],
        };
    },
    watch: {
       "dataIds":{
           handler(){
                this.categorylistall = [];
                if(this.dataIds.length>0){
                    this.getData()
                }else{
                    this.init(0).then((data)=>{
                        var item1 = {};
                        item1.list = data;
                        Vue.set(this.categorylistall, 0, item1);
                    })
                
                }
           }
       }
    },
    mounted: function() {
        this.categorylistall = [];
        
        if(this.dataIds.length>0){
            this.getData()
        }else{
            this.init(0).then((data)=>{
                var item1 = {};
                item1.list = data;
                Vue.set(this.categorylistall, 0, item1);
            })
        
        }
         
    },

    methods: {
        getData(){
            let that=this
            this.nameList=this.dataNames
            let ids=this.dataIds
            let index=0
            async function cateFn(){
                let data=await that.init(ids[index])
                
                if(data.length>0){
                    var item = {};
                    let catelist=data.map((item)=>{
                        if(item.id==ids[index+1]){
                            item.checked=true
                        }
                        return item
                    })
                    item.list = catelist;
                    Vue.set(that.categorylistall, index, item);
                }
                index++
                if(index<ids.length){
                    cateFn()
                }
            }
            cateFn()
        },
       init(id){
           let promise=new Promise((resolve,reject)=>{
               API.categoryListApi({id:id})
                .then(result => {
                if (result.data.code == "20000") {
                    let data =result.data.data||[];
                   resolve(data)
                } else {
                    that.$errMsg(result.data.message);
                }
                })
                .catch(function(error) {
                    reject(error)
                    that.$serverErrMsg();
                });
           })
           return promise
           
       },
  
      
        changeCategory(row, level) {
             var that = this;
       
            this.init(row.id).then((data)=>{
                if(data.length<1){
                    that.hasChild = true
                }else{
                that.hasChild = false
                var item1 = {};
                item1.list = data;
                Vue.set(that.categorylistall, level, item1);
                }

            
        })
           
            that.categoryItem = row
            that.categorylistallFn(row, level);
          
            Vue.set(that.ids, level - 1, row.id);
            Vue.delete(that.ids,level)
            Vue.set(that.nameList, level - 1, row.name);
            Vue.delete(that.nameList,level)
            var list = [];
            that.categorylistall.forEach(function(v, e) {
                if (e < level) {
                    list.push(v);
                }
            });
            that.categorylistall = list;
            
        },
     
        categorylistallFn(row, level) {//添加样式
            var that = this;
            if (this.categorylistall.length > 0) {
                let list= that.categorylistall[Number(level - 1)].list.map((dd)=>{
                      if (dd.id == row.id) {
                          dd.checked = true;
                      }else{
                          dd.checked = false;
                      }
                      return dd
                 });
                var item = {};
                item.list = list;
                Vue.set(that.categorylistall, level - 1, item);
            }
        },
        cancelFn() {
            this.$emit("on-cancel")
           
        },

        emitFn() {
            var that = this;
            if (!that.hasChild) {
                this.$errMsg("错误：您选择的类目还有子类目,请选择子类目！");
                return false
            }

            
            that.$emit(
                "on-catedetail",
                that.ids,
                that.nameList,
                that.categoryItem
            ); //把v传给父组件
        }
    }
};
</script>
