	import vHeader from '@/components/view/header'
	import vFooter from '@/components/view/vFooter'
	import API from '@/api/user';
	export default {
		name: 'reg',
		components: {
			vHeader,
			vFooter

		},
		data() {
			document.title = "注册账号"
			var checkMobile = (rule, value, callback) => {
				if(value === '') {
					callback(new Error('请输入手机号码'));
				} else if(!this.$checkPhone(value)) {
					callback(new Error('手机号码格式不正确'));
				} else callback();
			};
			var checkPwd = (rule, value, callback) => {
				if(!this.$checkPwd(value)) {
					callback(new Error("请输入6~14位密码"));
				} else {
					callback();
				}
			};
			return {
				headTitle: "用户注册",
				isLogin: 0,
				loading: false,
				falseString: false,
				loadingGetCode: false,
				dialogFormVisible: false,
				codeImg: '',
				codeImgVal: '',
				subCodeImg: "", //截取acid
				getCodeText: '获取短信验证码',
				gopage: 60,
				elDisable: false,
				account: {
					mobile: '',
					pass: '',
					code: '',
					checkCode: '',
				},
				rules: {
					mobile: [{
						required: true,
						message: '请输入手机号码',
						trigger: 'blur'
					}, {
						validator: checkMobile
					}],
					pass: [{
							required: true,
							message: '请输入密码',
							trigger: 'blur'
						},
						{
							validator: checkPwd
						}
					],
					code: [{
						required: true,
						message: '请输入短信验证码',
						trigger: 'blur'
					}]
				}
			};
		},
		mounted: function() {
			this.$nextTick(function() {
				this.codeImg = this.getCodeImg()
			})
			//document.getElementsByTagName("body")[0].className = "bodyActive";
		},
		methods: {
			openModal() {
				this.codeImg = this.getCodeImg();
				let flag = 0;
				this.$refs.AccountFrom.validateField('mobile', function(msg) {
					if(!msg) flag = 1;
					else flag = 0
				})
				if(flag == 1 && this.isLogin == 0) {
					this.dialogFormVisible = true;
				}

			},
			checkPhoneHave() {
				/*let that = this;
				let s = "account=" + this.account.mobile;
				let str = this.$jsencrypt.getKeyByStr(s)
				let formData = {
					pa: str
				}
				API.checkPhoneHave(formData).then(result => {
					if(result.data.code == "10010") {
						that.$message.error({
							showClose: true,
							message: '该手机号码已被注册，请更换其他号码',
							duration: 2000
						});
						that.isLogin = 1;
						return

					} else that.isLogin = 0;
				}).catch(function(error) {
					that.$message.error({
						showClose: true,
						message: '服务器异常',
						duration: 2000
					});
				});*/

			},
			submitForm(formName) {
				let that = this;
				this.$refs.AccountFrom.validate((valid) => {
					if(valid) {
						this.loading = true;
						let s = "acid=" + encodeURIComponent(that.subCodeImg) + "&account=" + encodeURIComponent(this.account.mobile) + "&password=" + encodeURIComponent(this.account.pass) + "&mobileCode=" + encodeURIComponent(this.account.code);
						let str = this.$jsencrypt.getKeyByStr(s)
						let formData = {
							pa: str
						}
						API.reg(formData).then(result => {
							that.loading = false;
							if(result.data.code == "000") {
								//localStorage.setItem('pt-access-user', JSON.stringify(result));
								that.$message.success({
									showClose: true,
									message: "恭喜！注册成功",
									duration: 2000
								});
								that.$router.push({
									path: '/index'
								});
							} else {
								that.$message.error({
									showClose: true,
									message: result.data.message || '注册失败',
									duration: 2000
								});
							}
						}).catch(function(error) {
							that.loading = false;
							that.$message.error({
								showClose: true,
								message: '服务器异常',
								duration: 2000
							});
						});

					}
				});

			},
			countGo() {
				let _this = this;
				if(--this.gopage > 0) {
					_this.elDisable = true
					setTimeout(() => {
						this.getCodeText = "已发送(" + _this.gopage + "s)";
						_this.countGo();
					}, 1000);
				} else {
					this.getCodeText = "获取短信验证码"
					_this.elDisable = false
					this.gopage = 60
				}
			},
			sendPhoneCode() {
				let that = this;
				if(!this.codeImgVal) {
					that.$message.error({
						showClose: true,
						message: "请输入图形验证码",
						duration: 2000
					});
					return
				}
				this.loadingGetCode = true;
				let s = "acid=" +that.subCodeImg+"&mobile=" + encodeURIComponent(this.account.mobile) + "&code=" + encodeURIComponent(this.codeImgVal) + "&type=1";
				let str = this.$jsencrypt.getKeyByStr(s)
				let formData = {
					pa: str
				}
				API.getCode(formData).then(result => {
					that.loadingGetCode = false;
					if(result.data.code == "000") {
						that.dialogFormVisible = false;
						that.countGo()
					} else {
						that.codeImg = that.getCodeImg() //重新获取验证码
						that.$message.error({
							showClose: true,
							message: result.data.message,
							duration: 2000
						});
					}
				}).catch(function(error) {
					that.loading = false;
					that.$message.error({
						showClose: true,
						message: '服务器异常',
						duration: 2000
					});
				});

			},
			getCodeImg() {
				this.codeImg = this.$getCodeImg()
				this.subCodeImg = this.codeImg.substr(this.codeImg.indexOf("acid") + 5)
				return this.codeImg;
			},
			handleClose(done) {

			}
		}
	}