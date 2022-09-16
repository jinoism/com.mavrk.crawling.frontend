<template>


	<div id="login_wrap">
		<div class="login_form">
			<div class="box">
				<h2>Password Change</h2>
				<div class="pw_form">
					<input type="password" v-model="form.password" placeholder="비밀번호" maxlength="20"/>
					<i class="xi-lock"></i>
				</div>
        <div class="button" @click="getRegist"><button>비밀번호 변경</button></div>
        <div class="button" @click="getLogin" style="margin-top:20px"><button style="background-color:#ffffff;color:#4165f0;border:1px solid #4165f0" >뒤로가기</button></div>
			</div>
		</div>
		<div class="bg">
			<h1><img src="/img/logo_w_big.png" style="max-width:23.1rem" alt="mavrk"></h1>
		</div>
	</div>


</template>

<script>
import ax from '@/api/login'
export default {
  name: 'Main',
  data(){
    return {

      loading :false,
      list : [],
      form :{
        email : this.$route.params.email,

        password : '',
      },

    }
  },
  mounted(){
    if (this.$route.params.email == null){
      alert('잘못된접근입니다.');
      this.$router.push({
        name: 'Main',

      });
    }


  },

  methods:{
    getLogin(){
      this.$router.push({
        name: 'Main',

      });
    },
    getRegist(){


      if (this.form.password ==''){
        alert('비밀번호를 입력해주세요.');
        return;
      }

      let re = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,50}$/
      if (re.test(this.form.password) ? false : true){
        alert('비밀번호는 최소 8자리이상 영문/숫자/특수문자 혼용으로 입력해주세요.');
        return
      }

      ax.pwChange(this.form, (flag, data) => {

        if (flag) {
          alert('비밀번호가 정상적으로 변경되었습니다. 바뀐 비밀번호로 로그인해주세요.');
          this.$router.push({
            name: 'Main',
          });
        } else {

          alert('오류가 발생하였습니다.')
        }
      })
    },

  }
}
</script>

