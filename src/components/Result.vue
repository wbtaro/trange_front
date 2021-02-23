<template>
  <div class="container text-center">
    <div>
      <p v-if="results.ErrorMessage" class="alert alert-danger">
        {{ results.ErrorMessage }}
      </p>
    </div>
    <div v-if="results.Stations" class="row justify-content-center">
      <!-- <h3>指定された条件</h3>
      <ul v-for="(condition, index) in executedSearchConditions" :key="index">
        <li>{{ condition.station }}から{{ condition.upperMinute }}分</li>
      </ul>
      <h3>条件を満たす駅</h3> -->
      <div class="col-md-8">
        <div
          v-for="(result, resultIndex) in results.Stations"
          :key="resultIndex"
          class="card pt-2 mb-4 border-secondary bg-light"
        >
          <h3 class="card-title h4 font-weight-bold">
            {{ result.Station.Name }}
          </h3>
          <ul class="list-group list-group-flush">
            <li
              v-for="(cost, conditionIndex) in result.Cost"
              :key="conditionIndex"
              class="list-group-item"
            >
              {{ executedSearchConditions[conditionIndex].station }}から{{
                cost.Minute
              }}
              分：乗り換え回数{{ cost.TransferCount }}回
            </li>
          </ul>
        </div>
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
  }
});
</script>
