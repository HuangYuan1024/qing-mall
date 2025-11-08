export default {
		data() {
			return {
				website_name:'',				
			}
		},
		mounted() {
			this.$nextTick(function() {
				this.website_name=localStorage.getItem('setConfig_ph_name')

			})
		},
	}