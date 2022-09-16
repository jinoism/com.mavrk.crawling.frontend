// const isEmpty = (fieldName, fieldValue) => {
//   return !fieldValue ? 'The ' + fieldName + ' field is required' : ''
// }
const isEmpty = (fieldValue) => {
  return !fieldValue ? false : true
}

const minLength = (fieldValue, min) => {
  return fieldValue.length < min ? false : true
}

const isEmail = (fieldValue) => {
  let re =
    /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  return !re.test(fieldValue) ? false : true
}

const isRequried = (fieldValue) => {
  return !fieldValue ? false : true
}

const isNickName = (fieldValue) => {
  let re = /^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$/
  return !re.test(fieldValue) ? false : true
}

const isPassWord = (fieldValue) => {
  // 8자 숫자영어, 문자1
  let re = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,50}$/
  return !re.test(fieldValue) ? false : true
}

export {isEmpty, minLength, isEmail, isRequried, isNickName, isPassWord}
