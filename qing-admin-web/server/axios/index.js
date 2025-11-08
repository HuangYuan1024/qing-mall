
const axios = require('axios')
// const jQuery =require('./jquery-1.9.1.min')
// var $ = require('jquery')(require("jsdom").jsdom().defaultView);
var jsdom = require('jsdom');
 
const { JSDOM } = jsdom;
const { window } = new JSDOM(`<!DOCTYPE html>`);
const $ = require('jQuery')(window);
//接口路径
const POST = (url, params) => {
	return axios.post(url, $.param(params))
}
module.exports = POST