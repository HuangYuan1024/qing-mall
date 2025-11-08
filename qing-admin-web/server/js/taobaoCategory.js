const superagent = require('superagent')
var request = require('request');
require('superagent-proxy')(superagent);
require('superagent-charset')(superagent)
const cheerio = require('cheerio')
const Q = require('q');
const agent=require('./agent')//代理
const proxy = require('./proxy')//代理ip

// const taobaoCategory = (url,token) => {


var url="https://shop432580588.taobao.com/category-1366113403.htm?spm=2013.1.w5002-18034302642.4.32517b65gd5Jk4&search=y&catName=T%D0%F4"
  var deferred = Q.defer();
  var shopReg=/shop([\d]*).taobao.com/
  var shopId=""
  if(url.match(shopReg)&&url.match(shopReg)[1]){
    shopId=url.match(shopReg)[1]
  }

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
            try{
              var list=document.querySelectorAll('.item');
              pageOperation(list)

            }catch(err){
              if(shopId!==""){
                var asynSearchUrl="https://shop"+ shopId +".taobao.com"+$("#J_ShopAsynSearchURL").val()
                asynSearchFn(asynSearchUrl)
              }else{
                deferred.reject(err);
              }
            }
          

          
          }
      }

			})

  }
  
  function asynSearchFn(url) {
		var headers = {            
      'User-Agent': agent,
      'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
      'accept-encoding': 'gzip, deflate, br',
      'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8,en-US;q=0.7',
      "cookie":"cna=9mTxFHlvkDoCAbcLRZZJETzF; thw=cn; miid=1186467057351949889; hng=CN%7Czh-CN%7CCNY%7C156; t=9d13ac58b3fd51c1259b30f3f149dd18; tracknick=%5Cu5B89%5Cu68A8%5Cu85B0; lgc=%5Cu5B89%5Cu68A8%5Cu85B0; tg=0; x=e%3D1%26p%3D*%26s%3D0%26c%3D0%26f%3D0%26g%3D0%26t%3D0%26__ll%3D-1%26_ato%3D0; UM_distinctid=1692e50e6de3f2-09c94558237b9f-58422116-1fa400-1692e50e6df499; _tb_token_=eeb365e903e3d; v=0; dnk=%5Cu5B89%5Cu68A8%5Cu85B0; swfstore=289108; _m_h5_tk=0733ee99b4b24298938903a27f2c2249_1551961486915; _m_h5_tk_enc=23c1d2875d2a216f5b49bbde83a99545; sg=%E8%96%B09c; _l_g_=Ug%3D%3D; csg=1d5a0224; existShop=MTU1MTk1MjUwNg%3D%3D; _cc_=URm48syIZQ%3D%3D; _nk_=%5Cu5B89%5Cu68A8%5Cu85B0; mt=ci=56_1&np=; pnm_cku822=098%23E1hvF9vUvbpvUvCkvvvvvjiPRLzylj3EPszp0jljPmPZAjYbPLMv6jnhnLsZ6jt8RphvChCvvvvPvpvhvv2MMqyCvm3vpvvvvvCvihCvmhIvvhnwphvwv9vvBj1vpCQmvvChxhCvVHOvvhPxkphvCyEmmvofe8yCvv3vpvoDuGgzMvyCvh12m0yvI1yaWoyZD76Xd5YRwhLpQC04aZ107reYr2E9Zj%2BO3w0AhjH2J9kx6fItb9gDN%2BLpditrcVQEfwkK5kx%2FwZnlYETJEct1Bc7QvphvCyCCvvvvv8wCvvBvpvpZ; uc1=cookie16=W5iHLLyFPlMGbLDwA%2BdvAGZqLg%3D%3D&cookie21=U%2BGCWk%2F7owY3i1vB2tkCkg%3D%3D&cookie15=WqG3DMC9VAQiUQ%3D%3D&existShop=true&pas=0&cookie14=UoTZ5bor7omhIQ%3D%3D&tag=8&lng=zh_CN; l=bBM8Ki47vIIFWGLzBOCNCuI8aG7OSIRAguPRwNqXi_5Bd1T_ls_OlsEBpe96Vj5R_xTB4xWabNe9-etui; isg=BBQUx3_6NEfH06A_Nl21ImBR5VJGxTg8FRmFDK71oB8imbTj1n0I58qbmdGkYXCv; whl=-1%260%260%261551953430341",
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
            console.log(sres.text)
            
            try{
              var domReg=/jsonp\d*\("[\s\S]*"\)/
            if(sres.text.match(domReg) && sres.text.match(domReg)[1]) {
              // var domHtml = eval('(' + sres.text.match(domReg)[1] + ')');
              var domHtml=sres.text.match(domReg)[1]
              console.log(domHtml)
              var $ = cheerio.load(domHtml);
              var list=document.querySelectorAll('.item');
              pageOperation(list)
            }
           
            }catch(err){
              deferred.reject(err);
            }
          

          
          }
      }

			})

  }
  function pageOperation(list){
      var urlArr=[]
      Array.prototype.forEach.call(list, function(ele, index) {
        var obj={}
        if( ele.querySelector('.detail')){
          if(ele.querySelector('.detail').querySelector(".item-name")){
              obj="https:"+ele.querySelector('.detail').querySelector(".item-name").getAttribute('href')
              var arr = Object.keys(obj);
              if(arr.length==0){
                var id=ele.getAttribute('data-id')
                obj='https://item.taobao.com/item.htm?id='+id
                urlArr.push(obj)
              }else{
                urlArr.push(obj)
              }
          }
        }
    })
    console.log(urlArr)
    deferred.resolve(urlArr)
  }
	return deferred.promise;

// }

// module.exports = taobaoCategory