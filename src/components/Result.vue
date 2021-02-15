<template>
  <div>
    <p v-if="results.ErrorMessage">
      {{ results.ErrorMessage }}
    </p>
    <div v-if="results.Stations">
      <h3>指定された条件</h3>
      <ul
        v-for="(condition, index) in executedSearchConditions"
        :key = index
      >
        <li>
          {{ condition.station }}から{{ condition.upperMinute }}分
        </li>
      </ul>
      <h3>条件を満たす駅</h3>
      <div
        v-for="(result, resultIndex) in results.Stations"
        :key="resultIndex"
      >
        <p>{{ result.Station.Name }}</p>
        <ul>
          <li
            v-for="(cost, conditionIndex) in result.Cost"
            :key="conditionIndex"
          >
            {{ executedSearchConditions[conditionIndex].station }}から{{ cost.Minute }} 分：乗り換え回数{{ cost.TransferCount }}回
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from "@vue/composition-api";

export default defineComponent({
  props: {
    results: Object,
    executedSearchConditions: Array
  },
})
</script>
