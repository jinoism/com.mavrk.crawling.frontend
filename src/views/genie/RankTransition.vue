<template>

<div class="inner_body">
  <div class="page_title">
    <h3>GENIE <br />{{typeTxt}}<br /> 순위 추이</h3>
  </div>
  <div class="page_container">
    <div class="cont_box search_form_box">
      <div class="search_form mb20 mb10-md" v-if="this.$route.query.type=='24hour'">
          <div><input type="date" placeholder="날짜" v-model="form.startDate"/></div>
        <div>
          <select v-model="form.startTime">
            <option :value="item.code" v-for="(item, idx) in searchTime()" :key="idx">{{item.codeName}}</option>
          </select>
          </div>
          <div class="dummy"></div>
        </div>
        <div class="search_form mb20 mb10-md" v-if="this.$route.query.type=='24hour'">
          <div><input type="date" placeholder="날짜" v-model="form.endDate"/></div>
        <div>
          <select v-model="form.endTime">
            <option :value="item.code" v-for="(item, idx) in searchTime()" :key="idx">{{item.codeName}}</option>
          </select>
          </div>
          <div class="dummy"></div>
        </div>
      <div class="search_form">
        <div><input type="text" placeholder="곡명" v-model="this.form.song" @keyup.enter="getInfo()"/></div>
        <div><input type="text" placeholder="가수명" v-model="this.form.artist" @keyup.enter="getInfo()"/></div>
        <div><button @click="getInfo()"><img src="/img/icon_search.png" alt="search" ></button></div>
      </div>
    </div>
  </div>
  <div class="song_list_body mt60 mt30-md">
  <div class="list_head">
    <ul>
      <li class="subject song_info">곡정보</li>
    </ul>
  </div>
  <div class="list_body">
    <ul v-for="(item, idx) in list" :key="idx">

      <li class="subject song_info" @click="getView(item.id, item.melonId)">
        <div class="thum"><img :src="item.image" alt=""></div>
        <div class="title">
          <p>	{{item.songName}}</p>
          <p>	{{item.artistName}}</p>
        </div>
      </li>

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
  name: 'MeloneTop',
  data(){
    return {
      searchTime(){
        let searchTimeList = []
        for (let i=1; i <=24; i++){
          let codeValue;
          if (i<10){
            codeValue = '0'+i
          } else {
            codeValue = i;
          }
          searchTimeList.push({code : codeValue, codeName : i+'시'});
        }
        return searchTimeList;
      },
      typeList :[
        {code: 'top100', codeName : 'TOP100'},
        {code: 'newtop100w1', codeName : '4주차트'},
        {code: 'realchart', codeName : '실시간'},
        {code: 'dailychart', codeName : '일간 이용자수'},
        {code: '24hour', codeName : '24시간 재생수'},
      ],
      list:[],
      typeTxt :'',
      searchMonth :[],
      form :{
        searchDate :'',
        searchTime :'',
        artist :'',
        song: '',
        type : this.$route.query.type

      }
    }
  },
  mounted(){
    let nowDate = new Date();
    this.form.endDate = moment(nowDate).format('YYYY-MM-DD')
    this.form.endTime = moment(nowDate).format('HH')
    this.form.startTime = moment(nowDate).format('HH')

    nowDate.setDate(nowDate.getDate()-1)
    this.form.startDate = moment(nowDate).format('YYYY-MM-DD')
    this.typeTxt = this.selectCodeName(this.typeList, this.$route.query.type)
  },

  methods:{
    getInfo(){
      if (this.form.song == '' && this.form.artist == ''){
        alert('곡명이나 가수명을 입력해주세요.');
        return;
      }
      ax.getSongId(this.form, (flag, data) => {
        if (flag) {
          console.dir(data)
          this.list= data.data
          this.loading =false
        } else {
          alert(data.message)
        }
      })
    },
    getView(songId, melonId){

      this.$router.push({
        name: 'GenieRankTransitionView',
        query: { searchDate: this.form.searchDate, searchTime : this.form.searchTime, type: this.form.type, songId:songId, startDate: this.form.startDate, startTime : this.form.startTime, endDate: this.form.endDate, endTime : this.form.endTime, melonId: melonId },
      });
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

  }
}
</script>

