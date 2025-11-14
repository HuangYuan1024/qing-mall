import axios from 'axios'

// 文件服务专用实例，baseURL 指向 8082
const fileAxios = axios.create({
  baseURL: localStorage.getItem('$FileApi') || 'http://localhost:8082'
})

// 请求拦截（需要就打开）
fileAxios.interceptors.request.use(req => {
  req.headers['wd-cs'] = '11'
  return req
})

// 响应拦截（需要就打开）
fileAxios.interceptors.response.use(
  res => res.data,
  err => Promise.reject(err)
)

/* 下面四个方法供外部 import 使用 */
export const GET  = (url, params) => fileAxios.get(url, { params })
export const POST = (url, data)  => fileAxios.post(url, data)
export const PUT  = (url, data)  => fileAxios.put(url, data)
export const DELETE = (url, params) => fileAxios.delete(url, { params })

export default fileAxios
