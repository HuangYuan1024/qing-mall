const superagent = require('superagent')
var request = require('request');
require('superagent-proxy')(superagent);
require('superagent-charset')(superagent)
const cheerio = require('cheerio')
const Q = require('q');
const agent = require('./agent') //代理
const Global = require('./global') //公共js文件
const jdApi = (url) => {

    var deferred = Q.defer();
    init(url)
    var urlIndex = 0

    function init(url) {
        url = encodeURI(url)
        urlIndex++
        var urlReg = /item.jd.com\/(\d*)./
        var skuId = ""
        if (url.match(urlReg) && url.match(urlReg)[1]) {
            skuId = url.match(urlReg)[1]
        }
        var headers = {             
            'User-Agent': agent,
                    'referer': 'https://item.jd.com/' + skuId + '.html',
            'x-requested-with': 'XMLHttpRequest',
                    'accept-encoding': 'gzip, deflate, br',
                    'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8,en-US;q=0.7'
        }
        superagent.get(url)
            .charset('gbk')
            .set({ "headers": headers })
            .end(function(err, sres) {
                if (err) {
                    if (err.status === 302) {
                        try {
                            if (urlIndex < 2) {
                                const redirectUrl = err.response.headers.location;
                                init(redirectUrl)
                            } else {
                                deferred.reject("002");
                            }
                        } catch (err) {
                            deferred.reject("002");
                        }
                    } else {
                        deferred.reject(err.status);
                    }
                } else {
                    if (sres.ok) {
                        var $ = cheerio.load(sres.text);
                        var productTitle = ""
                        var productPrice = ""
                        var imgList = ""
                        var productDesc = ""
                        if ($(".itemInfo-wrap")) { //标题
                            if ($(".itemInfo-wrap").children(".sku-name")) {
                                try {
                                    productTitle = $(".itemInfo-wrap").children(".sku-name").text().replace(/\s/g, "");
                                } catch (err) {
                                    productTitle = ""
                                }

                            }
                        }

                        if ($(".p-parameter")) { //描述
                            if ($(".p-parameter").children('ul')) {
                                try {
                                    productDesc = $(".p-parameter").children('ul').text().replace(/\s{2,}/g, "\n");
                                } catch (err) {
                                    productDesc = productTitle
                                }

                            }
                        }
                        var mainImg = [];
                        if ($("#spec-list")) { //轮播图
                            try {
                                var ul = $("#spec-list").children("ul");
                                $(ul).find('li').each(function() {
                                    var u = "http://img11.360buyimg.com/n1/s1000x1000_" + $(this).children("img").attr("data-url")
                                    mainImg.push(u);
                                });
                            } catch (err) {
                                console.log(err)
                            }
                        }
                        try {
                            var bckReg = /([\s\S]*)!cc_/
                            var arrayli = $("#choose-attr-1").find(".item");
                            Array.prototype.forEach.call(arrayli, function(ele, index) {
                                var imgu = $(ele).find("img").attr("src")
                                if (imgu.match(bckReg) && imgu.match(bckReg)[1]) {
                                    var cc = imgu.match(bckReg)[1].replace(/n9\/\S*\/t1/g, "n1/s1000x1000_jfs/t1")
                                    mainImg.push(cc);
                                } else {
                                    mainImg.push(imgu.replace(/n9\/\S*\/t1/g, "n1/s1000x1000_jfs/t1"));
                                }
                            })

                        } catch (err) {
                            console.log(err)
                        }
                        imgList = JSON.stringify(Global.uniq(mainImg))

                        //经测试area的格式为：2-4个下划线，随机数在1-11位之间
                        var area = Math.round(Math.random() * 10) + '_' + Math.round(Math.random() * 100) + '_' + Math.round(Math.random() * 10000) + '_' + Math.round(Math.random() * 10);

                        function priceFn() {
                            var deferred1 = Q.defer();
                            try {
                                var pageConfigReg = /var\s*pageConfig\s*=([\s\S]*);\s*try/;
                                if (sres.text.match(pageConfigReg) && sres.text.match(pageConfigReg)[1]) { //价格
                                    var pageConfig = eval('(' + sres.text.match(pageConfigReg)[1] + ')');
                                    var cat = pageConfig.product.cat.join(",");
                                    // request.buffer(true)({
                                    //   url: 'https://c0.3.cn/stock?skuId=' + skuId + '&cat=' + cat + '&area=' + area, // 请求的URL
                                    //   method: 'GET', // 请求方法
                                    //   headers: { // 指定请求头
                                    //      
                                    //     'User-Agent': agent,
                                    //      'referer': 'https://item.jd.com/' + skuId + '.html',
                                    //   },

                                    // }, function(error, response, body) {
                                    //   if(!error && response.statusCode == 200) {
                                    //     if(body) {
                                    //       var res = eval('(' + body + ')');
                                    //       productPrice = res.stock.jdPrice.op;
                                    //       deferred1.resolve(productPrice)
                                    //       //{op: "32.90", m: "32.90", id: "306825", p: "26.50"}
                                    //     }

                                    //   }else{
                                    //     productPrice=""
                                    //     deferred1.reject(productPrice);
                                    //   }
                                    // });
                                    try {
                                        var headers1 = { // 指定请求头
                                             
                                            'User-Agent': agent,
                                             'referer': 'https://item.jd.com/' + skuId + '.html',
                                        }
                                        superagent.get('https://c0.3.cn/stock?skuId=' + skuId + '&cat=' + cat + '&area=' + area)
                                            .buffer(true)
                                            .set({ "headers": headers1 })
                                            .end(function(err, sres) {
                                                if (!err) {
                                                    var res = eval('(' + sres.text + ')');
                                                    if (res.stock.jdPrice) {
                                                        productPrice = res.stock.jdPrice.p;
                                                        deferred1.resolve(productPrice)
                                                    } else {
                                                        productPrice = ""
                                                        deferred1.reject(productPrice);
                                                    }

                                                } else {
                                                    productPrice = ""
                                                    deferred1.reject(productPrice);
                                                }

                                            })
                                    } catch (err) {
                                        productPrice = ""
                                    }



                                }
                            } catch (err) {
                                productPrice = ""
                                deferred1.reject(productPrice);
                            }
                            return deferred1.promise;
                        }


                        if (productTitle !== "") {
                            if (productDesc == "") {
                                productDesc = productTitle
                            }
                            priceFn().then(function(productPrice) {
                                var postData = {
                                    productTitle: productTitle, //gb2312
                                    productDesc: productDesc, //描述
                                    productPrice: productPrice,
                                    imgList: imgList
                                }
                                deferred.resolve(postData)
                            }, function(productPrice) {
                                var postData = {
                                    productTitle: productTitle, //gb2312
                                    productDesc: productDesc, //描述
                                    productPrice: productPrice,
                                    imgList: imgList
                                }
                                deferred.resolve(postData)
                            })

                        } else {
                            deferred.reject("002");
                        }

                    }
                }

            })

    }
    return deferred.promise;

}
module.exports = jdApi