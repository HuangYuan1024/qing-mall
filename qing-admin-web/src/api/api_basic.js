import * as API from './api_http';
import axios from 'axios'
export default {

    //登录
    userLoginApi: (params) => {
        return API.POST(`/admin/login`, params)
    },
    //商品列表
    spuSearchApi: (params) => {
        return API.POST(`/spu/list/${params.page}/${params.pagesize}`, params)
    },
    //商品详情
    spuGoodsApi: (params) => {
        return API.GET(`/spu/product/${params.id}`, params)
    },

    //下架
    productPullApi: (params) => {
        return API.PUT(`/spu/pull/${params.id}`, params)
    },
    //上架
    productPutApi: (params) => {
        return API.PUT(`/spu/put/${params.id}`, params)
    },
    //审核
    productAuditApi: (params) => {
        return API.PUT(`/spu/audit/${params.id}`, params)
    },
    //商品删除
    logicDeleteApi: (params) => {
        return API.DELETE(`/spu/logic/delete/${params.id}`, { data: params })
    },
    //品牌列表（全部）
    categoryBrandApi: (params) => {
        return API.GET(`/brand`, params)
    },
    //商品分类列表
    categoryListApi: (params) => {
        return API.GET(`/category/parent/${params.id}?parentId=${params.id}`, params)
    },
    //商品分类添加
    categoryAddApi: (params) => {
        return API.POST(`/category`, params)
    },
    //品牌下拉
    brandCategoryApi: (params) => {
        return API.GET(`/brand/category/${params.id}`, params)
    },
    //商品参数集合
    paraCategoryApi: (params) => {
        return API.GET(`/para/category/${params.id}`, params)
    },
    //商品属性集合
    specCategoryApi: (params) => {
        return API.GET(`/skuAttribute/category/${params.id}`, params)
    },
    //商品保存
    spuSaveApi: (params) => {
        return API.POST(`/spu/save`, params)
    },

    /*-----------品牌--------*/
    //品牌管理列表
    brandListApi: (params) => {
        return API.POST(`/brand/list/${params.page}/${params.size}`, params)
    },
    //添加品牌
    brandAddApi: (params) => {
        return API.POST(`/brand`, params)
    },
    //编辑品牌
    brandEditApi: (params) => {
        return API.PUT(`/brand/${params.id}`, params)
    },
    //获取品牌详情
    brandDetailApi: (params) => {
        return API.GET(`/brand/${params.id}`, params)
    },
    //删除品牌
    brandDeleteApi: (params) => {
        return API.DELETE(`/brand/${params.id}`, params)
    },
    /*-----------规格--------*/
    //规格列表
    specListApi: (params) => {
        return API.POST(`/skuAttribute/list/${params.page}/${params.size}`, params)
    },
    //规格详情
    // specDetailApi: (params) => {
    //     return API.GET(`/spec/${params.id}`, params)
    // },
    //添加规格
    specAddApi: (params) => {
        return API.POST(`/skuAttribute`, params)
    },
    // //修改规格
    // specEditApi: (params) => {
    //     return API.PUT(`/spec/${params.id}`, params)
    // },
    //删除规格
    specDeleteApi: (params) => {
        return API.DELETE(`/skuAttribute/${params.id}`, params)
    },
    /*-----------参数--------*/
    //参数列表
    paraListApi: (params) => {
        return API.POST(`/para/search/${params.page}/${params.size}`, params)
    },
    //参数详情
    paraDetailApi: (params) => {
        return API.GET(`/para/${params.id}`, params)
    },
    //添加参数
    paraAddApi: (params) => {
        return API.POST(`/para`, params)
    },
    //修改参数
    paraEditApi: (params) => {
        return API.PUT(`/para/${params.id}`, params)
    },
    //删除参数
    paraDeleteApi: (params) => {
        return API.DELETE(`/para/${params.id}`, params)
    },
    /*-----------订单--------*/
    //订单列表
    orderListApi: (params) => {
        return API.POST(`/order/search`, params)
    },
    //订单详情
    orderDetailApi: (params) => {
        return API.GET(`/order/${params.id}`, params)
    },
    //条件查询分类
    categorySearchApi: (params) => {
        return API.POST(`/category/search`, params)
    },

}