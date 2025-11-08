import axios from './api_http'
import ElementUI from 'element-ui'
const fnGlobal = function(Vue) {

    Vue.prototype.$setCookie = function(c_name, value, expiredays) {
        var exdate = new Date();
        exdate.setDate(exdate.getDate() + expiredays);
        document.cookie = c_name + "=" + value + ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString());
    };
    Vue.prototype.$getCookie = function(name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
        if (arr = document.cookie.match(reg)) {
            return (arr[2]);
        } else {
            return false
        }
    }
    Vue.prototype.$delCookie = function(name) {
        var exp = new Date();
        exp.setTime(exp.getTime() - 1);
        var cval = getCookie(name);
        if (cval) {
            document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
        }
    };
    Vue.prototype.$checkIsMail = function(msg) { //邮箱
        if (!(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(msg))) {
            return false;
        } else {
            return true;
        }

    }
    Vue.prototype.$checkIsDomain = function(msg) {
        if (!(/^(?=^.{3,255}$)[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+$/.test(msg))) {
            return false;
        } else {
            return true;
        }
    }
    Vue.prototype.$checkPhone1 = function(msg) { //电话
        if (!(/[\d-]*/.test(msg))) {
            return false;
        } else
            return true;
    }
    Vue.prototype.$checkPhone = function(msg) { //固定电话
        if (!(/^1(3|4|5|6|7|8)\d{9}$/.test(msg))) {
            return false;
        } else
            return true;
    }
    Vue.prototype.$checkName = function(msg) { //账号
        if (/^[0-9a-zA-Z_]{1,}$/.test(msg))
            return true;
        else
            return false
    }
    Vue.prototype.$checkSku = function(msg) { //sku
        if (/^[0-9a-zA-Z_\-/\\\#\*]{1,}$/.test(msg))
            return true;
        else
            return false
    }
    Vue.prototype.$checkNum1 = function(msg) { //采集箱编辑的数量可以为0
        if (!/^[0-9]\d*$/.test(msg)) {
            return false;
        } else {
            return true;
        }
    }
    Vue.prototype.$checkNum = function(msg) { //数量,库存，处理天数
        if (!/^[1-9]\d*$/.test(msg)) {
            return false;
        } else {
            return true;
        }
    }
    Vue.prototype.$checkPrice = function(msg) { //价格
        // /(^[1-9](\d+)?(\.\d{1,2})?$)|(^\d\.\d{1,2}$)/
        if (/^[0-9]\d*(?:\.\d{0,2})?$/.test(msg))
            return true;
        else
            return false

    }
    Vue.prototype.$checkWeight = function(msg) { //重量
        if (/^[0-9]\d*(?:\.\d{1,3})?$/.test(msg))
            return true;
        else
            return false

    }
    Vue.prototype.$checkLetterNumber = function(msg) { //产品sku和采购运单号
        if (/^[0-9a-zA-Z\-]*$/.test(msg))
            return true;
        else
            return false
    }
    Vue.prototype.$checkTheme = function(msg) { //产品主题属性
        if (!/[\u4E00-\u9FA5]/g.test(msg))
            return true;
        else
            return false
    }
    Vue.prototype.$checkNumLetter = function(msg) { //物流运单号,产品类型id
        if (/^[0-9A-Za-z]*$/.test(msg))
            return true;
        else
            return false
    }
    Vue.prototype.$checkURL = function(msg) { //链接
        if (/^(https?|ftp|file):\/\/.+$/.test(msg))
            return true;
        else
            return false
    }


    Vue.prototype.$checkFloat = function(msg) {
        if (/^\d+(?=\.{0,1}\d+$|$)/.test(msg))
            return true;
        else
            return false

    }
    Vue.prototype.$getCodeImg = function() {
        let str = axios.defaults.baseURL + "common/code/getVerify?acid=" + this.$uuid();
        return str
    }
    Vue.prototype.$checkPwd = function(msg) {
        if (msg.indexOf(" ") >= 0) {
            return false;
        } else if (msg.length < 6 || msg.length > 14) {
            return false
        } else return true
    }
    Vue.prototype.$uuid = function() {
        var s = [];
        var hexDigits = "0123456789abcdef";
        for (var i = 0; i < 36; i++) {
            s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
        }
        s[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
        s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
        s[8] = s[13] = s[18] = s[23] = "-";

        var uuid = s.join("");
        return uuid;
    }


    Vue.prototype.$successMsg = function(msg) {
        this.$message.success({
            showClose: true,
            message: msg,
            duration: 2000
        });
    }

    Vue.prototype.$errMsg = function(msg) {
        this.$message.error({
            showClose: true,
            message: msg || '系统出错，请联系管理员',
            duration: 2000
        });
    }
    Vue.prototype.$serverErrMsg = function() {
        this.$message({
            showClose: true,
            message: '系统繁忙，请稍后重试',
            duration: 2000
        });
    }
    Vue.prototype.$formatDate = function(datetime) { //日期转换
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1;
        var date = datetime.getDate();
        if (month < 10) { month = "0" + month; }
        if (date < 10) { date = "0" + date; }
        var time = year + "-" + month + "-" + date;
        return time;
    }
    Vue.prototype.$formatTime = function(datetime) { //时间转换
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1;
        var date = datetime.getDate();
        var hour = datetime.getHours();
        var min = datetime.getMinutes();
        var sec = datetime.getSeconds();

        if (month < 10) { month = "0" + month; }
        if (date < 10) { date = "0" + date; }
        if (hour < 10) { hour = "0" + hour; }
        if (min < 10) { min = "0" + min; }
        if (sec < 10) { sec = "0" + sec; }
        var time = year + "-" + month + "-" + date + " " + hour + ":" + min + ":" + sec;
        return time;
    }
    Vue.prototype.$toTime_G = function(v) { //时间戳转时间
        var time = new Date(v)
        var year = time.getFullYear()
        var mon = time.getMonth() + 1;
        var day = time.getDate();
        var hour = time.getHours();
        var min = time.getMinutes();
        if (mon < 10) mon = "0" + mon
        if (day < 10) day = "0" + day
        if (hour < 10) hour = "0" + hour
        if (min < 10) min = "0" + min
        return year + "-" + mon + "-" + day + " " + hour + ":" + min
    }


    Vue.prototype.$formatMonth = function(datetime) { //月份转换
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1;
        if (month < 10) { month = "0" + month; }
        var time = year + "-" + month;
        return time;
    }
    Vue.prototype.$Rearrangement = function(rows) { //商品分类数组重构（树状图）
        function exists(rows, parentId) {
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].id == parentId) return true;
            }
            return false;
        }
        var list1 = []
        rows.forEach(function(item) {
            if (!exists(rows, item.parentId)) {
                list1.push({
                    id: item.id,
                    label: item.className,
                });
            }
        })
        var toDo = [];
        for (var i = 0; i < list1.length; i++) {
            toDo.push(list1[i]);
        }
        while (toDo.length) {
            var node = toDo.shift(); // the parent node
            // get the children nodes
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (row.parentId == node.id) {
                    var child = { id: row.id, label: row.className };
                    if (node.children) {
                        node.children.push(child);
                    } else {
                        node.children = [child];
                    }
                    toDo.push(child);
                }
            }
        }
        return JSON.stringify(list1);
    }

    Vue.prototype.$Rearrangement1 = function(rows) { //商品分类数组重构（级联）
        function exists(rows, parentId) {
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].id == parentId) return true;
            }
            return false;
        }
        var list1 = []
        rows.forEach(function(item) {
            if (!exists(rows, item.parentId)) {
                list1.push({
                    value: item.id,
                    label: item.className,
                });
            }
        })
        var toDo = [];
        for (var i = 0; i < list1.length; i++) {
            toDo.push(list1[i]);
        }
        while (toDo.length) {
            var node = toDo.shift(); // the parent node
            // get the children nodes
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (row.parentId == node.value) {
                    var child = { value: row.id, label: row.className };
                    if (node.children) {
                        node.children.push(child);
                    } else {
                        node.children = [child];
                    }
                    toDo.push(child);
                }
            }
        }
        return JSON.stringify(list1);
    }

    Vue.prototype.$cascadervalueFn = function(data, id) { //商品分类获取的时候重组数组，选中选项
        var that = this;
        var cascaderType = [id]
        var parentId = ""
        for (var i = 0; i < data.length; i++) { //获取到父级Id
            if (data[i].id == id) {
                parentId = data[i].parentId
            }
        }
        loop()

        function loop() {
            if (parentId !== "#") {
                cascaderType.unshift(parentId)
                for (var i = 0; i < data.length; i++) {
                    if (data[i].id == parentId) {
                        parentId = data[i].parentId
                        if (parentId !== "#") {
                            loop()
                        }
                    }
                }
            }
        }
        return cascaderType
    }
    Vue.prototype.$grouping = function(rows) { //属性列表分组
        var map = {},
            dest = [];
        for (var i = 0; i < rows.length; i++) {
            var ai = rows[i];
            if (!map[ai.groupName]) {
                dest.push({
                    groupName: ai.groupName,
                    attrlist: [ai]
                });
                map[ai.groupName] = ai;
            } else {
                for (var j = 0; j < dest.length; j++) {
                    var dj = dest[j];
                    if (dj.groupName == ai.groupName) {
                        dj.attrlist.push(ai);
                        break;
                    }
                }
            }
        }
        return JSON.stringify(dest)
    }
    Vue.prototype.$diff = function(arr1, arr2) { //两个数组的差值  
        return arr1.concat(arr2).filter(item => !arr1.includes(item) || !arr2.includes(item));
    }
    Vue.prototype.$numMulti = function(num1, num2) { //乘法运算
            var baseNum = 0;
            try {
                baseNum += num1.toString().split(".")[1].length;
            } catch (e) {}
            try {
                baseNum += num2.toString().split(".")[1].length;
            } catch (e) {}
            return Number(num1.toString().replace(".", "")) * Number(num2.toString().replace(".", "")) / Math.pow(10, baseNum);
        }
        /**
         * 除法运算
         */
    Vue.prototype.$numDiv = function(num1, num2) {
        var baseNum1 = 0,
            baseNum2 = 0;
        var baseNum3, baseNum4;
        try {
            baseNum1 = num1.toString().split(".")[1].length;
        } catch (e) {
            baseNum1 = 0;
        }
        try {
            baseNum2 = num2.toString().split(".")[1].length;
        } catch (e) {
            baseNum2 = 0;
        }
        baseNum3 = Number(num1.toString().replace(".", ""));
        baseNum4 = Number(num2.toString().replace(".", ""));
        return (baseNum3 / baseNum4) * Math.pow(10, baseNum2 - baseNum1);
    }
    Vue.prototype.$numAdd = function(num1, num2) { //加法运算
        var baseNum, baseNum1, baseNum2;
        try {
            baseNum1 = num1.toString().split(".")[1].length;
        } catch (e) {
            baseNum1 = 0;
        }
        try {
            baseNum2 = num2.toString().split(".")[1].length;
        } catch (e) {
            baseNum2 = 0;
        }
        baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
        return (num1 * baseNum + num2 * baseNum) / baseNum;
    }
    Vue.prototype.$numSub = function(num1, num2) { //减法运算
        var baseNum, baseNum1, baseNum2;
        var precision; // 精度
        try {
            baseNum1 = num1.toString().split(".")[1].length;
        } catch (e) {
            baseNum1 = 0;
        }
        try {
            baseNum2 = num2.toString().split(".")[1].length;
        } catch (e) {
            baseNum2 = 0;
        }
        baseNum = Math.pow(10, Math.max(baseNum1, baseNum2));
        precision = (baseNum1 >= baseNum2) ? baseNum1 : baseNum2;
        return ((num1 * baseNum - num2 * baseNum) / baseNum).toFixed(precision);
    }

    Vue.prototype.$multiCartesian = function(data) { //笛卡尔积(多个)
        var len = data.length;
        if (len == 0)
            return [];
        else if (len == 1)
            return data[0];
        else {
            var r = data[0];
            for (var i = 1; i < len; i++) {
                r = Cartesian(r, data[i]);
            }
            return r;
        }

        function Cartesian(a, b) {
            var ret = [];
            for (var i = 0; i < a.length; i++) {
                for (var j = 0; j < b.length; j++) {
                    ret.push(ft(a[i], b[j]));
                }
            }
            return ret;
        }

        function ft(a, b) {
            if (!(a instanceof Array))
                a = [a];
            var ret = Array.call(null, a);
            ret.push(b);
            return ret;
        }

    }

    Vue.prototype.$titleCase2 = function(s) { //将单词首字母变成大写
        return s.toLowerCase().replace(/\b([\w|']+)\b/g, function(word) {
            //return word.slice(0, 1).toUpperCase() + word.slice(1);  
            return word.replace(word.charAt(0), word.charAt(0).toUpperCase());
        });
    }

    Vue.prototype.$multiCartesian = function(list) { //笛卡尔积(多个)
        //parent上一级索引;count指针计数
        var point = {};
        var result = [];
        var pIndex = null;
        var tempCount = 0;
        var temp = [];
        //根据参数列生成指针对象
        for (var index in list) {
            if (typeof list[index] == 'object') {
                point[index] = {
                    'parent': pIndex,
                    'count': 0
                }
                pIndex = index;
            }
        }
        //单维度数据结构直接返回
        if (pIndex == null) {
            return list;
        }
        //动态生成笛卡尔积
        while (true) {
            for (var index in list) {
                tempCount = point[index]['count'];
                temp.push(list[index][tempCount]);
            }
            //压入结果数组
            result.push(temp);
            temp = [];
            //检查指针最大值问题
            while (true) {
                if (point[index]['count'] + 1 >= list[index].length) {
                    point[index]['count'] = 0;
                    pIndex = point[index]['parent'];
                    if (pIndex == null) {
                        return result;
                    }
                    //赋值parent进行再次检查
                    index = pIndex;
                } else {
                    point[index]['count']++;
                    break;
                }
            }
        }

    }
    Vue.prototype.$groupStoreing = function(rows) { //店铺按平台列表分组
        var map = {},
            dest = [];
        for (var i = 0; i < rows.length; i++) {
            var ai = rows[i];
            ai.checked = true
            if (!map[ai.platformId]) {
                dest.push({
                    platformId: ai.platformId,
                    platformName: ai.platformName,
                    attrlist: [ai],
                    checkAll: true,
                });
                map[ai.platformId] = ai;
            } else {
                for (var j = 0; j < dest.length; j++) {
                    var dj = dest[j];
                    if (dj.platformId == ai.platformId) {
                        dj.attrlist.push(ai);
                        break;
                    }
                }
            }
        }
        return JSON.stringify(dest)
    }

    Vue.prototype.$getBase64 = function(img) {
        function getBase64Image(img, width, height) { //width、height调用时传入具体像素值，控制大小 ,不传则默认图像大小
            var canvas = document.createElement("canvas");
            canvas.width = width ? width : img.width;
            canvas.height = height ? height : img.height;

            var ctx = canvas.getContext("2d");
            ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
            var dataURL = canvas.toDataURL();
            return dataURL;
        }
        var image = new Image();
        image.crossOrigin = '*';
        //image.src = img;
        image.src = img // 处理缓存
        var deferred = $.Deferred();
        if (img) {
            console.log("转base开始加载图片")
            image.onload = function() {
                console.log("转base开始加载图片进入")
                deferred.resolve(getBase64Image(image)); //将base64传给done上传处理
            }
            return deferred.promise(); //问题要让onload完成后再return sessionStorage['imgTest']
        }
    }
    Vue.prototype.$getBase641 = function(src, callback, outputFormat) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', src, true);
        xhr.responseType = 'arraybuffer';
        var deferred = $.Deferred();
        xhr.onload = function(e) {
            if (xhr.status == 200) {
                var uInt8Array = new Uint8Array(xhr.response);
                var i = uInt8Array.length;
                var binaryString = new Array(i);
                while (i--) {
                    binaryString[i] = String.fromCharCode(uInt8Array[i]);
                }
                var data = binaryString.join('');
                var base64 = window.btoa(data);
                var dataUrl = "data:" + (outputFormat || "image/png") + ";base64," + base64;
                //	alert(dataUrl)
                //callback.call(this, dataUrl);
                deferred.resolve(dataUrl); //将base64传给done上传处理
            }
        };
        xhr.send();
        return deferred.promise();
    }

}

export default fnGlobal