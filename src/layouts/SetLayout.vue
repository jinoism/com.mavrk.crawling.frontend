
<template>
  <div class="d-flex" id="wrapper">
    <Header :class="{'collapse':menuVisible}" />
    <div id="page-content-wrapper">
      <Subheader @leftHidden="leftHidden" />
      <slot />
    </div>
  </div>
</template>

<script>
import Header from '@/components/HeaderSet.vue'
import Subheader from '@/components/Subheader.vue'

export default {
  name: 'SetLayout',
  data() {
    return {
      menuVisible: true,
    }
  },
  components: {
    Header,
    Subheader
  },
  computed: {
    name: function() {
      return this.$route.name ? this.$route.name : ''
    }
  },
  methods: {
    leftHidden(){
      this.menuVisible=!this.menuVisible
    }
  }
}

</script>
