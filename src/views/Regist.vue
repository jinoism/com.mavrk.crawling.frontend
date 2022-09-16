<template>


	<div id="login_wrap">
		<div class="login_form" style="width:100%">
			<div class="box">
				<h2>Sign Up</h2>
				<div class="id_form">
					<input type="text" v-model="form.email" placeholder="이메일" maxlength="30"/>
					<i class="xi-mail"></i>
				</div>
        <div class="id_form">
					<input type="text" v-model="form.name" placeholder="이름" maxlength="10"/>
					<i class="xi-user"></i>
				</div>
				<div class="pw_form">
					<input type="password" v-model="form.password" placeholder="비밀번호" maxlength="20"/>
					<i class="xi-lock"></i>
				</div>
				<div class="button" @click="getRegist"><button>회원가입</button></div>
        <div class="button" @click="getLogin" style="margin-top:20px"><button style="background-color:#ffffff;color:#4165f0;border:1px solid #4165f0" >뒤로가기</button></div>
			</div>
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
        name :'',
        password : '',
      },

    }
  },
  mounted(){


  },

  methods:{
    getLogin(){
      this.$router.push({
        name: 'AdminMemberList',

      });
    },
    getRegist(){

      if (this.form.email ==''){
        alert('이메일을 입력해주세요.');
        return;
      }
      let emailChk =
      /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      if (emailChk.test(this.form.email) ? false : true){
        alert('올바른 이메일 형식을 입력해주세요.');
        return;
      }
      if (this.form.name ==''){
        alert('이름을 입력해주세요.');
        return;
      }

      if (this.form.password ==''){
        alert('비밀번호를 입력해주세요.');
        return;
      }

      let re = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,50}$/
      if (re.test(this.form.password) ? false : true){
        alert('비밀번호는 최소 8자리이상 영문/숫자/특수문자 혼용으로 입력해주세요.');
        return
      }

      ax.getRegist(this.form, (flag, data) => {

        if (flag) {
          alert('회원가입이 정상적으로 처리되었습니다.로그인후 이용해주세요.');
          this.$router.push({
            name: 'AdminMemberList',
          });
        } else {

          alert('중복된 이메일이 존재합니다.다른 이메일을 입력해주세요.')
        }
      })
    },

  }
}
</script>

