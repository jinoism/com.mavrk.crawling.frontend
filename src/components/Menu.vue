<template>
		<!-- aside -->
		<aside id="side_nav" ss-container>
			<ul class="side_nav_inner">
				<li>
          <router-link :to="{name: 'BoardList'}" style="background-image:url(/img/side_menu_home.png)" :class="{on: page == 1}">home</router-link>
				</li>
        <li v-if="this.role =='[ROLE_ADMIN]' || this.role =='[ROLE_MANAGER]'">
					<a style="background-image:url(/img/side_menu_admin.png)" :class="{on: page == 5}">home</a>
          <ul :class="{on: page == 5}">
						<li><router-link :to="{name: 'AdminBoardList'}" :class="{on: page==5 && sub == 1}">공지사항</router-link></li>
            <li v-if="this.role =='[ROLE_ADMIN]'"><router-link :to="{name: 'AdminMemberList'}" :class="{on: page==5 && sub == 4}">사용자관리</router-link></li>
						<li><router-link :to="{name: 'AdminArtistList'}" :class="{on: page==5 && sub == 2}">하트추이 가수등록</router-link></li>
            <li><router-link :to="{name: 'AdminSongList'}" :class="{on: page==5 && sub == 3}">하트추이 곡 등록</router-link></li>
            <!--<li><router-link :to="{name: 'MavrkChartMain'}" :class="{on: sub == 4}">플랫폼 연결 등록</router-link></li>
            <li><router-link :to="{name: 'MavrkChartMain'}" :class="{on: sub == 5}">수동 연결</router-link></li>-->
					</ul>
				</li>
				<li v-if="this.role =='[ROLE_ADMIN]' || this.role =='[ROLE_MANAGER]'">
					<a  style="background-image:url(/img/side_menu_mavrk.png)" :class="{on: page == 2}">ravex</a>
					<ul :class="{on: page == 2}">
						<!--<li><a href="#." :class="{on: sub == 1}" >개요</a></li>-->
						<li><router-link :to="{name: 'MavrkChartMain'}" :class="{on: sub == 1}">차트 데이터</router-link></li>
					</ul>
				</li>
				<li>
					<a  :class="{on: page == 3}" style="background-image:url(/img/side_menu_melon.png)">melon</a>
					<ul :class="{on: page == 3}">
						<li><router-link :to="{name: 'Rank' ,query: {type :'top100'}}" :class="{on: page == 3 &&sub == 1 && this.$route.query.type =='top100'}">TOP100</router-link></li>
						<li><router-link :to="{name: 'RankTransition' ,query: {type:'top100'}}" :class="{on: page == 3 &&sub == 2 && this.$route.query.type =='top100'}">TOP 100순위 추이</router-link></li>
						<li><router-link :to="{name: 'MelonTopCount'}" :class="{on: sub == 3}">TOP 100이용자수 추이</router-link></li>
						<li><router-link :to="{name: 'Rank' ,query: {type :'newtop100w1'}}" :class="{on: page == 3 &&sub == 1 && this.$route.query.type =='newtop100w1'}">최신 차트 순위</router-link></li>
						<li><router-link :to="{name: 'RankTransition' ,query: {type:'newtop100w1'}}" :class="{on: page == 3 &&sub == 2 && this.$route.query.type =='newtop100w1'}">최신 차트 순위 추이</router-link></li>
						<li><router-link :to="{name: 'Rank' ,query: {type :'realchart'}}" :class="{on: page == 3 && sub == 1&& this.$route.query.type =='realchart'}">실시간차트</router-link></li>
						<li><router-link :to="{name: 'RankTransition' ,query: {type:'realchart'}}" :class="{on: page == 3 && sub == 2&& this.$route.query.type =='realchart'}">실시간 순위 추이</router-link></li>
						<li><router-link :to="{name: 'Rank' ,query: {type :'dailychart'}}" :class="{on: page == 3 && sub == 1 && this.$route.query.type =='dailychart'}">일간차트</router-link></li>
						<li><router-link :to="{name: 'RankTransition' ,query: {type:'dailychart'}}" :class="{on: page == 3 &&sub == 2&& this.$route.query.type =='dailychart'}">일간 이용자수 추이</router-link></li>
						<li><router-link :to="{name: 'RankTransition' ,query: {type:'streamingcard'}}" :class="{on: page == 3 &&sub == 2&& this.$route.query.type =='streamingcard'}">감상자수 스트리밍수추이</router-link></li>
					</ul>
				</li>
				<li>
					<a  :class="{on: page == 4}" style="background-image:url(/img/side_menu_genie.png)">genie</a>
					<ul :class="{on: page == 4}">
						<li><router-link :to="{name: 'GenieRank' ,query: {type :'realchart'}}" :class="{on: page == 4 &&sub == 1 && this.$route.query.type =='realchart'}">실시간차트</router-link></li>
						<li><router-link :to="{name: 'GenieRankTransition' ,query: {type:'realchart'}}" :class="{on: page == 4 &&sub == 2 && this.$route.query.type =='realchart'}">실시간 순위 추이</router-link></li>
						<li><router-link :to="{name: 'GenieRank' ,query: {type :'dailychart'}}" :class="{on: page == 4 &&sub == 1 && this.$route.query.type =='dailychart'}">일간차트</router-link></li>
						<li><router-link :to="{name: 'GenieRankTransition' ,query: {type:'dailychart'}}" :class="{on: page == 4 &&sub == 2 && this.$route.query.type =='dailychart'}">일간 이용자수 추이</router-link></li>
						<li><router-link :to="{name: 'GenieRankTransition' ,query: {type:'24hour'}}" :class="{on: page == 4 &&sub == 2 && this.$route.query.type =='24hour'}">24시간 재생수 추이</router-link></li>
					</ul>
				</li>
				<!--<li>
					<a  style="background-image:url(/img/side_menu_youtube.png)">youtube</a>
					<ul>
						<li>음악차트</li>
						<li>뮤직비디오 차트</li>
					</ul>
				</li>-->
			</ul>

			<p class="pc-control-btn">
				<button><i class="xi-angle-left"></i></button>
			</p>
		</aside>
		<!-- adide -->





</template>

<script>
import ax from '@/api/login'
export default {
  name: 'Menu',

  data() {
    return {
      role : '',
      page: this.$route.meta.dep,
      sub: this.$route.meta.sub
    }
  },
  mounted(){
    this.getUserInfo();

  },
  watch: {
    '$route.name': function() {
      this.page = this.$route.meta.dep
      this.sub = this.$route.meta.sub
      $('#side_nav').removeClass('side_on');
      $('#mobile_menu_btn').removeClass('side_on');
      this.getUserInfo()
    },
    '$route.query':function(){
      $('#side_nav').removeClass('side_on');
      $('#mobile_menu_btn').removeClass('side_on');
    }

  },
  methods:{
    getUserInfo(){
      ax.getAuth(this.form, (flag, data) => {
        if (flag) {
          this.role = data.role;
          this.$parent.userName = data.name;
          this.$parent.userId = data.email;
        } else {
          this.$router.push({
            name: 'Main',
          });
        }
      })
    }
  }
}


</script>
