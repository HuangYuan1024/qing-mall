<template>
	<el-container style="height: 100%;">
		<el-header class="el-header" style="background: #242f35;">
			
			<div class="layoutWidth max_nav">
				<img class="header-logo" src="../assets/img/logo.png">
				
				
				<div class="menuRight">
					
					
					<span class="exit" @click="exit()"><i class="icon-exit"></i>
                    <a>退出</a>
                    </span>
				</div>
			</div>
		</el-header>
		
		<el-container style="padding-top: 60px;">
			<!--子账号账号菜单-->
			<div class="left_menublock">
				<el-aside class="left_menu">
					<div class="menuLeftAside left_menubos" >
						<el-menu background-color="#2e393e" text-color="#999" active-text-color="#fff" class="el-menu-vertical-demo" router :default-active="navselected">
						
								<el-menu-item v-for="item in menuData" :key="item.path" :name="item.path" :index="item.path" @click.native="changeMenu(item)">		
									{{item.name}}
								</el-menu-item>
								<!-- <el-submenu v-for="item in menuData" :index="item.path" :key="item.path" >
									<template slot="title"><i class="el-icon-menu"></i><span>{{item.name}}</span></template>
									<el-menu-item v-for="term in item.children" :key="term.path" >		
										{{term.name}}
									</el-menu-item>
								</el-submenu> -->
							
						</el-menu>
						 
						
					</div>
				</el-aside>
			</div>
		
			<el-main style="padding-top: 20px;">
				<el-row>
					<el-col :span="24" class="breadcrumb-container">
						<el-breadcrumb class="my_breadcrumb">
							<span class="el-breadcrumb__item">当前位置：</span>
							<el-breadcrumb-item v-for="item in $route.matched" :key="item.path">
								{{ item.name }}
							</el-breadcrumb-item>
						</el-breadcrumb>
					</el-col>
				</el-row>
				<router-view class="page-content"></router-view>
			</el-main>
		</el-container>
	</el-container>
</template>


<script>
import API from '@/api/api_basic';
export default {
    name: 'home',
    data() {
        return {
            navselected: "/pro_productlist",
            menuData: [{
                    path: '/pro_productlist',
                    name: '商品列表',
                    menuShow: true,
                },
                {
                    path: '/pro_edit',
                    name: '编辑产品',
                    menuShow: false,
                },
                {
                    path: '/cate_categorylist',
                    name: '商品分类',
                    menuShow: true,
                },
                {
                    path: '/brand_brandlist',
                    name: '品牌管理',
                    menuShow: false,
                },
                {
                    path: '/spec_speclist',
                    name: '规格管理',
                    menuShow: true,
                },
                {
                    path: '/order_orderlist',
                    name: '订单列表',
                    menuShow: false,
                },
            ],
  
          
        }
    },

    watch: {
		"$route":{
			handler(){
				console.log(this.navselected)
				this.navselected=this.$route.path
			},
			immediate:true
		}
    },
    created() {
        var that = this;
        this.$nextTick(function() {
        })
    },

    methods: {
        /**
         * @description 切换菜单
         */
        changeMenu(row) {
			this.navselected=row.path
            this.$router.push({
                path: row.path
            })
        },
     
        exit() {
            let that = this;
            localStorage.removeItem("pt-userName-key");
            localStorage.removeItem("pt-access-user");
            localStorage.removeItem("pt-accessKey");
            localStorage.removeItem("pt-access");
            that.$router.push({
                path: '/login'
            });
        },
    }
}
</script>