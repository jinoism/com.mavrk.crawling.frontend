<template>

<div class="inner_body">
  <div class="page_title">
    <h3>MELON <br>{{typeTxt}}<br>순위 추이</h3>
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

  <div class="cont_box song_result mt20" v-if="this.$route.query.type!='streamingcard' && this.$route.query.type!='dailychart'" style="text-align:center">
    <h4 class="cont_title mb20">
      {{artist}} - {{songName}}
    </h4>
    <div>
      <select v-model="form.type" v-if="this.$route.query.type=='newtop100w1' ||this.$route.query.type=='newtop100w4'" @change="changeWeek()">
        <option :value="item.code" v-for="(item, idx) in weekList" :key="idx">{{item.codeName}}</option>
      </select>
    </div>
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
            <template v-for="(item, idx) in list" :key="idx" >
              <tr>
                <th :style="getWeek(dateWeekList[idx])=='토' ? 'color:blue': getWeek(dateWeekList[idx])=='일' ?'color:red': ''">{{dateList[idx]}}</th>
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
            </template>
            <tr v-if="this.list.length ==0">
              <td colspan="25">조회된 내역이 없습니다.</td>

            </tr>
          </tbody>
        </table>
      </div>

      <!--<p class="more_lsit">
        <button><i class="xi-angle-down"></i><i class="xi-angle-down"></i></button>
      </p>-->
    </div>


  </div>
  <div class="cont_box song_result mt20" v-if="this.$route.query.type=='streamingcard'" >
    <h4 class="cont_title mb20">
      {{artist}} - {{songName}}
    </h4>
    <div class="table_type1 ">
      <div class="table_col_scroll">
        <table >
          <thead>
            <tr>
              <th>날짜</th>
              <th>감상자수</th>
              <th>변화량</th>
              <th>스트리밍</th>
              <th>변화량</th>
              <th>비율</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, idx) in list" :key="idx">
              <td>{{item.time.substring(0,10)}}</td>
              <td>{{comma(item.userCount)}}</td>
              <td :class="this.userCount(idx) > 0 ? 'fcRed' : 'fcBlue'">{{this.userCount(idx) > 0 ? '+' + comma(this.userCount(idx)) :comma(this.userCount(idx))}}</td>
              <td>{{comma(item.streamingCount)}}</td>
              <td :class="this.streamingCount(idx) > 0 ? 'fcRed' : 'fcBlue'">{{this.streamingCount(idx) > 0 ? '+' + comma(this.streamingCount(idx)) :comma(this.streamingCount(idx))}}</td>
              <td>{{comma((item.streamingCount/item.userCount).toFixed(1))}}</td>
            </tr>

          </tbody>
        </table>
      </div>
      <!--<p class="more_lsit">
        <button><i class="xi-angle-down"></i><i class="xi-angle-down"></i></button>
      </p>-->
    </div>
	</div>
  <div class="cont_box song_result mt20" v-if="this.$route.query.type=='dailychart'" >
    <h4 class="cont_title mb20">
      {{artist}} - {{songName}}
    </h4>
    <div class="table_type1 ">
      <div class="table_col_scroll">
        <table >
          <thead>
            <tr>
              <th>날짜</th>
              <th>순위</th>
              <th>이용자수</th>
              <th>변화량</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, idx) in list" :key="idx">
              <td>{{item.time.substring(0,10)}}</td>
              <td>{{comma(item.ranking)}}</td>
              <td>{{comma(item.dailyCount)}}</td>
              <td :class="this.dailyCount(idx) > 0 ? 'fcRed' : 'fcBlue'">{{this.dailyCount(idx) > 0 ? '+' + comma(this.dailyCount(idx)) :comma(this.dailyCount(idx))}}</td>

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
  name: 'MeloneTopRankView',
  data(){
    return {
      list:[],
      tmp:[],
      searchMonth :[],
      dateList : [],
      dateWeekList : [],
      songName :'',
      genieId : this.$route.query.genieId,
      typeList :[
        {code: 'top100', codeName : 'TOP100'},
        {code: 'newtop100w1', codeName : '최신 차트 순위'},
        {code: 'newtop100w4', codeName : '최신 차트 순위'},
        {code: 'realchart', codeName : '실시간 차트'},
        {code: 'dailychart', codeName : '일간차트'},
        {code: 'streamingcard', codeName : '감상자수'},
      ],
      weekList :[
        {code: 'newtop100w1', codeName : '1주내'},
        {code: 'newtop100w4', codeName : '4주내'},
      ],
      form :{
        platform : 'melon',
        songId : this.$route.query.songId,
        type : this.$route.query.type

      }
    }
  },
  mounted(){
    this.typeTxt = this.selectCodeName(this.typeList, this.$route.query.type)
    this.getInfo()
  },

  methods:{
    getInfo(){

      let params = {}
      params.platform =this.form.platform
      params.songId =this.form.songId
      params.type =this.form.type
      this.list =[]
      ax.getTop100RankList(params, (flag, data) => {
        if (flag) {
          this.songName = data.song[0].name
          this.artist = data.song[0].artists[0].name
          if (this.$route.query.type!='24hour' && this.$route.query.type != 'dailychart'){
            for (let i=0; i < data.data.length ; i++){
              let date = new Date(data.data[i].time)
              let time = data.data[i].time.substring(11, 13)
              let nowDate = parseInt(data.data[i].time.substring(8, 10));
              if (data.data[i].ranking == 1){
                data.data[i].color='r'
              } else if (data.data[i].ranking == 2 ){
                data.data[i].color='o'
              } else if (data.data[i].ranking == 3 ){
                data.data[i].color='y'
              } else if (data.data[i].ranking  >= 4 && data.data[i].ranking <=10){
                data.data[i].color='g'
              }  else if (data.data[i].ranking >= 11 && data.data[i].ranking <=20){
                data.data[i].color='n'
              } else if (data.data[i].ranking >= 21 && data.data[i].ranking <=30){
                data.data[i].color='b'
              } else if (data.data[i].ranking >= 31 && data.data[i].ranking <=40){
                data.data[i].color='c'
              } else if (data.data[i].ranking >= 41 && data.data[i].ranking <=50){
                data.data[i].color='d'
              } else {
                data.data[i].color='e'
              }
              if (i < data.data.length-1 && parseInt(data.data[i+1].time.substring(8, 10)) != nowDate){
                this.dateList.push(data.data[i].time.substring(2, 10).replaceAll('-', ''))
                this.dateWeekList.push(data.data[i].time.substring(0, 10))
                this.tmp[parseInt(time)]=data.data[i];

                this.list.push(this.tmp);
                this.tmp=[];
              } else {

                this.tmp[parseInt(time)]=data.data[i];

              }
              if (i+1 ==data.data.length){
                this.dateList.push(data.data[i].time.substring(2, 10).replaceAll('-', ''))
                this.dateWeekList.push(data.data[i].time.substring(0, 10))
                this.list.push(this.tmp);
              }
            }

            console.dir(this.list)
          } else {
            this.list = data.data
            //this.list.sort((a, b) => new Date(b.time) - new Date(a.time));
          }
        } else {
          alert(data.message)
        }
      })
    },
    comma(n){
      var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
      n += '';                          // 숫자를 문자열로 변환

      while (reg.test(n))
        n = n.replace(reg, '$1' + ',' + '$2');

      return n;
    },
    ranking(v, pv, idx){
      const rank = v-pv;
      if (rank < 0){
        this.list[idx].rank = 'down'
      } else if (rank ==0){
        this.list[idx].rank = ''
      } else {
        this.list[idx].rank = 'up'
      }
      return Math.abs(rank) == 0 ? '-' : Math.abs(rank)
    },
    getWeek(v){
      let day = new Date(v);
      const WEEKDAY = ['일', '월', '화', '수', '목', '금', '토'];
      return WEEKDAY[day.getDay()];
    },
    streamingCount(idx){
      let prevVal = 0;
      if (this.list[idx-1] != undefined){
        prevVal = this.list[idx-1].streamingCount;
      } else {
        return '-'
      }
      return this.list[idx].streamingCount - prevVal;
    },
    userCount(idx){
      let prevVal = 0;
      if (this.list[idx-1] != undefined){
        prevVal = this.list[idx-1].userCount;
      } else {
        return '-'
      }
      return this.list[idx].userCount - prevVal;
    },

    dailyCount(idx){
      let prevVal = 0;
      if (this.list[idx-1] != undefined){
        prevVal = this.list[idx-1].dailyCount;
      } else {
        return '-'
      }
      return this.list[idx].dailyCount - prevVal;
    },
    selectCodeName(obj, value, targets) {
      let codeName = ''

      if (obj != undefined) {
        obj.filter(function (elem) {
          if (elem.seq != undefined) {
            if (elem.seq == value) {
              codeName = elem.codeName
            }
          } else {
            if (elem.code == value) {
              codeName = elem.codeName
            }
          }
        })
        return codeName
      }
    },
    changeWeek(){
      this.$router.push({
        name: 'RankTransitionView',
        query: { searchDate: this.form.searchDate, searchTime : this.form.searchTime, type :this.form.type, songId :this.form.songId, genieId : this.genieId },
      });

    }




  }
}
</script>

