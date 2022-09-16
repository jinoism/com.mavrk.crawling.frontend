<template>
  <div id="collapseExample" class="header2">
    <div class="sidebar-heading">
      <router-link to="/">
        <img src="/img/logo.png" />
      </router-link>
    </div>
    <div class="sidebar-body">
      <ul>
        <li>
          <router-link :to="{name: 'MyPageMain'}" :class="{on: page == 1}">
            <span>내정보</span>
          </router-link>
        </li>
        <li>
          <router-link :to="{name: 'SettingMain'}" :class="{on: page == 2}">
            <span>메뉴편집</span>
          </router-link>
        </li>
        <li>
          <router-link :to="{name: 'SumMain'}" :class="{on: page == 3}">
            <span>통계</span>
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HeaderSet',
  data() {
    return {
      page: this.$route.meta.dep

    }
  },
  watch: {
    '$route.name': function () {
      this.page = this.$route.meta.dep
      this.sub = this.$route.meta.sub
    }
  }
}
</script>
