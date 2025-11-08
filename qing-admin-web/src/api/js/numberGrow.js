export default {
		props: {
			time: {
				type: Number,
				default: 2
			},
			value: {
				type: Number,
				default: 0
			},
			dotted: {
				type: Number,
				default: 0
			},
			dw: {
				type: String,
				default: ""
			}
		},
		methods: {
			numberGrow(ele) {
				let _this = this
				let step = (_this.value * 10) / (_this.time * 1000)
				let current = 0
				let start = 0
				let t = setInterval(function() {
					start += step
					if(start > _this.value) {
						clearInterval(t)
						start = _this.value
						t = null
					}
					if(current === start) {
						return
					}
					if(_this.dw)
						current = "￥" + start.toFixed(_this.dotted)
					else
						current = start.toFixed(_this.dotted)
					ele.innerHTML = current.toString().replace(/(\d)(?=(?:\d{3}[+]?)+$)/g, '$1,')
				}, 4)
			}
		},
		mounted() {
			this.numberGrow(this.$refs.numberGrow)
		}

	}