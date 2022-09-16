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
        <div class="page_container">
        <div class="cont_box search_form_box">
          <div class="search_form">
            <div><input type="date" placeholder="날짜" v-model="form.start"/></div>
            <div><input type="date" placeholder="날짜" v-model="form.end"/></div>
            <div><button @click="getList()"><img src="/img/icon_search.png" alt="search" ></button></div>
          </div>
        </div>
      </div>
				<div class="cont_box song_result">
          <h4 class="cont_title mb20">
            {{artist}} - {{songName}}
          </h4>
					<div class="table_type1 border_table">
						<div class="table_col_scroll">
							<table  style="min-width:650px;">
								<thead>
									<tr>
										<th>날짜</th>
										<th>시간</th>
										<th>일간순위</th>
										<th>맬론감상자</th>
										<th>남아있는 유저</th>
										<th>시간별 신규유입(6:4)</th>
										<th>신규유입(스트카드)</th>
										<th>신규유입</th>
										<th>이탈자</th>
									</tr>
								</thead>
								<tbody>
									<tr  v-for="(item, idx) in list" :key="idx">
										<td rowspan="2" class="bg_g" v-if="idx%2 == 0">{{item.date}}</td>

										<td>{{item.time.substring(0,5)}}</td>
										<td class="bg_g" v-if="idx%2 == 0" rowspan="2">{{item.ranking}}</td>
										<td class="bg_g" v-if="idx%2 == 0" rowspan="2">{{comma(item.streamingCount)}}</td>
										<td>{{comma(item.remainUser)}}</td>
										<td>{{comma(item.amInflow)}} / {{comma(item.pmInflow)}}</td>
										<td>{{comma(item.newInflow)}}</td>
										<td class="fcRed">{{comma(item.newInflow)}}</td>
										<td class="fcBlue">{{comma(item.outflow)}}</td>
									</tr>

								</tbody>
							</table>
						</div>

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
  name: 'MavrkChartView',
  data(){
    return {
      genieRealChart:[],
      melonRealChart:[],
      melonTop100:[],
      genieRealChartData:[],
      genieRealChartLabel:[],
      melonRealChartData:[],
      melonRealChartLabel :[],
      melonTop100Data:[],
      melonTop100Label :[],
      dailyList : [],
      dailyData : [],
      dailyLabel :[],
      likeList : [],
      likeChart : [],
      likeData : [],
      likeLabel :[],
      loading :false,

      form :{
        melonId : this.$route.query.melonId,
        genieId : this.$route.query.genieId,
        start : '',
        end:''
      },
      song :{
        name : '',
        artists :[{
          name:''
        }],
        album : [{
          image:''
        }]
      },
      songName:'',
    }
  },
  mounted () {
    let nowDate = new Date();
    this.form.end = moment(nowDate).format('YYYY-MM-DD')


    nowDate.setMonth(nowDate.getMonth()-1)
    this.form.start = moment(nowDate).format('YYYY-MM-DD')
    this.getList();
    this.getList();
    this.getSummary();
  },
  methods:{
    comma(v){
      return String(v).replace(/[^0-9]/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
    getList(){
      this.loading =true

      ax.getInfolowData(this.form, (flag, data) => {
        if (flag) {

          this.list = data.data
          this.loading = false;
        } else {
          alert(data.message)
          this.loading = false;
        }

      })
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

