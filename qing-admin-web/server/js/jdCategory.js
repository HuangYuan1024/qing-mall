const superagent = require('superagent')
var fs = require('fs');
var request = require('request');
require('superagent-proxy')(superagent);
require('superagent-charset')(superagent)
const cheerio = require('cheerio')
const Q = require('q');
const agent=require('./agent')//代理
const proxy = require('./proxy')//代理ip

var url="https://mall.jd.com/view_search-681369-9857502-99-1-20-1.html"


// const jdCategory = (url,token) => {
   var deferred = Q.defer();
  // var shopReg=/shop([\d]*).taobao.com/
  // var shopId=""
  // if(url.match(shopReg)&&url.match(shopReg)[1]){
  //   shopId=url.match(shopReg)[1]
  // }

  var urlArr=[]//抓取的url数组
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

	function init(url,ip) {
		var headers = {            
      ':authority': 'mall.jd.com',
      ':method': 'GET',
      ':path':' /view_search-681369-9857502-99-1-20-1.html',
      ':scheme': 'https',
      'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
     ' accept-encoding': 'gzip, deflate, br',
      'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8,en-US;q=0.7',
      'cache-control': 'max-age=0',
     // 'cookie': 'shshshfpa=00726e02-92ac-845f-5d2e-7ba32a7d5b29-1550483266; shshshfpb=kGNEaLamTBcRS9doIdpNoZg%3D%3D; ipLoc-djd=1-72-4137-0; ipLocation=%u5317%u4EAC; user-key=640d3394-f39d-4737-a961-b318d6f08324; cn=0; PCSYCityID=1607; unpl=V2_ZzNtbUAESxNwABIBeBBUB2JXE1sRUEYXIAhPV38cCAYwBEVdclRCFX0UR1ZnGFsUZwUZWUJcQB1FCEdkeBBVAWMDE1VGZxBFLV0CFSNGF1wjU00zQwBBQHcJFF0uSgwDYgcaDhFTQEJ2XBVQL0oMDDdRFAhyZ0AVRQhHZHsbWQ1mAxNZQ1FzJXI4dmR4H1gAYQciXHJWc1chVENTeBFVACoDEFhKVkMUcQlAZHopXw%3d%3d; __jdc=122270672; __jdu=1349010507; __jdv=122270672|baidu-pinzhuan|t_288551095_baidupinzhuan|cpc|0f3d30c8dba7459bb52f2eb5eba8ac7d_0_3b9749ed28934e07b643d18254e2f6f1|1551926353515; _gcl_au=1.1.582778760.1551927406; shshshfp=23cfef96cf17bfd6177064cbe1bb6362; 3AB9D23F7A4B3C9B=LCQWLBORUPNJUXER7QXXYSLIWOYRG2QNS335Q7S2K7E3PLJE6KHSNX7ZOMFIO4NULXNMNNRS7BAZGHHFQUIILUH4UU; __jda=122270672.1349010507.1550483265.1551926353.1551941538.16; JSESSIONID=B297D07BF297A9827790A57B60B6B616.s1',
      'if-modified-since': 'Thu, 07 Mar 2019 06:45:01 GMT',
      'upgrade-insecure-requests': '1',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36',
		}
		superagent.get(url)
      //.charset('gbk')
      //.proxy("https://125.123.139.228:9000")
      .set({ "headers": headers })
			.end(function(err, sres) {
        // if(timeout) return;//忽略中止请求
        // clearTimeout(timer);//取消等待的超时

        if(err){
          if(err.status === 302) {
            try{
                const redirectUrl = err.response.headers.location;
                console.log("重定向地址---------------------")
                init(redirectUrl)
            }catch(err){
              deferred.reject("002");
            }
        } else {
          deferred.reject(err.status);
        }
        }else{
          if(sres.ok) {
            var $ = cheerio.load(sres.text);
            //var url="https://module-jshop.jd.com/module/getModuleHtml.html?
            //appId=681369
            // &orderBy=99
            // &pageNo=1
            // &direction=1
            // &categoryId=9857502
            // &pageSize=20
            // &pagePrototypeId=8

            // &pageInstanceId=69347790
            // &moduleInstanceId=149662807
            // &prototypeId=55555
            // &templateId=905542
            // &layoutInstanceId=149662807
            // &origin=0
            //&shopId=1000087228
            // &venderId=1000087228
            // &callback=jshop_module_render_callback
            // &_=1551867246258"
            
            
            try{
              var paramsReg=/var\s*params\s*=\s*([\s\S]*)\|\|/
              var params=null
              var moduleUrl=null
           
              //console.log(sres.text)
              if(sres.text.match(paramsReg)&&sres.text.match(paramsReg)[1]){
                params= eval('(' + sres.text.match(paramsReg)[1] + ')');
                //{"appId":"681369","orderBy":"99","pageNo":"1","direction":"1","categoryId":"9857502","pageSize":"20","pagePrototypeId":"8"}
                // var eleArr=$(".m_render_structure");
                // var len=eleArr.length;
                // Array.prototype.forEach.call(eleArr, function(ele, index) {
                //     var query={}
                //     var obj=params
                //     obj.pageInstanceId = $("#pageInstance_id").val();
                //     obj.moduleInstanceId=$(ele).attr("m_render_instance_id")  
                //     obj.prototypeId=$(ele).attr("m_render_prototype_id")  
                //     obj.templateId = $(ele).attr('m_render_template_id');
                //     obj.appId =$(ele).attr('m_render_app_id');
                //     obj.layoutInstanceId = $(ele).attr('m_render_layout_instance_id');
                //     obj.origin = $(ele).attr('m_render_origin');
                //     obj.shopId = $("#shop_id").val();
                //     obj.venderId = $("#vender_id").val();
                //     query=obj
                //     obj = paramToString(obj);
                //     var isSearchModule = $(ele).attr('m_render_is_search');
                //     var url = null;
                //     if(isSearchModule && isSearchModule == "true"){
                //         url = "https://module-jshop.jd.com/module/getModuleHtml.html";
                //     }else{
                //         url = "https://mall.jd.com/view/getModuleHtml.html";
                //     }
                //     query.callback="jshop_module_render_callback"
                //    var moduleUrl=url + '?' + params + '&callback=jshop_module_render_callback'+'&_='+(new Date()).getTime()
                //    console.log(index)
                //    if(index==len-1){
                //       asynSearchFn(moduleUrl,query,true)
                //    }else{
                //      asynSearchFn(moduleUrl,query,false)
                //    }
                   
                // })
                var ele=$(".m_render_structure");
                var len=ele.length;
                params.pageInstanceId = $("#pageInstance_id").val();
                params.moduleInstanceId=ele.eq(len-1).attr("m_render_instance_id")  
                params.prototypeId=ele.eq(len-1).attr("m_render_prototype_id")  
                params.templateId = ele.eq(len-1).attr('m_render_template_id');
                params.appId = ele.eq(len-1).attr('m_render_app_id');
                params.layoutInstanceId = ele.eq(len-1).attr('m_render_layout_instance_id');
                params.origin = ele.eq(len-1).attr('m_render_origin');
                params.shopId = $("#shop_id").val();
                params.venderId = $("#vender_id").val();
                //params.callback='jshop_module_render_callback'
                params._=(new Date()).getTime()
                query=params
                params = paramToString(params);
                var isSearchModule = ele.eq(len-1).attr('m_render_is_search');
                var url = null;
                if(isSearchModule && isSearchModule == "true"){
                    url = "https://module-jshop.jd.com/module/getModuleHtml.html";
                }else{
                    url = "https://mall.jd.com/view/getModuleHtml.html";
                }
                moduleUrl=url + '?' + params
                asynSearchFn(moduleUrl,query,true)

               }

              

            }catch(err){

              
            }
          

          
          }
      }

			})

  }
  function paramToString(para){//对象重组成链接参数
    var result = [];

    for(var a in para){
        result.push(a + '=' + para[a]);
    }
    return result.join('&');
}



  function asynSearchFn(url,query,handle) {
    //var Cookie = fs.readFile('./server/js/cookies.txt');
    var Cookie="shshshfpb=kGNEaLamTBcRS9doIdpNoZg%3D%3D; shshshfp=23cfef96cf17bfd6177064cbe1bb6362; shshshfpa=a6202e73-12fb-3849-6179-8ea4dc50f9f4-1551951297; shshshsID=45bce752f9fa38bcbc174d0341c5ba53_1_1551951297599; __jda=122270672.15519512977841644072610.1551951298.1551951298.1551951298.1; __jdb=122270672.1.15519512977841644072610|1.1551951298; __jdc=122270672; __jdv=122270672|direct|-|none|-|1551951297785"
    console.log(Cookie)
		var headers = {            
      'Accept':' */*',
     ' Accept-Encoding': 'gzip, deflate, br',
      'Accept-Language':' zh-CN,zh;q=0.9,en;q=0.8,en-US;q=0.7',
      'Connection': 'keep-alive',
      'Cookie': Cookie,
      'Host': 'module-jshop.jd.com',
      'Referer': 'https://mall.jd.com/view_search-681369-9857502-99-1-20-1.html',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36'
		}
		superagent.get(url)
      .charset('gbk')
      //.proxy("https://125.123.139.228:9000")
      .set({ "headers": headers })
      .query(query)
			.end(function(err, sres) {
        console.log(url)
        // if(timeout) return;//忽略中止请求
        // clearTimeout(timer);//取消等待的超时

        if(err){
          if(err.status === 302) {
            try{
                const redirectUrl = err.response.headers.location;
                console.log("重定向地址---------------------")
                asynSearchFn(redirectUrl)
            }catch(err){
              deferred.reject("002");
            }
        } else {
          deferred.reject(err.status);
        }
        }else{
          if(sres.ok) {
            
            if(handle){
              console.log(sres.text)

            }
            console.log("完成")
            
            try{
            //   var domReg=/jshop_module_render_callback\d*\("[\s\S]*"\)/
            // if(sres.text.match(domReg) && sres.text.match(domReg)[1]) {
            //   // var domHtml = eval('(' + sres.text.match(domReg)[1] + ')');
            //   var domHtml=sres.text.match(domReg)[1]
            //   console.log(domHtml)
            //   var $ = cheerio.load(domHtml);
            //   var list=document.querySelectorAll('.item');
            //   pageOperation(list)
            //}
           
            }catch(err){
              deferred.reject(err);
            }
          

          
          }
      }

			})

  }
  function pageOperation(list){
      // var urlArr=[]
      // Array.prototype.forEach.call(list, function(ele, index) {
      //   var obj={}
      //   if( ele.querySelector('.detail')){
      //     if(ele.querySelector('.detail').querySelector(".item-name")){
      //         obj="https:"+ele.querySelector('.detail').querySelector(".item-name").getAttribute('href')
      //         var arr = Object.keys(obj);
      //         if(arr.length==0){
      //           var id=ele.getAttribute('data-id')
      //           obj='https://item.taobao.com/item.htm?id='+id
      //           urlArr.push(obj)
      //         }else{
      //           urlArr.push(obj)
      //         }
      //     }
      //   }
    // })
    // console.log(urlArr)
    // deferred.resolve(urlArr)
  }
	return deferred.promise;

// }

// module.exports = jdCategory