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
    <p>
      <button @click="rangeSearch">検索</button>
    </p>
    {{ result }}
  </div>
</template>

<script>
import { defineComponent } from "@vue/composition-api";
import SearchForm from "@/components/SearchForm.vue";
import axios from "axios";

class SearchCondition {
  constructor() {
    this.station = "";
    this.upperMinute = "";
  }

  getConditionInAPIForm() {
    return {
      BaseStationName: this.station,
      UpperMinute: this.upperMinute
    };
  }
}

export default defineComponent({
  components: {
    "search-form": SearchForm
  },
  data() {
    return {
      searchConditions: [new SearchCondition()],
      maxConditionNum: 4,
      minConditionNum: 1,
      result: undefined
    };
  },
  methods: {
    addSearchCondition: function() {
      this.searchConditions.push(new SearchCondition());
      if (this.searchConditions.length == this.maxConditionNum) {
        this.$refs.addConditionButton.disabled = true;
      }
      if (this.searchConditions.length > this.minConditionNum) {
        this.$refs.deleteConditionButton.disabled = false;
      }
    },
    deleteSearchCondition: function() {
      this.searchConditions.pop();
      if (this.searchConditions.length < this.maxConditionNum) {
        this.$refs.addConditionButton.disabled = false;
      }
      if (this.searchConditions.length == this.minConditionNum) {
        this.$refs.deleteConditionButton.disabled = true;
      }
    },
    rangeSearch: async function() {
      let body = { SearchConditions: [] };
      for (const condition of this.searchConditions) {
        body["SearchConditions"].push(condition.getConditionInAPIForm());
      }
      this.result = await axios.post(
        "https://iruj5ma8p6.execute-api.ap-northeast-1.amazonaws.com/prod/range_search",
        body
      )
    }
  }
});
</script>
