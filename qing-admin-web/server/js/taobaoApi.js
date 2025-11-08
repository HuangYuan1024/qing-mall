const superagent = require('superagent')
var request = require('request');
require('superagent-proxy')(superagent);
require('superagent-charset')(superagent)
const cheerio = require('cheerio')
const Q = require('q');
const agent=require('./agent')//代理
const proxy = require('./proxy')//代理ip
const Global = require('./global')//公共js文件

const taobaoApi = (url,token) => {
  var deferred = Q.defer();
  
  // proxy(token).then(function(ip){
  //   console.log("******************************ip"+ip)
  //   init(url,"http://113.102.165.106")
  // },function(err){
  //   init(url,"")
  // })
  // var time = false;//是否超时
  // var timer = setTimeout(function(){
  //     timeout = true;
  //     superagent.abort();//请求中止
  // },3000);


  init(url,"")
  var urlIndex=0;
	function init(url,ip) {
    url=encodeURI(url)
    urlIndex++
		var headers = {            
      'User-Agent': agent,
      'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
      'accept-encoding': 'gzip, deflate, br',
      'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8,en-US;q=0.7',
		}
		superagent.get(url)
      .charset('gbk')
      //.proxy("https://125.123.139.228:9000")
      .set({ "headers": headers })
			.end(function(err, sres) {
        // if(timeout) return;//忽略中止请求
        // clearTimeout(timer);//取消等待的超时

        if(err){
          if(err.status === 302) {
            try{
              if(urlIndex<2){
                  const redirectUrl = err.response.headers.location;
                  init(redirectUrl)
              }else{
                  deferred.reject("002");
              }
              
            }catch(err){
              deferred.reject("002");
            }
        } else {
          deferred.reject(err.status);
        }
        }else{
          if(sres.ok) {
            var $ = cheerio.load(sres.text);
            var productTitle = ""
            var productPrice = ""
            var imgList = ""
            var productDesc = ""
            var imgarr=[]
            try{
              var location = {}
              location.protocol = url.split('//')[0]
              var g_configReg = /var\s*g_config\s*=\s*([\s\S]*);\s*g_config.tadInfo\s*=\s*{/;
              if(sres.text.match(g_configReg) && sres.text.match(g_configReg)[1]) { //图片
                var g_config = eval('(' + sres.text.match(g_configReg)[1] + ')');
                // var mainImgReg=/auctionImages\s*:\s*(\[\s*[\s\S]*seller\s*:)/
                // var mainImg=sres.text.match(mainImgReg)[1].split("}")[0]
                if(g_config.idata!==undefined&&g_config.idata.item!==undefined&&g_config.idata.item.auctionImages!==undefined){
                  imgarr=g_config.idata.item.auctionImages
                }
              }
            }catch(err){
             console.log(err)
            }
            try{
              var arrayli=$(".tb-img").children("li");
              Array.prototype.forEach.call(arrayli, function(ele, index) {
                var astyle=$(ele).find('a').attr("style")
                var iurl=""
                var bckReg=/background:url\(([\s\S]*)_\d{1,2}x\d{1,2}.jpg\)/
                if(astyle.match(bckReg)&&astyle.match(bckReg)[1]){
                    iurl=astyle.match(bckReg)[1]
                    imgarr.push(iurl)
                }
              })
             
            }catch(err){
              console.log(err)
            }
            imgList=JSON.stringify(Global.uniq(imgarr))
            if($("#J_Title")) { //标题
              try{
                productTitle = $("#J_Title").children(".tb-main-title").attr("data-title").replace(/\s/g, "");
              }catch(err){
                productTitle = ""
              }
            
            }

            if($("#attributes")) { //描述
              try{
                productDesc = $("#attributes").text().replace(/\s{2,}/g, "\n"); //描述
              }catch(err){
                productDesc = productTitle
              }
            
            }

            if($("#J_StrPrice")) { //价格
              try{
                price = $("#J_StrPrice").find(".tb-rmb-num").text();
                if(price.indexOf('-') !== -1) { //价格是一个范围，取最大价格
                    productPrice = price.split('-')[0]
                } else {
                    productPrice = price
                }
              }catch(err){
                productPrice =""
              }
          
            }
            if(productTitle!==""){
              if(productDesc==""){
                productDesc=productTitle
              }
              var postData = {
                productTitle: productTitle, //gb2312
                productDesc: productDesc, //描述
                productPrice: productPrice,
                imgList: imgList
              }
              deferred.resolve(postData)
            }else{
              deferred.reject("002");
            }
          
          }
      }

			})

	}
	return deferred.promise;

}

module.exports = taobaoApi