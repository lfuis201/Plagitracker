<template>
  <div>
    <!-- ModalLayout que emite el evento 'close' -->
    <ModalLayout :modalOpen="modalOpen" @close="handleClose" :disableClose="isSubmitting">
      <template #default>
        <h3 class="pb-2 text-xl font-bold text-black dark:text-white sm:text-2xl">Create Course</h3>
        <form @submit.prevent="handleSubmit">
          <div>
            <label for="courseName" class="block mb-2">Course Name</label>
            <input
              type="text"
              id="courseName"
              v-model="course.name"
              maxlength="256"
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
            ]"
          >
            {{ isSubmitting ? 'Creating...' : 'Create Course' }}
          </button>
        </form>
      </template>
    </ModalLayout>
  </div>
</template>

<script setup lang="ts">
import { ref, defineEmits, defineProps } from 'vue'
import ModalLayout from '@/layouts/ModalLayout.vue'
import { useUserStore } from '@/stores/userStore' // Importa el store
import CourseService from '@/services/CourseService' // Asegúrate de importar el servicio
import { useCoursesStore } from '@/stores/coursesStore'
import Swal from 'sweetalert2'

// Definir las propiedades que el componente recibe del padre
const props = defineProps({
  modalOpen: Boolean
})

// Definir los eventos que el componente puede emitir
const emit = defineEmits(['close'])

// Estado para el curso
const course = ref({
  id: '', // Este se puede dejar vacío, ya que lo genera el servidor
  name: '',
  teacherId: '' // Este se llenará con el ID del usuario
})

// Usar el store de cursos
const coursesStore = useCoursesStore()
// Inicializa el store
const userStore = useUserStore()
const user = userStore.getUser // Obtiene el usuario del store

const isSubmitting = ref(false)
const errorMessage = ref('')

// Asigna el teacherId al curso
if (user) {
  course.value.teacherId = user.id // Asegúrate de que el ID del usuario esté disponible
}

// Función para cerrar el modal y emitir el evento 'close'
const handleClose = () => {
  emit('close')
}

// Función para manejar el envío del formulario
const handleSubmit = async () => {
  try {
    // Crea el curso usando el servicio
    isSubmitting.value = true // Deshabilita el botón

    const createdCourse = await CourseService.createCourse(course.value)
    console.log('Course Created:', createdCourse)
    await coursesStore.fetchCoursesByTeacher()

    // Restablece el campo del nombre del curso después de crear el curso
    course.value.name = '' // Limpia el campo

    handleClose() // Cierra el modal aquí

    Swal.fire({
      title: 'Course Created!',
      text: 'The course has been created successfully.',
      icon: 'success',
      confirmButtonText: 'Ok'
    })
  } catch (error: any) {
    console.error('Error creating course:', error)
    handleClose()
    if (error.response && error.response.status === 409) {
      errorMessage.value ='There is already a course with the same name'
    }else {
        // Si es cualquier otro error, mostrar un mensaje genérico
        errorMessage.value = 'An unexpected error occurred. Please try again later.';
    }


    // Display error using SweetAlert
    Swal.fire({
      title: 'Course Creation Failed',
      text: errorMessage.value,
      icon: 'error',
      confirmButtonText: 'Try Again'
    })
  } finally {
    isSubmitting.value = false // Habilita el botón nuevamente
  }
}
</script>

<style scoped></style>
