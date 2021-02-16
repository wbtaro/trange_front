<template>
  <div class="container">
    <div>
      <h2>検索条件</h2>
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
          class="btn btn-outline-dark"
        >
          条件を追加
        </button>
        <button
          @click="deleteSearchCondition"
          ref="deleteConditionButton"
          class="btn btn-outline-dark"
          disabled
        >
          条件を削除
        </button>
      </p>
      <p>
        <b-button @click="rangeSearch" variant="primary">駅を探す</b-button>
      </p>
    </div>
    <div v-if="results">
      <h2>検索結果</h2>
      <result
        is="result"
        :results="results"
        :executedSearchConditions="executedSearchConditions"
      >
      </result>
    </div>
  </div>
</template>

<script>
import { defineComponent } from "@vue/composition-api";
import SearchForm from "@/components/SearchForm.vue";
import Result from "@/components/Result.vue";
import axios from "axios";
import _ from "lodash";

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
    "search-form": SearchForm,
    result: Result
  },
  data() {
    return {
      searchConditions: [new SearchCondition()],
      maxConditionNum: 4,
      minConditionNum: 1,
      results: undefined,
      executedSearchConditions: undefined
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
      let response = await axios.post(
        "https://iruj5ma8p6.execute-api.ap-northeast-1.amazonaws.com/prod/range_search",
        body
      );
      this.results = response.data;
      this.executedSearchConditions = _.cloneDeep(this.searchConditions);
    }
  }
});
</script>
