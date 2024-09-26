<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useUserStore } from '@/stores/userStore';
import CourseCard from './CourseCard.vue'; // Asegúrate de importar el componente CourseCard
import CourseService from '@/services/CourseService'; // Importa el servicio para obtener cursos
import type { Course } from '@/types/Course'; // Importa el tipo Course

// Estado reactivo para almacenar los cursos
const courses = ref<Course[]>([]); 
const isLoading = ref(true); // Estado para manejar la pantalla de carga

// Obtener el store del usuario
const userStore = useUserStore();

// Método para obtener los cursos del profesor
const fetchCourses = async () => {
  const user = userStore.getUser; // Obtener el usuario desde el store

  // Verifica que el usuario esté autenticado y tenga un ID
  if (user && user.id) {
    try {
      const coursesData = await CourseService.getAllByTeacher(user.id); // Llama al servicio para obtener cursos

      // Simula un retraso de 2 segundos antes de mostrar los cursos
      setTimeout(() => {
        courses.value = coursesData; // Almacena los cursos después de 2 segundos
        isLoading.value = false; // Finaliza la pantalla de carga
      }, 2000); // Simula una demora de 2 segundos
    } catch (error) {
      console.error('Error fetching courses:', error);
      isLoading.value = false; // Finaliza la pantalla de carga si hay un error
    }
  } else {
    console.error('User not authenticated or ID not available.');
    isLoading.value = false; // Finaliza la pantalla de carga si no hay usuario
  }
};

// Llama a fetchCourses al montar el componente
onMounted(() => {
  fetchCourses();
});
</script>

<template>
  <!-- Pantalla de carga -->
  <div v-if="isLoading" class="flex items-center justify-center min-h-screen">
    <div class="animate-spin rounded-full h-16 w-16 border-t-4 border-b-4 border-blue-500"></div>
  </div>

  <!-- Lista de cursos -->
  <div v-else class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mt-6">
    <!-- Iteramos sobre la lista de cursos y mostramos un CourseCard para cada uno -->
    <CourseCard
      v-for="course in courses"
      :key="course.id"
      :course="course"
    />
  </div>
</template>
