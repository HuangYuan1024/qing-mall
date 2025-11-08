var iconv = require('iconv-lite');
const express = require('express')
var request = require('request');
const superagent = require('superagent')
require('superagent-proxy')(superagent);
require('superagent-charset')(superagent)
const cheerio = require('cheerio')
const Q = require('q');
const Instance = require("./axios/index")

const taobaoApi = require('./js/taobaoApi') //淘宝
const tmallApi = require('./js/tmallApi') //天猫
const jdApi = require('./js/jdApi') //京东
const aliApi = require('./js/aliApi') //速卖通
const alibabaApi = require('./js/alibabaApi') //1688
    //var proxy = Proxy.GetProxy()
var proxy = "http://121.61.33.84:9999"

var async = require('async'),
    eventproxy = require('eventproxy');

var ep = new eventproxy();




var urlArr = []
var reqType = ""
var token = ""
var baseURL = ""
    // const serverApi = (router) => {
    //   router.get('/crawl', (req, res) => {//获取url数组和类型
var urlsArray = []; //存放爬取网址
var allProducts = {}; //最后的结果
var curCount = 0;
allProducts.allNum = 0 //总url数量(前端显示)
allProducts.successNum = 0 //成功url数量(前端显示)
allProducts.failNum = 0; //失败个数(前端显示)
allProducts.failUrl = [] //失败url（前端显示）
allProducts.crawlfailUrl = [] //爬取失败url（统计）
allProducts.savefailUrl = [] //保存失败url（统计）


// urlArr=req.query.detailUrl.split("\n");
// reqType=req.query.type;
// token=req.query.token;
// baseURL=req.query.baseURL;
urlArr = ["https://www.aliexpress.com/item/32998641759.html?spm=2114.search0103.3.17.264a55040EcYXf&ws_ab_test=searchweb0_0%2Csearchweb201602_1_10065_10068_319_10546_10059_10884_317_10548_10887_10696_321_322_10084_453_10083_454_10103_10618_10307_537_536%2Csearchweb201603_52%2CppcSwitch_0&algo_expid=346fdaec-e65d-4b3f-9308-e67fac148ed1-2&algo_pvid=346fdaec-e65d-4b3f-9308-e67fac148ed1"];
reqType = 1;
token = "H1jIGEVnk6cvxwkAEpkGdaws4QqwCuUF+PghspUOZ+EjwUNlCERU10wc1N30X3L+0nLtd2pgsdkgGbNn/VLi6AnHejvcap6k1yHtmED+btMpSr/hiyYXtLm7jV6LHqOYiy3vKa2KvKTgwIdgt2Qq+hmHO/sDcldLrWcUtKoQs6M=";
baseURL = "http://192.168.0.129:8888";

if (reqType == 1) { //如果是详情页、
    urlsArray = urlArr //存放爬取网址
    allProducts.allNum = urlsArray.length
    async.mapLimit(urlsArray, 10, function(url, callback) {
        productDetailFn(url, callback);
    }, function(err, result) {
        // pageNum 个 URL 访问完成的回调函数
        console.log('抓取结束');


    });


}

function ReturnApi() {
    if (allProducts.successNum + allProducts.failNum == allProducts.allNum) {
        res.header('charset', 'utf8');
        res.header('Access-Control-Allow-Origin', '*');
        return res.status(200).json({ code: "000", message: "采集完成", failureReasons: "", data: allProducts });
    }
    if (allProducts.successNum == 0 && allProducts.failNum == 0) {
        res.header('charset', 'utf8');
        res.header('Access-Control-Allow-Origin', '*');
        return res.status(200).json({ code: "001", message: "采集失败", failureReasons: "", data: allProducts });
    }
}



