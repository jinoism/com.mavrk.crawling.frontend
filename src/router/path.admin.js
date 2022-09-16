const routes = {
  path: '/admin',
  name: 'AdminMain',
  meta: {
    layout: 'DefaultLayout',
    dep: 5
  },
  component: () => import(/* webpackChunkName: "board" */ '@/views/admin/Main.vue'),
  children: [
    {
      path: 'artist',
      alias: '',
      name: 'AdminArtistList',
      component: () => import(/* webpackChunkName: "board" */ '@/views/admin/ArtistList.vue'),
      meta: {
        title: 'AdminArtistList',
        sub:2
      }
    },
    {
      path: 'artist/write',
      alias: '',
      name: 'AdminArtistWrite',
      component: () => import(/* webpackChunkName: "board" */ '@/views/admin/ArtistWrite.vue'),
      meta: {
        title: 'AdminArtistList',
        sub:2
      }
    },
    {
      path: 'song',
      alias: '',
      name: 'AdminSongList',
      component: () => import(/* webpackChunkName: "board" */ '@/views/admin/SongList.vue'),
      meta: {
        title: 'AdminSongList',
        sub:3
      }
    },

    {
      path: 'song/write',
      alias: '',
      name: 'AdminSongWrite',
      component: () => import(/* webpackChunkName: "board" */ '@/views/admin/SongWrite.vue'),
      meta: {
        title: 'AdminSongList',
        sub:3
      }
    },
    {
      path: 'member',
      alias: '',
      name: 'AdminMemberList',
      component: () => import(/* webpackChunkName: "board" */ '@/views/admin/MemberList.vue'),
      meta: {
        title: 'AdminMemberList',
        sub:4
      }
    },
  ]
}

export default routes
