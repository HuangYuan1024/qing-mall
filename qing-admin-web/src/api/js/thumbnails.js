export default {
        props: {
            thumbnailImg: {
                type: String,
                default: ""
            },
            thumbnailId: {
                type: Number,
                default: null
            },
            imgIndex:{
                  type: Number,
                default: null
            }
        },
        data() {
            return {
                bigimgIndex:"",//大图片的key
                bigimgShow:false,//是否显示大图片
            }
        },
        watch:{
            'imgIndex': { //监听
				handler() {
					this.bigimgIndex=this.imgIndex
				}
			},
        },
        methods: {
           
            enter(e){//移入表格中的缩略图效果
                this.bigimgShow=true
                this.bigimgIndex=e
                this.$emit('get-index', e); //把v传给父组件
               
            },
            leave(e){
                 this.bigimgShow=false
            }
           
           
        }
    }