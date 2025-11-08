<template>
	<div>
		<div class="basictop">
			<div class="basicLeft">
				<div class="homeUserInfo">
					<div class="" style="">
						<div class="siteList">
							<el-col :xs="6" :sm="6" :md="4" :lg="3" :xl="3" v-for="(item,index) in toolbarList" :key="index" >
								<a :href="item.adLink" target="_blank" ><img :src="hostUrl+item.adImgUrl" /><span>{{item.adFullTitle}}</span></a>
							</el-col>
						</div>
					</div>
					<!--<div class="homeUILeft">
						<div>
							<p><img :src="memberLogo" :onerror="defaultImg" />
								<span class="editUserImg">
								<el-upload :before-upload="beforeAvatarUpload" :show-file-list="showfalse"  ref="upload"  :on-change="uploadImg" :data="userImgData" class="upload-demo" :action="fileApi">
									<el-button style="width: 100%" size="medium"name="file" type="info">修改头像</el-button>
								</el-upload>
								</span>
							</p>
						</div>
						<h2><span>您好</span>,<i>{{form.memberName}}</i></h2>
						<p>{{form.memberLevelName}}</p>
					</div>-->

					<!--<div class="homeUIRight" style="">
						<p><span class="icon-mail"></span>客服邮件：service@orgine.com</p>
						<p class="index_qq">QQ咨询：
							<a style="display: inline-block;" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1004917977&site=qq&menu=yes"><img src="../assets/img/qq_talk.gif" /></a>
						</p>
					</div>-->
				</div>
				<div class="myClient" style="position: relative;">
					<ul>
					
						<li class="Withdrawal">
							<span class="el-icon-goods clientItem"></span>
							<i class="titleItem">总订单</i>
							<div class="clientRight">
								<dl><dt><span><NumberGrow :value="Number(orderCount)" :dotted="Number(0)" v-if="orderCount!==''?true:false"></NumberGrow></span></dt>
								</dl>
								<div>
								</div>
							</div>
						</li>
						<li class="alreadyWithdrawals">
							<span style="background: #e95b95;" class="icon-redpacket clientItem"></span>
							<i class="titleItem">待处理</i>
							<div class="clientRight">
								<dl><dt><span><NumberGrow :value="Number(incomeAmount)" :dotted="Number(0)" v-if="incomeAmount!==''?true:false"></NumberGrow></span></dt>
								</dl>
							</div>
						</li>
						<li class="alreadyWithdrawals">
							<span style="background: #40b09b;" class="icon-group clientItem"></span>
							<i class="titleItem">发货中</i>
							<div class="clientRight">
								<dl><dt><span><NumberGrow :value="Number(buyerCount)" :dotted="Number(0)" v-if="buyerCount!==''?true:false"></NumberGrow></span></dt>
								</dl>
							</div>
						</li>
						<li class="alreadyWithdrawals">
							<span style="background: #67d176;" class="icon-browse clientItem"></span>
							<i class="titleItem">销售额</i>
							<div class="clientRight">
								<dl><dt><span><NumberGrow :value="Number(visitorCount)" dw="￥"  :dotted="Number(2)" v-if="visitorCount!==''?true:false"></NumberGrow></span></dt>
								</dl>
							</div>
						</li>

					</ul>
				</div>
				<div class="indexpro">
					<el-col :xs="24" :sm="24" :md="24" :lg="12" :xl="12">
						<el-card class="box-card" style="width:98.6%;">
							<div slot="header" class="clearfix">
								<span>利润</span>
							</div>
							<v-chart :options="polar" />
							
						</el-card>
					</el-col>
					<el-col :xs="24" :sm="24" :md="24" :lg="12" :xl="12">
						<el-card class="box-card" style="width:98.6%;margin-left:1.4%;">
							<div slot="header" class="clearfix">
								<span>周统计</span>
							</div>
								<v-chart :options="polar1" />
						</el-card>
					</el-col>
		

				
				</div>
				<!---右侧公告-->
				<div class="basicRight">
					<div class="basicMess">
						<div class="indexTitle">公告</div>
						<p>
							<a v-for="a in form.noticeList" @click="getArticDetail(a.articleId)">{{a.articleName}}</a>
						</p>
					</div>
					<div class="basicMess" style="margin-top: 20px;">
						<div class="indexTitle">常见问题</div>
						<p>
							<a v-for="a in form.problemList" @click="getArticDetail(a.articleId)">{{a.articleName}}</a>
						</p>
					</div>
					<div class="basicMess" style="margin-top: 20px;">
						<div class="indexTitle">版本信息</div>

						<div class="stepboxbig">
							<ul class="stepbox">
								<li v-for="item in versionList" :key="item.articleId">
									<div class="left_step">
										<span>{{item.createTime}}</span>
										<div class="roundbox"></div>
									</div>
									<a class="right_step" @click="getArticDetail(item.articleId)">{{item.articleName}}</a>
								</li>
								
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<el-dialog :title="articleName" :visible.sync="dialogVisible" width="1000px" :before-close="handleClose">
			<div class="articleDetail" v-html="articDetail.articleDesc" style="max-height: 600px;overflow-y: auto;"></div>
			<div slot="footer" class="dialog-footer">
				<el-button @click="dialogVisible = false">关闭</el-button>
			</div>
		</el-dialog>

		<!--详情 end-->

	</div>

</template>
<script>
import NumberGrow from '@/components/global/numberGrow' //没用
import API from '@/api/api_basic';
import ECharts from 'vue-echarts'
import 'echarts'
let Base64 = require('js-base64').Base64;


