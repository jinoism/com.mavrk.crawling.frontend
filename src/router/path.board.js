const routes = {
  path: '/board',
  name: 'BoardMain',
  meta: {
    layout: 'DefaultLayout',
    dep: 1
  },
  component: () => import(/* webpackChunkName: "board" */ '@/views/board/Main.vue'),
  children: [
    {
      path: 'view',
      alias: '',
      name: 'BoardList',
      component: () => import(/* webpackChunkName: "board" */ '@/views/Main.vue'),
      meta: {
        title: 'TOP100',
        sub:1
      }
    },
    {
      path: 'view',
      alias: '',
      name: 'BoardView',
      component: () => import(/* webpackChunkName: "board" */ '@/views/board/View.vue'),
      meta: {
        title: 'TOP100',
        sub:1
      }
    }
  ]
}

export default routes
