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
  import { ref } from 'vue';
  
  const url = ref("https://dolos.ugent.be/server/#/share/7644365938209024993");
  </script>
  
  <style scoped>
  .iframe-container {
    width: 100%;
    height: 100%;
    overflow: hidden;
  }
  </style>
