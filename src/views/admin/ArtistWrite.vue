<template>
<!-- /공지사항 -->
<div class="inner_body">
  <div class="page_title">
    <h3>ADMIN </h3>
    <small>하트추이 가수등록</small>
  </div>
  <div class="page_container">
    <div class="button_quick">

    </div>
    <div class="cont_box search_form_box">
      <div class="search_form">

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

      <li class="subject song_info" >
        <div class="thum"><img :src="item.image" alt=""></div>
        <div class="title">
          <p>	{{item.name}}</p>

        </div>
      </li>
      <li class="w_sm">
        <button class="deleted" @click="insertArtist(item.id)"><i class="xi-plus-circle"></i></button>
      </li>

    </ul>
    <ul v-if="list.length ==0 ">
      <li >조회된 내역이 없습니다.</li>
    </ul>
  </div>
  <div class="bottom_btn">
    <button type="submit" class="btn btn-purple" @click="getList">목록으로</button>
  </div>
</div>


</div>



</template>

<script>
import ax from '@/api/melon'
import adminAx from '@/api/admin/admin'
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
        {code: 'streamingcard', codeName : '감상자수'},
      ],
      list:[],
      typeTxt :'',
      searchMonth :[],
      form :{

        artist :'',

        type : this.$route.query.type,
        platform: this.$route.query.platform

      }
    }
  },
  mounted(){


  },

  methods:{
    getInfo(){
      if (this.form.song == '' && this.form.artist == ''){
        alert('곡명이나 가수명을 입력해주세요.');
        return;
      }
      adminAx.getArtistId(this.form, (flag, data) => {
        if (flag) {
          console.dir(data)
          this.list= data.data
          this.loading =false
        } else {
          alert(data.message)
        }
      })
    },
    insertArtist(idx){
      let params ={}
      params.platform = this.$route.query.platform
      params.artistId = idx
      if (confirm('아티스트를 등록하시겠습니까?')){
        adminAx.insertArtist(params, (flag, data) => {
          if (flag) {
            alert('등록되었습니다.');
            this.getList();
          } else {
            alert('이미 등록된 아티스트입니다.')
          }
        })
      }
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
    getList(){
      this.$router.push({
        name: 'AdminArtistList',
        query: {  platform : this.$route.query.platform },
      });
    }

  }
}
</script>

