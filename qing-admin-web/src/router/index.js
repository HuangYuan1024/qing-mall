import Vue from 'vue'
import Router from 'vue-router'
import index from '@/components/view/index'
import home from '@/components/home'


// //产品
import productlist from '@/components/product/productlist' //产品列表
import edit from '@/components/product/edit' //编辑产品
import categorylist from '@/components/category/categorylist' //商品分类
import brandlist from '@/components/brand/brandlist' //品牌管理

import speclist from '@/components/spec/speclist' //规格管理
import orderlist from '@/components/order/orderlist' //订单管理
import orderdetail from '@/components/order/orderdetail' //订单详情



import base from '@/components/base'


// import orderlist from '@/components/order/orderlist' //订单列表


//路由被访问时才加载对应组件
const login = resolve => require(['@/components/view/login'], resolve)
Vue.use(Router)
let router = new Router({
    // mode: 'history',
    linkActiveClass: 'is-active',
    routes: [{
            path: '/login',
            name: '登录',
            component: login,
            menuShow: false,
        },
        {
            path: '/',
            name: '首页',
            component: home,
            redirect: '/pro_productlist',
            leaf: true, // 只有一个节点
            menuShow: true,
            iconCls: 'iconfont icon-home', // 图标样式class
            children: [{
                    path: '/pro_productlist',
                    component: productlist,
                    name: '商品列表',
                    menuShow: true,
                    meta:{title:'商品列表',icon:'el-icon-s-goods'}
                },

                {
                    path: '/pro_edit',
                    component: edit,
                    name: '编辑产品',
                    menuShow: false,
                },
                {
                    path: '/cate_categorylist',
                    component: categorylist,
                    name: '商品分类',
                    menuShow: true,
                },
                {
                    path: '/brand_brandlist',
                    component: brandlist,
                    name: '品牌管理',
                    menuShow: false,
                },
                {
                    path: '/spec_speclist',
                    component: speclist,
                    name: '规格管理',
                    menuShow: true,
                },
                {
                    path: '/order_orderlist',
                    component: orderlist,
                    name: '订单列表',
                    menuShow: false,
                },
                {
                    path: '/order_orderdetail',
                    component: orderdetail,
                    name: '订单详情',
                    menuShow: false,
                },


            ]
        },



    ]
})
router.beforeEach((to, from, next) => {
    if (to.name) {
        document.title = localStorage.getItem('setConfig_ph_name') + '_' + to.name;

    }
    if (to.meta.auth) { //是否验证
        //if (localStorage.getItem('pt-access-user')) { //是否登录
        next()
            // } else {
            //     next('/login')
            // }
    } else {
        next()
    }
})
export default router