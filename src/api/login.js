import axios from '@/api/axios'
import store from '@/store'
import _ from 'lodash'
import qs from 'qs'
import {mapKeysCamelCase, mapKeysSnakeCase} from '@/utils/deepKeysMap'


const getLogin = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'POST',
    url: '/login',
    data: qs.stringify(params)
  }

  try {
    axios(options).then((response) => {
      console.dir(response)
      if (response.data == undefined ){
        result(false, response)
        return;
      }


      if (response.data.token != '' ){
        result(true, response.data)
        return;
      }
      if ( response.data.code === '1000') {
        finalData = _.merge(finalData, response.data)
        result(true, mapKeysCamelCase(finalData))
      } else {
        //console.error(response.data.result_code, response.data.message)

        result(false, response.data)
      }
    })
  } catch (err) {
    console.error('emailCheck', err)
    result(false, err)
  }
}


const getAuth = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/authenticate',
    params: null
  }

  try {
    axios(options).then((response) => {
      console.dir(response)
      if (response.data == undefined ){
        result(false, response)
        return;
      }


      if (response.data.token != '' ){
        result(true, response.data)
        return;
      }
      if ( response.data.code === '1000') {
        finalData = _.merge(finalData, response.data)
        result(true, mapKeysCamelCase(finalData))
      } else {
        //console.error(response.data.result_code, response.data.message)

        result(false, response.data)
      }
    })
  } catch (err) {
    console.error('emailCheck', err)
    result(false, err)
  }
}
const getRegist = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'POST',
    url: '/join',
    data: qs.stringify(params)
  }

  try {
    axios(options).then((response) => {
      console.dir(response)
      if (response.data == undefined ){
        result(false, response)
        return;
      }


      if (response.data.token != '' ){
        result(true, response.data)
        return;
      }
      if ( response.data.code === '1000') {
        finalData = _.merge(finalData, response.data)
        result(true, mapKeysCamelCase(finalData))
      } else {
        //console.error(response.data.result_code, response.data.message)

        result(false, response.data)
      }
    })
  } catch (err) {
    console.error('emailCheck', err)
    result(false, err)
  }
}

const pwChange = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'PUT',
    url: '/pwchange',
    data: qs.stringify(params)
  }

  try {
    axios(options).then((response) => {
      console.dir(response)
      if (response.data == undefined ){
        result(false, response)
        return;
      }


      if (response.data.token != '' ){
        result(true, response.data)
        return;
      }
      if ( response.data.code === '1000') {
        finalData = _.merge(finalData, response.data)
        result(true, mapKeysCamelCase(finalData))
      } else {
        //console.error(response.data.result_code, response.data.message)

        result(false, response.data)
      }
    })
  } catch (err) {
    console.error('emailCheck', err)
    result(false, err)
  }
}

export default {
  getLogin,
  getAuth,
  getRegist,
  pwChange

}
