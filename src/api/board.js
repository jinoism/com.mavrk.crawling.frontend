import axios from '@/api/axios'
import store from '@/store'
import _ from 'lodash'
import qs from 'qs'
import {mapKeysCamelCase, mapKeysSnakeCase} from '@/utils/deepKeysMap'


const getBoardList = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/notice',
    data: qs.stringify(mapKeysSnakeCase(null))
  }

  try {
    axios(options).then((response) => {
      console.dir(response)
      if (response.data.code === '1000') {
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


const getBoardInfo = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/notice/' + params.idx,
    data: qs.stringify(mapKeysSnakeCase(null))
  }

  try {
    axios(options).then((response) => {
      console.dir(response)
      if (response.data.code === '1000') {
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

const deleteBoard = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'DELETE',
    url: '/notice/' + params.idx,
    data: qs.stringify(mapKeysSnakeCase(null))
  }

  try {
    axios(options).then((response) => {
      console.dir(response)
      if (response.data.code === '1000') {
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

const updateBoard = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'PUT',
    url: '/notice/' + params.idx,
    params: params
  }

  try {
    axios(options).then((response) => {
      console.dir(response)
      if (response.data.code === '1000') {
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


const insertBoard = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'POST',
    url: '/notice/write',
    data: qs.stringify(params)
  }

  try {
    axios(options).then((response) => {
      console.dir(response)
      if (response.data.code === '1000') {
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
  getBoardList,
  getBoardInfo,
  deleteBoard,
  updateBoard,
  insertBoard
}
