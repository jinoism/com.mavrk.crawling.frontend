const routes = {
  path: '/mavrk',
  name: 'MavrkMain',
  meta: {
    layout: 'DefaultLayout',
    dep: 2
  },
  component: () => import(/* webpackChunkName: "customer" */ '@/views/mavrk/Main.vue'),
  children: [
    {
      path: 'rmain',
      alias: '',
      name: 'MavrkChartMain',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/mavrk/RMain.vue'),
      meta: {
        title: 'MavrkChartMain',
        sub:1
      }
    },

    {
      path: 'view',
      alias: '',
      name: 'MavrkChartView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/mavrk/ChartView.vue'),
      meta: {
        title: 'MavrkChartView',
        sub:2
      }
    },
    {
      path: 'inflow',
      alias: '',
      name: 'MavrkInflowView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/mavrk/Inflow.vue'),
      meta: {
        title: 'MavrkInflowView',
        sub:3
      }
    },
    {
      path: 'heart',
      alias: '',
      name: 'MavrkHeartView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/mavrk/Heart.vue'),
      meta: {
        title: 'MavrkHeartView',
        sub:4
      }
    },
    {
      path: 'detail',
      alias: '',
      name: 'MavrkDetailView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/mavrk/Detail.vue'),
      meta: {
        title: 'MavrkDetailView',
        sub:5
      }
    }


  ]
}

export default routes
