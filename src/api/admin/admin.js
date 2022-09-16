import axios from '@/api/axios'
import store from '@/store'
import _ from 'lodash'
import qs from 'qs'
import {mapKeysCamelCase, mapKeysSnakeCase} from '@/utils/deepKeysMap'




const getArtistList = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: params.platform +'/artist/whitelist',
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

const getArtistId = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/'+params.platform+'/artist',
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


const deleteArtist = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'DELETE',
    url: params.platform +'/artist/whitelist/' + params.artistId,
    params: {artist_id : params.artistId}
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


const deleteSong = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'DELETE',
    url: params.platform +'/song/whitelist/' + params.songId,
    params: {song_id : params.songId}
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

const insertArtist = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'POST',
    url: params.platform +'/artist/whitelist',
    params : {artist_id : params.artistId}
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

const insertSong = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'POST',
    url: params.platform +'/song/whitelist',
    params : {song_id : params.songId, start : params.start, end : params.end}
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

const getSongList = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: params.platform +'/song/whitelist',
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

const getUserList = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'GET',
    url: '/userlist',
    params: null
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



const pwChange = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'PUT',
    url: '/modify/password/'+params.email,
    params: null
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

const roleChange = (params, result) => {
  let finalData = {
    result_code: '00',
    message: ''
  }
  const options = {
    method: 'PUT',
    url: '/modify/role/'+params.email,
    params: {role : params.role}
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

  getArtistList,
  deleteArtist,
  insertArtist,
  getArtistId,
  getSongList,
  insertSong,
  deleteSong,
  getUserList,
  pwChange,
  roleChange
}
