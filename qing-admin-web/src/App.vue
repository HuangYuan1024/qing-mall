<template>
	<div id="app">
		<router-view></router-view>
	</div>
</template>

<script>
	export default {
		name: 'App'
	}
</script>

<style>
	body {
		padding: 0;
		margin: 0;
		overflow-x: hidden;
		/* 标准的语法 */
		height: 100%;
		width: 100%;
	}
	
	* {
		padding: 0;
		margin: 0;
		box-sizing: border-box;
	}
	
	#app {
		height: 100%;
		font-family: "Roboto,sans-serif,Microsoft Yahei", "Hiragino Sans GB", "WenQuanYi Micro Hei", sans-serif, arial
	}
	
	
	@font-face {
		font-family: 'icomoon';
		src: url('assets/fonts/icomoon.eot?dxzztq');
		src: url('assets/fonts/icomoon.eot?dxzztq#iefix') format('embedded-opentype'), url('assets/fonts/icomoon.ttf?dxzztq') format('truetype'), url('assets/fonts/icomoon.woff?dxzztq') format('woff'), url('assets/fonts/icomoon.svg?dxzztq#icomoon') format('svg');
		font-weight: normal;
		font-style: normal;
	}
	
	[class^="icon-"],
	[class*=" icon-"] {
		/* use !important to prevent issues with browser extensions that change fonts */
		font-family: 'icomoon' !important;
		speak: none;
		font-style: normal;
		font-weight: normal;
		font-variant: normal;
		text-transform: none;
		line-height: 1;
		/* Better Font Rendering =========== */
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
	}
	
	.icon-caigou:before {
		content: "\e912";
	}
	
	.icon-dingdan:before {
		content: "\e913";
	}
	
	.icon-chanping:before {
		content: "\e914";
	}
	
	.icon-cangku:before {
		content: "\e915";
	}
	
	.icon-wuliu:before {
		content: "\e916";
	}
	
	.icon-uniE90F:before {
		content: "\e90f";
	}
	
	.icon-redpacket:before {
		content: "\e90c";
	}
	
	.icon-group:before {
		content: "\e90d";
	}
	
	.icon-browse:before {
		content: "\e90e";
	}
	
	.icon-home:before {
		content: "\e904";
	}
	
	.icon-pwd2:before {
		content: "\e906";
	}
	
	.icon-mail:before {
		content: "\e907";
	}
	
	.icon-phone:before {
		content: "\e908";
	}
	
	.icon-code3:before {
		content: "\e909";
	}
	
	.icon-user2:before {
		content: "\e90a";
	}
	
	.icon-check-circle:before {
		content: "\e903";
	}
	
	.icon-qq:before {
		content: "\e905";
	}
	
	.icon-totop:before {
		content: "\e911";
	}
	
	.icon-1:before {
		content: "\e90b";
	}
	
	.icon-mobile2:before {
		content: "\e910";
	}
	
	.icon-caret-down:before {
		content: "\e900";
	}
	
	.icon-exit:before {
		content: "\e901";
	}
	
	.icon-user:before {
		content: "\e902";
	}
	
	.icon-smile:before {
		content: "\e9e1";
	}
	
	@media screen and (max-width: 1300px) {
		.pageText h2 {
			font-size: 20px;
		}
		.pageText h3 {
			font-size: 16px;
		}
		.pageText p {
			max-width: 410px;
		}
		.page img {
			width: 96%;
		}
		.processList>span {
			font-size: 80px;
		}
		.arrowRight {
			font-size: 40px;
		}
	}
	
	@media screen and (max-width: 1000px) {
		.logo>img {
			height: 30px;
		}
		#pcBanner {
			display: none;
		}
		#webBanner {
			display: block;
		}
		.aboutRight {
			display: none;
		}
		.pageText {
			top: 0;
		}
		.pageText h2 {
			font-size: 24px;
			text-align: center;
		}
		.pageText h3 {
			font-size: 18px;
			text-align: center;
		}
		.pageText p {
			padding-left: 10%;
		}
		.page {
			height: auto;
		}
		.pageRight {
			float: none;
		}
		.pageLeft {
			float: none
		}
		.zise {
			width: 200px;
		}
		.baise {
			width: 300px;
			height: auto;
		}
		.menu {
			display: none;
		}
		.processList>span {
			font-size: 50px;
		}
		.arrowRight {
			font-size: 30px;
		}
		.indexZzNow {
			padding: 20px 0;
		}
		.indexZzNow>span {
			display: block;
			width: 100px;
			margin: 0 auto;
		}
	}


</style>