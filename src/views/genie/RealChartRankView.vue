<template>

<div class="inner_body">
  <div class="page_title">
    <h3>GENIE REALCHART<br /> 순위 추이</h3>
  </div>
  <div class="page_container">
    <div class="button_quick">
      <div>
        <button>Melon</button>
        <ul>
         	<li><router-link :to="{name: 'Rank' ,query: {type :'top100'}}" :class="{on: page == 3 &&sub == 1 && this.$route.query.type =='top100'}">TOP100</router-link></li>
						<li><router-link :to="{name: 'RankTransition' ,query: {type:'top100'}}" :class="{on: page == 3 &&sub == 2 && this.$route.query.type =='top100'}">TOP 100순위 추이</router-link></li>
						<li><router-link :to="{name: 'MelonTopCount'}" :class="{on: sub == 3}">TOP 100이용자수 추이</router-link></li>
						<li><router-link :to="{name: 'Rank' ,query: {type :'newtop100w1'}}" :class="{on: page == 3 &&sub == 1 && this.$route.query.type =='newtop100w1'}">4주 차트 순위</router-link></li>
						<li><router-link :to="{name: 'RankTransition' ,query: {type:'newtop100w1'}}" :class="{on: page == 3 &&sub == 2 && this.$route.query.type =='newtop100w1'}">4주 차트 순위 추이</router-link></li>
						<li><router-link :to="{name: 'Rank' ,query: {type :'realchart'}}" :class="{on: page == 3 && sub == 1&& this.$route.query.type =='realchart'}">실시간차트</router-link></li>
						<li><router-link :to="{name: 'RankTransition' ,query: {type:'realchart'}}" :class="{on: page == 3 && sub == 2&& this.$route.query.type =='realchart'}">실시간 순위 추이</router-link></li>
						<li><router-link :to="{name: 'Rank' ,query: {type :'dailychart'}}" :class="{on: page == 3 && sub == 1 && this.$route.query.type =='dailychart'}">일간차트</router-link></li>
						<li><router-link :to="{name: 'RankTransition' ,query: {type:'dailychart'}}" :class="{on: page == 3 &&sub == 2&& this.$route.query.type =='dailychart'}">일간 이용자수 추이</router-link></li>
						<li><router-link :to="{name: 'RankTransition' ,query: {type:'streamingcard'}}" :class="{on: page == 3 &&sub == 2&& this.$route.query.type =='streamingcard'}">감상자수 스트리밍수추이</router-link></li>
        </ul>
      </div>
      <div>
        <button>Genie</button>
        <ul>
          	<li><router-link :to="{name: 'GenieRank' ,query: {type :'realchart'}}" :class="{on: page == 4 &&sub == 1 && this.$route.query.type =='realchart'}">실시간차트</router-link></li>
						<li><router-link :to="{name: 'GenieRankTransition' ,query: {type:'realchart'}}" :class="{on: page == 4 &&sub == 2 && this.$route.query.type =='realchart'}">실시간 순위 추이</router-link></li>
						<li><router-link :to="{name: 'GenieRank' ,query: {type :'dailychart'}}" :class="{on: page == 4 &&sub == 1 && this.$route.query.type =='dailychart'}">일간차트</router-link></li>
						<li><router-link :to="{name: 'GenieRankTransition' ,query: {type:'dailychart'}}" :class="{on: page == 4 &&sub == 2 && this.$route.query.type =='dailychart'}">일간 이용자수 추이</router-link></li>
						<li><router-link :to="{name: 'GenieRankTransition' ,query: {type:'24hour'}}" :class="{on: page == 4 &&sub == 2 && this.$route.query.type =='streamingcard'}">24시간 재생수 추이</router-link></li>
        </ul>
      </div>
    </div>
  </div>

  <div class="cont_box song_result mt20">
    <h4 class="cont_title mb20">
      {{artist}} - {{songName}}
    </h4>
    <div class="table_type1 cal_list">
      <div class="table_col_scroll">
        <table style="min-width:1000px;">
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
                <th>220330</th>
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
          </tbody>
        </table>
      </div>
      <p class="more_lsit">
        <button><i class="xi-angle-down"></i><i class="xi-angle-down"></i></button>
      </p>
    </div>

  </div>
</div>



</template>

<script>
import ax from '@/api/genie'
export default {
  name: 'MeloneTopRankView',
  data(){
    return {
      list:[],
      tmp:[],
      searchMonth :[],
      artist : '',
      songName: '',
      form :{
        platform : this.$route.query.platform,
        songId : this.$route.query.songId
      }
    }
  },
  mounted(){


    this.getInfo()
  },

  methods:{
    getInfo(){

      let params = {}
      params.platform =this.form.platform
      params.songId =this.form.songId
      ax.getTop100RankList(params, (flag, data) => {
        if (flag) {
          this.songName = data.song[0].name
          this.artist = data.song[0].artists[0].name
          for (let i=0; i < data.data.length ; i++){
            let date = new Date(data.data[i].time)
            let nowDate = date.getDate();
            if (data.data[i].ranking >= 1 && data.data[i].ranking <=10){
              data.data[i].color='r'
            } else if (data.data[i].ranking >= 11 && data.data[i].ranking <=20){
              data.data[i].color='o'
            } else if (data.data[i].ranking >= 21 && data.data[i].ranking <=30){
              data.data[i].color='y'
            } else if (data.data[i].ranking >= 31 && data.data[i].ranking <=40){
              data.data[i].color='g'
            } else if (data.data[i].ranking >= 34 && data.data[i].ranking <=50){
              data.data[i].color='b'
            } else {
              data.data[i].color='n'
            }

            if(i < data.data.length-1 && new Date(data.data[i+1].time).getDate() != nowDate){

              this.tmp[date.getHours()]=data.data[i];
              this.list.push(this.tmp);
              this.tmp=[];
            } else {
              this.tmp[date.getHours()]=data.data[i];
            }
          }



          /*for(let i=0; i < data.data.length ; i++){
            let date = new Date(data.data[i].time)
            if(i==0){
              for(let t =0; t < date.getHours(); t++){
                this.tmp.push({time:'',ranking:''})
              }
              this.tmp.push(data.data[i]);
            }else{
              this.tmp.push(data.data[i]);
              if(date.getHours() == 23){
                this.list.push(this.tmp)
                this.tmp =[];
              }
            }
            if(i == data.data.length-1){
                this.tmp.push(data.data[i]);
                for(let t =date.getHours(); t < 23; t++){
                  this.tmp.push({time:'',ranking:''})
                }
                this.list.push(this.tmp)
            }
          }*/
          console.dir(this.list)
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




  }
}
</script>

