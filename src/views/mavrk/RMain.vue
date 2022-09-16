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
      <h3>ravex</h3>
      <small>Chart 데이터 검색</small>
    </div>
    <div class="page_container">
      <div class="cont_box search_form_box">
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
        <ul v-for="(item, idx) in list" :key="idx" @click="getView(item.melonId,item.genieId)">

          <li class="subject song_info" >
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
import {Chart, Line, registerables, BarElement, LineController, BarController, PointElement, LinearScale, Title, CategoryScale, LineElement, Legend} from 'chart.js'
Chart.register( BarElement, BarController, LineController, PointElement, LineElement, LinearScale, Title, CategoryScale, Legend);
import ax from '@/api/mavrk'
import axMelon from '@/api/melon'
let chart = null
let dailyChart = null
let likeChart = null
export default {
  name: 'MavrkChartView',
  data(){
    return {

      loading :false,
      list : [],
      form :{
        song : '',
        artist : '',
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

  },
  methods:{
    getInfo(){
      if (this.form.song == '' && this.form.artist == ''){
        alert('곡명이나 가수명을 입력해주세요.');
        return;
      }
      this.loading =true
      axMelon.getSongId(this.form, (flag, data) => {
        if (flag) {
          console.dir(data)
          this.list= data.data
          this.loading =false
        } else {
          alert(data.message)
        }
      })
    },
    getView(melonId, genieId){
      this.$router.push({
        name: 'MavrkChartView',
        query: {melonId : melonId, genieId : genieId},
      });
    }
  }
}
</script>

