

var iconv = require('iconv-lite');
const express = require('express')
var request = require('request');
const superagent = require('superagent')
require('superagent-proxy')(superagent);
require('superagent-charset')(superagent)
const cheerio = require('cheerio')
const Q = require('q');
const Instance =require("./axios/index")

const taobaoApi=require('./js/taobaoApi')//淘宝
const tmallApi=require('./js/tmallApi')//天猫
const jdApi=require('./js/jdApi')//京东
const aliApi=require('./js/aliApi')//速卖通

const taobaoCategory=require('./js/taobaoCategory')//淘宝分类



//var proxy = Proxy.GetProxy()
var proxy = "http://121.61.33.84:9999"

var async = require('async'), 
    eventproxy = require('eventproxy');

var ep = new eventproxy(),
    urlsArray = [], //存放爬取网址
    pageUrls = [],  //存放收集页面网址
    pageNum = 1,  //要爬取的页数总数
    pageItems=40;  //每页的商品数目
    totalPageUrl = [];  
    
var allProducts={};//最后的结果


var urlArr=[]
var reqType=""
var token=""
var categoryUrl=""

// const serverApi = (router) => {
//   router.get('/crawl', (req, res) => {//获取url数组和类型
    var curCount = 0;
    allProducts.allNum=0//总url数量(前端显示)
    allProducts.successNum=0//成功url数量(前端显示)
    allProducts.failNum=0;//失败个数(前端显示)
    allProducts.failUrl=[]//失败url（前端显示）
    allProducts.crawlfailUrl=[]//爬取失败url（统计）
    allProducts.savefailUrl=[]//保存失败url（统计）



