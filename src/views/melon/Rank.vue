<template>

<div class="inner_body">
  <div class="page_title">
    <h3>MELON <br>{{typeTxt}}</h3>
  </div>
  <div class="page_container">
    <div class="cont_box search_form_box">
      <div class="search_form">
        <div><input type="date" placeholder="날짜" v-model="form.searchDate"/></div>
        <div>
          <select v-model="form.searchTime" v-if="this.$route.query.type!='dailychart'">
            <option :value="item.code" v-for="(item, idx) in searchTime()" :key="idx">{{item.codeName}}</option>
          </select>
        </div>
        <div><button @click="getInfo()"><img src="/img/icon_search.png" alt="search" ></button></div>
      </div>
    </div>
  </div>
</div>


</template>

<script>
export default {
  name: 'MeloneTop',
  data(){
    return {
      searchTime(){
        let searchTimeList = []
        for(let i=1; i <=24; i++){
          let codeValue;
          if(i<10){
            codeValue = '0'+i
          }else{
            codeValue = i;
          }
          searchTimeList.push({code : codeValue, codeName : i+'시'});
        }
        return searchTimeList;
      },

      typeList :[
        {code: 'top100', codeName : 'TOP100'},
        {code: 'newtop100w1', codeName : '최신 차트 순위'},
        {code: 'realchart', codeName : '실시간 차트'},
        {code: 'dailychart', codeName : '일간차트'},
        {code: 'streamingcard', codeName : '감상자수'},
      ],
      searchMonth :[],
      form :{
        searchDate :'',
        searchTime :'',
        type : this.$route.query.type
      }
    }
  },
  mounted(){

    let nowDate = new Date();
    if (this.$route.query.type!='dailychart'){
      this.form.searchDate = moment(nowDate).format('YYYY-MM-DD')
    } else {
      nowDate.setDate(nowDate.getDate()-1)
      this.form.searchDate = moment(nowDate).format('YYYY-MM-DD')
    }
    this.form.searchTime = moment(nowDate).format('HH')
    this.typeTxt = this.selectCodeName(this.typeList, this.$route.query.type)
  },
  methods:{
    getInfo(){
      this.$router.push({
        name: 'RankView',
        query: { searchDate: this.form.searchDate, searchTime : this.form.searchTime, type : this.form.type },
      });
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

  }
}
</script>

