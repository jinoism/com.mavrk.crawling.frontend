<template>
<!-- /공지사항 -->
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
  <h3>ravex</h3>
  <small>Chart 데이터 검색</small>
</div>
<div class="page_container page_container-sm">
  <div class="cont_box song_list_control">
    <div>
      <button><i class="xi-angle-left"></i></button>
      <div class="over_btn">
        <button @click="changeDate(-1)" v-if="this.$route.query.type!='dailychart'"><i class="xi-check-min"></i> 이전날짜</button>
      </div>
    </div>
    <div class="date">
      {{this.form.issueDate}}({{getWeek(this.form.issueDate)}})

    </div>
    <div>
      <button><i class="xi-angle-right"></i></button>
      <div class="over_btn">
        <button @click="changeDate(+1)"><i class="xi-check-min"></i> 다음날짜</button>
      </div>
    </div>
  </div>
</div>

<div class="cont_box song_result">
  <h4 class="cont_title mb20">
    {{artist}} - {{songName}}
  </h4>
  <div class="table_type1 border_table">
    <div class="table_col_scroll">
      <table  style="min-width:950px;">
        <thead>
          <tr>
            <th>시간</th>
            <th class="bg_g">멜론<br />실시간차트</th>
            <th class="bg_o">멜론<br />좋아요</th>
            <th class="bg_g">멜론<br />좋아요(증가량)</th>
            <th class="bg_b">지니<br />실시간차트</th>
            <th class="bg_o">지니<br />청취자수</th>
            <th class="bg_b">지니<br />청취자수(증가량)</th>
            <th class="bg_o">지니<br />전체재생</th>
            <th class="bg_b">지니<br />전체재생(증가량)</th>
            <th class="bg_b">지니<br />빈도수</th>
          </tr>
        </thead>
        <tbody>
          <tr  v-for="(item, idx) in list" :key="idx">
            <td>{{item.mTime.substring (11, 16)}}</td>
            <td>{{item.mRanking}}</td>
            <td class="bg_o">{{comma(item.mLikeCount)}}</td>
            <td>{{getMelonCount(idx)}}</td>
            <td>{{item.gRanking}}</td>
            <td class="bg_o">{{comma(item.gUserCount)}}</td>
            <td>{{getgUserCount(idx)}}</td>
            <td class="bg_o">{{comma(item.gStreamingCount)}}</td>
            <td>{{getgStreamingCount(idx)}}</td>
            <td>{{(item.gStreamingCount/item.gUserCount).toFixed(1)}}</td>
          </tr>
          <tr v-if ="this.list.length ==0">
            <td colspan="10">조회된 내역이 없습니다.</td>
          </tr>

        </tbody>
      </table>
    </div>
    <!--<p class="more_lsit">
      <button><i class="xi-angle-down"></i><i class="xi-angle-down"></i></button>
    </p>-->
  </div>

</div>
</div>





</template>

<script>
import {Chart, Line, registerables, BarElement, LineController, BarController, PointElement, LinearScale, Title, CategoryScale, LineElement, Legend} from 'chart.js'
Chart.register( BarElement, BarController, LineController, PointElement, LineElement, LinearScale, Title, CategoryScale, Legend);
import ax from '@/api/mavrk'
let chart = null
let dailyChart = null
let likeChart = null
export default {
  name: 'MavrkHeartView',
  data(){
    return {
      list:[],
      loading :false,

      form :{
        melonId : this.$route.query.melonId,
        genieId : this.$route.query.genieId
      },
      songName: '',
      song :{
        name : '',
        artists :[{
          name:''
        }],
        album : [{
          image:''
        }]
      }
    }
  },
  mounted () {
    if (this.$route.query.searchDate ==null ){
      let date = new Date();
      this.form.issueDate = moment(date).format('YYYY-MM-DD')
    } else {
      this.form.issueDate = this.$route.query.searchDate;
    }

    this.getList();
    this.getSummary();
  },
  methods:{
    comma(v){
      return String(v).replace(/[^0-9]/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
    getList(){
      this.loading =true

      ax.getHeartData(this.form, (flag, data) => {
        if (flag) {
          this.list = data.data
          this.loading = false;
        } else {
          alert(data.message)
          this.loading = false;
        }

      })
    },
    getMelonCount(idx){
      if (this.list[idx+1] ==undefined ){
        return '-'
      } else {
        return this.comma(this.list[idx].mLikeCount - this.list[idx+1].mLikeCount)
      }
    },
    getgUserCount(idx){
      if (this.list[idx+1] ==undefined ){
        return '-'
      } else {
        return this.comma(this.list[idx].gUserCount - this.list[idx+1].gUserCount)
      }
    },
    getgStreamingCount(idx){
      if (this.list[idx+1] ==undefined ){
        return '-'
      } else {
        return this.comma(this.list[idx].gStreamingCount - this.list[idx+1].gStreamingCount)
      }
    },

    getWeek(v){
      let day = new Date(v);
      const WEEKDAY = ['일', '월', '화', '수', '목', '금', '토'];
      return WEEKDAY[day.getDay()];
    },
    changeTime(v){
      let time = parseInt(this.form.searchTime) + v;
      if (time ==24){
        time = 0;
      }
      if (time < 0){
        time = 23
      }
      this.$router.push({
        name: 'RankView',
        query: { searchDate: this.form.searchDate, searchTime : time, type :this.form.type   },
      });
    },
    changeDate(v){
      let date = new Date(this.form.issueDate);
      date.setDate(date.getDate() + v);
      date = moment(date).format('YYYY-MM-DD')
      this.$router.push({
        name: 'MavrkHeartView',
        query: { searchDate: date, searchTime : this.form.searchTime, type :this.form.type,melonId :this.form.melonId, genieId : this.form.genieId },
      });
    },
    getSummary(){
      let params = {}
      params.melonId = this.form.melonId;
      params.genieId = this.form.genieId;
      ax.getDetailData(params, (flag, data) => {
        if (flag) {

          this.songName  = data.song[0].name
          this.artist = data.song[0].artists[0].name

        } else {
          alert(data.message)

        }

      })
    },

  }
}
</script>

