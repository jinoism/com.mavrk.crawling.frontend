import {createApp} from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import 'bootstrap/dist/js/bootstrap.js'
import {VueCookieNext} from 'vue-cookie-next'

const app = createApp(App)
app.use(VueCookieNext)
app.config.globalProperties.$store = store
app.use(store)
app.use(router).mount('#app')