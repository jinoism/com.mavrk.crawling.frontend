import {createRouter, createWebHistory} from 'vue-router'
import melonPath from './path.melon'
import mavrkPath from './path.mavrk'
import geniePath from './path.genie'
import boardPath from './path.board'
import adminLoginPath from './path.admin.login'
import adminBoardPath from './path.admin.board'
import adminPath from './path.admin'


const routes = [
  {
    path: '/',
    alias: '',
    name: 'Main',
    dep :1,
    component: () => import(/* webpackChunkName: "main" */ '@/views/Login.vue'),
    meta: {
      layout: 'NoneLayout',
      dep :1,
    }
  },
  {
    path: '/regist',
    alias: '',
    name: 'Regist',
    dep :0,
    component: () => import(/* webpackChunkName: "main" */ '@/views/Regist.vue'),
    meta: {
      layout: 'DefaultLayout',
      dep :0,
      sub:4
    }
  }
  ,
  {
    path: '/pwChange',
    alias: '',
    name: 'PwChange',
    dep :1,
    component: () => import(/* webpackChunkName: "main" */ '@/views/PwChange.vue'),
    meta: {
      layout: 'NoneLayout',
      dep :1,
    }
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})
router.addRoute(melonPath)
router.addRoute(mavrkPath)
router.addRoute(geniePath)
router.addRoute(boardPath)
router.addRoute(adminLoginPath)
router.addRoute(adminBoardPath)
router.addRoute(adminPath)

export default router
