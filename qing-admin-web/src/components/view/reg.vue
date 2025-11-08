<template>
	<div class="">
		<vHeader></vHeader>

		<div class="viewBox loginG">
			<h3 class="RegTitle">欢迎注册</h3>
			<div class="RegBox">

				<el-form ref="AccountFrom" :model="account" :rules="rules" class="demo-infoForm">
					<el-form-item prop="mobile">
						<el-input prefix-icon="icon-mobile2 loginIcon" type="text" v-model="account.mobile" auto-complete="off" placeholder="手机号码">
						</el-input>
					</el-form-item>
					<el-form-item prop="code">
						<el-input prefix-icon="icon-code3 loginIcon" placeholder="验证码" v-model="account.code">
							<el-button @click="openModal()" slot="append" v-bind:disabled="elDisable">
								<span id="getCodeBtn" v-text="getCodeText"></span>
							</el-button>
						</el-input>
					</el-form-item>
					<el-form-item prop="pass">
						<el-input @keyup.enter.native="submitForm()" prefix-icon="icon-pwd2 loginIcon" type="password" v-model="account.pass" auto-complete="off" placeholder="密码">
						</el-input>
					</el-form-item>
					<el-form-item class="formBtn">
						<el-button type="primary" @click="submitForm()" v-loading="loading">立即注册</el-button>
					</el-form-item>
					<div class="RegReg">
						<span style="float: right;">已有账号？<router-link  to="/login">直接登录</router-link></span>
					</div>
				</el-form>

				<!--star-->
				<el-dialog title="请输入图形验证码" :close-on-click-modal="falseString" width="480px" :visible.sync="dialogFormVisible" @submit.native.prevent>
					<p style="text-align: left;line-height:20px;padding-left: 20px;color: #999;">一个手机号每天最多发送<strong>5</strong>条短信，超出将被锁定，24小时后自动解除，请谨慎操作</p>
					<el-form ref="codeFrom" label-width="80px">
						<el-form-item prop="codeImgVal" label="验证码">
							<el-input @keyup.enter.native="sendPhoneCode()" placeholder="请输入验证码" class="codeInput" v-model="codeImgVal">
								<span class="codeSpan" slot="append"><img class="codeImg" v-bind:src="codeImg" @click="getCodeImg()"  /></span>
							</el-input>
						</el-form-item>
					</el-form>
					<div slot="footer" class="dialog-footer">
						<el-button @click="dialogFormVisible = false">取 消</el-button>
						<el-button type="primary" @click="sendPhoneCode()" v-loading="loadingGetCode">确 定</el-button>
					</div>
				</el-dialog>
				<!---end-->
			</div>
		</div>
		<div class="footerApi"><vFooter></vFooter></div>
	</div>
</template>

<script src="./js/reg.js"></script>