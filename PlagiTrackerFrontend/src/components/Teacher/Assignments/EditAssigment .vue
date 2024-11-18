<template>
  <div>
    <!-- ModalLayout que emite el evento 'close' -->
    <ModalLayout :modalOpen="modalOpen" @close="handleClose" :disableClose="isSubmitting">
      <template #default>
        <h3 class="pb-2 text-xl font-bold text-black dark:text-white sm:text-2xl">
          Edit Assignment
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
              v-model="formattedSubmissionDate"
               :min="minDate"
                :max="maxDate"
              class="border rounded w-full px-3 py-2"
              required
            />
          </div>

    
          <button
            type="submit"
            :disabled="isSubmitting"
            :class="[
              'mt-4 block w-full rounded p-3 text-white',
              isSubmitting ? 'bg-blue-300 cursor-not-allowed' : 'bg-blue-500 hover:bg-blue-600'
            ]"          >
            {{ isSubmitting ? 'Updating...' : 'Update Assignment' }}
          </button>


        </form>
      </template>
    </ModalLayout>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, computed } from 'vue'
import ModalLayout from '@/layouts/ModalLayout.vue'
import type { Assignment } from '@/types/Assigment'
import AssignmentService from '@/services/AssigmentService'
import { useAssignmentStore } from '@/stores/assigmentStore'
import { useRoute } from 'vue-router'
import Swal from 'sweetalert2'

// Definir las propiedades que el componente recibe del padre
const props = defineProps({
  modalOpen: Boolean,
  assignment: Object as () => Assignment, // Se define assignment como un objeto del tipo Assignment
  courseId: String // Asume que el courseId es pasado como prop
})

// Definir los eventos que el componente puede emitir
const emit = defineEmits(['close'])

const isSubmitting = ref(false)
const errorMessage = ref('')

// Computed property para manejar la fecha en el formato adecuado
const formattedSubmissionDate = computed({
  get: () => {
    // Convierte la fecha a formato YYYY-MM-DDTHH:mm
    return new Date(assignment.value.submissionDate).toISOString().slice(0, 16)
  },
  set: (value) => {
    // Cuando se cambia el valor, se convierte a ISO para guardar en el assignment
    assignment.value.submissionDate = new Date(value).toISOString()
  }
})
const assignmentStore = useAssignmentStore()
const route = useRoute() // Acceder a los parámetros de la ruta


const minDate = computed(() => {
  const now = new Date()
  now.setMinutes(now.getMinutes() - now.getTimezoneOffset()) // Ajustar para la zona horaria
  return now.toISOString().slice(0, 16) // Devuelve la fecha y hora en el formato correcto
})

const maxDate = computed(() => {
  const now = new Date()
  now.setFullYear(now.getFullYear() + 2) // Sumar 2 años a la fecha actual
  return now.toISOString().slice(0, 16) // Formato 'YYYY-MM-DDTHH:MM'
})

// Estado para la asignación
const assignment = ref<Assignment>({ ...props.assignment }) // Clonar el assignment recibido

// Observa los cambios en props.assignment para actualizar el estado local
watch(
  () => props.assignment,
  (newAssignment) => {
    assignment.value = { ...newAssignment } // Actualiza el estado local cuando cambian las props
  }
)


// Función para cerrar el modal y emitir el evento 'close'
const handleClose = () => {
  emit('close')
}

// Función para manejar el envío del formulario
const handleSubmit = async () => {
  try {
    // Actualiza la asignación usando el servicio

    isSubmitting.value = true // Deshabilita el botón


    const updatedAssignment = await AssignmentService.updateAssignment(assignment.value)
    console.log('Assignment Updated:', updatedAssignment)
    // Obtener courseId de los parámetros de la ruta
    const courseId = route.params.id // Acceder al id de la ruta

    await assignmentStore.fetchAssignmentsByCourse(courseId) // Pasar courseId al método

    // Si deseas realizar alguna acción adicional después de la actualización, hazlo aquí

    handleClose() // Cierra el modal después de actualizar la asignación

     // Mostrar alerta de éxito
     Swal.fire({
      title: 'Assignment Updated!',
      text: 'The assignment has been updated successfully.',
      icon: 'success',
      confirmButtonText: 'Ok'
    })


  } catch (error:any) {
    console.error('Error updating assignment:', error)

    if (
      error.response &&
      error.response.status === 409 &&
      error.response.data.message === 'An assignment with the same title already exists in this course.'
    ) {
      errorMessage.value =  error.response.data.message
    } else {
      errorMessage.value = 'An error occurred while updating the course.'
    }

    handleClose()
    // Display error using SweetAlert
     // Mostrar el error usando SweetAlert
     Swal.fire({
      title: 'Assignment Update Failed',  // Cambiar a "Assignment Update Failed"
      text: errorMessage.value,          // Usar el mensaje de error adecuado
      icon: 'error',
      confirmButtonText: 'Try Again'
    });
  }finally {
    isSubmitting.value = false // Habilita el botón nuevamente
  }
}
</script>

<style scoped>
/* Estilos opcionales adicionales */
</style>
