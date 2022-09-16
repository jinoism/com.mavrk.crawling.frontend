<template>
  <div id="collapseExample" class="header3">
    <div class="sidebar-heading">
      <router-link to="/">
        <img src="/img/logo.png" />
        <p>관리자 페이지</p>
      </router-link>
    </div>
    <div class="sidebar-body">
      <ul>
        <li>
          <router-link :to="{name: 'General'}" :class="{on: page == 1}">
            <span>A/S 고객등록 및 관리</span>
          </router-link>
        </li>
        <li>
          <router-link :to="{name: 'SalesSubs'}" :class="{on: page == 2}">
            <span>매출관리</span>
          </router-link>
        </li>
        <li>
          <router-link :to="{name: 'Apply'}" :class="{on: page == 3}">
            <span>파트너스관리</span>
          </router-link>
        </li>
        <li>
          <div class="accordion" id="accordionExample">
            <div class="accordion-item">
              <a
                :class="{on: page == 4}"
                id="headingOne"
                class="accordion-header"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#collapseOne"
                aria-expanded="true"
                aria-controls="collapseOne"
              >
                통계
              </a>
              <div
                id="collapseOne"
                class="accordion-collapse collapse"
                aria-labelledby="headingOne"
                data-bs-parent="#accordionExample"
              >
                <router-link :to="{name: 'Connect'}" class="in">
                  <span>파트너사별 접속횟수</span>
                </router-link>
                <router-link :to="{name: 'Usage'}" class="in">
                  <span>WEB 사용시간</span>
                </router-link>
                <router-link :to="{name: 'Accum'}" class="in">
                  <span>전체 업체 누적견적금액 통계</span>
                </router-link>
                <router-link :to="{name: 'SubTotal'}" class="in">
                  <span>전체 업체 고객 합계</span>
                </router-link>
                <router-link :to="{name: 'Distribution'}" class="in">
                  <span>A/S 분포율 구분 통계</span>
                </router-link>
              </div>
            </div>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HeaderAdm',
  data() {
    return {
      page: this.$route.meta.dep
    }
  },
  watch: {
    '$route.name': function () {
      console.log(this.$route.name)
      this.page = this.$route.meta.dep
    }
  }
}
</script>
