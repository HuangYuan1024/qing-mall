const superagent = require('superagent');
const request = require('request');
require('superagent-proxy')(superagent);
require('superagent-charset')(superagent);
const cheerio = require('cheerio');
const Q = require('q');
const agent = require('./agent') //代理
const proxy = require('./proxy') //代理ip
const Global = require('./global') //公共js文件
const alibabaApi = (url, token) => {
    var that = this;
    var deferred = Q.defer();

    //   proxy(token).then(function(ip){
    //     console.log("******************************ip"+ip)
    //     init(url,ip)
    //   },function(err){
    //     init(url,"")
    //   })

    init(url)
    var urlIndex = 0;

    function init(url) {
        url = encodeURI(url)
        urlIndex++
        var headers = {            
            'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            'accept-encoding': 'gzip, deflate, sdch, br',
            'accept-language': 'zh-CN,zh;q=0.8',
            'referer': url,
            'upgrade-insecure-requests': '1',
        }
        superagent.get(url)
            .charset('gbk')
            // .proxy("http://121.69.37.6:9797")
            .set({ "headers": headers })
            .end(function(err, sres) {
                if (err) {
                    if (err.status === 302) {
                        try {
                            if (urlIndex < 3) {
                                const redirectUrl = err.response.headers.location;

                                init(redirectUrl)
                            } else {
                                deferred.reject("002");
                            }

                        } catch (err) {
                            deferred.reject("002");
                        }
                    } else if (err.status === 301) {
                        try {
                            const redirectUrl = err.response.headers.location;
                            init(redirectUrl)
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
                        var imgarr = []
                        if ($("#content")) {
                            try {
                                if ($("#mod-detail-title")) { //标题
                                    try {
                                        productTitle = $("#mod-detail-title").find("h1.d-title").text();
                                    } catch (err) {
                                        productTitle = ""
                                    }
                                }
                                if ($("tr.price")) { //价格
                                    try {
                                        priceLi = $("tr.price").find("td");
                                        var priceArr = [];
                                        Array.prototype.forEach.call(priceLi, function(ele, index) {
                                            if ($(ele).find(".value").length > 0) {
                                                var eleArr = $(ele).find(".value")
                                                Array.prototype.forEach.call(eleArr, function(e, c) {
                                                    priceArr.push($(e).text())
                                                })
                                            }
                                        })
                                        productPrice = priceArr[0]
                                    } catch (err) {
                                        productPrice = ""
                                    }

                                }
                                if (productPrice == "") {
                                    try {
                                        try {
                                            var price1 = $(".obj-price").find("del").text();
                                            if (price1 !== "") {
                                                productPrice = price1.replace(/[^\d.]/g, "")
                                            }
                                        } catch (err) {
                                            productPrice = ""
                                        }
                                        if (productPrice == "") {
                                            try {
                                                var price = $(".obj-price").find(".price-now").text();
                                                if (price.split("-") && price.split("-")[0]) {
                                                    productPrice = price.split("-")[0]
                                                }
                                            } catch (err) {
                                                productPrice = ""
                                            }
                                        }


                                    } catch (err) {
                                        productPrice = ""
                                    }
                                }
                                if ($("#dt-tab")) { //轮播图
                                    try {

                                        var arrayli = $("#dt-tab").find(".nav-tabs li");
                                        Array.prototype.forEach.call(arrayli, function(ele, index) {
                                            var astyle = $(ele).attr("data-imgs")
                                            astyle = eval('(' + astyle + ')')
                                            var iurl = astyle.original
                                            imgarr.push(iurl)
                                        })


                                    } catch (err) {
                                        console.log(err)
                                    }
                                }
                                try {
                                    var array = $(".list-leading").children("li");
                                    Array.prototype.forEach.call(array, function(ele, index) {
                                        if ($(ele).find('.unit-detail-spec-operator').attr("data-imgs") !== undefined) {
                                            var astyle = $(ele).find('.unit-detail-spec-operator').attr("data-imgs")
                                            astyle = eval('(' + astyle + ')')
                                            var iurl = astyle.original
                                            imgarr.push(iurl)
                                        }


                                    })
                                } catch (err) {
                                    console.log(err)
                                }
                                try {
                                    var array = $(".table-sku").find("tr");
                                    Array.prototype.forEach.call(array, function(ele, index) {
                                        if ($(ele).find('.image').attr("data-imgs") !== undefined) {
                                            var astyle = $(ele).find('.image').attr("data-imgs")
                                            astyle = eval('(' + astyle + ')')
                                            var iurl = astyle.original
                                            imgarr.push(iurl)
                                        }

                                    })
                                } catch (err) {
                                    console.log(err)
                                }
                                imgList = JSON.stringify(Global.uniq(imgarr)) //轮播图
                                if ($("#mod-detail-attributes")) { //描述
                                    try {
                                        var titleArr = $("#mod-detail-attributes").children(".obj-content").find(".de-feature");
                                        var deseArr = $("#mod-detail-attributes").children(".obj-content").find(".de-value");
                                        var desclist = []
                                        Array.prototype.forEach.call(titleArr, function(ti, c) {
                                            if ($(ti).text() !== "" || $(deseArr[c]).text() !== "") {
                                                var obj = $(ti).text() + ":" + $(deseArr[c]).text()
                                                desclist.push(obj)
                                            }

                                        })
                                        productDesc = desclist.join("\n")
                                    } catch (err) {
                                        productDesc = productTitle
                                    }
                                }


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
                                deferred.reject("002");

                            }

                        } else {
                            deferred.reject("002");
                        }

                    }
                }

            })

    }
    return deferred.promise;
}

module.exports = alibabaApi