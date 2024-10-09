<template>
    <div class="flex flex-col justify-center items-center w-full bg-gray-50 inset-0 z-10 p-4 sm:p-8 md:p-12 lg:p-16">
      <h3 class="font-semibold text-red-600 text-2xl">{{ title }}</h3>
      <p class="text-zinc-600 mt-2">{{ description }}</p>
      <router-link :to="link" class="mt-4">
        <button class="bg-blue-500 text-white hover:bg-blue-600 px-6 py-3 rounded-md transition duration-200 ease-in-out transform hover:scale-105">
          {{ buttonText }}
        </button>
      </router-link>
    </div>
  </template>
  
  <script setup lang="ts">
  defineProps({
    title: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },
    buttonText: {
      type: String,
      required: true,
    },
    link: {
      type: String,
      required: true,
    },
  });
  </script>
  
  <style scoped>
  /* Puedes agregar estilos personalizados aquí si lo deseas */
  </style>
  