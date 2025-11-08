import Vue from 'vue'
import App from './App'
import router from './router'
import Vuex from 'vuex'

Vue.use(Vuex)
import Q from 'q'
import './assets/theme/element-3e8ef7/index.css';
//import '../theme/index.css'//主题二
//import './element-variables.scss'//深圳这边的样式
import './assets/css/basic.css';
import './assets/css/style.css';

//import './assets/css/style2.css';//深圳这边的样式



//import './assets/css/themeself.css'//主题二

import VDistpicker from 'v-distpicker'
Vue.component('v-distpicker', VDistpicker)


import ElementUI from 'element-ui'
import axios from 'axios'
import global from './api/global'
import 'babel-polyfill'
import jsencrypt from './assets/libs/jsencrypt.js'

import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.core.css' // import styles
import 'quill/dist/quill.snow.css' // for snow theme
import 'quill/dist/quill.bubble.css' // for bubble theme
Vue.use(VueQuillEditor)

// import '../static/UE/ueditor.config.js'
// import '../static/UE/ueditor.all.min.js'
// import '../static/UE/lang/zh-cn/zh-cn.js'
// import '../static/UE/ueditor.parse.min.js'
import VueUeditorWrap from 'vue-ueditor-wrap'

import API from '@/api/api_basic';
Vue.component('vue-ueditor-wrap', VueUeditorWrap)
Vue.prototype.$http = axios
Vue.prototype.$jsencrypt = jsencrypt
Vue.use(Q)

Vue.use(ElementUI);
Vue.use(global)
Vue.config.productionTip = false

import echarts from 'echarts'

Vue.prototype.$echarts = echarts
Vue.prototype.$fileApi = "http://qq/upload"
Vue.filter('validPrice', function(value) {
    var result = parseFloat(value);
    if (isNaN(result)) {
        return false;
    }
    result = Math.round(value * 100) / 100;
    var s_x = result.toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + 2) {
        s_x += '0';
    }
    return s_x;
});
const store = new Vuex.Store({
    state: {
        defaultOpen: [],
        childrenMenuData: "",
        mainMenu: false,
        adminleftnavnum: "/",
        mtImg: "",
    },
    mutations: {
        increment(state) {
            // console.log(state)
        }
    }
})
new Vue({
    el: '#app',
    router,
    components: {
        App
    },
    store,
    template: '<App/>',
    data() {
        return {
            userBtn: '', //初始化userRole
        }
    }
})