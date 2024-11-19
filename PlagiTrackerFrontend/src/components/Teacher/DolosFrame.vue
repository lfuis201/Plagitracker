<template>
  <div class="iframe-container">
    <iframe
      :src="url"
      width="100%"
      height="600px"
      frameborder="0"
      allowfullscreen
    ></iframe>
  </div>
</template>

<script setup>
import { defineProps } from 'vue';

// Define the props the component will receive
const props = defineProps({
  url: {
    type: String,
    required: true
  }
});
</script>

<style scoped>
.iframe-container {
  width: 100%;
  height: 100%;
  overflow: hidden;
}
</style>
