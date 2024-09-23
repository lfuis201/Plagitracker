<template>
  <div>
    <!-- ModalLayout que emite el evento 'close' -->
    <ModalLayout :modalOpen="modalOpen" @close="handleClose">
      <template #default>
        <h3 class="pb-2 text-xl font-bold text-black dark:text-white sm:text-2xl">Create Course</h3>
        <form @submit.prevent="handleSubmit">
          <div>
            <label for="courseName" class="block mb-2">Course Name</label>
            <input
              type="text"
              id="courseName"
              v-model="course.name"
              class="border rounded w-full px-3 py-2"
              required
            />
          </div>
         
          <button
            type="submit"
            class="mt-4 block w-full rounded bg-blue-500 p-3 text-white hover:bg-blue-600"
          >
            Create Course
          </button>
        </form>
   
      </template>
    </ModalLayout>
  </div>
</template>

<script setup lang="ts">
import { ref, defineEmits, defineProps } from 'vue'
import ModalLayout from '@/layouts/ModalLayout.vue'
import Course from '@/components/Courses/Course.vue'
// Definir las propiedades que el componente recibe del padre
const props = defineProps({
  modalOpen: Boolean
})

// Definir los eventos que el componente puede emitir
const emit = defineEmits(['close'])

// Estado para el curso
const course = ref<Course>({
  id: '',
  name: '',
  teacherId: ''
})

// Función para cerrar el modal y emitir el evento 'close'
const handleClose = () => {
  emit('close')
}

// Función para manejar el envío del formulario
const handleSubmit = () => {
  // Generar un ID único para el curso
  course.value.id = generateUniqueId()
  console.log('Course Created:', course.value)
  // Opcional: cerrar el modal después de crear el curso
  handleClose()
}

// Función para generar un ID único (puedes adaptarla según tus necesidades)
const generateUniqueId = () => {
  return 'course-' + Math.random().toString(36).substr(2, 9)
}
</script>

<style scoped>
/* Estilos opcionales adicionales */
</style>
