<!-- src/components/NoInternetView.vue -->
<template>
    <div class="flex flex-col items-center justify-center min-h-screen bg-red-100">
      <div class="text-center">
        <h1 class="text-4xl font-bold text-red-600 mb-4">Sin Conexión a Internet</h1>
        <p class="text-lg text-gray-700 mb-8">Parece que has perdido la conexión a internet. Verifica tu red y vuelve a intentarlo.</p>
        <button @click="retryConnection" class="px-4 py-2 bg-blue-600 text-white font-semibold rounded hover:bg-blue-700">
          Reintentar
        </button>
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
  // El botón de reintentar puede intentar volver a verificar si hay conexión
  function retryConnection() {
    if (navigator.onLine) {
      location.reload() // O simplemente hacer algo cuando se recupere la conexión
    }
  }
  </script>
  
  <style scoped>
  /* Estilos adicionales si se requieren */
  </style>
  