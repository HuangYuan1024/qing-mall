<template>

		<div>
			<ul class="chooseImgBlock clearfix">
				<div class="imgCheckbox" v-if="dataType" @click="chooseAllFn(chooseAll)" ><input type="checkbox" :checked="chooseAll"><span>全选</span></div>
				<li v-for="(element ,index) in imglist" :key="index" @click="chooseImgFn(element.imgUrl ,index)" :class="element.checked==true?'active':''">
					<div class="productimgbck" :style="'background:url('+ element.imgUrl +') no-repeat center/cover;'"></div>
					<div class="imgchoosebox"></div>
				</li>
			</ul>
			<div style="margin-top:10px;text-align:center;">
				<el-button @click="returnFn">取 消</el-button>
				<el-button type="primary" @click="submitFn" >引用</el-button>
			</div>
		</div>
	
</template>
<style>
	.productimgbck {
		background-size: contain;
	}
</style>
<script src="@/api/js/imgquote.js"></script>