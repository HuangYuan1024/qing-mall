const api = require('./api')
const express = require('express')
const app = express()
var superagent = require("superagent")

var allowCrossDomain = function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    res.header('Access-Control-Allow-Credentials', 'true');
    next();
};
app.use(allowCrossDomain);

app.use(api)



// 监听`8888`端口
app.listen(8088)
app.use((err, req, res, next) => {
    console.log(err);
    return res.json({ 'status': -1, 'result': err.stack })
});


console.log('node server is running at port 8088')

// var https = require('https'); //创建服务器 https
// var fs = require('fs'); //文件系统的模块

// const hostname = '127.0.0.1';
// const port = 8089;

// var options = {
//     key: fs.readFileSync('ssh_key.pem'), //读出 sytly 文件？
//     cert: fs.readFileSync('ssh_cert.pem'), //同步读出 SSL 证书
// }

// const server = http.createServer(options, (req, res) => { //监听到请求后，回调 function   req 请求相关的信息（如：从哪来过来的，类型是get还是post等信息）
//     res.statusCode = 200;
//     res.setHeader('Content-Type', 'text/plain'); // 返回的请求头  200 成功  文本内容Content-Type   是 text/plain
//     res.end('Hello World\n'); //返回的内容，改变内容的重启服务 ctrl+c关掉， 再重启 node server.js
// });

// server.listen(port, hostname, () => {
//     console.log(`Server running at http://${hostname}:${port}/`);
// });