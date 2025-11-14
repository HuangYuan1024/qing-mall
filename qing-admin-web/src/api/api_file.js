import * as FileAPI from './file_axios'

export default {

  // 上传图片签名
  uploadImgApi: (params) => {
    return FileAPI.GET(`/media/signaturePut`, params)
  },
  // 下载图片签名
  downloadImgApi: (params) => {
    return FileAPI.GET(`/media/signatureGet/${params.key}`, params)
  }

}
