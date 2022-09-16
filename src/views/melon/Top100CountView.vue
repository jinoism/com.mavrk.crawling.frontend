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

				<div class="page_title">
					<h3>MELON TOP100<br /> 이용자 추이</h3>
				</div>
				<div class="page_container">
					<div class="button_quick">
					<div>
            <button>Melon</button>
            <ul>
                <li><router-link :to="{name: 'RankTransitionView' ,query: {type:'top100',songId : this.$route.query.songId, genieId:this.genieId}}" :class="{on: page == 3 &&sub == 2 && this.$route.query.type =='top100'}">TOP 100순위 추이</router-link></li>
                <li><router-link :to="{name: 'MelonTopCountView' ,query:{songId : this.$route.query.songId, genieId:this.genieId}}" :class="{on: sub == 3}">TOP 100이용자수 추이</router-link></li>
                <li><router-link :to="{name: 'RankTransitionView' ,query: {type:'newtop100w1' , songId : this.$route.query.songId, genieId:this.genieId}}" :class="{on: page == 3 &&sub == 2 && this.$route.query.type =='newtop100w1'}">4주 차트 순위 추이</router-link></li>
                <li><router-link :to="{name: 'RankTransitionView' ,query: {type:'realchart', songId : this.$route.query.songId, genieId:this.genieId}}" :class="{on: page == 3 && sub == 2&& this.$route.query.type =='realchart'}">실시간 순위 추이</router-link></li>
                <li><router-link :to="{name: 'RankTransitionView' ,query: {type:'dailychart', songId : this.$route.query.songId, genieId:this.genieId}}" :class="{on: page == 3 &&sub == 2&& this.$route.query.type =='dailychart'}">일간 이용자수 추이</router-link></li>
                <li><router-link :to="{name: 'RankTransitionView' ,query: {type:'streamingcard', songId : this.$route.query.songId, genieId:this.genieId}}" :class="{on: page == 3 &&sub == 2&& this.$route.query.type =='streamingcard'}">감상자수 스트리밍수추이</router-link></li>
            </ul>
          </div>
          <div>
            <button>Genie</button>
            <ul>
              <li><router-link :to="{name: 'GenieRankTransitionView' ,query: {type:'realchart', songId:this.genieId , melonId :this.$route.query.songId}}" :class="{on: page == 4 &&sub == 2 && this.$route.query.type =='realchart'}">실시간 순위 추이</router-link></li>
              <li><router-link :to="{name: 'GenieRankTransitionView' ,query: {type:'dailychart', songId:this.genieId, melonId :this.$route.query.songId}}" :class="{on: page == 4 &&sub == 2 && this.$route.query.type =='dailychart'}">일간 이용자수 추이</router-link></li>
              <li><router-link :to="{name: 'GenieRankTransitionView' ,query: {type:'24hour', songId:this.genieId, melonId :this.$route.query.songId}}" :class="{on: page == 4 &&sub == 2 && this.$route.query.type =='streamingcard'}">24시간 재생수 추이</router-link></li>
            </ul>
          </div>
					</div>
				</div>



				<div class="cont_box song_result mt20">
					<h4 class="cont_title mb20">
            {{artist}} - {{songName}}<br><br>
						{{this.$route.query.startDate}}({{getWeek(this.$route.query.startDate)}})
            {{this.$route.query.startTime}}:00 ~
            {{this.$route.query.endDate}}({{getWeek(this.$route.query.endDate)}})
            {{this.$route.query.endTime}}:00
					</h4>
					<div class="table_type1 ">
						<div class="table_col_scroll">
							<table >
								<thead>
									<tr>
										<th>시간</th>
										<th>순위</th>
										<th>1시간</th>
										<th>변화량</th>
										<th>24시간</th>
										<th>변화량</th>
										<!--<th>비율</th>-->
									</tr>
								</thead>
								<tbody>
									<tr v-for="(item, idx) in list" :key="idx">
										<td>{{item.time.substring(0,16)}}</td>
										<td>{{item.ranking}}</td>
										<td>{{comma(item.hourlyCount)}}</td>
										<td :class="this.hourlyCount(idx) > 0 ? 'fcRed' : 'fcBlue'">{{this.hourlyCount(idx) > 0 ? '+' + comma(this.hourlyCount(idx)) :comma(this.hourlyCount(idx))}}</td>
										<td>{{comma(item.dailyCount)}}</td>
										<td :class="this.dailyCount(idx) > 0 ? 'fcRed' : 'fcBlue'">{{this.dailyCount(idx) > 0 ? '+' + comma(this.dailyCount(idx)) :comma(this.dailyCount(idx))}}</td>
										<!--<td></td>-->
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
import ax from '@/api/melon'
export default {
  name: 'MeloneTopCount',
  data(){
    return {

      loading :false,
      searchMonth :[],
      genieId : this.$route.query.genieId,
      form :{
        searchDate :'',
        searchTime :'',
        songid : this.$route.query.songId

      }
    }
  },
  mounted(){
    let nowDate = new Date();
    if (this.$route.query.startDate == null ||this.$route.query.startTime == null || this.$route.query.endTime == null || this.$route.query.endDate == null){
      let endDate = moment(nowDate).format('YYYY-MM-DD')
      let endTime = moment(nowDate).format('HH')
      let startTime = moment(nowDate).format('HH')
      nowDate.setDate(nowDate.getDate()-7)
      let startDate = moment(nowDate).format('YYYY-MM-DD')
      this.$router.replace({
        name: 'MelonTopCountView',
        query: { startDate: startDate, startTime : startTime, endDate: endDate, endTime : endTime,  songId:this.$route.query.songId, genieId : this.$route.query.genieId },
      });
      return;
    } else {

      this.getInfo()
    }
  },
  methods:{
    getInfo(){
      let dateArr = this.form.searchDate.split("-")
      let params = {}

      params.start = this.$route.query.startDate + ' ' + this.$route.query.startTime
      params.end = this.$route.query.endDate + ' ' + this.$route.query.endTime
      params.songId = this.$route.query.songId

      this.loading =true
      ax.getTop100Count(params, (flag, data) => {
        if (flag) {


          this.artist = data.song[0].artists[0].name;
          this.songName = data.song[0].name;
          this.list= data.data
          //this.list.sort((a, b) => new Date(b.time) - new Date(a.time));
          this.loading =false
        } else {
          alert(data.message)
        }
      })
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
        name: 'MelonTopCountView',
        query: { searchDate: this.form.searchDate, searchTime : time, songId:this.form.songid},
      });
    },
    comma(n){
      var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
      n += '';                          // 숫자를 문자열로 변환

      while (reg.test(n))
        n = n.replace(reg, '$1' + ',' + '$2');

      return n;
    },
    changeDate(v){
      let date = new Date(this.form.searchDate);
      date.setDate(date.getDate() + v);
      date = moment(date).format('YYYY-MM-DD')
      this.$router.push({
        name: 'MelonTopCountView',
        query: { searchDate: date, searchTime : this.form.searchTime, songId:this.form.songid },
      });
    },
    hourlyCount(idx){
      let prevVal = 0;
      if (this.list[idx-1] != undefined){
        prevVal = this.list[idx-1].hourlyCount;
      } else {
        return '-'
      }
      return this.list[idx].hourlyCount - prevVal;
    },
    dailyCount(idx){
      let prevVal = 0;
      if (this.list[idx-1] != undefined){
        prevVal = this.list[idx-1].dailyCount;
      } else {
        return '-'
      }
      return this.list[idx].dailyCount - prevVal;
    }
  }
}
</script>