export default {
    components: {
        NumberGrow: NumberGrow,
        'v-chart': ECharts
    },
    data() {

        return {
            polar1: {
                title: {
                    text: ''
                },
                color: ['#6daede'],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: { // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: [{
                    type: 'category',
                    data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
                    axisTick: {
                        alignWithLabel: true
                    }
                }],
                yAxis: [{
                    type: 'value'
                }],
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                series: [{
                    name: '收入',
                    type: 'bar',
                    barWidth: '60%',
                    data: [12500, 32900, 25900, 13340, 23900, 6900, 3000]
                }]

            },
            polar: {
                title: {
                    text: ''
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ['线下销售', '线上销售']
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },

                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: ['2018.10', '2018.11', '2018.12', '2019.02', '2019.02', '2019.03', ]
                },
                yAxis: {
                    type: 'value'
                },
                series: [{
                        name: '线下销售',
                        type: 'line',
                        stack: '总量',
                        color: ['#6daede'],
                        data: [12000, 13200, 10100, 13400, 9000, 23000, 21000]
                    },
                    {
                        name: '线上销售',
                        type: 'line',
                        stack: '总量',
                        color: ['#14944a'],
                        data: [22000, 18200, 19100, 23400, 29000, 33000, 31000]
                    }
                ]
            },

            token: "",
            dialogVisible: false,
            loading: false,
            articDetail: "",
            articleName: "",
            memberImg: "",
            tweenedNumber: 0,
            orderCount: "",
            incomeAmount: "",
            buyerCount: "",
            visitorCount: "",
            versionList: [],
            form: {
                homeName: "",
                imgUrl: "",
                orderCount: "0.00",
                incomeAmount: "0.00",
                buyerCount: "0.00",
                visitorCount: '0.00'
            },
            regUrl: "",
            userImgData: {
                token: this.token,
                type: 1,

            },
            memberLogo: "",
            defaultImg: 'this.src="' + require('@/assets/img/default.jpg') + '"',
            fileApi: localStorage.getItem("$Api") + "config/file/headImgUpload",
            hostUrl: localStorage.getItem("$ImgApi"),
            showfalse: false,
            toolbarList: "",
        }
    },
    created: function() {
        this.$nextTick(function() {

            // if(localStorage.getItem('pt-access-user')) { //是否登录
            // 	this.token = JSON.parse(localStorage.getItem('pt-access-user')).token
            // 	this.userImgData.token = JSON.parse(localStorage.getItem('pt-access-user')).token
            // } else {
            // 	this.$router.push({
            // 		path: '/login'
            // 	});
            // 	return
            // }
            this.getArticleList()
        })
    },
    mounted: function() {
        $(".breadcrumb-container").css("display", "none");
        document.getElementsByTagName("body")[0].className = "bodyActive";
    },
    beforeDestroy() {
        $(".breadcrumb-container").css("display", "block");
        document.body.removeAttribute("class", "bodyActive");
    },
    computed: {
        animatedNumber: function() {
            return this.tweenedNumber.toFixed(0);
        }
    },
    methods: {
        uploadImg(data) {
            if (data.status == 'ready')
                return
            var response = data.response

            if (data.status == "success") {
                if (response.code == "000") {
                    this.memberLogo = response.imgUrl
                } else
                    this.$errMsg("response.message")

            } else {
                this.$serverErrMsg("response.message")
            }
        },
        beforeAvatarUpload(file) {
            const isJPG = file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/gif';
            const isLt2M = file.size / 1024 / 1024 < 2;

            if (!isJPG) {
                this.$message.error('上传图片只能是 JPG 格式!');
            }
            if (!isLt2M) {
                this.$message.error('上传图片大小不能超过 2MB!');
            }
            return isJPG && isLt2M;
        },
        getArticDetail(id) {

            this.getArticDetailTo(id)
        },
        getArticDetailTo(id) {
            let formData = {
                token: this.token,
                articleId: id
            };
            let that = this;
            that.loading = true;
            API.getArticleDetail(formData).then(result => {
                that.loading = false;
                if (result.data.code == "000") {
                    that.dialogVisible = true
                    that.articDetail = result.data.data;
                    that.articleName = result.data.data.articleName;
                } else {

                    that.$errMsg(result.data.message)
                }
            }).catch(function(error) {
                that.$serverErrMsg()
            });
        },
        getArticleList() {
            let formData = {
                token: this.token
            };
            let that = this;
            that.loading = true;
            API.getArticleList(formData).then(result => {
                that.loading = false;
                if (result.data.code == "000") {
                    that.form = result.data.data;
                    that.orderCount = result.data.data.orderCount.total
                    that.incomeAmount = result.data.data.orderCount.delivery
                    that.buyerCount = result.data.data.orderCount.pending
                    that.visitorCount = result.data.data.orderCount.sales

                    that.form.memberName = result.data.data.memberName;
                    that.toolbarList = result.data.data.toolbarList
                    that.versionList = result.data.data.versionList

                    if (!that.form.memberLogo) {
                        that.memberLogo = "../assets/img/default.jpg"
                    } else
                        that.memberLogo = that.form.memberLogo

                } else {

                    that.$errMsg(result.data.message)
                }
            }).catch(function(error) {
                that.$serverErrMsg()
            });
        },
        getNum(ids, nums) {
            var num = 0;
            var nf = 0;
            if (nums > 100)
                nf = 10;
            else if (nums > 1000)
                nf = 100;
            else if (nums > 10000)
                nf = 1000;
            else
                nf = 1;

            var t = setInterval(function() {
                num + nf;
                var id = document.getElementById(ids);
                id.innerText = num;
                if (num == nums) {
                    clearInterval(t);
                }
            }, 1);
        },
        handleClose() { //取消弹框
            this.dialogVisible = false;
        },
    }
}</script>
<style>
    .echarts {
        width: 100%;
        height: 400px;
    }
</style>