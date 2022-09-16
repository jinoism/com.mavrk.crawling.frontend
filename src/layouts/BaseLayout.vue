<template>
  <component :is="layout ? layout : 'NoneLayout'">
    <router-view />
  </component>
</template>

<script>
import DefaultLayout from './DefaultLayout'
import Sublayout from './SubLayout'
import Setlayout from './SetLayout'
import Admlayout from './AdmLayout'
import NoneLayout from './NoneLayout'


export default {
  name: 'BaseLayout',
  components: {
    DefaultLayout,
    Sublayout,
    Setlayout,
    Admlayout,
    NoneLayout
  },
  data() {
    return {}
  },
  computed: {
    layout() {
      return this.$route.meta.layout || 'NoneLayout'
    }
  }
}
</script>
