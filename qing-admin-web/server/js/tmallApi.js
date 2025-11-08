const superagent = require('superagent');
const request = require('request');
require('superagent-proxy')(superagent);
require('superagent-charset')(superagent);
const cheerio = require('cheerio');
const Q = require('q');
const agent=require('./agent')//代理
const proxy = require('./proxy')//代理ip
const Global = require('./global')//公共js文件
const tmallApi = (url,token) => {
    var that=this;
    var deferred = Q.defer();

//   proxy(token).then(function(ip){
//     console.log("******************************ip"+ip)
//     init(url,ip)
//   },function(err){
//     init(url,"")
//   })
  init(url)
var urlIndex=0;
	function init(url) {
        url=encodeURI(url)
        // var url=""
        // var detailUrlReg=/id\=(\d*)&{1,1}/
        // if(detailUrl.match(detailUrlReg)&&detailUrl.match(detailUrlReg)[1]){
        //     url="https://detail.tmall.com/item.htm?id="+detailUrl.match(detailUrlReg)[1]
        // }else{
        //     deferred.reject("002");
        //     return false
        // }
        urlIndex++
		var headers = {            
			'User-Agent': agent,
            'Referer': 'https://toread.tmall.com',
            'accept': 'text/javascript, application/javascript, application/ecmascript, application/x-ecmascript, */*; q=0.01',
            'x-requested-with': 'XMLHttpRequest',
            'accept-encoding': 'gzip, deflate, br',
            'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8'
		}
		superagent.get(url)
            .charset('gbk')
           // .proxy("http://121.69.37.6:9797")
			.set({ "headers": headers })
			.end(function(err, sres) {
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
                    }else  if(err.status === 301) {
                        try{
                            const redirectUrl = err.response.headers.location;
                            init(redirectUrl)
                        }catch(err){
                          deferred.reject("002");
                        }
                    } else {
                      deferred.reject(err.status);
                    }
                }else{
                    if(sres.ok) {
                        //   var urlReg = /\"descUrl\"\:[\s]*\"(\S*[0-9])\"\,[\s]*\"httpsDescUrl?/;
                        //   var descUrl="http:"+sres.text.match(urlReg)[1]
                        //   that.getDetailFn(descUrl)
                        var $ = cheerio.load(sres.text);
                        var productTitle=""
                        var productPrice=""
                        var imgList=""
                        var productDesc=""
                        var imgarr=[]
                            if($("#page")&&$("#content")){
                                try{
                                    if( $("#J_DetailMeta")){//标题
                                        try{
                                            productTitle = $("#J_DetailMeta").find(".tb-detail-hd").children("h1").text();
                                        }catch(err){
                                            productTitle = ""	
                                        }
                                    }
                                   
                                    var TShopSetupReg = /TShop.Setup\(([\s\S]*)\);\s*}\)\(\);/;
                                    if(sres.text.match(TShopSetupReg)&&sres.text.match(TShopSetupReg)[1]){
                                        var TShopSetup = eval('(' + sres.text.match(TShopSetupReg)[1] + ')');
                                        try{
                                            price = TShopSetup.itemDO.reservePrice //价格
                                            if(price.indexOf('-') !== -1) { //价格是一个范围，取最大价格
                                                productPrice = price.split('-')[0]
                                            } else {
                                                productPrice = price
                                            }
                                        }catch(err){
                                            productPrice = "" //价格
                                        }
                                       
                                        if(TShopSetup.propertyPics!==undefined&&TShopSetup.propertyPics.default!==undefined){
                                            imgarr=TShopSetup.propertyPics.default
                                        }
                                    }
                                    try{
                                        var arrayli=$(".tb-img").children("li");
                                        Array.prototype.forEach.call(arrayli, function(ele, index) {
                                            var astyle=$(ele).find('a').attr("style")
                                            var iurl=""
                                            var bckReg=/background:url\(([\s\S]*)_\d{1,2}x\d{1,2}q\d{1,2}.jpg\)/
                                            if(astyle.match(bckReg)&&astyle.match(bckReg)[1]){
                                                iurl=astyle.match(bckReg)[1]
                                                imgarr.push(iurl)
                                            }
                                        })
                                    }catch(err){
                                        console.log(err)
                                    }
                                    try{
                                        var imgReg=/(\/\/\S*)_\d{1,2}x\d{1,2}q\d{1,2}.jpg/
                                          var array=$("#J_UlThumb").children("li");
                                          Array.prototype.forEach.call(array, function(ele, index) {
                                            var imgurl=$(ele).find('img').attr("src")
                                            if(imgurl.match(imgReg)&&imgurl.match(imgReg)[1]){
                                                var iurl=imgurl.match(imgReg)[1]
                                                imgarr.push(iurl)
                                            }
                                          })  
                                    }catch(err){
                                        console.log(err)
                                    }
                                    imgList=JSON.stringify(Global.uniq(imgarr))//轮播图
                                    if($("#J_AttrUL")){//描述
                                        try{
                                            productDesc = $("#J_AttrUL").text().replace(/\s{2,}/g, "\n");
                                        }catch(err){
                                            productDesc = productTitle
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
                                }catch(err){
                                    deferred.reject("002");
                                    
                                }
                                
                            }else{
                                deferred.reject("002");
                            }
                            
                    }
                }

			})

	}
	return deferred.promise;
}

module.exports = tmallApi