<template>
  <el-card class="box-card">
    <div slot="header" class="clearfix">
      <span>图片信息</span>
    </div>

    <div>
      <el-upload
        ref="upload"
        :before-upload="beforeAvatarUpload"
        :show-file-list="showfalse"
        :on-change="uploadProImg"
        :data="imgData"
        :action="fileApi"
        style="display:inline-block;margin-right:10px;"
      >
        <el-button size="medium" type="primary">本地图片</el-button>
      </el-upload>
      <!-- <el-button size="medium" type="primary" style="margin-right:10px;" @click="networkFn">网络图片</el-button> -->
      <p style="margin-top:10px;">
        <el-tag type="success">温馨提示：点击图片拖动，即可调整图片顺序！</el-tag>
      </p>
      <ul class="productimg_list clearfix">
        <draggable v-model="imglist" @update="datadragEnd" :options="{animation:500}">
          <!-- <transition-group> -->

          <li v-for="(element ,index) in imglist" :key="index">
            <div class="productimgblock">
              <div
                class="productimgbck"
                :style="'background:url('+ element +') no-repeat center/cover;'"
                @click="previewImgFn(element)"
              ></div>
              <div class="productimgmask">
                <i class="el-icon-delete delbtn" @click="removeImg(index)"></i>
                <span v-if="dataMainShow">
                  <p class="mainbtn" v-if="element!=imgMain" @click="setMainImg(element,index)">设为主图</p>
                  <p v-if="element==imgMain">主图</p>
                </span>
              </div>
            </div>
          </li>
        </draggable>
      </ul>
    </div>

    <el-dialog :visible.sync="imgVisible" :modal="false" class="img_scalbox" width="600px">
      <img width="100%" :src="imgUrl" alt class="scalimg" />
    </el-dialog>
  </el-card>
</template>
<style>
.productimgbck {
  background-size: contain;
}
</style>
<script>
import draggable from "vuedraggable";
import Vue from "vue";
import { showLoading, hideLoading } from "@/api/loading";
export default {
  components: {
    draggable
  },
  props: {
    infoImg: {
      type: Object,
      default: () => {}
    },
    dataMainShow: {
      type: Boolean,
      default: true
    }
  },
  data() {
    return {
      //imglist: ["1","2","3" ],
      imgVisible: false,
      imgUrl: "", //图片放大的url
      imglist: [],
      imgMain: "",
      showfalse: false,
      submitImg: "",
      imgData: {},
      fileApi: "http://source-api.secby.cn/oss/upload",
      networkShow: false, //网络图片弹窗
      networkForm: {
        url: ""
      },
      rules: {
        //验证规则
        url: [{ required: true, message: "请填写url" }]
      },
      timer: ""
    };
  },
  created: function() {
    let that = this;
    this.$nextTick(function() {
      this.init();
    });
  },
  watch: {
    "infoImg": {
      handler() {
        this.init();
      },
      immediate: true
    }
  },

  methods: {
    init() {
      var that = this;
			this.imglist = this.infoImg.images ||[]
      if (!!that.infoImg.image) {
        if (that.imglist.indexOf(that.infoImg.image) !== "-1") {
          that.imgMain = that.infoImg.image;
        }
      } else {
        if (that.imglist.length > 0) {
          that.imgMain = that.imglist[0];
        }
      }
    },

    datadragEnd(evt) {
      evt.preventDefault();
      this.$emit("on-imglist", this.imglist, this.imgMain);
    },
    uploadProImg(data) {
      hideLoading();
      if (data.status == "ready") return;
      var response = data.response;
      if (data.status == "success") {
        if (response.code == "20000") {
          this.imglist.push(response.data);
          if (this.imglist.length == 1) {
            this.imgMain = response.data;
          }
          this.$emit("on-imglist", this.imglist, this.imgMain);
        } else this.$errMsg("response.message");
      } else {
        this.$serverErrMsg("response.message");
      }
    },
    removeImg(index) {
      if (index > -1) {
        this.imglist.splice(index, 1);
      }
      this.$emit("on-imglist", this.imglist, this.imgMain);
    },
    setMainImg(urlImg) {
      this.imgMain = urlImg;
      this.$emit("on-imglist", this.imglist, this.imgMain);
    },
    beforeAvatarUpload(file) {
      const isJPG =
        file.type === "image/jpeg" ||
        file.type === "image/png" ||
        file.type === "image/gif";
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error("上传图片只能是 JPG 格式!");
      }
      if (!isLt2M) {
        this.$message.error("上传图片大小不能超过 2MB!");
      }
      if (isJPG && isLt2M) showLoading();
      return isJPG && isLt2M;
    },
    previewImgFn(url) {
      //图片放大效果
      this.imgUrl = url;
      this.imgVisible = true;
    }
  }
};
</script>