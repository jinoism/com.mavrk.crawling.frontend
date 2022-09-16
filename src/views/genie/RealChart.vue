<template>

<div class="inner_body">
  <div class="page_title">
    <h3>GENIE REALCHART</h3>
  </div>
  <div class="page_container">
    <div class="cont_box search_form_box">
      <div class="search_form">
        <div><input type="date" placeholder="날짜" v-model="form.searchDate"/></div>
        <div>
          <select v-model="form.searchTime">
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
  name: 'GenieTop',
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

      searchMonth :[],
      form :{
        searchDate :'',
        searchTime :''
      }
    }
  },
  mounted(){
    let nowDate = new Date();
    this.form.searchDate = moment(nowDate).format('YYYY-MM-DD')
    this.form.searchTime = moment(nowDate).format('HH')

  },
  methods:{
    getInfo(){
      this.$router.push({
        name: 'GenieTopView',
        query: { searchDate: this.form.searchDate, searchTime : this.form.searchTime },
      });
    },
  }
}
</script>

