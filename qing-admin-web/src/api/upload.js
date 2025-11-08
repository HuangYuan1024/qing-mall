import config from './api_conf';
import Vue from 'vue'
let { fileup, base } = config


// 压缩
var ys = {
    // 处理图片
    onUpload: function(file) {
        var that = this
            // 通过canvas压缩图片
        var reader = new FileReader()
        reader.readAsDataURL(file)
        var img = new Image

        let promise = new Promise((res, rej) => {
            reader.onload = function(e) {
                let quality = 0.5, //图像质量
                    canvas = document.createElement('canvas'),
                    drawer = canvas.getContext('2d')

                img.src = this.result
                img.onload = function() {
                    canvas.width = img.width
                    canvas.height = img.height

                    drawer.drawImage(img, 0, 0, canvas.width, canvas.height)
                    img.src = canvas.toDataURL('image/jpeg', quality)
                    res(that.dataURItoBlob(canvas.toDataURL('image/jpeg', quality), file))
                }
            }
        })
        return promise.then(async(f) => {
            let param = new FormData()
            param.append('file', f)
            param.append('filename', f.name)
            let data = await axios.post(fileup + '/upload/upload', param).then(res => res.data)
            return data
        })

    },
    // base64转文件
    dataURItoBlob: function(dataURI, file) {
        var byteString = atob(dataURI.split(',')[1])
        var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0]
        var ab = new ArrayBuffer(byteString.length)
        var ia = new Uint8Array(ab)
        for (var i = 0; i < byteString.length; i++) {
            ia[i] = byteString.charCodeAt(i)
        }
        let blob = new Blob([ab], { type: mimeString })
            // let tempFile = new File([blob], file.name);
        return blob
    },
}

export default function(axios) {
    this.download = (uri) => {
        return axios.get(fileup + `/upload/download/${uri}`, null).then(res => res.data)
    }

    /**
     * @description 文件上传
     * @param {Object} file 要上传的文件
     * @param {Object} params 附带的参数
     */
    this.uploadFile = (file, params) => {
        console.log(file)
        console.log(params)
        const formData = new FormData()

        // 额外参数
        if (params && Object.keys(params).length) {
            for (const key in params) {
                if (params.hasOwnProperty(key) && key !== 'file') {
                    formData.append(key, params[key])
                }
            }
        }
        formData.append('file', file)
        formData.append('filename', file.name)
        return axios.post(fileup + '/upload/upload', formData).then(res => res)
    }

    const MAX_SIZE = 2
    this.upload = (param) => {
        let file = param.get('file')
        let fileName = file.name
        var size = file.size;
        console.log(file)
        let imgTypes = ['.bmp', '.png', '.jpg', '.jpeg', '.pbm']
            // if (size > MAX_SIZE * 1024 * 1024) {
            //     return new Promise((resolve, reject) => {
            //         new Vue().$message.error('文件大小不能超过' + MAX_SIZE + 'M')
            //         reject({
            //             sucess: false, message: '文件大小不能超过' + MAX_SIZE + 'M'
            //         })
            //     })
            // } else {
            // 小于30k不进行压缩
        if (size / 1024 <= 30) {
            var formData = new FormData()
            formData.append('file', file)
            formData.append('filename', file.name)
            return axios.post(fileup + '/upload/upload', formData).then(res => res.data)
        }
        // 只有图片进行压缩 imgTypes
        let isImage = imgTypes.every((item) => fileName.indexOf(item) == -1)
        if (isImage) {
            var formData = new FormData()
            formData.append('file', file)
            formData.append('filename', file.name)
            return axios.post(fileup + '/upload/upload', formData).then(res => res.data)
        }
        let promise = new Promise((res, rej) => {
            fileResizetoFile(file, 0.5, function(blob) {
                console.log(blob)
                blob.name = fileName
                param.set('file', blob)
                param.set('filename', fileName)
                res(param)
            })
        })
        return promise.then(async(p) => {
                let pfile = p.get('file')
                pfile = new File([pfile], 'file.jpg', { type: pfile.type })
                p.set('file', pfile)
                p.set('filename', pfile.name)
                let data = await axios.post(fileup + '/upload/upload', p).then(res => res.data)
                return data
            })
            // return axios.post(fileup + '/upload/upload', param).then(res => res.data)
            //}
    }

    const MAX_SIZE2 = 20
    this.upload2 = (param) => {
        return axios.post(base + '/upload/upload', param).then(res => res.data)
            // if (size > MAX_SIZE2 * 1024 * 1024) {
            //     new Vue().$message.error('文件大小不能超过' + MAX_SIZE2 +'M')
            //     return () => {}
            // }
            // let param = new FormData()
            // param.append('file', file)
            // return axios.post(fileup + '/upload/upload', param).then(res => res.data)
    }

    /**
     * 将一个 File 对象压缩之后再变为 File 对象
     * @param file
     * @param quality
     * @param fn
     */
    function fileResizetoFile(file, quality, fn) {
        filetoDataURL(file, function(dataurl) {
            dataURLtoImage(dataurl, function(image) {
                canvasResizetoFile(imagetoCanvas(image), quality, fn);
            })
        })
    }

    /**
     *  canvasResizetoFile(canvas,quality,fn) 会将一个 Canvas 对象压缩转变为一个 Blob 类型对象；
     *  其中 canvas 参数传入一个 Canvas 对象; quality 参数传入一个0-1的 number 类型，表示图片压缩质量;
     *  fn 为回调方法，包含一个 Blob 对象的参数;代码如下：
     */
    function canvasResizetoFile(canvas, quality, fn) {
        canvas.toBlob(function(blob) {
            fn(blob);
        }, 'image/jpeg', quality);
    };

    /**
     * filetoDataURL(file,fn) 会将 File （ Blob ）类型文件转变为 dataURL 字符串,其中 file 参数传入一个 File （ Blob ）类型文件;
     * fn 为回调方法，包含一个 dataURL 字符串的参数;
     * @param file
     * @param fn
     */
    function filetoDataURL(file, fn) {
        var reader = new FileReader();
        reader.onloadend = function(e) {
            fn(e.target.result);
        };
        reader.readAsDataURL(file);
    };

    /**
     * dataURLtoImage(dataurl,fn) 会将一串 dataURL 字符串转变为 Image 类型文件,其中 dataurl 参数传入一个 dataURL 字符串,
     * fn 为回调方法，包含一个 Image 类型文件的参数
     * @param dataurl
     * @param fn
     */
    function dataURLtoImage(dataurl, fn) {
        var img = new Image();
        img.onload = function() {
            fn(img);
        };
        img.src = dataurl;
    };

    /**
     * imagetoCanvas(image) 会将一个 Image 对象转变为一个 Canvas 类型对象，其中 image 参数传入一个Image对象
     * @param image
     * @returns {HTMLElement}
     */
    function imagetoCanvas(image) {
        var cvs = document.createElement("canvas");
        var ctx = cvs.getContext('2d');
        cvs.width = image.width;
        cvs.height = image.height;
        ctx.drawImage(image, 0, 0, cvs.width, cvs.height);
        return cvs;
    };
}