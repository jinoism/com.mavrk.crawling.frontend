<template>
  <div class="top">
    <button type="button" @click="leftHidden"><img src="/img/ico_menu.png"></button>
    <p class="title" v-if="title !== 'hidden'">{{ title }}</p>
  </div>
</template>

<script>
export default {
  name: 'Subheader',
  computed: {
    title() {
      return this.$route.meta.title || ''
    }
  },
  methods: {
    leftHidden() {
      this.$emit('leftHidden')
    }
  }
}
</script>
