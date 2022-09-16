'use strict'

import axios from 'axios'
import store from '@/store'
import {deCrypted} from '@/utils/cryptJs'

const _axios = axios.create({
  baseURL: process.env.VUE_APP_API_URL,
  withCredentials: false,
  timeout: 10000
})

_axios.interceptors.request.use(
  function (config) {
    // Do something before request is sent
    let accessToken = sessionStorage.getItem('mavrkToken') || localStorage.getItem('mavrkToken')
    config.headers.common['X-Auth-Token'] =  accessToken
    return config
  },
  function (error) {
    // Do something with request error
    return Promise.reject(error)
  }
)

_axios.interceptors.response.use(
  (response) => {
    // if (response.data.code === '110') {
    //   store.dispatch('logout')
    //   window.location.href = '/login'
    // }
    // response.data = deCrypted(JSON.stringify(response.data))
    return response
  },
  async (error) => {
    const {
      config,
      response: {status, data}
    } = error
    // const originalRequest = config
    if (status === 401 && data === 'Unauthorized1') {
      return new Promise((resolve) => {
        // window.location.href = '/login'
        return Promise.reject(new Error('로그인이 만료 되었습니다.1'))

        // auth.refreshToken((flag, accessToken) => {
        //   if (flag) {
        //     originalRequest.headers.Authorization = accessToken
        //     resolve(axios(originalRequest))
        //   } else {
        //     store.dispatch('logout')
        //     window.location.href = '/'
        //     return Promise.reject(new Error('로그인이 만료 되었습니다.'))
        //   }
        // })
      })
    } else {

      return data;
      // await store.dispatch('logout')
      // window.location.href = '/login'
      //return Promise.reject(new Error('통신에 오류가 있습니다.'))
    }
  }
)

export default _axios
