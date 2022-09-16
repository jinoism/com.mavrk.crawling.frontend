<template>
<!-- /공지사항 -->

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
            <div><input type="date" placeholder="날짜" v-model="form.startDate"/></div>
            <div><input type="date" placeholder="날짜" v-model="form.endDate"/></div>
            <div><button @click="getList()"><img src="/img/icon_search.png" alt="search" ></button></div>
          </div>
        </div>
      </div>

				<!--  -->
				<div class="cont_box song_result mt20"  style="text-align:center">
          <h4 class="cont_title mb20">
            {{artist}} - {{songName}}
          </h4>
					<h4 class="cont_title mb20">
						멜론 실시간차트
					</h4>
					<div class="table_type2 cal_list" >
            <div class="table_col_scroll" style="margin:auto">
              <table style="min-width:1000px;width:50%;margin: auto;">
								<tbody>
									<tr>
										<th>날짜</th>
										<td>0</td>
                    <td>1</td>
										<td>2</td>
										<td>3</td>
										<td>4</td>
										<td>5</td>
										<td>6</td>
										<td>7</td>
										<td>8</td>
										<td>9</td>
										<td>10</td>
										<td>11</td>
										<td>12</td>
										<td>13</td>
										<td>14</td>
										<td>15</td>
										<td>16</td>
										<td>17</td>
										<td>18</td>
										<td>19</td>
										<td>20</td>
										<td>21</td>
										<td>22</td>
										<td>23</td>
									</tr>
									<tr v-for="(item, idx) in melonList" :key="idx">
										<th>{{melonDateList[idx]}}</th>

                      <td :class="item[0] == undefiend? 'k' : item[0].color">{{item[0] == undefined ? '' :item[0].ranking }}</td>
                      <td :class="item[1] == undefiend? 'k' : item[1].color">{{item[1] == undefined ? '' :item[1].ranking }}</td>
                      <td :class="item[2] == undefiend? 'k' : item[2].color">{{item[2] == undefined ? '' :item[2].ranking }}</td>
                      <td :class="item[3] == undefiend? 'k' : item[3].color">{{item[3] == undefined ? '' :item[3].ranking }}</td>
                      <td :class="item[4] == undefiend? 'k' : item[4].color">{{item[4] == undefined ? '' :item[4].ranking }}</td>
                      <td :class="item[5] == undefiend? 'k' : item[5].color">{{item[5] == undefined ? '' :item[5].ranking }}</td>
                      <td :class="item[6] == undefiend? 'k' : item[6].color">{{item[6] == undefined ? '' :item[6].ranking }}</td>
                      <td :class="item[7] == undefiend? 'k' : item[7].color">{{item[7] == undefined ? '' :item[7].ranking }}</td>
                      <td :class="item[8] == undefiend? 'k' : item[8].color">{{item[8] == undefined ? '' :item[8].ranking }}</td>
                      <td :class="item[9] == undefiend? 'k' : item[9].color">{{item[9] == undefined ? '' :item[9].ranking }}</td>
                      <td :class="item[10] == undefiend? 'k' : item[10].color">{{item[10] == undefined ? '' :item[10].ranking }}</td>
                      <td :class="item[11] == undefiend? 'k' : item[11].color">{{item[11] == undefined ? '' :item[11].ranking }}</td>
                      <td :class="item[12] == undefiend? 'k' : item[12].color">{{item[12] == undefined ? '' :item[12].ranking }}</td>
                      <td :class="item[13] == undefiend? 'k' : item[13].color">{{item[13] == undefined ? '' :item[13].ranking }}</td>
                      <td :class="item[14] == undefiend? 'k' : item[14].color">{{item[14] == undefined ? '' :item[14].ranking }}</td>
                      <td :class="item[15] == undefiend? 'k' : item[15].color">{{item[15] == undefined ? '' :item[15].ranking }}</td>
                      <td :class="item[16] == undefiend? 'k' : item[16].color">{{item[16] == undefined ? '' :item[16].ranking }}</td>
                      <td :class="item[17] == undefiend? 'k' : item[17].color">{{item[17] == undefined ? '' :item[17].ranking }}</td>
                      <td :class="item[18] == undefiend? 'k' : item[18].color">{{item[18] == undefined ? '' :item[18].ranking }}</td>
                      <td :class="item[19] == undefiend? 'k' : item[19].color">{{item[19] == undefined ? '' :item[19].ranking }}</td>
                      <td :class="item[20] == undefiend? 'k' : item[20].color">{{item[20] == undefined ? '' :item[20].ranking }}</td>
                      <td :class="item[21] == undefiend? 'k' : item[21].color">{{item[21] == undefined ? '' :item[21].ranking }}</td>
                      <td :class="item[22] == undefiend? 'k' : item[22].color">{{item[22] == undefined ? '' :item[22].ranking }}</td>
                      <td :class="item[23] == undefiend? 'k' : item[23].color">{{item[23] == undefined ? '' :item[23].ranking }}</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--<p class="more_lsit">
							<button><i class="xi-angle-down"></i><i class="xi-angle-down"></i></button>
						</p>-->
					</div>

				</div>
        <!--  -->

        <!--  -->
				<div class="cont_box song_result mt20"  style="text-align:center">
					<h4 class="cont_title mb20">
						멜론 TOP100
					</h4>
					<div class="table_type2 cal_list">
            <div class="table_col_scroll" style="margin:auto">
              <table style="min-width:1000px;width:50%;margin: auto;">
								<tbody>
									<tr>
										<th>날짜</th>
										<td>0</td>
                    <td>1</td>
										<td>2</td>
										<td>3</td>
										<td>4</td>
										<td>5</td>
										<td>6</td>
										<td>7</td>
										<td>8</td>
										<td>9</td>
										<td>10</td>
										<td>11</td>
										<td>12</td>
										<td>13</td>
										<td>14</td>
										<td>15</td>
										<td>16</td>
										<td>17</td>
										<td>18</td>
										<td>19</td>
										<td>20</td>
										<td>21</td>
										<td>22</td>
										<td>23</td>
									</tr>
									<tr v-for="(item, idx) in topList" :key="idx">
										<th>{{topDateList[idx]}}</th>
                     <td :class="item[0] == undefiend? 'k' : item[0].color">{{item[0] == undefined ? '' :item[0].ranking }}</td>
                      <td :class="item[1] == undefiend? 'k' : item[1].color">{{item[1] == undefined ? '' :item[1].ranking }}</td>
                      <td :class="item[2] == undefiend? 'k' : item[2].color">{{item[2] == undefined ? '' :item[2].ranking }}</td>
                      <td :class="item[3] == undefiend? 'k' : item[3].color">{{item[3] == undefined ? '' :item[3].ranking }}</td>
                      <td :class="item[4] == undefiend? 'k' : item[4].color">{{item[4] == undefined ? '' :item[4].ranking }}</td>
                      <td :class="item[5] == undefiend? 'k' : item[5].color">{{item[5] == undefined ? '' :item[5].ranking }}</td>
                      <td :class="item[6] == undefiend? 'k' : item[6].color">{{item[6] == undefined ? '' :item[6].ranking }}</td>
                      <td :class="item[7] == undefiend? 'k' : item[7].color">{{item[7] == undefined ? '' :item[7].ranking }}</td>
                      <td :class="item[8] == undefiend? 'k' : item[8].color">{{item[8] == undefined ? '' :item[8].ranking }}</td>
                      <td :class="item[9] == undefiend? 'k' : item[9].color">{{item[9] == undefined ? '' :item[9].ranking }}</td>
                      <td :class="item[10] == undefiend? 'k' : item[10].color">{{item[10] == undefined ? '' :item[10].ranking }}</td>
                      <td :class="item[11] == undefiend? 'k' : item[11].color">{{item[11] == undefined ? '' :item[11].ranking }}</td>
                      <td :class="item[12] == undefiend? 'k' : item[12].color">{{item[12] == undefined ? '' :item[12].ranking }}</td>
                      <td :class="item[13] == undefiend? 'k' : item[13].color">{{item[13] == undefined ? '' :item[13].ranking }}</td>
                      <td :class="item[14] == undefiend? 'k' : item[14].color">{{item[14] == undefined ? '' :item[14].ranking }}</td>
                      <td :class="item[15] == undefiend? 'k' : item[15].color">{{item[15] == undefined ? '' :item[15].ranking }}</td>
                      <td :class="item[16] == undefiend? 'k' : item[16].color">{{item[16] == undefined ? '' :item[16].ranking }}</td>
                      <td :class="item[17] == undefiend? 'k' : item[17].color">{{item[17] == undefined ? '' :item[17].ranking }}</td>
                      <td :class="item[18] == undefiend? 'k' : item[18].color">{{item[18] == undefined ? '' :item[18].ranking }}</td>
                      <td :class="item[19] == undefiend? 'k' : item[19].color">{{item[19] == undefined ? '' :item[19].ranking }}</td>
                      <td :class="item[20] == undefiend? 'k' : item[20].color">{{item[20] == undefined ? '' :item[20].ranking }}</td>
                      <td :class="item[21] == undefiend? 'k' : item[21].color">{{item[21] == undefined ? '' :item[21].ranking }}</td>
                      <td :class="item[22] == undefiend? 'k' : item[22].color">{{item[22] == undefined ? '' :item[22].ranking }}</td>
                      <td :class="item[23] == undefiend? 'k' : item[23].color">{{item[23] == undefined ? '' :item[23].ranking }}</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--<p class="more_lsit">
							<button><i class="xi-angle-down"></i><i class="xi-angle-down"></i></button>
						</p>-->
					</div>

				</div>
				<div class="cont_box song_result mt20"  style="text-align:center">
					<h4 class="cont_title mb20">
						지니 실시간차트
					</h4>
					<div class="table_type2 cal_list">
            <div class="table_col_scroll" style="margin:auto">
              <table style="min-width:1000px;width:50%;margin: auto;">
								<tbody>
									<tr>
										<th>날짜</th>
										<td>0</td>
                    <td>1</td>
										<td>2</td>
										<td>3</td>
										<td>4</td>
										<td>5</td>
										<td>6</td>
										<td>7</td>
										<td>8</td>
										<td>9</td>
										<td>10</td>
										<td>11</td>
										<td>12</td>
										<td>13</td>
										<td>14</td>
										<td>15</td>
										<td>16</td>
										<td>17</td>
										<td>18</td>
										<td>19</td>
										<td>20</td>
										<td>21</td>
										<td>22</td>
										<td>23</td>
									</tr>
									<tr v-for="(item, idx) in genieList" :key="idx">
										<th>{{genieDateList[idx]}}</th>
                      <td :class="item[0] == undefiend? 'k' : item[0].color">{{item[0] == undefined ? '' :item[0].ranking }}</td>
                      <td :class="item[1] == undefiend? 'k' : item[1].color">{{item[1] == undefined ? '' :item[1].ranking }}</td>
                      <td :class="item[2] == undefiend? 'k' : item[2].color">{{item[2] == undefined ? '' :item[2].ranking }}</td>
                      <td :class="item[3] == undefiend? 'k' : item[3].color">{{item[3] == undefined ? '' :item[3].ranking }}</td>
                      <td :class="item[4] == undefiend? 'k' : item[4].color">{{item[4] == undefined ? '' :item[4].ranking }}</td>
                      <td :class="item[5] == undefiend? 'k' : item[5].color">{{item[5] == undefined ? '' :item[5].ranking }}</td>
                      <td :class="item[6] == undefiend? 'k' : item[6].color">{{item[6] == undefined ? '' :item[6].ranking }}</td>
                      <td :class="item[7] == undefiend? 'k' : item[7].color">{{item[7] == undefined ? '' :item[7].ranking }}</td>
                      <td :class="item[8] == undefiend? 'k' : item[8].color">{{item[8] == undefined ? '' :item[8].ranking }}</td>
                      <td :class="item[9] == undefiend? 'k' : item[9].color">{{item[9] == undefined ? '' :item[9].ranking }}</td>
                      <td :class="item[10] == undefiend? 'k' : item[10].color">{{item[10] == undefined ? '' :item[10].ranking }}</td>
                      <td :class="item[11] == undefiend? 'k' : item[11].color">{{item[11] == undefined ? '' :item[11].ranking }}</td>
                      <td :class="item[12] == undefiend? 'k' : item[12].color">{{item[12] == undefined ? '' :item[12].ranking }}</td>
                      <td :class="item[13] == undefiend? 'k' : item[13].color">{{item[13] == undefined ? '' :item[13].ranking }}</td>
                      <td :class="item[14] == undefiend? 'k' : item[14].color">{{item[14] == undefined ? '' :item[14].ranking }}</td>
                      <td :class="item[15] == undefiend? 'k' : item[15].color">{{item[15] == undefined ? '' :item[15].ranking }}</td>
                      <td :class="item[16] == undefiend? 'k' : item[16].color">{{item[16] == undefined ? '' :item[16].ranking }}</td>
                      <td :class="item[17] == undefiend? 'k' : item[17].color">{{item[17] == undefined ? '' :item[17].ranking }}</td>
                      <td :class="item[18] == undefiend? 'k' : item[18].color">{{item[18] == undefined ? '' :item[18].ranking }}</td>
                      <td :class="item[19] == undefiend? 'k' : item[19].color">{{item[19] == undefined ? '' :item[19].ranking }}</td>
                      <td :class="item[20] == undefiend? 'k' : item[20].color">{{item[20] == undefined ? '' :item[20].ranking }}</td>
                      <td :class="item[21] == undefiend? 'k' : item[21].color">{{item[21] == undefined ? '' :item[21].ranking }}</td>
                      <td :class="item[22] == undefiend? 'k' : item[22].color">{{item[22] == undefined ? '' :item[22].ranking }}</td>
                      <td :class="item[23] == undefiend? 'k' : item[23].color">{{item[23] == undefined ? '' :item[23].ranking }}</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--<p class="more_lsit">
							<button><i class="xi-angle-down"></i><i class="xi-angle-down"></i></button>
						</p>-->
					</div>

				</div>
				<!--  -->
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
      melonList :[],
      melonDateList :[],
      genieList:[],
      genieDateList :[],
      topList : [],
      topDateList :[],
      loading :false,
      tmp:[],

      form :{
        melonId : this.$route.query.melonId,
        genieId : this.$route.query.genieId,
        start : '2022-07-29',
        end :'2022-08-11',
        song: '',
        artist :'',
        searchDate :'',
        searchTime :''
      },
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
    let nowDate = new Date();
    this.form.endDate = moment(nowDate).format('YYYY-MM-DD')


    nowDate.setDate(nowDate.getDate()-7)
    this.form.startDate = moment(nowDate).format('YYYY-MM-DD')
    this.getList();
  },
  methods:{
    comma(v){
      return String(v).replace(/[^0-9]/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
    getList(){
      this.loading =true
      let params = {}
      params.start= moment(this.form.startDate).format('YYYY-MM-DD')
      params.end=  moment(this.form.endDate).format('YYYY-MM-DD')
      params.melonId = this.form.melonId
      params.genieId =this.form.genieId

      ax.getDetailData(params, (flag, data) => {
        if (flag) {

          this.tmp=[];
          for (let i=0; i < data.data.melonrealchart.length ; i++){
            let date = new Date(data.data.melonrealchart[i].time)
            let nowDate = date.getDate();
            if (data.data.melonrealchart[i].ranking == 1){
              data.data.melonrealchart[i].color='r'
            } else if (data.data.melonrealchart[i].ranking == 2 ){
              data.data.melonrealchart[i].color='o'
            } else if (data.data.melonrealchart[i].ranking == 3 ){
              data.data.melonrealchart[i].color='y'
            } else if (data.data.melonrealchart[i].ranking  >= 4 && data.data.melonrealchart[i].ranking <=10){
              data.data.melonrealchart[i].color='g'
            }  else if (data.data.melonrealchart[i].ranking >= 11 && data.data.melonrealchart[i].ranking <=20){
              data.data.melonrealchart[i].color='n'
            } else if (data.data.melonrealchart[i].ranking >= 21 && data.data.melonrealchart[i].ranking <=30){
              data.data.melonrealchart[i].color='b'
            } else if (data.data.melonrealchart[i].ranking>= 31 && data.data.melonrealchart[i].ranking <=40){
              data.data.melonrealchart[i].color='c'
            } else if (data.data.melonrealchart[i].ranking >= 41 && data.data.melonrealchart[i].ranking <=50){
              data.data.melonrealchart[i].color='d'
            } else {
              data.data.melonrealchart[i].color='e'
            }

            if (i < data.data.melonrealchart.length-1 && new Date(data.data.melonrealchart[i+1].time).getDate() != nowDate){
              this.melonDateList.push(data.data.melonrealchart[i].time.substring(2, 10).replaceAll('-', ''))
              this.tmp[date.getHours()]=data.data.melonrealchart[i];
              this.melonList.push(this.tmp);
              this.tmp= [];

            } else {

              this.tmp[date.getHours()]=data.data.melonrealchart[i];

            }

            if (i+1 ==data.data.melonrealchart.length){

              this.melonDateList.push(data.data.melonrealchart[i].time.substring(2, 10).replaceAll('-', ''))
              this.melonList.push(this.tmp);
            }
          }
          console.dir(data.data.melonrealchart)
          console.dir(this.melonList)
          this.tmp=[];
          for (let i=0; i < data.data.melontop100.length ; i++){
            let date = new Date(data.data.melontop100[i].time)
            let nowDate = date.getDate();
            if (data.data.melontop100[i].ranking == 1){
              data.data.melontop100[i].color='r'
            } else if (data.data.melontop100[i].ranking == 2 ){
              data.data.melontop100[i].color='o'
            } else if (data.data.melontop100[i].ranking == 3 ){
              data.data.melontop100[i].color='y'
            } else if (data.data.melontop100[i].ranking  >= 4 && data.data.melontop100[i].ranking <=10){
              data.data.melontop100[i].color='g'
            }  else if (data.data.melontop100[i].ranking >= 11 && data.data.melontop100[i].ranking <=20){
              data.data.melontop100[i].color='n'
            } else if (data.data.melontop100[i].ranking >= 21 && data.data.melontop100[i].ranking <=30){
              data.data.melontop100[i].color='b'
            } else if (data.data.melontop100[i].ranking>= 31 && data.data.melontop100[i].ranking <=40){
              data.data.melontop100[i].color='c'
            } else if (data.data.melontop100[i].ranking >= 41 && data.data.melontop100[i].ranking <=50){
              data.data.melontop100[i].color='d'
            } else {
              data.data.melontop100[i].color='e'
            }
            if (i < data.data.melontop100.length-1 && new Date(data.data.melontop100[i+1].time).getDate() != nowDate){
              this.topDateList.push(data.data.melontop100[i].time.substring(2, 10).replaceAll('-', ''))
              this.tmp[date.getHours()]=data.data.melontop100[i];
              this.topList.push(this.tmp);
              this.tmp=[];
            } else {

              this.tmp[date.getHours()]=data.data.melontop100[i];
            }
            if (i+1 ==data.data.melontop100.length){
              this.topDateList.push(data.data.melontop100[i].time.substring(2, 10).replaceAll('-', ''))
              this.topList.push(this.tmp);
            }
          }
          this.tmp=[];
          for (let i=0; i < data.data.genierealchart.length ; i++){
            let date = new Date(data.data.genierealchart[i].time)
            let nowDate = date.getDate();
            if (data.data.genierealchart[i].ranking == 1){
              data.data.genierealchart[i].color='r'
            } else if (data.data.genierealchart[i].ranking == 2 ){
              data.data.genierealchart[i].color='o'
            } else if (data.data.genierealchart[i].ranking == 3 ){
              data.data.genierealchart[i].color='y'
            } else if (data.data.genierealchart[i].ranking  >= 4 && data.data.genierealchart[i].ranking <=10){
              data.data.genierealchart[i].color='g'
            }  else if (data.data.genierealchart[i].ranking >= 11 && data.data.genierealchart[i].ranking <=20){
              data.data.genierealchart[i].color='n'
            } else if (data.data.genierealchart[i].ranking >= 21 && data.data.genierealchart[i].ranking <=30){
              data.data.genierealchart[i].color='b'
            } else if (data.data.genierealchart[i].ranking>= 31 && data.data.genierealchart[i].ranking <=40){
              data.data.genierealchart[i].color='c'
            } else if (data.data.genierealchart[i].ranking >= 41 && data.data.genierealchart[i].ranking <=50){
              data.data.genierealchart[i].color='d'
            } else {
              data.data.genierealchart[i].color='e'
            }
            if (i < data.data.genierealchart.length-1 && new Date(data.data.genierealchart[i+1].time).getDate() != nowDate){
              this.genieDateList.push(data.data.genierealchart[i].time.substring(2, 10).replaceAll('-', ''))
              this.tmp[date.getHours()]=data.data.genierealchart[i];
              this.genieList.push(this.tmp);
              this.tmp=[];
            } else {
              this.tmp[date.getHours()]=data.data.genierealchart[i];
            }

            if (i+1 ==data.data.genierealchart.length){
              this.genieDateList.push(data.data.genierealchart[i].time.substring(2, 10).replaceAll('-', ''))
              this.genieList.push(this.tmp);
            }
          }
          this.artist = data.song[0].artists[0].name;
          this.songName = data.song[0].name;
          console.dir(this.genieList)
          this.loading = false;
        } else {
          alert(data.message)
          this.loading = false;
        }

      })
    },

  }
}
</script>

