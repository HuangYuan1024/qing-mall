<template>
	<div class="viewHeader">
		<div class="viewHeaderMid">
			<div class="viewHeaderWidth bodyWidth">
				<router-link class="loginA" to="/index"><img :src="website_logo" /></router-link>
				<div class="viewHeaderRight" :class="$route.path=='/login'?'isLogin':'NoIsLogin'">
					<router-link to="/login">返回登录</router-link>
				</div>
			</div>
		</div>
	</div>
</template>

<script src="./js/header.js"></script>

<style>
	@import url("../../assets/css/view.css");
</style>