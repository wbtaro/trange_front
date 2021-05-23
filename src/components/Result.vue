<template>
  <div class="container">
    <div class="containter-fluid row justify-content-center">
      <p v-if="results.ErrorMessage" class="alert alert-danger col-md-8">
        {{ results.ErrorMessage }}
      </p>
    </div>
    <div v-if="results.Stations" class="row justify-content-center">
      <p>{{ results.Stations.length }}件</p>
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
