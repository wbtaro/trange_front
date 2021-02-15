<template>
  <div>
    <p v-if="result.ErrorMessage">
      {{ result.ErrorMessage }}
    </p>
    <div v-if="result.Stations">
      <div
        v-for="(station, index) in result.Stations"
        :key="index"
      >
        <p>{{ station }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from "@vue/composition-api";

export default defineComponent({
  props: {
    result: Object,
  },
});
</script>
