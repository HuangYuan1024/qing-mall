	import Vue from 'vue';
	import { showLoading, hideLoading } from '@/api/loading';
	export default {
	    props: {
	        dataImglist: { //图片数组字符串
	            type: String,
	            default: ''
	        },
	        dataType: { //true是多选，false是单选
	            type: Boolean,
	            default: true
	        },
	        dataIndex: { //点击引用图片时的时间戳，用来判断是否清空所有选项
	            default: ""
	        }
	    },
	    data() {
	        return {
	            imgurl: "",
	            chooseAll: false,
	            //imglist: ["1","2","3" ],
	            imglist: [],
	            imgMain: "",
	            submitImg: "",

	            networkForm: {
	                url: ""
	            },
	            rules: { //验证规则
	                url: [
	                    { required: true, message: '请填写url' }
	                ],
	            },


	        }
	    },

	    created: function() {
	        let that = this;
	        this.$nextTick(function() {
	            this.chooseAll = false
	            if (this.dataImglist !== '') {
	                var list = JSON.parse(this.dataImglist)
	                var list1 = []
	                list.forEach(function(ele, index) {
	                    var obj = {}
	                    obj.imgUrl = ele
	                    obj.checked = false
	                    list1.push(obj)
	                })
	                this.imglist = list1
	            }


	        });

	    },
	    watch: {
	        "dataImglist": {
	            handler() {
	                this.chooseAll = false
	                if (this.dataImglist !== '') {
	                    var list = JSON.parse(this.dataImglist)
	                    var list1 = []
	                    list.forEach(function(ele, index) {
	                        var obj = {}
	                        obj.imgUrl = ele
	                        obj.checked = false
	                        list1.push(obj)
	                    })
	                    this.imglist = list1
	                }
	            }
	        },
	        "dataIndex": {
	            handler() {
	                this.chooseAll = false
	                if (this.dataImglist !== '') {
	                    var list = JSON.parse(this.dataImglist)
	                    var list1 = []
	                    list.forEach(function(ele, index) {
	                        var obj = {}
	                        obj.imgUrl = ele
	                        obj.checked = false
	                        list1.push(obj)
	                    })
	                    this.imglist = list1
	                }
	            }
	        }
	    },
	    methods: {
	        chooseAllFn(chooseAll) { //全选
	            var that = this

	            if (chooseAll) {
	                that.imglist.forEach(function(item, i) {
	                    var obj = {}
	                    obj.imgUrl = that.imglist[i].imgUrl
	                    obj.checked = false
	                    Vue.set(that.imglist, i, obj)
	                })
	                that.chooseAll = false
	            } else {
	                that.imglist.forEach(function(item, i) {
	                    var obj = {}
	                    obj.imgUrl = that.imglist[i].imgUrl
	                    obj.checked = true
	                    Vue.set(that.imglist, i, obj)
	                })
	                that.chooseAll = true
	            }

	        },
	        chooseImgFn(imgUrl, index) {
	            var that = this;
	            if (that.dataType) { //多选
	                var can = true
	                that.imglist.forEach(function(item, i) {
	                    if (index == i) {
	                        that.imgurl = imgUrl
	                        var obj = {}
	                        obj.imgUrl = imgUrl
	                        if (item.checked) {
	                            can = false
	                            obj.checked = false
	                        } else {
	                            obj.checked = true
	                        }
	                        Vue.set(that.imglist, index, obj)
	                    } else {
	                        if (!item.checked) {
	                            can = false
	                        }
	                        var obj = item
	                        Vue.set(that.imglist, i, obj)
	                    }

	                })
	                if (!!can) {
	                    that.chooseAll = true
	                } else {
	                    that.chooseAll = false
	                }
	            } else { //单选
	                that.imglist.forEach(function(item, i) {
	                    if (index == i) {
	                        that.imgurl = imgUrl
	                        var obj = {}
	                        obj.imgUrl = imgUrl
	                        obj.checked = true
	                        Vue.set(that.imglist, index, obj)
	                    } else {
	                        var obj = {}
	                        obj.imgUrl = that.imglist[i].imgUrl
	                        obj.checked = false
	                        Vue.set(that.imglist, i, obj)
	                    }
	                })

	            }


	        },




	        submitFn() {
	            var list = []
	            this.imglist.forEach(function(ele, index) {
	                if (ele.checked) {
	                    list.push(ele.imgUrl)
	                }
	            })
	            this.$emit("on-imglist", JSON.stringify(list))
	        },
	        returnFn() {
	            this.$emit("on-imglist", "")
	        }

	    }

	}