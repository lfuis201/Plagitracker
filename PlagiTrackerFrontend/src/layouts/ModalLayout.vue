<template>
  <transition name="modal-fade" @before-enter="beforeEnter" @after-leave="afterLeave">
    <div
      v-if="modalOpen"
      class="fixed left-0 top-0 z-999999 flex h-full min-h-screen w-full items-center justify-center bg-black/90 px-4 py-5"
      @click="emitClose"
    >
      <div
        @click.stop
        class="w-full max-w-142.5 rounded-lg bg-white px-8 py-12 text-center dark:bg-boxdark md:px-17.5 md:py-15"
      >
        <slot></slot>
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
