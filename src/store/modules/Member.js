import router from '@/router'

export const Member = {
  state: () => ({
    provision: [false, false, false],
    email: '',
    name: '',
    birth: '',
    gender: '',
    nick: '',
    hp1: '010',
    hp2: '',
    hp3: '',
    pwd: '',
    pwd2: ''
  }),
  mutations: {
    // this.$store.commit("setProvision", provision)
    setProvision(state, provision) {
      state.provision = provision
    },
    setEmail(state, email) {
      state.email = email
    },
    setNameBirthGender(state, form) {
      state.name = form.name
      state.birth = form.birth
      state.gender = form.gender
    },
    setNick(state, form) {
      state.nick = form.nick
    },
    setPhone(state, form) {
      state.hp1 = form.hp1
      state.hp2 = form.hp2
      state.hp3 = form.hp3
    },
    setPassword(state, form) {
      state.pwd = form.pwd
      state.pwd2 = form.pwd2
    },
    reset(state) {
      state = {
        provision: [false, false, false],
        email: '',
        name: '',
        birth: '',
        gender: '',
        nick: '',
        hp1: '010',
        hp2: '',
        hp3: '',
        pwd: '',
        pwd2: ''
      }
    }
  },
  actions: {
    // this.$store.dispatch("setProvision_test", provision)
    setProvision: function (context, payload) {
      // commit 의 대상인 addCount 는 mutations 의 메서드를 의미한다.
      // 비동기 로직 수행후
      return setTimeout(function () {
        context.commit('setProvision', payload.provision)
      }, 1000)
    },
    resetMember: function (context, payload) {
      // 비동기 로직 수행후
      return setTimeout(function () {
        context.commit('reset')
      }, 1000)
    },
    logout() {
      localStorage.removeItem('eotoken')
      router.replace('/')
    },
    login(context, [provider, eotoken]) {
      localStorage.setItem('eotoken', eotoken)
      if (window.location.hash.length) {
        router.go(-2)
      } else {
        router.go(-1)
      }
    }
  },
  getters: {
    // $store.getters.member
    member(state) {
      return state
    }
  }
}
