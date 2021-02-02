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
    <p>
      <button
        @click="addSearchCondition"
        ref="addConditionButton"
      >
        条件を追加
      </button>
      <button
        @click="deleteSearchCondition"
        ref="deleteConditionButton"
        disabled
      >
        条件を削除
      </button>
    </p>
  </div>
</template>

<script>
import { defineComponent } from "@vue/composition-api";
import SearchForm from "@/components/SearchForm.vue";

class SearchCondition {
  constructor(){
    this.station = "";
    this.upperMinute = "";
  }
}

export default defineComponent({
  components: {
    'search-form': SearchForm
  },
  data(){
    return {
      searchConditions: [new SearchCondition()],
      maxConditionNum: 4,
      minConditionNum: 1
    }
  },
  methods: {
    addSearchCondition: function(){
      this.searchConditions.push(new SearchCondition());
      if (this.searchConditions.length == this.maxConditionNum) {
        this.$refs.addConditionButton.disabled = true;
      }
      if (this.searchConditions.length > this.minConditionNum){
        this.$refs.deleteConditionButton.disabled = false;
      }
    },
    deleteSearchCondition: function(){
      this.searchConditions.pop();
      if (this.searchConditions.length < this.maxConditionNum){
        this.$refs.addConditionButton.disabled = false;
      }
      if (this.searchConditions.length == this.minConditionNum){
        this.$refs.deleteConditionButton.disabled = true;
      }
    }
  }
})
</script>
