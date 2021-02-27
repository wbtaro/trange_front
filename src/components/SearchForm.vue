<template>
  <div class="form-group row justify-content-center">
    <label class="col-form-label">
      <span class="badge bg-dark mr-2 text-light">条件{{ index + 1 }}</span>
    </label>
    <form class="form-inline">
      <input
        type="text"
        placeholder="東京"
        v-model="searchCondition.station"
        class="form-control"
      />
      <span class="mx-2">駅から</span>
      <input
        type="text"
        size="4"
        maxlength="3"
        placeholder="30"
        v-model="searchCondition.upperMinute"
        class="form-control"
      />
      <span class="mx-2">分以内</span>
    </form>
  </div>
</template>

<script>
import { defineComponent } from "@vue/composition-api";

export default defineComponent({
  props: {
    searchCondition: Object,
    index: Number
  }
});
</script>
