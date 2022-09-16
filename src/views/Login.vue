<template>


	<div id="login_wrap">
		<div class="login_form">
			<div class="box">
				<h2>Log In</h2>
				<div class="id_form">
					<input type="text" v-model="form.email" placeholder="이메일" />
					<i class="xi-mail"></i>
				</div>
				<div class="pw_form">
					<input type="password" v-model="form.password" placeholder="비밀번호" @keyup.enter="getLogin()"/>
					<i class="xi-lock"></i>
				</div>
				<div class="button" @click="getLogin"><button>로그인</button></div>
      <!--  <div class="button" @click="getRegist" style="margin-top:20px"><button style="background-color:#ffffff;color:#4165f0;border:1px solid #4165f0" >회원가입</button></div>-->
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
        email : '',
        password : '',
      },

    }
  },
  mounted(){


  },

  methods:{
    getLogin(){

      if (this.form.email ==''){
        alert('이메일을 입력해주세요.');
        return;
      }
      if (this.form.password ==''){
        alert('비밀번호를 입력해주세요.');
        return;
      }
      ax.getLogin(this.form, (flag, data) => {

        if (flag) {
          sessionStorage.setItem('mavrkToken', data.token)
          localStorage.setItem('mavrkToken', data.token)
          this.$router.push({
            name: 'BoardList',

          });
        } else {

          alert(data.message)

          if (data.message=='첫 로그인입니다.\n비밀번호를 변경해주세요.'){
            this.$router.push({
              name: 'PwChange',
              params : {email :this.form.email}

            });
          }
        }
      })
    },
    getRegist(){
      this.$router.push({
        name: 'Regist',

      });
    }

  }
}
</script>

