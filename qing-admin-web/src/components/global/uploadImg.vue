<template>
    <div>
       
            <div class="uploadbox" v-if="imgMode=='1'">
                <el-upload
                class="avatar-uploader"
                action="http://source-api.secby.cn/oss/upload"
                :show-file-list="false"
                :before-upload="uploadProImg"
                :on-success="onSuccess"
                :style="'width:'+width+'px;height:'+height+'px;'"
                >
                <img v-if="dialogImageUrl" :src="dialogImageUrl" class="avatar" :style="'width:'+width+'px;height:'+height+'px;'" />
               
                <i v-else class="el-icon-plus avatar-uploader-icon" :style="'width:'+width+'px;height:'+height+'px;line-height:'+height+'px'"></i>
                </el-upload>
            </div>
           
            <div class="sizere_uploadbox" v-else>
                <p class="imgblock" v-if="!!dataStatus&&limit">
                    <span style="line-height:40px;">可上传图片数{{imageCount}}，剩余可上传{{residueCount}}个，（单张图片大小不应超过{{imgSize}}M）</span>
                </p>
                <div class="evabox">
                    <ul class="el-upload-list el-upload-list--picture-card upload_block" >
                        
                        <li :tabindex="index" class="el-upload-list__item is-success" v-for="(item,index) in imgList" :key="index" style="float:left;">
                            <img :src="item" alt="" class="el-upload-list__item-thumbnail"/>
                            <a class="el-upload-list__item-name"><i class="el-icon-document"></i>{{item}}
                            </a>
                            <label class="el-upload-list__item-status-label">
                                <i class="el-icon-upload-success el-icon-check"></i>
                            </label>
                            <i class="el-icon-close"></i>
                            <span class="el-upload-list__item-actions">
                            <span class="el-upload-list__item-preview" @click="previewImgFn(item)"><i class="el-icon-zoom-in"></i></span>
                            <span class="el-upload-list__item-delete" @click="deleteImgFn(index,item)" v-if="!!dataStatus"><i class="el-icon-delete"></i></span>
                            </span>
                        </li>
                        <div v-if="dataStatus">
                            <el-upload class="upload_btn" v-show="uploadShow" style="display:inline;float:left;" ref="upload"  action="" :show-file-list="false" 
                                name="file" :limit="Number(residueCount+1)" :on-exceed="onexceedFn" :multiple="true" 
                                :before-upload="uploadProImg" list-type="picture-card" accept=".png,.jpg,.jpeg,.gif" :http-request="function(){}">
                                <i class="el-icon-plus"></i>
                            </el-upload>
                        </div>
                    </ul>

                    <!---->
                    
                    <el-dialog :visible.sync="dialogVisible" :modal="false" class="model_box dia_notitle" >
                        <img width="100%" :src="dialogImageUrl" alt="" class="scalimg">
                    </el-dialog>

                </div>
            </div>
        
            <el-row class="aright" v-if="isBtn" style="margin-top:10px;">
            <el-button type="warning" @click="closeUpload">关闭</el-button>
            <el-button type="success" @click="saveUpload">保存</el-button>
        </el-row>
    </div>
