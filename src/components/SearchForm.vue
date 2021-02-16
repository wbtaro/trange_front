<template>
  <div>
    <label>条件{{ index + 1 }}：</label>
    <form>
      <input type="text" v-model="searchCondition.station" />
      <span>駅から</span>
      <input type="text" v-model="searchCondition.upperMinute" />
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
