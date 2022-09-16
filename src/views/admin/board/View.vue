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
							<input type="text" class="form-control" name="" vale="" v-model="this.form.title" id="" />
						</div>
						<div class="mt20">
							<h4>내용</h4>
							<textarea name="" id="" class="form-control" v-model="this.form.contents"></textarea>
						</div>

						<div class="bottom_btn">
              <button type="submit" class="btn btn-purple" style="margin-right:10px" @click="save">저장</button>
              <button type="submit" class="btn btn-red" v-if="this.$route.query.idx != null" style="margin-right:10px" @click="deleteBoard()">삭제</button>
							<button type="submit" class="btn btn-purple" style="background-color:#ffffff;color:#4165f0;border:1px solid #4165f0 ;" @click="getList">목록</button>
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
        idx : this.$route.query.idx,
        contents: '',
        title : '',
      },
      info :{},

    }
  },
  mounted(){
    if (this.$route.query.idx != null){
      this.getInfo()
    }
  },

  methods:{
    getInfo(){
      this.loading =true
      ax.getBoardInfo(this.form, (flag, data) => {
        if (flag) {
          console.dir(data)
          this.form= data.data[0]
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
    },
    deleteBoard(){
      if (confirm('공지사항을 삭제하시겠습니까?')){
        ax.deleteBoard(this.form, (flag, data) => {
          if (flag) {
            alert('삭제되었습니다.')
            this.$router.push({
              name: 'AdminBoardList'
            });
          } else {
            alert(data.message)
          }
        })
      }
    },
    save(){


      if (this.$route.query.idx != null){
        this.form.updateId = this.$parent.$parent.$parent.$parent.userId
        ax.updateBoard(this.form, (flag, data) => {
          if (flag) {
            alert('수정되었습니다.')
            this.$router.push({
              name: 'AdminBoardList'
            });
          } else {
            alert(data.message)
          }
        })
      } else {
        this.form.createId = this.$parent.$parent.$parent.$parent.userId
        ax.insertBoard(this.form, (flag, data) => {
          if (flag) {
            alert('등록되었습니다.')
            this.$router.push({
              name: 'AdminBoardList'
            });
          } else {
            alert(data.message)
          }
        })
      }

    }
  }
}
</script>

