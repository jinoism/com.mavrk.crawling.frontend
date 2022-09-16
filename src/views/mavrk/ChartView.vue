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

				<div class="page_container wp100">

					<!-- 타이틀 -->
					<div class="cont_box song_title">
						<div class="thum">
							<p><img :src="this.song.album[0].image" alt=""></p>
						</div>
						<div class="info">
							<p class="title">{{this.song.name}}</p>
							<p class="artist">{{this.song.artists[0].name}}</p>
						</div>
					</div>
					<!-- 타이틀 -->


          <!-- 옵션1 -->
          <div class="chart_option_check mt40">
						<ul>
							<li>
								<p class="checkbox">
									<input type="checkbox" value="0" name="" id="option_top100" true-value="0" @change="toggleChart" v-model="form.realChartCheck" />
									<label for="option_top100">멜론TOP100</label>
								</p>
							</li>
							<li>
								<p class="checkbox">
									<input type="checkbox" value="1" name="" id="option_melon"  true-value="1" @change="toggleChart" v-model="form.realChartCheck" />
									<label for="option_melon">멜론실시간</label>
								</p>
							</li>
							<li>
								<p class="checkbox">
									<input type="checkbox" value="2" name="" id="option_genie"  true-value="2" @change="toggleChart" v-model="form.realChartCheck" />
									<label for="option_genie">지니실시간</label>
								</p>
							</li>
						</ul>
					</div>
          <!-- //옵션1 -->

          <!-- 날짜 -->
          <div class="page_container mb20 mt20">
            <div class="cont_box search_form_box">
                <div class="search_form">
                    <div><input type="date" v-model="form.melonStDate" placeholder="날짜" /></div>
                    <div><input type="date" v-model="form.melonEdDate" placeholder="날짜" /></div>
                    <div><button><img src="/img/icon_search.png" alt="search" @click="getList"></button></div>
                </div>
            </div>
          </div>
          <!-- //날짜 -->


					<!-- 시실간 차트 -->
					<div class="cont_box melon_live_chart mt20">
						<h4 class="cont_title">Melon 실시간 차트</h4>
						<div id="graph_div">
               <canvas class="graph" id="chart" ></canvas>
            </div>
					</div>
					<!--  시실간 차트 -->

					<!-- 곡상세정보 -->
					<div class="row">
						<div class="col-lg-6">
							<div class="cont_box mt20">
								<h4 class="cont_title mb20">Melon</h4>
								<ul class="list-unstyled info_box_2">
									<li>
										<p>일간순위</p>
										<p><strong>{{comma(summary.melon.ranking)}}위</strong></p>
									</li>
									<li>
										<p>일간감상자</p>
										<p><strong>{{comma(summary.melon.dailyCount)}}</strong></p>
									</li>
									<li>
										<p>스트리밍감상자</p>
										<p><strong>{{comma(summary.melon.streamingCount)}}</strong></p>
									</li>
									<li>
										<p>총감상자</p>
										<p><strong>{{comma(summary.melon.userCount)}}</strong></p>
									</li>
									<li>
										<p>곡하트</p>
										<p><strong>{{comma(summary.melon.songLike)}}</strong></p>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="cont_box mt20">
								<h4 class="cont_title mb20">Genie</h4>
								<ul class="list-unstyled info_box_2">
									<li>
										<p>일간순위</p>
										<p><strong>{{comma(summary.genie.ranking)}}위</strong></p>
									</li>
									<li>
										<p>총감상자</p>
										<p><strong>{{comma(summary.genie.userCount)}}</strong></p>
									</li>
									<li>
										<p>스트리밍감상자</p>
										<p><strong>{{comma(summary.genie.streamingCount)}}</strong></p>
									</li>

								</ul>
							</div>
						</div>
					</div>
					<!-- //곡상세정보 -->

        <!-- 옵션2 -->
         <div class="chart_option_check option2 mt40">
						<ul>
							<li>
								<p class="checkbox">
									<input type="checkbox" value="" name="" id="option2_all" @change="allCheck" v-model="form.allCheck"/>
									<label for="option2_all">전체</label>
								</p>
							</li>
							<li>
								<p class="checkbox">
									<input type="checkbox" value="0" name="" id="option2_man" @change="toggleDailyChart" v-model="form.dailyChartCheck"/>
									<label for="option2_man">남성</label>
								</p>
							</li>
							<li>
								<p class="checkbox">
									<input type="checkbox" value="1" name="" id="option2_woman" @change="toggleDailyChart" v-model="form.dailyChartCheck"/>
									<label for="option2_woman">여성</label>
								</p>
							</li>
							<li>
								<p class="checkbox">
									<input type="checkbox" value="2" name="" id="option2_year10" @change="toggleDailyChart" v-model="form.dailyChartCheck"/>
									<label for="option2_year10">10대</label>
								</p>
							</li>
							<li>
								<p class="checkbox">
									<input type="checkbox" value="3" name="" id="option2_year20" @change="toggleDailyChart" v-model="form.dailyChartCheck"/>
									<label for="option2_year20">20대</label>
								</p>
							</li>
							<li>
								<p class="checkbox">
									<input type="checkbox" value="4" name="" id="option2_year30" @change="toggleDailyChart" v-model="form.dailyChartCheck"/>
									<label for="option2_year30">30대</label>
								</p>
							</li>
              <li>
								<p class="checkbox">
									<input type="checkbox" value="5" name="" id="option2_year40" @change="toggleDailyChart" v-model="form.dailyChartCheck"/>
									<label for="option2_year40">40대</label>
								</p>
							</li>
              <li>
								<p class="checkbox">
									<input type="checkbox" value="6" name="" id="option2_year50" @change="toggleDailyChart" v-model="form.dailyChartCheck"/>
									<label for="option2_year50">50대</label>
								</p>
							</li>
              <li>
								<p class="checkbox">
									<input type="checkbox" value="7" name="" id="option2_year60" @change="toggleDailyChart" v-model="form.dailyChartCheck"/>
									<label for="option2_year60">60대</label>
								</p>
							</li>
						</ul>
					</div>
          <!-- 옵션2 -->

          <!-- 날짜 -->
            <div class="page_container mb20 mt20">
              <div class="cont_box search_form_box">
                  <div class="search_form">
                      <div><input type="date" v-model="form.liveStDate" placeholder="날짜" /></div>
                      <div><input type="date" v-model="form.liveEdDate" placeholder="날짜" /></div>
                      <div><button><img src="/img/icon_search.png" alt="search" @click="getDailyList"></button></div>
                  </div>
              </div>
            </div>
          <!-- //날짜 -->

					<!-- 시실간 차트 -->
					<div class="cont_box melon_live_chart mt20">
						<div id="daily_graph_div" >
               <canvas class="graph" id="daily_chart" ></canvas>
            </div>

					</div>


					<!--  시실간 차트 -->


					<!-- 곡 result -->
					<div class="cont_box song_result mt20">
						<h4 class="cont_title mb20">
							<!--Melon 실시간 차트-->
							<button class="refresh"><i class="xi-renew" @click="dailyChange()"></i></button>
						</h4>
						<div class="table_type1">
							<div class="table_col_scroll">
								<table style="min-width:900px;" v-if="!dailyChangeFlag">
									<colgroup>
										<col>
										<col>
										<col>
										<col>
										<col>
										<col>
										<col>
										<col>
										<col>
										<col>
									</colgroup>
									<thead>
										<tr>
											<th>Melon</th>
											<th>일간감상자</th>
											<th>남성</th>
											<th>여성</th>
											<th>10대</th>
											<th>20대</th>
											<th>30대</th>
											<th>40대</th>
											<th>50대</th>
											<th>60대</th>
										</tr>
									</thead>
									<tbody>
										<template v-for="(item, idx) in dailyList" :key="idx">
										<tr v-if="idx < 7 || dailyMore" >
											<td>{{item.time.substring(0,10)}}</td>
											<td>{{comma(item.dailyCount)}}</td>
											<td>{{item.male}}</td>
											<td>{{item.female}}</td>
											<td>{{item.age10}}</td>
											<td>{{item.age20}}</td>
											<td>{{item.age30}}</td>
											<td>{{item.age40}}</td>
											<td>{{item.age50}}</td>
											<td>{{item.age60}}</td>
										</tr>
                    </template>

									</tbody>
								</table>
                <table style="min-width:900px;" v-if="dailyChangeFlag">
									<colgroup>
										<col>
										<col>
										<col>
										<col>
										<col>
										<col>
										<col>
										<col>
										<col>
										<col>
									</colgroup>
									<thead>
										<tr>
											<th>Melon</th>
											<th>일간감상자</th>
											<th>남성</th>
											<th>여성</th>
											<th>10대</th>
											<th>20대</th>
											<th>30대</th>
											<th>40대</th>
											<th>50대</th>
											<th>60대</th>
										</tr>
									</thead>
									<tbody>
                    <template v-for="(item, idx) in dailyCountList" :key="idx">
										<tr v-if="idx < 7 || dailyMore" >
											<td>{{item.time.substring(0,10)}}</td>
											<td>{{comma(item.dailyCount)}}</td>
											<td>{{comma(item.male)}}</td>
											<td>{{comma(item.female)}}</td>
											<td>{{comma(item.age10)}}</td>
											<td>{{comma(item.age20)}}</td>
											<td>{{comma(item.age30)}}</td>
											<td>{{comma(item.age40)}}</td>
											<td>{{comma(item.age50)}}</td>
											<td>{{comma(item.age60)}}</td>
										</tr>
                    </template>
									</tbody>
								</table>
							</div>
							<p class="more_lsit">
								<button @click="this.dailyMore =true;dailyMoreChange()" v-if="!dailyMore && dailyCountList.length > 7"><i class="xi-angle-down"></i><i class="xi-angle-down"></i></button>
							</p>
						</div>

					</div>
					<!-- 곡 result -->
          <!-- 날짜 -->
          <div class="page_container mb20 mt20">
            <div class="cont_box search_form_box">
                <div class="search_form">
                    <div><input type="date" v-model="form.likeStDate" placeholder="날짜" /></div>
                    <div><input type="date" v-model="form.likeEdDate" placeholder="날짜" /></div>
                    <div><button><img src="/img/icon_search.png" alt="search" @click="getLikeList"></button></div>
                </div>
            </div>
          </div>
          <!-- //날짜 -->
					<!-- 시실간 차트 -->
					<div class="cont_box melon_live_chart mt20">
						<h4 class="cont_title">Like 차트</h4>
						<div id="like_graph_div">
               <canvas class="graph" id="like_chart" ></canvas>
            </div>
					</div>
					<!--  시실간 차트 -->

					<!-- 곡 result -->
					<div class="cont_box song_result mt20">
						<h4 class="cont_title mb20">
							Melon Like 차트
							<!--<button class="refresh"><i class="xi-renew"></i></button>-->
						</h4>
						<div class="table_type1">
							<table>
								<colgroup>
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>날짜</th>
										<th>누적 좋아요</th>
										<th>일일 증가량</th>

									</tr>
								</thead>
								<tbody>
                  <template v-for="(item, idx) in likeList" :key="idx">
									<tr  v-if="idx<7 ||likeMore ">
										<td>{{item.time.substring(0,10)}}</td>
										<td :class="likeColor(idx)">{{comma(item.count)}}</td>
										<td :class="likeColor(idx)">{{likeIncrease(idx)}}</td>

									</tr>
                  </template>
								</tbody>
							</table>
							<p class="more_lsit">
								<button @click="this.likeMore =true;likeChange()" v-if="!likeMore  && likeList.length > 7"><i class="xi-angle-down"></i><i class="xi-angle-down"></i></button>
							</p>
						</div>

					</div>
					<!-- 곡 result -->

				</div>
			</div>



