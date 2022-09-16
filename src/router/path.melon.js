const routes = {
  path: '/melon',
  name: 'MeloneMain',
  meta: {
    layout: 'DefaultLayout',
    dep: 3
  },
  component: () => import(/* webpackChunkName: "customer" */ '@/views/melon/Main.vue'),
  children: [
    {
      path: 'rank',
      alias: '',
      name: 'Rank',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/melon/Rank.vue'),
      meta: {
        title: 'TOP100',
        sub:1
      }
    },
    {
      path: 'rank/view',
      alias: '',
      name: 'RankView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/melon/RankView.vue'),
      meta: {
        title: 'TOP100',
        sub:1
      }
    },
    {
      path: 'transition',
      alias: '',
      name: 'RankTransition',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/melon/RankTransition.vue'),
      meta: {
        title: 'TOP100추이 조회',
        sub:2
      }
    },
    {
      path: 'transition/view',
      alias: '',
      name: 'RankTransitionView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/melon/RankTransitionView.vue'),
      meta: {
        title: 'TOP100추이 결과',
        sub:2
      }
    },
    {
      path: 'top100/count',
      alias: '',
      name: 'MelonTopCount',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/melon/Top100Count.vue'),
      meta: {
        title: 'TOP100 이용자수 추이',
        sub:3
      }
    },
    {
      path: 'top100/count/view',
      alias: '',
      name: 'MelonTopCountView',
      component: () => import(/* webpackChunkName: "customer" */ '@/views/melon/Top100CountView.vue'),
      meta: {
        title: 'TOP100 이용자수 추이',
        sub:3
      }
    }
  ]
}

export default routes
