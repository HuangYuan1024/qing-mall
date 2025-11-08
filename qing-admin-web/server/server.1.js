

var iconv = require('iconv-lite');
const express = require('express')
// const router = express.Router()
const superagent = require('superagent')
var request = require('request');
require('superagent-proxy')(superagent);
require('superagent-charset')(superagent)
const cheerio = require('cheerio')
const Instance =require("./axios/index")
//var proxy = Proxy.GetProxy()
var proxy = "http://121.61.33.84:9999"
// router.use((req, res, next) => {
//     next()
// })
// const app = express()

var async = require('async'), 
    eventproxy = require('eventproxy');

var ep = new eventproxy(),
    urlsArray = [], //存放爬取网址
    pageUrls = [],  //存放收集页面网址
    pageNum = 1,  //要爬取的页数总数
    pageItems=40;  //每页的商品数目
    totalPageUrl = [];  
    
var allProducts={};//最后的结果



const serverApi = (router,superagent,cheerio) => {
  router.get('/crawl', (req, res) => {//获取url数组和类型
    var curCount = 0;
    allProducts.list=[]
    allProducts.allNum=0//总url数量
    allProducts.successNum=0//成功url数量
    allProducts.failNum=0;//失败

  var urlArr=req.query.detailUrl.split("\n");
  var reqType=req.query.type;
  var token=req.query.token;

//  var url="https://www.aliexpress.com/item/NEW-Design-Good-Deal-Fashion-Men-Coat-Jacket-Outwear-Sweater-Winter-Slim-Hoodie-Warm-Hooded-Sweatshirt/32955428068.html?spm=2114.search0103.3.1.34bb700brFGKXR&ws_ab_test=searchweb0_0,searchweb201602_5_10065_10068_10890_319_10546_10059_10884_317_10548_10887_10696_321_322_10084_453_10083_454_10103_10618_10307_537_536_10902,searchweb201603_55,ppcSwitch_0&algo_expid=3c7f4c38-7283-4caa-b395-247c034bd308-0&algo_pvid=3c7f4c38-7283-4caa-b395-247c034bd308"
//     var urlArr=url.split("\n");
//      var reqType=1;
//      var token="P07Qclgxt5HPT6MxjluBaloQm1xWRhJVY5ofXu5JWJ85otntXB8ZjtLvP2v8xE1LryQfGH+HMViMgFbl/8TeYC8jIVOyVI7tN43+dv8cC4hMSEXgPDvLgRbrZF7quatPW6No7YrYZvSkpqJIPnSTBfNCYYMKME6TsNEebdnZMJc="





  if(reqType==1){//如果是详情页、
      urlsArray = urlArr //存放爬取网址
      allProducts.allNum=urlsArray.length
      async.mapLimit(urlsArray, 10 ,function (url, callback) {
          productDetailFn(url, callback);
      }, function (err,result) {
          // pageNum 个 URL 访问完成的回调函数
          console.log('抓取结束');
      }); 

    
  }
  function productDetailFn(url,callback){//解析详情页
      //延迟毫秒数
      var delay = parseInt((Math.random() * 30000000) % 1000, 10);
      curCount++;
      console.log('现在的并发数是', curCount, '，正在抓取的是', '，耗时' + delay + '毫秒'); 
      if(url.indexOf("taobao")!==-1){
              taobaoFn(url)
      }else if(url.indexOf("tmall")!==-1){
          console.log("我是天猫")
              tmallFn(url)
      }else if(url.indexOf("jd")!==-1){
              jingdongFn(url)
      }else if(url.indexOf('aliexpress'!==-1)){
          console.log(url)
            aliexpressFn(url)
      }
      
  };


function submitFn(params){
    Instance("product/general/operate",params).then(result => {
        console.log(result)
        if(result.data.code == "000") {
            allProducts.successNum++//成功url数量
        } else {
            allProducts.failNum++
        }
        console.log(allProducts.successNum)
        console.log(allProducts.failNum)
        console.log(allProducts.allNum)
        if(allProducts.successNum+allProducts.failNum== allProducts.allNum){
            console.log("w我跑完了")
            var data=allProducts
            res.header('charset', 'utf8');
            res.header('Access-Control-Allow-Origin', '*');
            if(allProducts.successNum>0){
                return res.status(200).json({code:"000",message:"采集成功",failureReasons:"",data:data});
            }else{
                return res.status(200).json({code:"001",message:"采集失败",failureReasons:"数据库保存不成功",data:params});
            }
           
        }
        // res.send({code:result.data.code,message:result.data.message})
        // res.header('charset', 'utf8');
        // res.header('Access-Control-Allow-Origin', '*');
        // return res.status(200).json({code:result.data.code,message:result.data.message});
        
    }).catch(function(error) {
        console.log(error);
        res.send(error)
    });
  }
  function taobaoFn(url){//淘宝
     var that=this;
      superagent.get(url).charset('gbk').end(function(err,sres){
         if(sres.ok){
            
          //商品详情
        // var descUrlReg=/descUrl[\s]*:\s*([\s\S]*counterApi)/;
        // var descUrl=sres.text.match(descUrlReg)[1].split("//")[1].split("'")[0];
            // that.getDetailFn(descUrl)
            var location={

            }
            location.protocol=url.split('//')[0]
            var g_configReg=/var\s*g_config\s*=\s*([\s\S]*);\s*g_config.tadInfo\s*=\s*{/;
            console.log(sres.text.match(g_configReg)[1])
            var g_config = eval('(' + sres.text.match(g_configReg)[1] + ')');
           
            console.log(g_config)
            console.log(g_config.idata.item.auctionImages)
            // var mainImgReg=/auctionImages\s*:\s*(\[\s*[\s\S]*seller\s*:)/
            // var mainImg=sres.text.match(mainImgReg)[1].split("}")[0]
            var mainImg=g_config.idata.item.auctionImages;
            var $ = cheerio.load(sres.text);
            // var charset = "utf-8";
            // var arr = sres.text.match(/<meta([^>]*?)>/g);
            // if (arr) {
            //     arr.forEach(function (val) {
             //         var match = val.match(/charset\s*=\s*(.+)\"/);
            //         if (match && match[1]) {
            //             if (match[1].substr(0, 1) == '"')match[1] = match[1].substr(1);
            //             charset = match[1].trim();
            //         }
            //     })
            // }
                
              var productTitle=$("#J_Title").children(".tb-main-title").attr("data-title").replace(/\s/g,"");
            var sourceName="淘宝";
            var sourceUrl=url;//来源url
            var productDesc=$("#attributes").text().replace(/\s/g,"");//描述
            var productPrice=$("#J_StrPrice").find(".tb-rmb-num").text();
            
            console.log(productTitle)
      
            var postData = {
                token:token,
                productTitle:productTitle,//gb2312
                sourceName:sourceName,
                type:"1",//新增
                sourceUrl:sourceUrl,//来源url
                productDesc:productDesc,//描述
                productPrice:productPrice,
                imgList:JSON.stringify(mainImg)
            }
            console.log(postData)
            submitFn(postData)
         }else{
            res.header('charset', 'utf8');
            res.header('Access-Control-Allow-Origin', '*');
            var data=allProducts;
            return res.status(200).json({code:"002",message:"数据采集失败",failureReasons:"采集数据不成功",data:data});
         }
         
      })
  }

  function tmallFn(url){
    var headers = {
            'User-Agent':change_agent(),
            'Referer':'https://toread.tmall.com',
            'accept':'text/javascript, application/javascript, application/ecmascript, application/x-ecmascript, */*; q=0.01',
            'x-requested-with':'XMLHttpRequest',
            'accept-encoding':'gzip, deflate, br',
            'accept-language':'zh-CN,zh;q=0.9,en;q=0.8'
    }
      superagent.get(url)
      .charset('gbk')
      .set({"headers":headers})
      .end(function(err,sres){
          if(err){
              console.log(err)
              if (err.status === 302) {
                  const redirectUrl = err.response.headers.location;
                  console.log("重定向地址---------------------")
                  tmallFn(redirectUrl)
              } 
          }
          if(sres.ok){
            //   var urlReg = /\"descUrl\"\:[\s]*\"(\S*[0-9])\"\,[\s]*\"httpsDescUrl?/;
            //   var descUrl="http:"+sres.text.match(urlReg)[1]
            //   that.getDetailFn(descUrl)
              var $ = cheerio.load(sres.text);

              var productTitle= $("#J_DetailMeta").find(".tb-detail-hd").children("h1").text();

              var TShopSetupReg=/TShop.Setup\(([\s\S]*)\);\s*}\)\(\);/;
              console.log(sres.text.match(TShopSetupReg))
              var TShopSetup = eval('(' + sres.text.match(TShopSetupReg)[1] + ')');
                console.log(TShopSetup)
               var productPrice=TShopSetup.itemDO.reservePrice
               var mainImg=TShopSetup.propertyPics.default;
               console.log(productPrice)
            //var productPrice=""
              //var productDesc=$("#J_AttrList").text().replace(/(\r*)|(\n*)|(\t*)/g,'')

              var productDesc=$("#J_AttrUL").text().replace(/\s/g,"");
              var sourceName="天猫"
              var sourceUrl=url
            //   var mainImgReg=/propertyPics\s*"\s*:\s*([\s\S]*),\s*"tmallRateType/
            //   var mainArr=sres.text.match(mainImgReg)
            //   console.log(mainArr)
            //   var obj = eval('(' + mainArr[1] + ')');
            //   var mainImg=obj.default
            //console.log(mainImg)
              var postData = {
                token:token,
                productTitle:productTitle,//gb2312
                sourceName:sourceName,
                type:"1",//新增
                sourceUrl:sourceUrl,//来源url
                productDesc:productDesc,//描述
                productPrice:productPrice,
                imgList:JSON.stringify(mainImg)
            }
            console.log(postData)
            submitFn(postData)
                
          }
          //console.log(sres.text)
         
      })
  }

  function jingdongFn(url){//京东
    var urlReg=/item.jd.com\/(\d*)./
    var skuId=url.match(urlReg)[1]
    var headers = {
                'User-Agent':change_agent(),
                'referer':'https://item.jd.com/'+ skuId +'.html',
                'x-requested-with':'XMLHttpRequest',
                'accept-encoding':'gzip, deflate, br',
                'accept-language':'zh-CN,zh;q=0.9,en;q=0.8,en-US;q=0.7'
        }
      superagent.get(url).set({"headers":headers}).charset('gbk').end(function(err,sres){
          
          if(sres.ok){
              var $ = cheerio.load(sres.text);
              var productPrice="";
              var pageConfigReg=/var\s*pageConfig\s*=([\s\S]*);\s*try/;
              var pageConfig = eval('(' + sres.text.match(pageConfigReg)[1] + ')');
              console.log(sres.text.match(pageConfigReg))
              console.log(pageConfig)
              var cat=pageConfig.product.cat.join(",");
              console.log(cat)
              var area=Math.round(Math.random()*10)+'_'+Math.round(Math.random()*100)+'_'+Math.round(Math.random()*10000)+'_'+Math.round(Math.random()*10);
              //经测试area的格式为：2-4个下划线，随机数在1-11位之间
              request({
                url:    'https://c0.3.cn/stock?skuId='+ skuId +'&cat='+ cat +'&area='+area,   // 请求的URL
                method: 'GET',                   // 请求方法
                headers: {                       // 指定请求头
                     'User-Agent':change_agent(),
                     'referer':'https://item.jd.com/'+ skuId +'.html',
                }
              }, function (error, response, body) {
                if (!error && response.statusCode == 200) {
                  console.log(body) // 输出网页内容
                  var res= eval('(' + body + ')');
                  console.log(res.stock.jdPrice)
                  productPrice=res.stock.jdPrice.op;
                  //{op: "32.90", m: "32.90", id: "306825", p: "26.50"}
                }
              });


              var productTitle=$(".itemInfo-wrap").children(".sku-name").text().replace(/\s/g,"");
              var sourceName="京东";
              var sourceUrl=url;//来源url
              var productDesc=$(".p-parameter").children('ul').text().replace(/\s/g,"");//描述
            
              var mainImg=[];
              var ul=$("#spec-list").children("ul");
              $(ul).find('li').each(function() {
                mainImg.push($(this).children("img").attr("src"));
              });
              
              console.log(mainImg)
              console.log(productTitle)
             
              var postData = {
                  token:token,
                  productTitle:productTitle,//gb2312
                  sourceName:sourceName,
                  type:"1",//新增
                  sourceUrl:sourceUrl,//来源url
                  productDesc:productDesc,//描述
                  productPrice:productPrice,
                  imgList:JSON.stringify(mainImg)
              }
              console.log(postData)
              submitFn(postData)
          }
    
      })
  }
    
  function aliexpressFn(url){//速卖通
    var headers = {
                'User-Agent':change_agent(),
        }
      superagent.get(url).set({"headers":headers}).charset('gbk').end(function(err,sres){
          
          if(sres.ok){
              var $ = cheerio.load(sres.text);
              console.log(sres.text)
              console.log("完成")

            var sourceName="速卖通";
            var sourceUrl=url;//来源url
            var productTitle=$("#j-product-detail-bd").find("h1.product-name").text();
           
            var productPrice=""
            var price=$("#j-sku-price").text().replace(/\s/g,"");
            if(price.indexOf('-')!==-1){//价格是一个范围，取最大价格
                 productPrice=price.split('-')[1]
            }else{
                productPrice=price
            }
            console.log(productPrice)
            var desc=[]
            // var productDesc=$(".product-property-list").text().replace(/\s/g,"");//描述
            $(".product-property-list").children('li').each(function() {
                desc.push($(this).text().replace(/\s/g,""));
            });
            var productDesc=desc.join(',')
               var imageBigViewURLReg=/window.runParams.imageBigViewURL\s*=\s*([\s\S]*]);/;
            var mainImg= sres.text.match(imageBigViewURLReg)[1];
            console.log(mainImg)
              var postData = {
                  token:token,
                  productTitle:productTitle,//gb2312
                  sourceName:sourceName,
                  type:"1",//新增
                  sourceUrl:sourceUrl,//来源url
                  productDesc:productDesc,//描述
                  productPrice:productPrice,
                  imgList:mainImg
              }
              console.log(postData)
              submitFn(postData)
          }
    
      })
  }
  function change_agent(){//代理
    var change_agent=["Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36",  
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36",  
    "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:30.0) Gecko/20100101 Firefox/30.0",  
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/537.75.14",  
    "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Win64; x64; Trident/6.0)"  
    ] 
    return change_agent[Math.floor(Math.random()*change_agent.length)]
  }     
   })
}


  module.exports = serverApi