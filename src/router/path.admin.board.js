const routes = {
  path: '/admin/board',
  name: 'AdminBoardMain',
  meta: {
    layout: 'DefaultLayout',
    dep: 5
  },
  component: () => import(/* webpackChunkName: "board" */ '@/views/admin/board/Main.vue'),
  children: [
    {
      path: 'list',
      alias: '',
      name: 'AdminBoardList',
      component: () => import(/* webpackChunkName: "board" */ '@/views/admin/board/List.vue'),
      meta: {
        title: 'AdminBoardList',
        sub:1
      }
    },
    {
      path: 'view',
      alias: '',
      name: 'AdminBoardView',
      component: () => import(/* webpackChunkName: "board" */ '@/views/admin/board/View.vue'),
      meta: {
        title: 'AdminBoardView',
        sub:1
      }
    }

  ]
}

export default routes
