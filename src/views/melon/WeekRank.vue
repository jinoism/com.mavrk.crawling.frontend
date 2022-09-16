<template>

<div class="inner_body">
  <div class="page_title">
    <h3>MELON 4주 차트<br /> 순위 추이</h3>
  </div>
  <div class="page_container">
    <div class="cont_box search_form_box">
      <div class="search_form">
        <div><input type="text" placeholder="곡명" /></div>
        <div><input type="text" placeholder="가수명" /></div>
        <div><button><img src="/img/icon_search.png" alt="search"></button></div>
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
        name: 'MelonTopView',
        query: { searchDate: this.form.searchDate, searchTime : this.form.searchTime },
      });
    },
  }
}
</script>

