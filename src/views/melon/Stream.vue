<template>

<!-- /공지사항 -->
<div class="inner_body">



  <div class="page_title">
    <h3>MELON 감상자수<br /> 스트리밍추이</h3>
  </div>
  <div class="page_container">
    <div class="cont_box search_form_box">
      <div class="search_form">
        <div><input type="text" placeholder="곡명" /></div>
        <div><input type="text" placeholder="가수명" /></div>
        <div><button><img src="/img/icon_search.png" alt="search"></button></div>
      </div>
    </div>
  </div>
</div>


</template>

<script>
import ax from '@/api/melon'
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
      }else if (rank ==0){
        this.list[idx].rank = ''
      }else{
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
        name: 'MelonTopRankView',
        query: { platform: 'melon', songId : id},
      });
    }



  }
}
</script>

