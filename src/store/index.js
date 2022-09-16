import {createStore} from 'vuex'
import {Member} from '@/store/modules/Member'

export default createStore({
  state: {
    login: false
  },
  mutations: {},
  actions: {},
  getters: {
    // $store.getters.login
    login(state) {
      let eotoken = sessionStorage.getItem('eotoken') || localStorage.getItem('eotoken')
      if (eotoken) {
        return true
      } else {
        return false
      }
    }
  },
  modules: {
    Member
  }
})
