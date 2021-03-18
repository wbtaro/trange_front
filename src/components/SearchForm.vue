<template>
  <div class="form-group row justify-content-center">
    <label class="col-form-label">
      <span class="badge bg-dark mr-2 text-light">条件{{ index + 1 }}</span>
    </label>
    <form class="form-inline">
      <input
        type="text"
        placeholder="駅名を入力"
        v-model="searchCondition.station"
        @keyup="incrementalSearch"
        v-bind:list="'possibleStationList' + index"
        autocomplete="on"
        class="form-control"
      />
      <datalist v-bind:id="'possibleStationList' + index">
        <option
          v-for="(possibleStation, possibleStationIndex) in possibleStations"
          :key="possibleStationIndex"
          v-bind:value="possibleStation"
        >
          {{ possibleStation }}
        </option>
      </datalist>
      <span class="mx-2">駅から</span>
      <input
        type="text"
        size="4"
        maxlength="3"
        placeholder="200分以内で入力"
        v-model="searchCondition.upperMinute"
        class="form-control"
      />
      <span class="mx-2">分以内</span>
    </form>
  </div>
</template>

<script>
import { defineComponent } from "@vue/composition-api";
import axios from "axios";

export default defineComponent({
  props: {
    searchCondition: Object,
    index: Number
  },
  data() {
    return {
      possibleStations: [],
      incrementalSearchExecutable: true
    };
  },
  methods: {
    incrementalSearch: async function() {
      if (
        !this.incrementalSearchExecutable || //検索実行権(=別のタイミングで実施中)がないとき
        !this.searchCondition.station || //検索フォームが空の場合
        (this.possibleStations.length === 1 &&
          this.searchCondition.station in this.possibleStations) // 検索候補から選んだものがすでにフォームに入っている時
      ) {
        return;
      }

      this.incrementalSearchExecutable = false;
      let response = await axios.get(
        "https://iruj5ma8p6.execute-api.ap-northeast-1.amazonaws.com/prod/incremental_search?baseStationName=" +
          this.searchCondition.station
      );
      console.log(
        "https://iruj5ma8p6.execute-api.ap-northeast-1.amazonaws.com/prod/incremental_search?baseStationName=" +
          this.searchCondition.station
      );
      this.possibleStations = response.data.PossibleStations;
      if (!this.possibleStations) {
        // 検索結果が0件の場合は実行権をすぐに手放す
        this.incrementalSearchExecutable = true;
        return;
      }
      await new Promise(resolve => setTimeout(resolve, 500));
      this.incrementalSearchExecutable = true;
    }
  }
});
</script>
