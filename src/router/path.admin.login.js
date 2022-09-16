const routes = {
  path: '/admin',
  name: 'AdminLoginMain',
  meta: {
    layout: 'NoneLayout',
    dep: 0
  },
  component: () => import(/* webpackChunkName: "board" */ '@/views/admin/Main.vue'),
  children:[

  ]
}

export default routes
