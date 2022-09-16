import axios from '@/api/axios'
import store from '@/store'
import _ from 'lodash'
import qs from 'qs'
import {mapKeysCamelCase, mapKeysSnakeCase} from '@/utils/deepKeysMap'


const getTop100List = (params, result) => {
  let url =''
  if (params.type== 'dailychart'){
    url = '/genie/'+params.type+'/'+params.year+''+params.month+''+params.day
  } else {
    url = '/genie/'+params.type+'/'+params.year+'/'+params.month+'/'+params.day+'/'+params.time
  }

  let finalData = {
    result_code: '00',
    message: ''
  }


  const options = {
    method: 'GET',
    url: url,
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

const getTop100RankList = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  let tmp = {}
  if (params.type =='24hour'){
    tmp.start = params.start
    tmp.end  =params.end
  }

  const options = {
    method: 'GET',
    url: '/'+params.platform+'/'+params.type+'/trend/'+params.songId,
    params: params.type =='24hour'? tmp : null
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


const getSongId = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/genie/search',
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

export default {
  getTop100List,
  getTop100RankList,
  getSongId,

}
