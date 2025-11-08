const express = require('express')
const router = express.Router()
const server = require('./server')
router.use((req, res, next) => {
    try {
        next()
    } catch (e) {
        console.log('', e, '', e.stack);
        try {
            res.end(e.stack);
        } catch (e) {}
    }

})


// api接口获取分类文档
server(router)
    // 导出接口
module.exports = router