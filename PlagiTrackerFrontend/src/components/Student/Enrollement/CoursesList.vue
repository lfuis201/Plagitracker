<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useUserStore } from '@/stores/userStore'
import CourseService from '@/services/CourseService'
import EnrollmentService from '@/services/EnrollmentService'
import Swal from 'sweetalert2' // Import SweetAlert2
import router from '@/router'
import SubmissionService from '@/services/SubmissionService'
import type { Course } from '@/types/Course'

// Estado reactivo para almacenar los cursos
const courses = ref<Course[]>([])
const errorMessage = ref('')

// Obtener el store del usuario
const userStore = useUserStore()

// Método para obtener los cursos del profesor
const fetchCourses = async () => {
  const user = userStore.getUser // Obtener el usuario desde el store

  // Verifica que el usuario esté autenticado y tenga un ID
  if (user && user.id) {
    try {
      courses.value = await CourseService.getAllCourses() // Llama al servicio para obtener cursos
    } catch (error) {
      console.error('Error fetching courses:', error)
    }
  } else {
    console.error('User not authenticated or ID not available.')
  }
}

const courseId = ref<string>('') // Se asegura de que el courseId sea una referencia reactiva de string

// Método para inscribirse en el curso con el ID del curso y el ID del estudiante automáticamente
const enrollInCourse = async () => {
  try {
    const studentId = userStore.getUser?.id // Obtener el ID del estudiante desde el store de usuario
    if (!studentId) {
      throw new Error('El usuario no está autenticado.')
    }

    // Llamar al servicio de inscripción usando courseId.value
    const response = await EnrollmentService.createEnrollment(courseId.value, studentId)
    console.log('Inscripción exitosa:', response)
    // Mostrar un mensaje de éxito con SweetAlert2
    await Swal.fire({
      title: 'Enrollment Successful',
      text: 'You have successfully enrolled in the course.',
      icon: 'success',
      confirmButtonText: 'OK'
    })

    router.push('/student/courses'); // Cambia '/courses' a la ruta que desees


  } catch (error:any) {
    console.error('Error al inscribirse:', error)
    // Set the error message dynamically based on the error status
    if (error.response && error.response.status === 409) {
    errorMessage.value = error.response.data.message; // Specific message for 409 error
  } else if (error.response && error.response.status === 404) {
    errorMessage.value = 'The course does not exist.'; // Message for 404 error
  } else if (error.response && error.response.status === 400) {
    errorMessage.value = 'The ID is not valid.'; // Message for 400 error
  } else {
    errorMessage.value = 'An error occurred while trying to enroll.'; // General message for other errors
  }

    // Mostrar un mensaje de error con SweetAlert2
    await Swal.fire({
      title: 'Enrollment Failed',
      text: errorMessage.value,
      icon: 'error',
      confirmButtonText: 'Try Again'
    });
    
  }


  courseId.value=''
}



// Llama a fetchCourses al montar el componente
onMounted(() => {
  fetchCourses()
})
</script>

<template>
  <div class="max-w-sm mx-auto mt-8 p-4 bg-white border border-gray-300 rounded-lg shadow-md">
    <h2 class="text-lg font-bold mb-4">Enroll in a Course</h2>

    <!-- Formulario de inscripción -->
    <form @submit.prevent="enrollInCourse">
      <!-- Campo de entrada para el ID del curso -->
      <div class="mb-4">
        <label for="courseId" class="block text-sm font-medium text-gray-700 mb-2">Course ID:</label>
        <input
          id="courseId"
          v-model="courseId"
          minlength="1"
          maxlength="50"

          type="text"
          class="border border-gray-300 rounded-md p-2 w-full"
          placeholder="Enter course ID"
          required
        />
      </div>

      <!-- Botón para inscribirse -->
      <button
        type="submit"
        class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-md w-full"
      >
        Enroll
      </button>
    </form>
  </div>
</template>
