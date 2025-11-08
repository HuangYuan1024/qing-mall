<template>
	<div class="number-grow-warp">
		<span ref="numberGrow" :data-time="time" class="number-grow" :data-value="value">0</span>
	</div>
</template>

<script src="@/api/js/numberGrow.js"></script>

<style>
	.number-grow-warp {
		transform: translateZ(0);
	}
	
	.number-grow {
		font-family: Arial-BoldMT;
		font-size: 22px;
		color: #969696;
	}
</style>