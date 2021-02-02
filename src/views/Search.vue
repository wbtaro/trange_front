<template>
  <div>
    <searchForm
      is="search-form"
      v-for="(searchCondition, index) in searchConditions"
      :key="index"
      :index="index"
      :searchCondition="searchCondition"
     >
     </searchForm>
  </div>
</template>

<script>
import {
  defineComponent,
} from '@vue/composition-api'
import SearchForm from "@/components/SearchForm.vue"

class SearchCondition {
  constructor(){
    this.station = '';
    this.upperMinute = '';
  }
}

export default defineComponent({
  components: {
    'search-form': SearchForm
  },
  data(){
    return {
      searchConditions: [new SearchCondition()],
    }
  },
})
</script>
