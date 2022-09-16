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
          <h3>revex </h3>
          <small>공지사항</small>
        </div>

        <div class="page_container">
					<div class="cont_box notice_write">
						<h3>공지사항</h3>

						<div class="mt20">
							<h4>제목</h4>
							<input type="text" class="form-control" name="" vale="" v-model="this.info.title" id="" readonly/>
						</div>
						<div class="mt20">
							<h4>내용</h4>
							<textarea name="" id="" class="form-control"  readonly>{{this.info.contents}}</textarea>
						</div>
						<div class="bottom_btn">
							<button type="submit" class="btn btn-purple" @click="getList">목록</button>
						</div>
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
        idx : this.$route.query.idx
      },
      info :{},

    }
  },
  mounted(){
    this.getInfo()
  },

  methods:{
    getInfo(){
      this.loading =true
      ax.getBoardInfo(this.form, (flag, data) => {
        if (flag) {
          console.dir(data)
          this.info= data.data[0]
          this.loading = false;
        } else {
          alert(data.message)
        }
      })
    },
    getList(){
      this.$router.push({
        name: 'BoardList'
      });
    }
  }
}
</script>

