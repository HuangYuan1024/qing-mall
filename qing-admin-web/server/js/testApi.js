
const testApi = (url) => {
    
var promise = new Promise(function(resolve, reject) {
    if (url==1){
    resolve("成功");
    } else {
    reject("失败");
    }
   });
    
   promise.then(function(value) {
    // success
    console.log(value)
   }, function(value) {
    // failure
   })   
  
  
}
module.exports = testApi