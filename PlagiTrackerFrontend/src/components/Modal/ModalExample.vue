<template>
    <div>
      <!-- ModalLayout que emite el evento 'close' -->
      <ModalLayout :modalOpen="modalOpen" @close="handleClose">
        <template #default>
          <h3 class="pb-2 text-xl font-bold text-black dark:text-white sm:text-2xl">
            Custom Modal Title
          </h3>
          <p class="mb-10 font-medium">
            This is the custom content inside the modal. You can add any content here.
          </p>
          <button
            @click="handleClose"
            class="block w-full rounded bg-blue-500 p-3 text-white hover:bg-blue-600"
          >
            Close Modal
          </button>
        </template>
      </ModalLayout>
    </div>
  </template>
  
  <script setup lang="ts">
  import { defineEmits, defineProps } from 'vue';
  import ModalLayout from '@/layouts/ModalLayout.vue';
  
  // Definir las propiedades que el componente recibe del padre
  const props = defineProps({
    modalOpen: Boolean,
  });
  
  // Definir los eventos que el componente puede emitir
  const emit = defineEmits(['close']);
  
  // Función para cerrar el modal y emitir el evento 'close'
  const handleClose = () => {
    emit('close');
  };
  </script>
  
  <style scoped>
  /* Estilos opcionales adicionales */
  </style>
  