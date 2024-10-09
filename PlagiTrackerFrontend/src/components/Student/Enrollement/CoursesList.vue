<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useUserStore } from '@/stores/userStore'
import CourseCard from './CourseCard.vue'
import CourseService from '@/services/CourseService'
import type { Course } from '@/types/Course'
import EnrollmentService from '@/services/EnrollmentService'

// Estado reactivo para almacenar los cursos
const courses = ref<Course[]>([])

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
const courseId = ref<string>(''); // Se asegura de que el courseId sea una referencia reactiva de string

// Método para inscribirse en el curso con el ID del curso y el ID del estudiante automáticamente
const enrollInCourse = async () => {
  try {
    const studentId = userStore.getUser?.id; // Obtener el ID del estudiante desde el store de usuario
    if (!studentId) {
      throw new Error('El usuario no está autenticado.');
    }

    // Validamos si el courseId no está vacío
    if (!courseId.value) {
      throw new Error('No se ha proporcionado un ID de curso.');
    }

    // Llamar al servicio de inscripción usando courseId.value
    const response = await EnrollmentService.createEnrollment(courseId.value, studentId);
    console.log('Inscripción exitosa:', response);
    alert('Te has inscrito exitosamente al curso.');
  } catch (error) {
    console.error('Error al inscribirse:', error);
    alert('Ocurrió un error al intentar inscribirte.');
  }
};
// Llama a fetchCourses al montar el componente
onMounted(() => {
  fetchCourses()
})
</script>

<template>
  <div class="max-w-sm mx-auto mt-8 p-4 border border-gray-300 rounded-lg shadow-md">
  <h2 class="text-lg font-bold mb-4">Inscribirse en un curso</h2>

  <!-- Campo de entrada para el ID del curso -->
  <div class="mb-4">
    <label for="courseId" class="block text-sm font-medium text-gray-700 mb-2">ID del Curso:</label>
    <input
      id="courseId"
      v-model="courseId"
      type="text"
      class="border border-gray-300 rounded-md p-2 w-full"
      placeholder="Ingresa el ID del curso"
      required
    />
  </div>

  <!-- Botón para inscribirse -->
  <button
    @click="enrollInCourse"
    class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-md w-full"
  >
    Inscribirse
  </button>
</div>
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mt-6">
    <!-- Iteramos sobre la lista de cursos y mostramos un CourseCard para cada uno -->
    <CourseCard v-for="course in courses" :key="course.id" :course="course" />
  </div>
</template>
