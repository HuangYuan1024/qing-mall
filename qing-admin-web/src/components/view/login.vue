<template>
	<div class="loginBox logoUser">
		<vHeader></vHeader>
		<div class="loginG loginBg">
			<div class="bodyWidth loginc">
				<div class="indexLoginBox login-box">
					<h2>用户登录</h2>
					<!--<h3 class="loginTitle" v-show="timeOutTxt">登录已过期！请重新登录</h3>-->
					<el-form ref="account" :model="account" :rules="rules" class="demo-infoForm">
						<el-form-item prop="username">
							<el-input @keyup.enter.native="submitLogin()" prefix-icon="loginIcon icon-user2" type="text" v-model="account.username" auto-complete="off" placeholder="账号/手机号码">
							</el-input>
						</el-form-item>
						<el-form-item prop="password">
							<el-input @keyup.enter.native="submitLogin()" prefix-icon="loginIcon icon-pwd2" type="password" v-model="account.password" auto-complete="off" placeholder="密码">
							</el-input>
						</el-form-item>
						<el-form-item class="formBtn">
							<el-button type="primary" @click="submitLogin()" :loading="loading">马上登录</el-button>
						</el-form-item>
					</el-form>
					<div class="loginReg">
						<span style="float: right;">还没有账号？<router-link to="/reg">注册</router-link></span>
						<router-link style="float: left;" to="/backPwd">忘记密码？</router-link>

					</div>
				</div>

			</div>
			<div class="footerApi">
				<vFooter></vFooter>
			</div>
		</div>
	</div>
	
</template>

<script>
import vHeader from '@/components/view/header'
import vFooter from '@/components/view/vFooter'
// import API from '@/api/api_basic';
import axios from 'axios'
export default {
    name: 'login',
    components: {
        vHeader,
        vFooter
    },

    data() {
        // document.title = "amz buy-用户登录"
        return {
            loading: false,
            timeOutTxt: localStorage.getItem('pt-outTime'),
            account: {
                username: '',
                password: ''
            },
            rules: {
                username: [{
                    required: true,
                    message: '请输入账号',
                    trigger: 'blur'
                }, ],
                password: [{
                    required: true,
                    message: '请输入密码',
                    trigger: 'blur'
                }, ]
            }
        };
    },
    mounted: function() {
        document.body.removeAttribute("class", "bodyActive");
        document.getElementsByTagName("body")[0].className = "bodylogin";


    },
    beforeDestroy() {
        document.body.removeAttribute("class", "bodyActive");
        document.body.removeAttribute("class", "bodylogin");
    },
    methods: {
        submitLogin() {
			let that = this;
			
            that.$refs.account.validate((valid) => {
                if (valid) {
                    //this.loading = true;
                    // axios.get(`http://login-qq/user/mg/login?username=${this.account.username}&password=${this.account.password}`).then(result => {
                    //     that.loading = false;
                    //     if (result.data.code == "20000") {
                    //         let data = result.data.data
                    //         localStorage.removeItem("pt-access-user")
                    //         localStorage.removeItem("pt-outTime")
                    //         localStorage.setItem('pt-access-user', JSON.stringify(data));
                    //         this.$setCookie("Admin-Token-qq", data.accessToken, 7) //保存cookie(如不设置时间，浏览器关闭后cookie失效)
                    //         setTimeout(function() {
                    //             that.$router.push({
                    //                 path: '/pro_productlist'
                    //             });
                    //         }, 1000)

                    //     } else {
                    //         that.$message.error({
                    //             showClose: true,
                    //             message: result.data.message || '登录失败',
                    //             duration: 2000
                    //         });
                    //     }
                    // }).catch(function(error) {
                    //     that.loading = false;
                    //     that.$message.error({
                    //         showClose: true,
                    //         message: '服务器异常',
                    //         duration: 2000
                    //     });
					// });
					if(this.account.username=='admin'&&this.account.password=='admin'){
						that.$message.success({
							showClose: true,
							message: '登录成功',
							duration: 2000
						});
						setTimeout(() => {
							that.$router.push({
								path: '/pro_productlist'
							});
						}, 1000)
					}else{
						that.$message.error({
							showClose: true,
							message: '账号或密码不对',
							duration: 2000
						});
					}
                  

                }
            });

        }

    }
}
</script>

<style>
	.loginIcon {
		display: inline-block;
		width: 100%;
	}
	
	.loginReg a {
		color: #018ffb;
		text-decoration: none;
	}
	
	.loginReg a:hover {
		filter: Alpha(opacity=60);
		opacity: .6;
	}
	
	.loginTitle {
		color: #b71818;
		font-weight: normal;
		margin-top: 0;
		padding-bottom: 10px;
	}
	
	.indexLoginBox {
		
		background: rgba(255, 255, 255, 0.4);
		padding: 60px 30px 40px;
		margin: 0 auto;
	}
	
	.indexLoginBox>h2 {
		font-weight: normal;
		font-size: 18px;
		padding-bottom: 20px;
	}
	
	
</style>