</template>

<script>
import {Chart, Line, registerables, Tooltip, BarElement, LineController, BarController, PointElement, LinearScale, Title, CategoryScale, LineElement, Legend, TooltipOptions, tooltips} from 'chart.js'
Chart.register( BarElement, BarController, LineController, PointElement, LineElement, LinearScale, Title, CategoryScale, Legend, Tooltip);
import ax from '@/api/mavrk'
let chart = null
let dailyChart = null
let dailyCountChart = null
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
      maleData :[],
      maleLabel : [],
      femaleData :[],
      age10Data :[],
      age20Data :[],
      age30Data :[],
      age40Data :[],
      age50Data :[],
      age60Data :[],
      maleCountData :[],
      maleCountLabel : [],
      femaleCountData :[],
      age10CountData :[],
      age20CountData :[],
      age30CountData :[],
      age40CountData :[],
      age50CountData :[],
      age60CountData :[],
      maleWeekData :[],
      maleWeekLabel : [],
      femaleWeekData :[],
      age10WeekData :[],
      age20WeekData :[],
      age30WeekData :[],
      age40WeekData :[],
      age50WeekData :[],
      age60WeekData :[],
      maleCountWeekData :[],
      maleCountWeekLabel : [],
      femaleCountWeekData :[],
      age10CountWeekData :[],
      age20CountWeekData :[],
      age30CountWeekData :[],
      age40CountWeekData :[],
      age50CountWeekData :[],
      age60CountWeekData :[],
      maleAllData :[],
      maleAllLabel : [],
      femaleAllData :[],
      age10AllData :[],
      age20AllData :[],
      age30AllData :[],
      age40AllData :[],
      age50AllData :[],
      age60AllData :[],
      maleCountAllData :[],
      maleCountAllLabel : [],
      femaleCountAllData :[],
      age10CountAllData :[],
      age20CountAllData :[],
      age30CountAllData :[],
      age40CountAllData :[],
      age50CountAllData :[],
      age60CountAllData :[],
      dailyList : [],
      dailyCountList : [],
      dailyData : [],
      dailyLabel :[],
      likeList : [],
      likeChart : [],
      likeWeekChart : [],
      likeData : [],
      likeLabel :[],
      likeWeekData : [],
      likeWeekLabel :[],
      likeAllData : [],
      likeAllLabel :[],
      likeMore :false,
      dailyMore :false,
      loading :false,
      dailyChangeFlag : false,
      form :{
        realChartCheck :['0', '1', '2'],
        dailyChartCheck :['0', '1', '2', '3', '4', '5', '6', '7'],
        allCheck: true,
        melonId : this.$route.query.melonId,
        genieId : this.$route.query.genieId,
        melonStDate : '',
        melonEdDate :'',

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
      summary:{
        melon : {},
        genie : {}
      }
    }
  },
  mounted () {
    let nowDate = new Date();
    this.form.melonEdDate = moment(nowDate).format('YYYY-MM-DD')
    this.form.liveEdDate = moment(nowDate).format('YYYY-MM-DD')
    this.form.likeEdDate = moment(nowDate).format('YYYY-MM-DD')
    nowDate.setDate(nowDate.getDate()-2)
    this.form.melonStDate = moment(nowDate).format('YYYY-MM-DD')
    nowDate.setDate(nowDate.getDate()-12)
    this.form.liveStDate = moment(nowDate).format('YYYY-MM-DD')
    this.form.likeStDate = moment(nowDate).format('YYYY-MM-DD')




    this.getDailyList();
    this.getList();
    this.getLikeList();
    this.getSummary();
  },
  methods:{

    getDailyList(){
      if (dailyChart != null){
        dailyChart.destroy();
      }
      ax.getDailyChartData(this.form, (flag, data) => {
        if (flag) {
          this.song = data.song[0]
          this.dailyList = data.data;
          this.dailyCountList = _.merge(this.dailyCountList, data.data)
          console.dir(this.dailyList)
          console.dir(this.dailyCountList)

          this.maleCountAllData =[]
          this.maleCountAllLabel= []
          this.femaleCountAllData=[]
          this.age10CountAllData=[]
          this.age20CountAllData=[]
          this.age30CountAllData=[]
          this.age40CountAllData=[]
          this.age50CountAllData=[]
          this.age60CountAllData=[]

          this.maleAllData=[]
          this.maleAllLabel=[]
          this.femaleAllData=[]
          this.age10AllData=[]
          this.age20AllData=[]
          this.age30AllData=[]
          this.age40AllData=[]
          this.age50AllData=[]
          this.age60AllData=[]

          this.maleCountWeekData=[]
          this.maleCountWeekLabel=[]
          this.femaleCountWeekData=[]
          this.age10CountWeekData=[]
          this.age20CountWeekData=[]
          this.age30CountWeekData=[]
          this.age40CountWeekData=[]
          this.age50CountWeekData=[]
          this.age60CountWeekData=[]

          this.maleWeekData=[]
          this.maleWeekLabel=[]
          this.femaleWeekData=[]
          this.age10WeekData=[]
          this.age20WeekData=[]
          this.age30WeekData=[]
          this.age40WeekData=[]
          this.age50WeekData=[]
          this.age60WeekData=[]

          for (let i=0  ; i < this.dailyList.length; i++){

            this.dailyCountList[i].male = (this.dailyCountList[i].dailyCount * this.dailyList[i].male / 100).toFixed(0)
            this.dailyCountList[i].female = (this.dailyCountList[i].dailyCount * this.dailyList[i].female / 100).toFixed(0)
            this.dailyCountList[i].age10 = (this.dailyCountList[i].dailyCount * this.dailyList[i].age10 / 100).toFixed(0)
            this.dailyCountList[i].age20 = (this.dailyCountList[i].dailyCount * this.dailyList[i].age20 / 100).toFixed(0)
            this.dailyCountList[i].age30 = (this.dailyCountList[i].dailyCount * this.dailyList[i].age30 / 100).toFixed(0)
            this.dailyCountList[i].age40 = (this.dailyCountList[i].dailyCount * this.dailyList[i].age40 / 100).toFixed(0)
            this.dailyCountList[i].age50 = (this.dailyCountList[i].dailyCount * this.dailyList[i].age50 / 100).toFixed(0)
            this.dailyCountList[i].age60 = (this.dailyCountList[i].dailyCount * this.dailyList[i].age60 /  100).toFixed(0)

            this.maleCountAllData.push(this.dailyCountList[i].male)
            this.maleCountAllLabel.push(this.dailyCountList[i].time.substring(0, 10))
            this.femaleCountAllData.push(this.dailyCountList[i].female)
            this.age10CountAllData.push(this.dailyCountList[i].age10)
            this.age20CountAllData.push(this.dailyCountList[i].age20)
            this.age30CountAllData.push(this.dailyCountList[i].age30)
            this.age40CountAllData.push(this.dailyCountList[i].age40)
            this.age50CountAllData.push(this.dailyCountList[i].age50)
            this.age60CountAllData.push(this.dailyCountList[i].age60)

            this.maleAllData.push(this.dailyList[i].male)
            this.maleAllLabel.push(this.dailyList[i].time.substring(0, 10))
            this.femaleAllData.push(this.dailyList[i].female)
            this.age10AllData.push(this.dailyList[i].age10)
            this.age20AllData.push(this.dailyList[i].age20)
            this.age30AllData.push(this.dailyList[i].age30)
            this.age40AllData.push(this.dailyList[i].age40)
            this.age50AllData.push(this.dailyList[i].age50)
            this.age60AllData.push(this.dailyList[i].age60)

            if (i > this.dailyList.length -8){
              this.maleCountWeekData.push(this.dailyCountList[i].male)
              this.maleCountWeekLabel.push(this.dailyCountList[i].time.substring(0, 10))
              this.femaleCountWeekData.push(this.dailyCountList[i].female)
              this.age10CountWeekData.push(this.dailyCountList[i].age10)
              this.age20CountWeekData.push(this.dailyCountList[i].age20)
              this.age30CountWeekData.push(this.dailyCountList[i].age30)
              this.age40CountWeekData.push(this.dailyCountList[i].age40)
              this.age50CountWeekData.push(this.dailyCountList[i].age50)
              this.age60CountWeekData.push(this.dailyCountList[i].age60)

              this.maleWeekData.push(this.dailyList[i].male)
              this.maleWeekLabel.push(this.dailyList[i].time.substring(0, 10))
              this.femaleWeekData.push(this.dailyList[i].female)
              this.age10WeekData.push(this.dailyList[i].age10)
              this.age20WeekData.push(this.dailyList[i].age20)
              this.age30WeekData.push(this.dailyList[i].age30)
              this.age40WeekData.push(this.dailyList[i].age40)
              this.age50WeekData.push(this.dailyList[i].age50)
              this.age60WeekData.push(this.dailyList[i].age60)
            }
          }

          this.maleCountData = this.maleCountWeekData
          this.maleCountLabel = this.maleCountWeekLabel
          this.femaleCountData = this.femaleCountWeekData
          this.age10CountData = this.age10CountWeekData
          this.age20CountData = this.age20CountWeekData
          this.age30CountData = this.age30CountWeekData
          this.age40CountData = this.age40CountWeekData
          this.age50CountData = this.age50CountWeekData
          this.age60CountData = this.age60CountWeekData

          this.maleData = this.maleWeekData
          this.maleLabel = this.maleWeekLabel
          this.femaleData = this.femaleWeekData
          this.age10Data =this.age10WeekData
          this.age20Data =this.age20WeekData
          this.age30Data =this.age30WeekData
          this.age40Data =this.age40WeekData
          this.age50Data =this.age50WeekData
          this.age60Data =this.age60WeekData


          this.dailyList.sort((a, b) => new Date(b.time) - new Date(a.time));
          this.dailyCountList.sort((a, b) => new Date(b.time) - new Date(a.time));
          this.createDailyChart();

          console.dir(this.dailyList)
          console.dir(this.dailyCountList)

        } else {
          alert(data.message)
        }
      })
    },
    getLikeList(){
      if (likeChart != null){
        likeChart.destroy();
      }
      ax.getLikeChartData(this.form, (flag, data) => {
        if (flag) {
          this.likeList = data.data;
          this.likeChart = data.data;
          this.likeWeekChart;
          this.likeAllData =[]
          this.likeAllLabel =[]
          this.likeWeekData =[]
          this.likeWeekLabel = []
          for (let i=0  ; i < this.likeChart.length; i++){
            this.likeAllData.push(this.likeChart[i].count)
            this.likeAllLabel.push(this.likeChart[i].time.substring(0, 10))
          }

          if (this.likeChart.length > 7){
            for (let i=this.likeChart.length-7  ; i < this.likeChart.length ; i++){

              this.likeWeekData.push(this.likeChart[i].count)
              this.likeWeekLabel.push(this.likeChart[i].time.substring(0, 10))
            }
            this.likeData= this.likeWeekData;
            this.likeLabel= this.likeWeekLabel;
          } else {
            this.likeData= this.likeAllData;
            this.likeLabel= this.likeAllLabel;
          }
          this.likeList.sort((a, b) => new Date(b.time) - new Date(a.time));


          this.createLikeChart();

        } else {
          alert(data.message)
        }
      })
    },
    getList(){
      this.loading =true
      if (chart != null){
        chart.destroy();
      }
      ax.getChartData(this.form, (flag, data) => {
        if (flag) {
          this.genieRealChart = data.data.genierealchart
          this.melonRealChart = data.data.melonrealchart
          this.melonTop100 = data.data.melontop100

          const label = []
          const chartData = []
          this.genieRealChartLabel = []
          this.genieRealChartData = []
          this.melonRealChartLabel =[]
          this.melonRealChartData =[]
          this.melonTop100Label=[]
          this.melonTop100Data=[]

          for (let i =0 ; i < this.genieRealChart.length; i ++){
            this.genieRealChartLabel.push(this.genieRealChart[i].time.substring(0, 13))
            this.genieRealChartData.push(this.genieRealChart[i].ranking)
          }
          for (let i =0 ; i < this.melonRealChart.length; i ++){
            this.melonRealChartLabel.push(this.melonRealChart[i].time.substring(0, 13))
            this.melonRealChartData.push(this.melonRealChart[i].ranking)
          }
          for (let i =0 ; i < this.melonTop100.length; i ++){
            this.melonTop100Label.push(this.melonTop100[i].time.substring(0, 13))
            this.melonTop100Data.push(this.melonTop100[i].ranking)
          }
          this.createChart(label, chartData)
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

          this.summary.melon = data.melon[0]
          this.summary.genie = data.genie[0]


        } else {
          alert(data.message)

        }

      })
    },
    likeIncrease(idx){
      let prevVal = 0;
      if (this.likeList[idx+1] != undefined){
        prevVal = this.likeList[idx+1].count;
      } else {
        return '-'
      }
      return this.comma(this.likeList[idx].count - prevVal);
    },

    likeColor(idx){
      let prevVal = 0;
      if (this.likeList[idx+1] != undefined){
        prevVal = this.likeList[idx+1].count;
      }
      if (this.likeList[idx].count - prevVal < 0){
        return 'fcBlue'
      } else {
        return 'fcRed'
      }
    },
    createChart(label, chartData){
      $('#chart').remove()
      $('#graph_div').append('<canvas class="graph" id="chart"  style="width:100%" height="400"></canvas>')
      const ctx = document.getElementById('chart')
      chart = new Chart(ctx, {
        type: 'line',
        data: {
          labels: this.melonRealChartLabel,
          datasets: [{
            label: '멜론TOP100',
            data: this.melonTop100Data,
            backgroundColor: '#f54251',
            borderColor: '#f54251',
            borderWidth: 2
          }, {
            label: '멜론실시간',
            data: this.melonRealChartData,
            backgroundColor: '#42f57e',
            borderColor: '#42f57e',
            borderWidth: 2
          }, {
            label: '지니실시간',
            data: this.genieRealChartData,
            backgroundColor: '#4287f5',
            borderColor: '#4287f5',
            borderWidth: 2
          } ]
        },
        options: {

          plugins: {
            legend: {
              display: true
            },
          },
          ticks : {

          },
          scales: {
            y: {
              reverse: true,
              min: 0,
              ticks: {
                stepSize: 1
              }
            }
          }
        }
      })
    },
    comma(v){
      return String(v).replace(/[^0-9]/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },

    createDailyChart(label, chartData){
      $('#daily_chart').remove()
      $('#daily_graph_div').append('<canvas class="graph" id="daily_chart"  style="width:100%" height="400"></canvas>')
      const ctx = document.getElementById('daily_chart')
      dailyChart = new Chart(ctx, {
        type: 'line',
        data: {
          labels: this.maleLabel,
          datasets:  [{
            label: '남성',
            data: this.maleData,
            backgroundColor: '#4287f5',
            borderColor: '#4287f5',
            borderWidth: 2
          }, {
            label: '여성',
            data: this.femaleData,
            backgroundColor: '#f54251',
            borderColor: '#f54251',
            borderWidth: 2
          }, {
            label: '10대',
            data: this.age10Data,
            backgroundColor: '#42f5b3',
            borderColor: '#42f5b3',
            borderWidth: 2
          }, {
            label: '20대',
            data: this.age20Data,
            backgroundColor: '#60f542',
            borderColor: '#60f542',
            borderWidth: 2
          }, {
            label: '30대',
            data: this.age30Data,
            backgroundColor: '#42f5e0',
            borderColor: '#42f5e0',
            borderWidth: 2
          }, {
            label: '40대',
            data: this.age40Data,
            backgroundColor: '#f64dff',
            borderColor: '#f64dff',
            borderWidth: 2
          }, {
            label: '50대',
            data: this.age50Data,
            backgroundColor: '#ffaf4d',
            borderColor: '#ffaf4d',
            borderWidth: 2
          }, {
            label: '60대',
            data: this.age60Data,
            backgroundColor: '#5e554a',
            borderColor: '#5e554a',
            borderWidth: 2
          }]
        },
        options: {
          responsive: false,
          plugins: {
            legend: {
              display: true
            },
          },
          scales: {
            y: {

              ticks: {
                stepSize: 1
              }
            }
          }
        }
      })
    },

    createDailyCountChart(label, chartData){
      $('#daily_chart').remove()
      $('#daily_graph_div').append('<canvas class="graph" id="daily_chart"  style="width:100%" height="400"></canvas>')
      const ctx = document.getElementById('daily_chart')
      dailyChart = new Chart(ctx, {
        type: 'line',
        data: {
          labels: this.maleCountLabel,
          datasets:  [{
            label: '남성',
            data: this.maleCountData,
            backgroundColor: '#4287f5',
            borderColor: '#4287f5',
            borderWidth: 2
          }, {
            label: '여성',
            data: this.femaleCountData,
            backgroundColor: '#f54251',
            borderColor: '#f54251',
            borderWidth: 2
          }, {
            label: '10대',
            data: this.age10CountData,
            backgroundColor: '#42f5b3',
            borderColor: '#42f5b3',
            borderWidth: 2
          }, {
            label: '20대',
            data: this.age20CountData,
            backgroundColor: '#60f542',
            borderColor: '#60f542',
            borderWidth: 2
          }, {
            label: '30대',
            data: this.age30CountData,
            backgroundColor: '#42f5e0',
            borderColor: '#42f5e0',
            borderWidth: 2
          }, {
            label: '40대',
            data: this.age40CountData,
            backgroundColor: '#f64dff',
            borderColor: '#f64dff',
            borderWidth: 2
          }, {
            label: '50대',
            data: this.age50CountData,
            backgroundColor: '#ffaf4d',
            borderColor: '#ffaf4d',
            borderWidth: 2
          }, {
            label: '60대',
            data: this.age60CountData,
            backgroundColor: '#5e554a',
            borderColor: '#5e554a',
            borderWidth: 2
          }]
        },
        options: {
          responsive: false,
          plugins: {
            legend: {
              display: true
            },
          },
          scales: {
            y: {

              ticks: {
                stepSize: 1
              }
            }
          }
        }
      })
    },
    createLikeChart(label, chartData){
      $('#like_chart').remove()
      $('#like_graph_div').append('<canvas class="graph" id="like_chart"  style="width:100%" height="400"></canvas>')
      const ctx = document.getElementById('like_chart')
      likeChart = new Chart(ctx, {
        type: 'line',
        data: {
          labels: this.likeLabel,
          datasets: [{
            label: 'like 차트',
            data: this.likeData,
            backgroundColor: '#f5a742',
            borderColor: '#f5a742',
            borderWidth: 2
          }],
        },
        options: {

          plugins: {
            legend: {
              display: false
            },
            tooltip: {
              // Disable the on-canvas tooltip
              enabled: true,
            },
          },
          scales: {
            y: {

              ticks: {
                stepSize: 1
              }
            }
          }
        }
      })
    },
    toggleChart(idx){
      for (let i=0; i < 3 ; i++){
        console.dir(this.form.realChartCheck)
        if (this.form.realChartCheck.indexOf(i.toString()) > - 1){
          console.dir(i)
          chart.setDatasetVisibility(i, true); // hides dataset at index 1
          chart.update(); // chart now renders with dataset hidden
        } else {
          chart.setDatasetVisibility(i, false); // hides dataset at index 1
          chart.update(); // chart now renders with dataset hidden
        }
      }
    },
    toggleDailyChart(idx){
      console.dir(this.form.dailyChartCheck)
      for (let i=0; i < 8 ; i++){

        if (this.form.dailyChartCheck.indexOf(i.toString()) > - 1){
          dailyChart.setDatasetVisibility(i, true); // hides dataset at index 1
          dailyChart.update(); // chart now renders with dataset hidden
        } else {
          dailyChart.setDatasetVisibility(i, false); // hides dataset at index 1
          dailyChart.update(); // chart now renders with dataset hidden
        }
      }
    },
    allCheck(){

      if (this.form.allCheck){
        for (let i=0; i < 8 ; i++){
          this.form.dailyChartCheck[i]= i.toString();
          dailyChart.setDatasetVisibility(i, true); // hides dataset at index 1
          dailyChart.update(); // chart now renders with dataset hidden
        }
      } else {

        for (let i=0; i < 8 ; i++){
          this.form.dailyChartCheck[i]= false;
          dailyChart.setDatasetVisibility(i, false); // hides dataset at index 1
          dailyChart.update(); // chart now renders with dataset hidden
        }
      }
    },
    dailyChange(){

      if (this.dailyChangeFlag){
        this.dailyChangeFlag = false
        dailyChart.destroy();
        this.createDailyChart();
        this.toggleDailyChart();


      } else {
        this.dailyChangeFlag = true
        dailyChart.destroy();
        this.createDailyCountChart();
        this.toggleDailyChart();

      }
    },
    likeChange(){
      likeChart.destroy();
      this.likeData = this.likeAllData;
      this.likeLabel = this.likeAllLabel;
      this.createLikeChart();
    },
    dailyMoreChange(){
      this.maleCountData = this.maleCountAllData
      this.maleCountLabel = this.maleCountAllLabel
      this.femaleCountData = this.femaleCountAllData
      this.age10CountData = this.age10CountAllData
      this.age20CountData = this.age20CountAllData
      this.age30CountData = this.age30CountAllData
      this.age40CountData = this.age40CountAllData
      this.age50CountData = this.age50CountAllData
      this.age60CountData = this.age60CountAllData

      this.maleData = this.maleAllData
      this.maleLabel = this.maleAllLabel
      this.femaleData = this.femaleAllData
      this.age10Data =this.age10AllData
      this.age20Data =this.age20AllData
      this.age30Data =this.age30AllData
      this.age40Data =this.age40AllData
      this.age50Data =this.age50AllData
      this.age60Data =this.age60AllData

      if (this.dailyChangeFlag){
        dailyChart.destroy();
        this.createDailyCountChart();
        this.toggleDailyChart();

      } else {
        dailyChart.destroy();
        this.createDailyChart();
        this.toggleDailyChart();

      }

    }



  },


  watch: {
    form: {
      deep: true,
      handler(nv, ov) {

      }
    },


  },
}
</script>

