import axios from '@/api/axios'
import store from '@/store'
import _ from 'lodash'
import qs from 'qs'
import {mapKeysCamelCase, mapKeysSnakeCase} from '@/utils/deepKeysMap'


const getChartData = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/summary/'+params.melonId +'_' + params.genieId,
    params : {start : params.melonStDate, end :params.melonEdDate}
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

const getDailyChartData = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/melon/dailychart/trend/'+params.melonId,
    params: {start : params.liveStDate, end :params.liveEdDate}
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

const getLikeChartData = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/melon/songlikedaily/trend/'+params.melonId,
    params :{start : params.likeStDate, end :params.likeEdDate}

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

const getInfolowData = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/inoutflow/'+params.melonId +'_' + params.genieId,
    params: {start:params.start, end : params.end}
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

const getHeartData = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/heart/trend/'+params.melonId +'_' + params.genieId,
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
    console.error('getHeartData', err)
    result(false, err)
  }
}

const getDetailData = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/summary/'+params.melonId +'_' + params.genieId,
    params: {start:params.start, end:params.end}
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
    console.error('getHeartData', err)
    result(false, err)
  }
}




export default {
  getChartData,
  getDailyChartData,
  getLikeChartData,
  getInfolowData,
  getHeartData,
  getDetailData,
}