function productDetailFn(url, callback) { //解析详情页
    var that = this;
    var sourceUrl = url
        //延迟毫秒数
    var delay = parseInt((Math.random() * 30000000) % 1000, 10);
    curCount++;
    setTimeout(function() {
        if (url.indexOf("item.taobao.com/item") !== -1) {
            taobaoApi(url).then(function(data) {
                var postData = {
                    token: token,
                    sourceUrl: sourceUrl,
                    country: "cn", //中国
                    productTitle: data.productTitle, //gb2312
                    sourceName: "淘宝 ",
                    type: "1", //新增
                    productDesc: data.productDesc, //描述
                    productPrice: data.productPrice,
                    imgList: data.imgList,
                    language: 'zh-CHS'
                }

                submitApi(postData)
                callback(null)
            }, function(err) {
                allProducts.crawlfailUrl.push(url)
                allProducts.failUrl.push(url)
                allProducts.failNum++
                    ReturnApi()
                callback(null)
            })

        } else if (url.indexOf("detail.tmall.com/item") !== -1) {
            tmallApi(url).then(function(data) {
                var postData = {
                    token: token,
                    country: "cn", //中国
                    sourceUrl: sourceUrl,
                    productTitle: data.productTitle, //gb2312
                    sourceName: "天猫",
                    type: "1", //新增
                    productDesc: data.productDesc, //描述
                    productPrice: data.productPrice,
                    imgList: data.imgList,
                    language: 'zh-CHS'
                }
                submitApi(postData)
                callback(null)
            }, function(err) {
                allProducts.crawlfailUrl.push(url)
                allProducts.failUrl.push(url)
                allProducts.failNum++
                    ReturnApi()
                callback(null)
            })
        } else if (url.indexOf("item.jd.com") !== -1) {
            var that = this;

            jdApi(url).then(function(data) {
                var postData = {
                    token: token,
                    country: "cn", //中国
                    sourceUrl: sourceUrl,
                    productTitle: data.productTitle, //gb2312
                    sourceName: "京东",
                    type: "1", //新增
                    productDesc: data.productDesc, //描述
                    productPrice: data.productPrice,
                    imgList: data.imgList,
                    language: 'zh-CHS'
                }
                submitApi(postData)
                callback(null)
            }, function(err) {
                allProducts.crawlfailUrl.push(url)
                allProducts.failUrl.push(url)
                allProducts.failNum++
                    ReturnApi()
                callback(null)
            })
        } else if (url.indexOf('aliexpress.com/item') !== -1 || url.indexOf('aliexpress.com/store/product') !== -1) {
            var country = "us"
            var language = "us"
            switch (url) {
                case url.indexOf('www.aliexpress.com') != -1:
                    return country = "us" //美语
                    language = "us"
                    break;
                case url.indexOf('ru.aliexpress.com') != -1:
                    return country = "ru" //俄罗斯语
                    language = "ru"
                    break;
                case url.indexOf('pt.aliexpress.com') != -1:
                    return country = "pt" //葡萄牙语
                    language = "pt"
                    break;
                case url.indexOf('es.aliexpress.com') != -1:
                    return country = "es" //西班牙语
                    language = "es"
                    break;
                case url.indexOf('fr.aliexpress.com') != -1:
                    return country = "fr" //法国
                    language = "fr"
                    break;
                case url.indexOf('de.aliexpress.com') != -1:
                    return country = "de" //德语
                    language = "de"
                    break;
                case url.indexOf('it.aliexpress.com') != -1:
                    return country = "it" //意大利语
                    language = "it"
                    break;
                case url.indexOf('ja.aliexpress.com') != -1:
                    return country = "jp" //日本语
                    language = "jp"
                    break;
                case url.indexOf('ko.aliexpress.com') != -1:
                    return country = "kr" //朝鲜语
                    language = "kr"
                    break;
                case url.indexOf('ar.aliexpress.com') != -1:
                    return country = "ar" //阿拉伯语
                    language = "ar"
                    break;
                case url.indexOf('nl.aliexpress.com') != -1:
                    return country = "nl" //荷兰语
                    break;
                case url.indexOf('vi.aliexpress.com') != -1:
                    return country = "vi" //越南语
                    language = "vi"
                    break;
                case url.indexOf('th.aliexpress.com') != -1:
                    return country = "th" //泰国
                    language = "th"
                    break;
                case url.indexOf('tr.aliexpress.com') != -1:
                    return country = "tr" //土耳其
                    language = "tr"
                    break;
                case url.indexOf('he.aliexpress.com') != -1:
                    return country = "he" //希伯来
                    language = "he"
                    break;
                case url.indexOf('id.aliexpress.com') != -1:
                    return country = "id" //印尼
                    language = "id"
                    break;
                default:
                    break;
            }
            aliApi(url).then(function(data) {
                var postData = {
                    token: token,
                    country: country,
                    sourceUrl: sourceUrl,
                    productTitle: data.productTitle, //gb2312
                    sourceName: "速卖通",
                    type: "1", //新增
                    productDesc: data.productDesc, //描述
                    productPrice: data.productPrice,
                    imgList: data.imgList,
                    language: language,
                }
                submitApi(postData)
                callback(null)
            }, function(err) {
                allProducts.crawlfailUrl.push(url)
                allProducts.failUrl.push(url)
                allProducts.failNum++
                    ReturnApi()
                callback(null)
            })
        } else if (url.indexOf('detail.1688.com/offer') !== -1) { //1688
            alibabaApi(url).then(function(data) {
                console.log(data)
                console.log("爬取1688数据结束")
                var postData = {
                    token: token,
                    country: "cn",
                    sourceUrl: sourceUrl,
                    productTitle: data.productTitle, //gb2312
                    sourceName: "阿里巴巴",
                    type: "1", //新增
                    productDesc: data.productDesc, //描述
                    productPrice: data.productPrice,
                    imgList: data.imgList,
                    language: language,
                }
                submitApi(postData)
                callback(null)
            }, function(err) {
                allProducts.crawlfailUrl.push(url)
                allProducts.failUrl.push(url)
                allProducts.failNum++
                    ReturnApi()
                callback(null)
            })
        } else {
            allProducts.crawlfailUrl.push(url)
            allProducts.failUrl.push(url)
            allProducts.failNum++
                ReturnApi()
            callback(null)
        }
    }, delay)



};



function submitApi(params) {
    var that = this;
    Instance(baseURL + "product/general/operate", params).then(result => {
        if (result.data.code == "000") {
            allProducts.successNum++ //成功url数量
        } else {
            allProducts.savefailUrl.push(url)
            allProducts.failUrl.push(url)
            allProducts.failNum++
        }
        ReturnApi()
    }).catch(function(error) {
        ReturnApi()
    });

}



//    })
// }


//   module.exports = serverApi