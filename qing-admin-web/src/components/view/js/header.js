	export default {
		//name: 'header',
		data() {
			return {
				website_logo: "",
				website_name: "",
			}
		},
		created() {
			this.$nextTick(function() {
				this.website_logo = localStorage.getItem('setConfig_ph_logo');
				this.website_name = localStorage.getItem('setConfig_ph_name')
			})
		},
		mounted: function() {
			document.getElementsByTagName("body")[0].className = "bodyActive";
		},
		beforeDestroy() {
			document.body.removeAttribute("class", "bodyActive");
		},
	}