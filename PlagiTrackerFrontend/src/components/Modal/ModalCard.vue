<template>
    <transition
      name="modal-fade"
      @before-enter="beforeEnter"
      @after-leave="afterLeave"
    >
      <div
        v-if="modalOpen"
        class="fixed left-0 top-0 z-999999 flex h-full min-h-screen w-full items-center justify-center bg-black/90 px-4 py-5"
      >
        <div
          @click.self="closeModal"
          class="w-full max-w-142.5 rounded-lg bg-white px-8 py-12 text-center dark:bg-boxdark md:px-17.5 md:py-15"
        >
          <h3 class="pb-2 text-xl font-bold text-black dark:text-white sm:text-2xl">
            Your Message Sent Successfully
          </h3>
          <span class="mx-auto mb-6 inline-block h-1 w-22.5 rounded bg-primary"></span>
          <p class="mb-10 font-medium">
            Lorem Ipsum is simply dummy text of the printing and typesetting industry.
            Lorem Ipsum has been the industry's standard dummy text ever since
          </p>
          <div class="-mx-3 flex flex-wrap gap-y-4">
            <div class="w-full px-3 2xsm:w-1/2">
              <button
                @click="closeModal"
                class="block w-full rounded border border-stroke bg-gray p-3 text-center font-medium text-black transition hover:border-meta-1 hover:bg-meta-1 hover:text-white dark:border-strokedark dark:bg-meta-4 dark:text-white dark:hover:border-meta-1 dark:hover:bg-meta-1"
              >
                Cancel
              </button>
            </div>
            <div class="w-full px-3 2xsm:w-1/2">
              <button
                class="block w-full rounded border border-primary bg-primary p-3 text-center font-medium text-white transition hover:bg-opacity-90"
              >
                View Details
              </button>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </template>
  
  <script setup lang="ts">
  import { ref, defineExpose } from 'vue';
  
  // Estado reactivo para el control de apertura/cierre del modal
  const modalOpen = ref(false);
  
  // Función para cerrar el modal
  const closeModal = () => {
    modalOpen.value = false;
  };
  
  // Función para abrir el modal
  const openModal = () => {
    modalOpen.value = true;
  };
  
  // Exponer las funciones al componente padre
  defineExpose({
    openModal,
    closeModal
  });
  
  // Eventos de transición (opcional, pero útiles para manejar estado durante la animación)
  const beforeEnter = () => {
    console.log('Modal is about to enter');
  };
  const afterLeave = () => {
    console.log('Modal has left');
  };
  </script>
  
  <style scoped>
  /* Clases para la animación */
  .modal-fade-enter-active, .modal-fade-leave-active {
    transition: opacity 0.5s ease;
  }
  .modal-fade-enter-from, .modal-fade-leave-to {
    opacity: 0;
  }
  </style>
  