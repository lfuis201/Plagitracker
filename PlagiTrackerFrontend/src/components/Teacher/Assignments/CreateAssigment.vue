<template>
  <div>
    <!-- ModalLayout que emite el evento 'close' -->
    <ModalLayout :modalOpen="modalOpen" @close="handleClose">
      <template #default>
        <h3 class="pb-2 text-xl font-bold text-black dark:text-white sm:text-2xl">
          Create Assignment
        </h3>
        <form @submit.prevent="handleSubmit">
          <!-- Assignment Title -->
          <div>
            <label for="assignmentTitle" class="block mb-2">Assignment Title</label>
            <input
              type="text"
              id="assignmentTitle"
              v-model="assignment.title"
              class="border rounded w-full px-3 py-2"
              required
            />
          </div>

          <!-- Assignment Description -->
          <div class="mt-4">
            <label for="assignmentDescription" class="block mb-2">Assignment Description</label>
            <textarea
              id="assignmentDescription"
              v-model="assignment.description"
              class="border rounded w-full px-3 py-2"
              rows="4"
            />
          </div>

          <!-- Submission Date -->
          <div class="mt-4">
            <label for="submissionDate" class="block mb-2">Submission Date</label>
            <input
              type="datetime-local"
              id="submissionDate"
              v-model="assignment.submissionDate"
              :min="minDate"
              :max="maxDate"
              class="border rounded w-full px-3 py-2"
              required
            />
          </div>

          <button
            type="submit"
            class="mt-4 block w-full rounded bg-blue-500 p-3 text-white hover:bg-blue-600"
          >
            Create Assignment
          </button>
        </form>
      </template>
    </ModalLayout>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import ModalLayout from '@/layouts/ModalLayout.vue'
import type { Assignment } from '@/types/Assigment'
import AssignmentService from '@/services/AssigmentService'
import { useAssignmentStore } from '@/stores/assigmentStore'

// Definir las propiedades que el componente recibe del padre
const props = defineProps({
  modalOpen: Boolean,
  courseId: String // Asume que el courseId es pasado como prop
})

// Definir los eventos que el componente puede emitir
const emit = defineEmits(['close'])
// Calcula la fecha mínima para el campo de entrada
const minDate = computed(() => {
  const now = new Date();
  now.setMinutes(now.getMinutes() - now.getTimezoneOffset()); // Ajustar para la zona horaria
  return now.toISOString().slice(0, 16); // Devuelve la fecha y hora en el formato correcto
});


const maxDate = computed(() => {
  const now = new Date()
  now.setFullYear(now.getFullYear() + 2) // Sumar 2 años a la fecha actual
  return now.toISOString().slice(0, 16) // Formato 'YYYY-MM-DDTHH:MM'
})
// Inicializa el store
const assignmentStore = useAssignmentStore()

// Estado para la asignación
const assignment = ref<Assignment>({
  id: '', // El servidor generará el ID
  title: '',
  description: '',
  submissionDate: '',
  courseId: props.courseId // Asigna el courseId que se pasa como prop
})

// Función para cerrar el modal y emitir el evento 'close'
const handleClose = () => {
  emit('close')
}

// Función para manejar el envío del formulario
const handleSubmit = async () => {
  try {
    // Convierte submissionDate a UTC antes de enviar
    const localDate = new Date(assignment.value.submissionDate)
    assignment.value.submissionDate = localDate.toISOString() // Convierte a UTC

    // Crear la asignación usando el servicio
    const createdAssignment = await AssignmentService.createAssignment(assignment.value)
    console.log('Assignment Created:', createdAssignment)
    await assignmentStore.fetchAssignmentsByCourse(props.courseId)

    handleClose()
  } catch (error) {
    console.error('Error creating assignment:', error)
  }
}
</script>

<style scoped>
/* Estilos opcionales adicionales */
</style>
