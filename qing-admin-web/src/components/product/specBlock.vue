<template>
    <div>
    <el-form-item :label="arr.name+'：'" v-for="arr in specList" :key="arr.id">
          <el-checkbox-group v-model="arr.value" @change="tableDataChange" >
            <el-checkbox :label="option" v-for="(option,index) in arr.options.split(',')" :key="index" :name="option" :value="option"></el-checkbox>
        </el-checkbox-group>
    </el-form-item>
     <el-table
                    class="variedTable"
                    ref="multipleTable"
                    :data="tableData" v-show="tableData.length>0">
                    <el-table-column prop="sizename" :label="vari.name" min-width="4%" v-for="(vari,i) in variationThemeInput" :key="i">
                        <template slot-scope="scope">
                            <div :ref="'theme'+vari.id" >
								{{scope.row.descartesName[i]}}
							</div>
                        </template>
                    </el-table-column>
                    <el-table-column min-width="7%">
                        <template slot="header" slot-scope="scope">
                            <div>
                                <span class="fill">*</span>价格
								<!-- <p class="multbutton" @click="editFormchange('2','价格')">修改</p> -->
                            </div>
                        </template>
                         <template slot-scope="scope">
                            <div>
                                <el-input type="text" size="medium" class="smallinput" v-model="scope.row.price" @blur="submit()"  onKeyPress="if((event.keyCode<48 || event.keyCode>57) && event.keyCode!=46 || /\.\d\d$/.test(value))event.returnValue=false"></el-input>
                                <p :class="'hint productPrice'+scope.$index">请填写价格，大于0的数字</p>
                            </div>
                        </template>
                    </el-table-column>
                    
                   
                     <el-table-column min-width="8%">
                          <template slot="header" slot-scope="scope">
                            <div>
                                <span class="fill">*</span>库存数量
								<!-- <p class="multbutton" @click="editFormchange('5','数量')" >修改</p> -->
                            </div>
                        </template>
                         <template slot-scope="scope">
                            <div>
                                <el-input type="text" size="medium" class="smallinput" v-model="scope.row.num" @blur="submit()" ></el-input>
                                 <p :class="'hint productQty'+scope.$index">请填写数量，大于或者等于0的整数</p>
                            </div>
                        </template>
                    </el-table-column>
                     <el-table-column prop="productSku" min-width="6%">
                        <template slot="header" slot-scope="scope">
                            <div>
                                图片
							
                            </div>
                        </template>
                        <template slot-scope="scope">
                            <div>
                            <div class="table_btn">
                                <uploadImg @on-submit="onSubmit" :data-img="scope.row.image" :isBtn="false" :imgSize="2" height="40" width="40" :dataIndex="scope.$index"></uploadImg>
                            </div>
                           
                                
                            </div>
                        </template>
                    </el-table-column>
                   
                </el-table>
            <!-- <ul class="search_libox" v-for="arr in specList" :key="arr.id">
                <li  v-for="(option,index) in arr.options.split(',')" :key="index" :label="option" >{{option}}</li>
            </ul> -->
              
        
        </div>
