<template>
<!-- /공지사항 -->
<div class="inner_body">
  <div class="page_title">
    <h3>ADMIN </h3>
    <small>하트추이 곡등록</small>
  </div>
  <div class="page_container">
    <div class="button_quick">
      <div>
        <button @click="changePlatform('melon')" :class= "{'on' : platform == 'genie'}">Melon</button>
      </div>
      <div>
        <button @click="changePlatform('genie')" :class= "{'on' : platform == 'melon'}">Genie</button>
      </div>
    </div>

  </div>
  <div class="song_list_body mt60 mt30-md">
  <div class="list_head">
    <ul>
      <li class="subject song_info">곡정보</li>
      <li>시작시간</li>
      <li>종료시간</li>
      <li> 삭제</li>
    </ul>
  </div>
  <div class="list_body">
    <ul v-for="(item, idx) in list" :key="idx" @click="getTopRank(item.song[0].name.platform, item.song[0].id)">
      <li class="subject song_info" >
        <div class="thum"><img :src="item.image" alt=""></div>
        <div class="title">
          <p>	{{item.songName}}</p>
          <p>	{{item.artistName}}</p>

        </div>
      </li>
      <li>
        {{item.start}}
      </li>
      <li>
        {{item.end}}
      </li>
      <li >
        <button class="deleted" @click="deleteList(item.songId)"><i class="xi-trash-o"></i></button>
      </li>
    </ul>
    <ul v-if="list.length ==0 ">
      <li >조회된 내역이 없습니다.</li>
    </ul>
  </div>
  <div class="bottom_btn">
    <button type="submit" class="btn btn-purple" @click="getWrite">추가하기</button>
  </div>
</div>

</div>



</template>

<script>
import ax from '@/api/admin/admin'
export default {
  name: 'Main',
  data(){
    return {

      loading :false,
      list : [],
      platform :'melon',
      form :{
        song : '',
        artist : '',
      },

    }
  },
  mounted(){

    if (this.$route.query.platform != null){
      this.platform = this.$route.query.platform
    }
    this.getList()
  },

  methods:{
    getList(){
      let params = {};
      this.loading =true
      params.platform = this.platform
      ax.getSongList(params, (flag, data) => {
        if (flag) {
          console.dir(data)
          this.list= data.data
          this.loading =false
        } else {
          alert(data.message)
        }
      })
    },
    getWrite(){
      this.$router.push({
        name: 'AdminSongWrite',
        query: {  platform : this.platform },
      });
    },
    deleteList(idx){
      if (confirm('해당 데이터를 삭제하시겠습니까?')){
        let params ={}
        params.platform = this.platform
        params.songId = idx
        ax.deleteSong(params, (flag, data) => {
          if (flag) {
            alert('삭제되었습니다.');
            this.getList();
          } else {
            alert(data.message)
          }
        })
        return false;
      }
    },
    changePlatform(platform){
      this.platform = platform;
      this.$router.push({
        name: 'AdminSongList',
        query: {  platform : this.platform },
      });

    }

  }
}
</script>

