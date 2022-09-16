<template>
<!-- /공지사항 -->
<div class="inner_body">
  <div class="page_title">
    <h3>ADMIN </h3>
    <small>사용자관리</small>
  </div>

  <div class="song_list_body mt30-md">
  <div class="list_head">
    <ul>
      <li class="subject song_info">사용자 정보</li>


    </ul>
  </div>
  <div class="list_body admin_list_mody">
    <ul v-for="(item, idx) in list" :key="idx" >

      <li class="subject song_info" >
        <div class="title">
          <p>	{{item.email}}</p>

        </div>
      </li>
      <li>
        {{item.name}}
        </li>
      <li>
        <div class="search_form_box">
          <div class="search_form" >

            <div style="width:200px;margin-right:50px">
              <select v-model="list[idx].roles[0]" v-if="this.$route.query.type!='dailychart'" @change="changeRole(item.email,$event)" :disabled="item.email == 'admin@mavrk.co.kr'">
                <option :value="item.code" v-for="(item, idx) in typeList" :key="idx">{{item.codeName}}</option>
              </select>
            </div>
          </div>
        </div>
      </li>

       <li class="w_sm">
        <button class="save" @click="pwChange(item.email)"><i class="xi-sync"></i></button>
      </li>


    </ul>
    <ul v-if="list.length ==0 ">
      <li >조회된 내역이 없습니다.</li>
    </ul>
  </div>
  <div class="bottom_btn">
    <button type="submit" class="btn btn-purple" @click="getList">회원등록</button>
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

      typeList :[
        {code: 'ROLE_ADMIN', codeName : '최고관리자'},
        {code: 'ROLE_MANAGER', codeName : '관리자'},
        {code: 'ROLE_USER', codeName : '사용자'},

      ],
      list:[

      ],
      typeTxt :'',
      searchMonth :[],
      form :{
        song :'',
        artist :'',

        type : this.$route.query.type,
        platform: this.$route.query.platform

      }
    }
  },
  mounted(){
    this.getInfo();

  },

  methods:{
    getInfo(){

      adminAx.getUserList(this.form, (flag, data) => {
        if (flag) {
          console.dir(data)
          this.list= data.data
          this.loading =false
        } else {
          alert(data.message)
        }
      })
    },
    pwChange(email){
      if (confirm('해당회원의 비밀번호를 초기화 하시겠습니까?')){
        let params = {}
        params.email = email
        adminAx.pwChange(params, (flag, data) => {
          if (flag) {
            alert('비밀번호가 초기화 되었습니다.');
          } else {
            alert(data.message)
          }
        })

      }
    },

    changeRole(email, e){

      if (confirm('해당회원의 권한을 변경 하시겠습니까?')){
        let params = {}
        params.email = email
        params.role = e.target.value
        adminAx.roleChange(params, (flag, data) => {
          if (flag) {
            alert('권한이 변경되었습니다.');
          } else {
            alert(data.message)
          }
        })

      } else {
        this.getInfo();
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
        name: 'Regist'
      });
    }

  }
}
</script>

