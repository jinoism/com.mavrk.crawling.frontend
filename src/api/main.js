import axios from '@/api/axios'
import store from '@/store'
import _ from 'lodash'
import qs from 'qs'
import {mapKeysCamelCase} from '@/utils/deepKeysMap'
import {enCrypted, deCrypted} from '@/utils/cryptJs'

// main popup
const mainPopup = (result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/api/v1/main_popup.php'
  }

  try {
    axios(options).then((response) => {
      if (response.data.result_code === '00') {
        response.data.list.forEach((item, idx) => {
          if (typeof item.link_url === 'object') {
            item.links = '/board/notice/' + item.idx
          } else {
            item.links = item.link_url
          }
        })
        finalData = _.merge(finalData, response.data)
        result(true, mapKeysCamelCase(finalData))
      } else {
        //console.error(response.data.result_code, response.data.message)
        result(false, response.data.message)
      }
    })
  } catch (err) {
    console.error('mainPopup', err)
    result(false, err)
  }
}

const getMainPage = (type, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/api/v1/get_main_page.php',
    params: {
      'type': type
    }
  }

  try {
    axios(options).then((response) => {
      if (response.data.result_code === '00') {
        finalData = _.merge(finalData, response.data)
        result(true, mapKeysCamelCase(finalData))
      } else {
        //console.error(response.data.result_code, response.data.message)
        result(false, response.data.message)
      }
    })
  } catch (err) {
    console.error('mainPopup', err)
    result(false, err)
  }
}
export default {
  mainPopup,
  getMainPage
}
