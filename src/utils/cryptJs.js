import CryptoJS from 'crypto-js'

const CryptoJSAesJson = {
  stringify: function(cipherParams) {
    let j = {j: cipherParams.ciphertext.toString(CryptoJS.enc.Base64)}
    if (cipherParams.iv) j.i = cipherParams.iv.toString()
    if (cipherParams.salt) j.s = cipherParams.salt.toString()
    return JSON.stringify(j)
  },
  parse: function(jsonStr) {
    let json = JSON.parse(jsonStr)
    let cipherParams = CryptoJS.lib.CipherParams.create({ciphertext: CryptoJS.enc.Base64.parse(json.j)})
    if (json.i) cipherParams.iv = CryptoJS.enc.Hex.parse(json.i)
    if (json.s) cipherParams.salt = CryptoJS.enc.Hex.parse(json.s)
    return cipherParams
  }
}

const enCrypted = (v) => {
  const today = new Date()
  let year = today.getFullYear()
  let month = today.getMonth() + 1
  let date = today.getDate()
  let hour = today.getHours()
  const key = '656f436f6d756e69636174696f6e53746f636b696e5369676874'
  return CryptoJS.AES.encrypt(JSON.stringify(v), CryptoJS.enc.Utf8.stringify(CryptoJS.enc.Hex.parse(key))+year+month+date+hour, {
    format: CryptoJSAesJson
  }).toString()
}

const deCrypted = (encrypted) => {
  const today = new Date()
  let year = today.getFullYear()
  let month = today.getMonth() + 1
  let date = today.getDate()
  let hour = today.getHours()
  // CryptoJS.enc.Utf8.parse('string')
  const key = '656f436f6d756e69636174696f6e53746f636b696e5369676874'
  return JSON.parse(
    CryptoJS.AES.decrypt(encrypted, CryptoJS.enc.Utf8.stringify(CryptoJS.enc.Hex.parse(key))+year+month+date+hour, {format: CryptoJSAesJson}).toString(CryptoJS.enc.Utf8)
  )
}

export {enCrypted, deCrypted}
