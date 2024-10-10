<script setup lang="ts">
import { onMounted } from 'vue';
import { useCoursesStore } from '@/stores/coursesStore'; // Importa el store de cursos
import CourseCard from './CourseCard.vue'; // Asegúrate de importar el componente CourseCard

// Usamos el store de cursos
const coursesStore = useCoursesStore();

// Llama a fetchCoursesByTeacher cuando el componente se monte
onMounted(() => {
  coursesStore.fetchCoursesByTeacher(); // Cargar los cursos al montar el componente
  console.log(coursesStore.courses)
});
</script>

<template>
  <!-- Pantalla de carga -->
  <div v-if="coursesStore.isLoading" class="flex items-center justify-center min-h-screen">
    <div class="animate-spin rounded-full h-16 w-16 border-t-4 border-b-4 border-blue-500"></div>
  </div>

  <!-- Mostrar error si ocurre -->
  <div v-if="coursesStore.errorMessage" class="text-red-500 text-center">
    {{ coursesStore.errorMessage }}
  </div>

  <!-- Lista de cursos -->
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mt-6">
    <!-- Iteramos sobre la lista de cursos y mostramos un CourseCard para cada uno -->
    <CourseCard
      v-for="course in coursesStore.courses"
      :key="course.id"
      :course="course"
    />
  </div>
</template>
