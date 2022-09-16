<template>

<div class="inner_body">


<!-- loading -->
<div id="page_loading" v-if="loading">
  <div class="loading-container">
    <div class="loading"></div>
    <div id="loading-text">loading</div>
  </div>
</div>
<!-- //loading -->
<div class="page_title">
  <h3>GENIE REALCHART</h3>
  <small>{{this.$route.query.searchDate}}({{getWeek(this.$route.query.searchDate)}}) {{this.$route.query.searchTime}}시 기준</small>
</div>
<div class="page_container page_container-sm">
  <div class="cont_box song_list_control">
    <div>
      <button><i class="xi-angle-left"></i></button>
      <div class="over_btn">
        <button @click="changeTime(-1)"><i class="xi-check-min" ></i> 이전시각</button>
        <button @click="changeDate(-1)"><i class="xi-check-min"></i> 이전날짜</button>
      </div>
    </div>
    <div class="date">
      {{this.$route.query.searchDate}}({{getWeek(this.$route.query.searchDate)}})
      <br />{{this.$route.query.searchTime}}:00
    </div>
    <div>
      <button><i class="xi-angle-right"></i></button>
      <div class="over_btn">
        <button @click="changeTime(+1)"><i class="xi-check-min"></i> 다음시각</button>
        <button @click="changeDate(+1)"><i class="xi-check-min"></i> 다음날짜</button>
      </div>
    </div>
  </div>
</div>

<div class="song_list_body mt60 mt30-md">
  <div class="list_head">
    <ul>
      <li>순위</li>
      <li class="subject song_info">곡정보</li>
      <li>좋아요</li>
      <li>1시간</li>
      <li>24시간</li>
    </ul>
  </div>
  <div class="list_body">
    <ul v-for="(item, idx) in list" :key="idx" @click="getTopRank(item.song[0].name.platform, item.song[0].id)">
      <li class="num">
        <div>
          <p class="no">{{item.ranking}}</p>
          <p :class="'status '+item.rank"><img :src="'/img/icon_'+item.rank+'.png'" alt="" v-if="item.rank != ''"> {{ranking(item.ranking, item.preRanking, idx)}}</p>
        </div>
      </li>
      <li class="subject song_info">
        <div class="thum"><img :src="item.song[0].album[0].image" alt=""></div>
        <div class="title">
          <p>	{{item.song[0].name}}</p>
          <p>	{{item.song[0].artists[0].name}}</p>
        </div>
      </li>
      <li>
        <i class="xi-heart-o"></i> <strong>{{comma(item.songLike)}}</strong>
      </li>
      <li><strong>{{comma(item.dailyCount)}}</strong></li>
      <li><strong>{{comma(item.hourlyCount)}}</strong></li>
    </ul>
    <ul v-if="list.length ==0 ">
      <li >조회된 내역이 없습니다.</li>
    </ul>
  </div>
</div>
</div>


</template>

<script>
import ax from '@/api/genie'
export default {
  name: 'MeloneTopView',
  data(){
    return {
      list:[],
      searchMonth :[],
      loading:false,
      form :{
        searchDate : this.$route.query.searchDate,
        searchTime : this.$route.query.searchTime
      }
    }
  },
  mounted(){
    if(this.$route.query.searchTime == null || this.$route.query.searchDate == null){
      alert('잘못된 접근입니다.');
      this.$router.replace({
        name: 'GenieTop'
      });
    }

    this.getInfo()
  },

  methods:{
    getInfo(){
      let dateArr = this.form.searchDate.split("-")
      let params = {}

      params.year = dateArr[0]
      params.month = dateArr[1]
      params.day = dateArr[2]
      params.time = this.form.searchTime
      this.loading =true
      ax.getTop100List(params, (flag, data) => {
        if (flag) {
          console.dir(data)
          this.list= data.data
          this.loading =false
        } else {
          alert(data.message)
        }
      })
    },
    comma(v){
      return String(v).replace(/[^0-9]/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
    ranking(v, pv, idx){
      const rank = v-pv;
      if(rank < 0){
        this.list[idx].rank = 'down'
      } else if (rank ==0){
        this.list[idx].rank = ''
      } else{
        this.list[idx].rank = 'up'
      }
      return Math.abs(rank) == 0 ? '-' : Math.abs(rank)
    },
    getWeek(v){
      let day = new Date(v);
      const WEEKDAY = ['일', '월', '화', '수', '목', '금', '토'];
      return WEEKDAY[day.getDay()];
    },
    changeTime(v){
      let time = parseInt(this.form.searchTime) + v;
      if(time ==24){
        time = 0;
      }
      if(time < 0){
        time = 23
      }
      this.$router.push({
        name: 'MelonTopView',
        query: { searchDate: this.form.searchDate, searchTime : time },
      });
    },
    changeDate(v){
      let date = new Date(this.form.searchDate);
      date.setDate(date.getDate() + v);
      date = moment(date).format('YYYY-MM-DD')
      this.$router.push({
        name: 'MelonTopView',
        query: { searchDate: date, searchTime : this.form.searchTime },
      });
    },

    getTopRank(platform, id){
      this.$router.push({
        name: 'GenieTopRankView',
        query: { platform: 'genie', songId : id},
      });
    }



  }
}
</script>

