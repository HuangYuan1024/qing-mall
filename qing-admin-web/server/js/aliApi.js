const superagent = require('superagent')
var request = require('request');
require('superagent-proxy')(superagent);
require('superagent-charset')(superagent)
const cheerio = require('cheerio')
const Q = require('q');
const agent = require('./agent') //代理
const Global = require('./global') //公共js文件
const aliApi = (url) => {
    var deferred = Q.defer();
    init(url)
    var urlIndex = 0

    function init(url) {
        url = encodeURI(url)
        urlIndex++
        var headers = {            
            'User-Agent': agent,
            'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
            'accept-encoding': 'gzip, deflate, br',
            'accept-language': ' zh-CN,zh;q=0.9,en;q=0.8,en-US;q=0.7',
        }
        superagent.get(url)
            .charset('utf-8')
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

                        if ($("#alitalk-origin")) {
                            try {
                                if ($("#j-product-detail-bd")) { //标题
                                    try {
                                        productTitle = $("#j-product-detail-bd").find("h1.product-name").text();
                                    } catch (err) {
                                        productTitle = ""
                                    }
                                }
                                if ($("#j-sku-price")) { //价格
                                    try {
                                        var price = $("#j-sku-price").text().replace(/\s/g, "");
                                        if (price.indexOf('-') !== -1) { //价格是一个范围，取最大价格
                                            productPrice = price.split('-')[0]
                                        } else {
                                            productPrice = price
                                        }
                                    } catch (err) {
                                        productPrice = ""
                                    }

                                }
                                if ($(".product-property-list")) { //描述
                                    try {
                                        var desc = []
                                        $(".product-property-list").children('li').each(function() {
                                            desc.push($(this).text().replace(/\s/g, ""));
                                        });
                                        productDesc = desc.join('\n')
                                    } catch (err) {
                                        productDesc = ""
                                    }

                                }
                                var imgArr = []
                                try {
                                    var lunimg = ""
                                    var imageBigViewURLReg = /window.runParams.imageBigViewURL\s*=\s*([\s\S]*]);/;
                                    if (sres.text.match(imageBigViewURLReg) && sres.text.match(imageBigViewURLReg)[1]) {
                                        lunimg = sres.text.match(imageBigViewURLReg)[1]; //轮播图
                                        imgArr = JSON.parse(lunimg)
                                    }
                                } catch (err) {
                                    console.log(err)
                                }
                                try {
                                    var liArr = $("#j-sku-list-2").children("li");
                                    Array.prototype.forEach.call(liArr, function(ele, index) {
                                        var astyle = $(ele).children('a').children("img").attr("bigpic")
                                        imgArr.push(astyle)
                                    })

                                } catch (err) {
                                    console.log(err)
                                }
                                imgList = JSON.stringify(Global.uniq(imgArr))
                                if (productTitle !== "") {
                                    if (productDesc == "") {
                                        productDesc = productTitle
                                    }
                                    var postData = {
                                        productTitle: productTitle, //gb2312
                                        productDesc: productDesc, //描述
                                        productPrice: productPrice,
                                        imgList: imgList
                                    }
                                    deferred.resolve(postData)
                                } else {
                                    deferred.reject("002");
                                }
                            } catch (err) {
                                deferred.reject("002")

                            }

                        } else {
                            deferred.reject("002")
                        }
                    }
                }

            })

    }
    return deferred.promise;

}

module.exports = aliApi