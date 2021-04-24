<template>
  <div>
    <div class="container-fluid text-center bg-light p-4">
      <section id="search-condition">
        <h2 class="mb-3 h3">検索条件</h2>
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
            class="btn btn-secondary btn-sm mx-2"
          >
            条件を追加
          </button>
          <button
            @click="deleteSearchCondition"
            ref="deleteConditionButton"
            class="btn btn-secondary btn-sm mx-2"
            disabled
          >
            条件を削除
          </button>
        </p>
        <p>
          <button
            @click="rangeSearch"
            variant="primary"
            class="btn btn-primary btn-lg mt-4"
          >
            検索
          </button>
        </p>
      </section>
    </div>
    <div v-if="results" class="container text-center">
      <section id="search-result">
        <h2 class="my-4 h3">検索結果</h2>
        <result
          is="result"
          :results="results"
          :executedSearchConditions="executedSearchConditions"
        >
        </result>
      </section>
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