// if(req.query.type==1){
//     urlArr=req.query.detailUrl.split("\n");
// }else if(req.query.type==2){
//     categoryUrl=req.query.detailUrl
// }
// reqType=req.query.type;
// token=req.query.token;

 var url="https://shop432580588.taobao.com/category-1366113403.htm?spm=a1z10.5-c-s.w5002-18034302642.4.1a0811ebQmryaJ&search=y&catName=T%D0%F4"
    var urlArr=url.split("\n");
    var categoryUrl="https://shop432580588.taobao.com/category-1366113403.htm?spm=a1z10.5-c-s.w5002-18034302642.4.1a0811ebQmryaJ&search=y&catName=T%D0%F4"
     var reqType=2;
     var token="P07Qclgxt5HPT6MxjluBaloQm1xWRhJVY5ofXu5JWJ85otntXB8ZjtLvP2v8xE1LryQfGH+HMViMgFbl/8TeYC8jIVOyVI7tN43+dv8cC4hMSEXgPDvLgRbrZF7quatPW6No7YrYZvSkpqJIPnSTBfNCYYMKME6TsNEebdnZMJc="


  if(reqType==1){//如果是详情页、
      urlsArray = urlArr //存放爬取网址
      allProducts.allNum=urlsArray.length
      async.mapLimit(urlsArray, 10 ,function (url) {
          productDetailFn(url);
      }, function (err,result) {
          // pageNum 个 URL 访问完成的回调函数
          console.log('抓取结束');
      }); 
  }else if(reqType==2){
    if(categoryUrl.indexOf("taobao.com")!==-1){
        console.log("淘宝分类")
        taobaoCategory(categoryUrl).then(function(data){
            console.log(data)
           
        },function(err){
            console.log(err)
            allProducts.crawlfailUrl.push(categoryUrl)
            allProducts.failUrl.push(categoryUrl)
            allProducts.failNum++
            ReturnApi()
        })
    }
  }
  function ReturnApi() {
      console.log(allProducts)
    // if(allProducts.successNum+allProducts.failNum== allProducts.allNum){
    //     res.header('charset', 'utf8');
    //     res.header('Access-Control-Allow-Origin', '*');
    //     return res.status(200).json({code:"000",message:"采集完成",failureReasons:"",data:allProducts});
    // }
  }


  function productDetailFn(url){//解析详情页
    var that=this;
    var sourceUrl=url
      //延迟毫秒数
      var delay = parseInt((Math.random() * 30000000) % 1000, 10);
      curCount++;
      console.log(url.indexOf("detail.tmall.com/item"))
      if(url.indexOf("item.taobao.com/item")!==-1){
        taobaoApi(url).then(function(data){
            console.log(data)
            var postData = {
                token:token,
                sourceUrl:sourceUrl,
                country:"cn",//中国
                productTitle:data.productTitle,//gb2312
                sourceName:"淘宝 ",
                type:"1",//新增
                productDesc:data.productDesc,//描述
                productPrice:data.productPrice,
                imgList:data.imgList,
                language:'zh-CHS'
            }

            submitApi(postData)
        },function(err){
            console.log(err)
            allProducts.crawlfailUrl.push(url)
            allProducts.failUrl.push(url)
            allProducts.failNum++
            ReturnApi()
        })
      
      }else if(url.indexOf("detail.tmall.com/item")!==-1){
        tmallApi(url).then(function(data){
            console.log(data)
            var postData = {
                token:token,
                country:"cn",//中国
                sourceUrl:sourceUrl,
                productTitle:data.productTitle,//gb2312
                sourceName:"天猫",
                type:"1",//新增
                productDesc:data.productDesc,//描述
                productPrice:data.productPrice,
                imgList:data.imgList,
                language:'zh-CHS'
            }
            submitApi(postData)
        },function(err){
            console.log(err)
            allProducts.crawlfailUrl.push(url)
            allProducts.failUrl.push(url)
            allProducts.failNum++
            ReturnApi()
        })
      }else if(url.indexOf("item.jd.com")!==-1){
          var that=this;
          console.log(url)
          
        jdApi(url).then(function(data){
            console.log(token)
            console.log(url)
            var postData = {
                token:token,
                country:"cn",//中国
                sourceUrl:sourceUrl,
                productTitle:data.productTitle,//gb2312
                sourceName:"京东",
                type:"1",//新增
                productDesc:data.productDesc,//描述
                productPrice:data.productPrice,
                imgList:data.imgList,
                language:'zh-CHS'
            }
           console.log(postData)
            submitApi(postData)
        },function(err){
            console.log(err)
            allProducts.crawlfailUrl.push(url)
            allProducts.failUrl.push(url)
            allProducts.failNum++
            ReturnApi()
        })
      }else if(url.indexOf('aliexpress.com/item')!==-1){
        var country="us" 
        var language="us"
        switch (url) {
            case url.indexOf('www.aliexpress.com') != -1:
                return country="us"//美语
                       language="us"
                break;
            case url.indexOf('ru.aliexpress.com') != -1:
                return country="ru"//俄罗斯语
                       language="ru"
                break;
            case url.indexOf('pt.aliexpress.com') != -1:
                return country="pt"//葡萄牙语
                       language="pt"
                break;
            case url.indexOf('es.aliexpress.com') != -1:
                return country="es"//西班牙语
                       language="es"
                break;
            case url.indexOf('fr.aliexpress.com') != -1:
                return country="fr"//法国
                       language="fr"
                break;
            case url.indexOf('de.aliexpress.com') != -1:
                return country="de"//德语
                        language="de"
                break;
                case url.indexOf('it.aliexpress.com') != -1:
                return country="it"//意大利语
                        language="it"
                break;
            case url.indexOf('ja.aliexpress.com') != -1:
                return country="jp"//日本语
                        language="jp"
                break;
            case url.indexOf('ko.aliexpress.com') != -1:
                return country="kr"//朝鲜语
                      language="kr"
                break;
            case url.indexOf('ar.aliexpress.com') != -1:
                return country="ar"//阿拉伯语
                        language="ar"
                break;
            case url.indexOf('nl.aliexpress.com') != -1:
                return country="nl"//荷兰语
                break;
            case url.indexOf('vi.aliexpress.com') != -1:
                return country="vi"//越南语
                        language="vi"
                break;
                case url.indexOf('th.aliexpress.com') != -1:
                return country="th"//泰国
                        language="th"
                break;
            case url.indexOf('tr.aliexpress.com') != -1:
                return country="tr"//土耳其
                      language="tr"
                break;
            case url.indexOf('he.aliexpress.com') != -1:
                return country="he"//希伯来
                        language="he"
                break;
            case url.indexOf('id.aliexpress.com') != -1:
                return country="id"//印尼
                        language="id"
                break;
            default:
                break;
        }
        aliApi(url).then(function(data){
            var postData = {
                token:token,
                country:country,
                sourceUrl:sourceUrl,
                productTitle:data.productTitle,//gb2312
                sourceName:"速卖通",
                type:"1",//新增
                productDesc:data.productDesc,//描述
                productPrice:data.productPrice,
                imgList:data.imgList,
                language:language,
            }
            submitApi(postData)
        },function(err){
            console.log(err)
            allProducts.crawlfailUrl.push(url)
            allProducts.failUrl.push(url)
            allProducts.failNum++
            ReturnApi()
        })
      }else{
         allProducts.crawlfailUrl.push(url)
         allProducts.failUrl.push(url)
         allProducts.failNum++
         ReturnApi()
      }
     
      
  };



function submitApi(params) {
    var that=this;
    Instance("product/general/operate",params).then(result => {
        console.log(result)
        if(result.data.code == "000") {
            allProducts.successNum++//成功url数量
        } else {
            allProducts.savefailUrl.push(url)
            allProducts.failUrl.push(url)
            allProducts.failNum++
        }
        console.log(allProducts.successNum)
        console.log(allProducts.failNum)
        console.log(allProducts.allNum)
        ReturnApi()
    }).catch(function(error) {
        console.log(error);
        ReturnApi()
    });
  
}


    
//    })
// }


//   module.exports = serverApi