<template>


		<!-- header -->
		<header id="header">
			<div class="container-fluid">
        <div class="mobile_menu_btn" id="mobile_menu_btn">
					<button>
						<span></span><span></span><span></span>
					</button>
				</div>
				<h1>
					<a href="#."><img src="/img/logo_w.png" alt="mavrk"></a>
				</h1>
				<nav v-if="page==2 && this.$route.query.melonId != null">
					<ul >
						<li><router-link :to="{name: 'MavrkInflowView' ,query:{melonId : this.$route.query.melonId , genieId : this.$route.query.genieId}}" :class="{on: sub == 3}">유입&이탈자 데이터</router-link></li>
						<li><router-link :to="{name: 'MavrkHeartView' ,query:{melonId : this.$route.query.melonId , genieId : this.$route.query.genieId}}" :class="{on: sub == 4}">발매일 하트 추이</router-link></li>
						<li><router-link :to="{name: 'MavrkDetailView',query:{melonId : this.$route.query.melonId , genieId : this.$route.query.genieId}}" :class="{on: sub == 5}">차트 자세히 보기</router-link></li>
					</ul>
				</nav>


				<div class="member_m">
					<p>{{userName}}님 |</p>
					<p><button @click="logout()"><i class="xi-log-out"></i></button></p>
				</div>




      </div>
		</header>
		<!-- header -->



</template>

<script>
export default {
  name: 'Header',
  props: ['userName'],
  data() {
    return {
      page: this.$route.meta.dep,
      sub : this.$route.meta.sub
    }
  },
  watch: {
    '$route.name': function() {

      this.page = this.$route.meta.dep
      this.sub = this.$route.meta.sub

      $('#mobile_menu_btn').removeClass('side_on');
    },
    '$route.query':function(){
      $('#mobile_menu_btn').removeClass('side_on');
    }

  },
  methods:{
    logout() {
      sessionStorage.removeItem('mavrkToken')
      localStorage.removeItem('mavrkToken')
      this.$router.push({
        name: 'Main'
      })
    },
  }
}
</script>
