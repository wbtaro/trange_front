<template>
  <div class="form-group row justify-content-center">
    <label class="col-form-label">条件{{ index + 1 }}：</label>
    <form class="form-inline">
      <input
        type="text"
        placeholder="東京"
        v-model="searchCondition.station"
        class="form-control"
      />
      <span>駅から</span>
      <input
        type="text"
        size="4"
        maxlength="3"
        placeholder="30"
        v-model="searchCondition.upperMinute"
        class="form-control"
      />
      <span>分以内</span>
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
