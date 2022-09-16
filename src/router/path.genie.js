const routes = {
  path: '/genie',
  name: 'GenieMain',
  meta: {
    layout: 'DefaultLayout',
    dep: 4
  },
  component: () => import(/* webpackChunkName: "customer" */ '@/views/genie/Main.vue'),
  children: [
    {
      path: 'realchart',
      alias: '',
      name: 'GenieTop',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/genie/RealChart.vue'),
      meta: {
        title: 'TOP100',
        sub:1
      }
    },
    {
      path: 'realchart/view',
      alias: '',
      name: 'GenieTopView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/genie/RealChartView.vue'),
      meta: {
        title: 'TOP100',
        sub:1
      }
    },
    {
      path: 'realchart/rank/view',
      alias: '',
      name: 'GenieTopRankView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/genie/RealChartRankView.vue'),
      meta: {
        title: 'TOP100',
        sub:1
      }
    },
    {
      path: 'transition',
      alias: '',
      name: 'GenieRankTransition',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/genie/RankTransition.vue'),
      meta: {
        title: '추이 조회',
        sub:2
      }
    },
    {
      path: 'transition/view',
      alias: '',
      name: 'GenieRankTransitionView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/genie/RankTransitionView.vue'),
      meta: {
        title: 'TOP100추이 결과',
        sub:2
      }
    },
    {
      path: 'rank',
      alias: '',
      name: 'GenieRank',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/genie/Rank.vue'),
      meta: {
        title: 'TOP100',
        sub:1
      }
    },
    {
      path: 'rank/view',
      alias: '',
      name: 'GenieRankView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/genie/RankView.vue'),
      meta: {
        title: 'TOP100',
        sub:1
      }
    },

  ]
}

export default routes
