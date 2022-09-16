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
          <h3>HOME </h3>
          <small>공지사항</small>
        </div>


        <div class="song_list_body mt20 mt30-md">
          <div class="list_head">
            <ul>

              <li class="subject song_info">제목</li>
              <li class="mo-none">날짜</li>
              <li>작성자</li>

            </ul>
          </div>
          <div class="list_body">
            <ul v-for="(item, idx) in list" :key="idx" >
              <!--<li class="num">
                <div>
                  <p class="no">{{item.idx}}</p>
                </div>
              </li>-->
              <li class="subject song_info" @click="getInfo(item.idx)" style="height:50px">

                <div class="title">
                  <p>	{{item.title}}</p>
                  <p></p>
                </div>
              </li>
              <li class="mo-none">
                <strong>{{item.createTime}}</strong>
              </li>
              <li><strong>{{item.createId}}</strong></li>

            </ul>
            <ul v-if="list.length ==0 ">
              <li >조회된 내역이 없습니다.</li>
            </ul>
          </div>
        </div>

			</div>



</template>

<script>
import ax from '@/api/board'
export default {
  name: 'Main',
  data(){
    return {

      loading :false,
      list : [],
      form :{
        song : '',
        artist : '',
      },

    }
  },
  mounted(){
    this.getList()
  },

  methods:{
    getList(){
      let params = {};
      this.loading =true
      ax.getBoardList(params, (flag, data) => {
        if (flag) {
          console.dir(data)
          this.list= data.data
          this.loading =false
        } else {
          alert(data.message)
        }
      })
    },
    getInfo(idx){
      this.$router.push({
        name: 'BoardView',
        query: {  idx : idx },
      });
    },
  }
}
</script>