</template>
<script>
 import Vue from 'vue'
 import API from '@/api/api_basic';
 import uploadImg from "@/components/global/uploadImg";
 export default {
     components: {
         uploadImg
     },
     props: {
         dataList: {
             type: Array,
             default: () => []
         },
         dataId: {
             default: ""
         },
         infoDetail: {
             type: Object,
             default: () => {}
         }
     },

     data() {
         return {
             deleteArr: [], //列表没有的笛卡尔值
             specList: [],
             variationThemeInput: [], //变种主题选项的
             tableData: [], //多变种表格
             checkinputarr: {}, //变量数组对象，求笛卡尔值的
             multiCartesianlist: [], //计算出的笛卡尔数组总值
             imgVisible: false,
             imgUrl: "", //图片放大的url
             upIndex: "", //上传图片需要的下标信息
             showfalse: false,
             productImgData: { //上传图片的参数
                 token: ""
             },
             fileApi: localStorage.getItem("$Api") + "config/file/productImgUpload", //上传图片的路径
         }
     },
     watch: {
         "dataId": {
             handler() {
                 let specItems= this.infoDetail.spu&& this.infoDetail.spu.specItems&&JSON.parse(this.infoDetail.spu.specItems)||[]
                 if(this.dataId){
                      this.getSpecCategory(this.dataId,specItems)
                 }
                
                 this.tableData=this.infoDetail.skuList
                 this.tableData=this.infoDetail.skuList&&Array.isArray(this.infoDetail.skuList)&&this.infoDetail.skuList.map((item)=>{
                    let cd = {}
                    cd.id=item.id
                    cd.price = item.price
                    cd.num =item.num
                    let descartesName=[]
                    let spec=JSON.parse(item.spec)||{}
                    for(let i in spec){
                        descartesName.push(spec[i])
                    }
                    cd.descartesName = descartesName
                    cd.image = item.image
                    return cd
                 })||[]
             }
         },
     },

     created: function() {
         let that = this;
         this.$nextTick(function() {
                 if(this.dataId){
                      this.getSpecCategory(this.dataId,specItems)
                 }
         });

     },
     methods: {
         /**
          *@description 上传图片
          *   */
         onSubmit(image, index) {
             if (image !== "") {
                 var cd = this.tableData[index]
                 cd["image"] = image
                 Vue.set(this.tableData, index, cd)
                 this.submit()
             }

         },

       
         tableDataChange() { //操作多变种table
             var that = this;
             this.variationThemeInput = this.specList.map((item) => {
                 let obj = {}
                 if (item.value && item.value.length > 0) {
                     obj.value = item.value
                     obj.name = item.name
                     obj.id = item.id
                     return obj
                 }
             }).filter(n => n)
             that.checkinputarr = {}
             that.variationThemeInput.forEach(function(obj, index) {
                 that.checkinputarr['checkarr' + index] = obj.value //追加新的值
             })
             var data = [] //组合数组
             var can = false
             for (let i in that.checkinputarr) {
                 if (that.checkinputarr[i].length > 0) {
                     can = true
                 }
                 data.push(that.checkinputarr[i]);
             }
             if (can == false) {
                 that.tableData = []
                 that.multiCartesianlist = []
                 return false
             }

             var r = that.$multiCartesian(data); //计算笛卡尔数组
             var list = []
             that.tableData.forEach(function(item, index) {
                 list.push(item.descartesName.join(',').replace(/\s*/g, ""))
             })
             that.tableArr = list

             var tableData = that.tableData
             that.tableData = []
             var num = 0
             that.multiCartesianlist = []
             var deleteArr = that.deleteArr;
             that.deleteArr = []
      
             for (var i = 0; i < r.length; i++) {
                 console.log(r[i])
                 var delIndex = deleteArr.indexOf(r[i].join(',').replace(/\s*/g, ""));
                 that.multiCartesianlist.push(r[i].join(',').replace(/\s*/g, ""))

                 //判断table与新数组是否有相同的

                 var tabIndex = this.tableArr.indexOf(r[i].join(',').replace(/\s*/g, ""));
                 if (tabIndex !== -1) { //table有值
                     let obj = tableData[tabIndex]
                     obj.descartesName = r[i]
                     Vue.set(that.tableData, num, obj) //变种主题分类
                     num++
                 } else {
                     if (delIndex == -1) { //删除中没有
                         var cd = {}
                         cd.id=""
                         cd.price = ""
                         cd.num = ""
                         cd.descartesName = r[i]
                         cd.image = ""
                         Vue.set(that.tableData, num, cd) //变种主题分类
                         num++
                     } else { //如果删除中有这个值(删除数组中始终都是笛卡尔数组中的子集)
                         that.deleteArr.push(r[i].join(',').replace(/\s*/g, ""))
                     }

                 }
             }
             this.submit()

         },
         /**
          * @description 获取商品属性集合
          */
         getSpecCategory(id,specItems={}) {
             var that=this
             API.specCategoryApi({ id: id })
                 .then(result => {
                     if (result.data.code == "20000") {
                         var data = result.data.data
                         that.specList=data.map((item)=>{
                             item.value=[]
                             return item
                         })
                             var themeList=[]
                         for(var i in specItems){
                            var tObj={}
                            data.forEach((item,index)=>{
                                var obj=item
                                var tObj={
                                    name:item.name,
                                    id:item.id
                                }
                                if(item.name==i){
                                    obj.value=specItems[i]
                                    tObj.value = specItems[i]
                                    themeList.push(tObj)
                                }
                                that.$set(that.specList,index,obj)
                            })
                        }
                        that.variationThemeInput = themeList
                     }
                 })
                 .catch(function(error) {
                     that.$serverErrMsg();
                 });
         },
         submit() {


             this.$emit("on-submit", this.tableData, this.variationThemeInput, this.specList)
         }
     }


 }
</script>
