<template>


    <Header v-bind:userName = "userName"/>
    <Menu />
    <div id="contents_body" class="ravex">

    <!-- 공지사항 -->
    <!--<div class="notice_bar">
      <p><a href="#.">[공지] 새로운 운영자를 찾습니다.</a><button><i class="xi-close"></i></button></p>
    </div>-->
    <slot />
    </div>
    <Footer />

</template>

<script>
import Footer from '@/components/Footer.vue'
import Menu from '@/components/Menu.vue'
import Header from '@/components/Header.vue'

export default {
  name: 'DefaultLayout',
  components: {
    Footer,
    Menu,
    Header
  },
  data() {
    return {
      userName : '',
      email : '',

    }
  },
}
</script>

<script>
</script>
