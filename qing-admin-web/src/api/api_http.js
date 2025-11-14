import axios from 'axios'
import {
    bus
} from '../bus.js'
import router from '../router'
import jquery from '../assets/libs/jquery-1.9.1.min'

var locationUrl = window.location.host.split(":")[0]
console.log(locationUrl)
console.log(window.location.host)
    // var $Api = "http://qq/api"
var $Api = "http://localhost:8081"

var $ImgApi = window.g.http + locationUrl + ":" + window.g.port + "/"

// var $Api = "http://192.168.0.129:8881/api/"
// var $ImgApi = "http://192.168.0.129:8881/"

localStorage.setItem("$Api", $Api)
localStorage.setItem("$ImgApi", $ImgApi)

var baseURLStr = localStorage.getItem("$Api")

axios.defaults.baseURL = baseURLStr;


import {
    showLoading,
    hideLoading
} from './loading';
/* 请求拦截器（请求之前的操作） */
axios.interceptors.request.use(function(req) {

    // if (localStorage.getItem("pt-access-user")) {
    //     let token = JSON.parse(localStorage.getItem("pt-access-user")).accessToken
    //     req.headers['Authorization'] = token;
    // }
    req.headers['wd-cs'] = "11"
    return req;
})

// axios.interceptors.request.use((req) => {
//     if (req.data !== undefined && req.data.indexOf("loading") == -1) //如果参数里含有loading字段则不加载loading
//         showLoading();
//     return req;


// }, err => {
//     console.log(err)
//     Promise.reject(err)
//     hideLoading()
// });

// http响应拦截器
axios.interceptors.response.use(response => {
        hideLoading()
            // if (response.data.code == "20002") {
            //     localStorage.removeItem("pt-userName-key");
            //     localStorage.removeItem("pt-access-user");
            //     localStorage.removeItem("pt-accessKey");
            //     localStorage.setItem('pt-outTime', true)
            //     router.push({
            //         path: '/login/'
            //     })
            // } ///注意：上线xu去掉注释
        return response
    }, error => {
        return Promise.reject(error);
    })
    //通用方法
export const POST = (url, params) => {
        // return axios.post(url, $.param(params))
        return axios.post(url, params)
    }
    //通用方法
export const DELETE = (url, params) => {
        return axios.delete(url, params)
    }
    //通用方法
export const GET = (url, params) => {
        return axios.get(url, params)
    }
    //通用方法
export const PUT = (url, params) => {
    return axios.put(url, params)
}
export default axios
