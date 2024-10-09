<template>
  <transition name="modal-fade" @before-enter="beforeEnter" @after-leave="afterLeave">
    <div
      v-if="modalOpen"
      class="fixed left-0 top-0 z-999999 flex h-full min-h-screen w-full items-center justify-center bg-black/90 px-4 py-5"
      @click="emitClose"
    >
      <div
        @click.stop
        class="relative w-full max-w-142.5 rounded-lg bg-white px-8 py-12 dark:bg-boxdark md:px-17.5 md:py-15"
      >
        <!-- Botón de cerrar (X) -->
        <button
          @click="emitClose"
          class="absolute top-4 right-4 text-black hover:text-gray-800 focus:outline-none"
          aria-label="Close modal"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
            <path
              fill="#333333"
              d="M6.4 19L5 17.6l5.6-5.6L5 6.4L6.4 5l5.6 5.6L17.6 5L19 6.4L13.4 12l5.6 5.6l-1.4 1.4l-5.6-5.6z"
            />
          </svg>
        </button>

        <slot> </slot>
      </div>
    </div>
  </transition>
</template>

<script setup lang="ts">
import { defineEmits, defineProps } from 'vue'

const emit = defineEmits(['close'])
const props = defineProps({
  modalOpen: {
    type: Boolean,
    required: true
  }
})

// Función para cerrar el modal y emitir el evento
const emitClose = () => {
  emit('close')
}

// Eventos de transición (opcional)
const beforeEnter = () => {
  console.log('Modal is about to enter')
}
const afterLeave = () => {
  console.log('Modal has left')
}
</script>

<style scoped>
.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.5s ease;
}
.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
}
</style>
