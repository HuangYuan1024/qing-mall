
const Instance =require("./../axios/index")
const Q = require('q');

const proxyApi = (token) => {
    var that=this;
    var deferred = Q.defer();
    var num=0
    var params={
        token:token
    }
    init(params)
    function init(params){
        num++
        Instance("/config/general/randomIp",params).then(result => {
            if(result.data.code == "000") {
                deferred.resolve('http://'+result.data.data[0].ip+':'+result.data.data[0].port)
            } else {
                init(token)
                if(num>2){
                    deferred.reject("");
                }

            }
           
        }).catch(function(error) {
            console.log(error);
        });
    }
	return deferred.promise;
}

module.exports = proxyApi