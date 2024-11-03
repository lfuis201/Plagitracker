<template>
    <!-- Pantalla de carga -->
    <div v-if="props.isLoading" class="mt-10 flex justify-center min-h-scree">
        <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24"><path fill="#4f46e5" d="M12 2A10 10 0 1 0 22 12A10 10 0 0 0 12 2Zm0 18a8 8 0 1 1 8-8A8 8 0 0 1 12 20Z" opacity=".5"/><path fill="#4f46e5" d="M20 12h2A10 10 0 0 0 12 2V4A8 8 0 0 1 20 12Z"><animateTransform attributeName="transform" dur="1s" from="0 12 12" repeatCount="indefinite" to="360 12 12" type="rotate"/></path></svg>    </div>
  </template>
  
  <script setup lang="ts">
  import { defineProps } from 'vue';
  
  // Definir las propiedades que recibe el componente
  const props = defineProps({
    isLoading: {
      type: Boolean,
      required: true
    }
  });
  </script>
  
  <style scoped>
  /* Añadir estilos adicionales si es necesario */
  </style>
  