</template>
<script>
import axios from 'axios'
export default {
    props:{
        width:{
            type:String,
            default:'100%',
        },
        height:{
            type:String,
            default:'230',
        },
        isBtn:{//是否有保存按钮
            type:Boolean,
            default:true,
        },
        imgType:{//图片类型，不传不限制
            type:Array,
            default:()=>[]
        },
        imgSize:{//图片大小，默认10M
            type:Number,
            default:10,
        },
        imgMode:{//图片上传的模式
            type:String,
            default:'1'
        },
        dataImg:{//模式1，单张图片，编辑需要
            type:String,
            default:''
        },
        dataList:{//模式2，图片数组,编辑需要
            type:Array,
            default:()=>[],
        },
        dataNum:{//模式2，最大上传个数
            default:5
        },
        dataStatus:{//模式2，true表示可以上传，false表示不能上传，只展示图片列表（详情展示用）
            default:true
        },
        limit:true,//模式2，true限制个数，false不限制个数
        dataIndex:"",

    },
     data(){
         return {
            dialogImageUrl:'',//查看图片url
            dialogVisible:false,//图片放大弹框
            imgList:[],//图片
            residueCount:0,//剩余可上传
            uploadShow:true,//上传图片按钮
            imageCount:0,//最大上传图片数
            
         }
     },
      created: function() {
        this.$nextTick(function() {
            this.init()
        });

    },
    watch:{
           'residueCount': {
            handler(newValue, oldValue) {
                if (newValue > '0') { //如果剩余可上传为0,则不显示上传按钮
                    this.uploadShow = true
                } else {
                    this.uploadShow = false
                }　　　　
            }
        },
        'dataNum':{
            handler(){
                this.imageCount=this.dataNum
                this.imgList=this.dataList
                this.residueCount=this.$numSub(this.imageCount,this.imgList.length)
          
            }
        },
          'dataList':{
            handler(){
               this.init()
            },
             immediate:true,
        },
        'dataImg':{
            handler(){
                this.init()
            },
            immediate:true,
        }
    },
    methods:{
        init(){
             if(this.imgMode=='1'){
                this.dialogImageUrl=this.dataImg
            }else{
                 this.imgList=this.dataList
                this.imageCount=this.dataNum
                this.residueCount=this.$numSub(this.imageCount,this.imgList.length)
            }
          
            if(!this.isBtn){
                this.emitFn();
            }
        },
        previewImgFn(url) { //查看图片
            this.dialogImageUrl = url;
            this.dialogVisible = true;
        },

        deleteImgFn(index, url) { //删除图片，imgList移除对应的url,residueCount+1
            this.imgList.splice(index, 1)
            this.residueCount = this.$numAdd(Number(this.residueCount), 1)
             if(!this.isBtn){
                this.emitFn();
            }
        },
         onexceedFn(files, fileList) { //文件超出个数时
            this.$message.error({
                showClose: true,
                message: '图片不能超过剩余图片个数' + this.residueCount,
                duration: 2000
            });
            
        },
        onSuccess(res){
            if (res.code == '20000') {
                this.loading=false
                    this.$message.success({
                    showClose: true,
                    message: '上传成功',
                    duration: 2000
                });
                
                this.dialogImageUrl = '';
                if(this.imgMode=='1'){
                    this.dialogImageUrl = res.data;
                    this.imgList=[]
                    this.imgList.push(res.data)
                }else{
                    this.imgList.push(res.data)
                }
                
                this.residueCount = this.$numSub(Number(this.residueCount), 1)
                if(!this.isBtn){
                    this.emitFn();
                }
            } else {
                    this.loading=false
                    this.$message.error({
                    showClose: true,
                    message: '上传失败',
                    duration: 2000
                });
            }
          
        },
        uploadProImg(file) {
            var type = file.type
            var size = file.size
            if(this.imgType.length>0){
                let list=[]
                this.imgType.forEach((item)=>{
                    if(item.toUpperCase()=='JPG'){
                        list.push('image/jpeg')
                        list.push('image/jpg')
                    }else if(item.toUpperCase()=='PNG'){
                        list.push('image/png')
                    }else if(item.toUpperCase()=='GIF'){
                         list.push('image/GIF')
                    }
                })
                if(!list.includes(type)){
                     this.$message.error({
                        showClose: true,
                        message: `上传图片必须是${this.imgType.join('/')} 格式!` ,
                        duration: 2000
                    });
                    return false
                }
            }
            const isSize = size / 1024 / 1024 < this.imgSize;
            if (!isSize) {
                this.$message.error({
                    showClose: true,
                    message: `图片大小不能超过${this.imgSize}M` ,
                    duration: 2000
                });
                return false
            }

             this.loading=true
           
        },
          //关闭
            closeUpload(){
                this.dialogImageUrl='',//查看图片url
                this.dialogVisible=false,//图片放大弹框
                this.imgList=[],//图片
                this.residueCount=0,//剩余可上传
                this.uploadShow=true,//上传图片按钮
                this.imageCount=0,//最大上传图片数
                this.init()
                this.$emit('on-close');
            },
            //保存
            saveUpload(){
                this.emitFn();
            },
            // 返回的参数，模式1返回单张图片，模式2返回图片列表
            emitFn(){
                if(this.imgMode=='1'){
                    if(this.dialogImageUrl==''&&this.isBtn){
                        this.$message.error({
                            showClose: true,
                            message: '请上传图片',
                            duration: 2000
                        });
                        return false
                    }
                    this.$emit('on-submit',this.dialogImageUrl,this.dataIndex)
                }else{
                    this.$emit('on-submit',this.imgList,this.dataIndex)
                }
                
            },
       
    },
}
</script>
<style>

.sizere_uploadbox{
    overflow: hidden;
}
.sizere_uploadbox .el-upload-list--picture-card .el-upload-list__item,.upload_btn .el-upload--picture-card{
    width:80px;
    height:80px;
    line-height:80px;
}
.uploadbox {
  width:100%;
}
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  width: 100%;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100%;
  height: 230px;
  line-height: 230px;
  text-align: center;
  display: block;
}
.avatar {
  width: 100%;
  height: 230px;
  display: block;
}
</style>