<script setup lang="ts">
// Importamos el tipo Course desde el archivo de tipos
import type { Course } from '@/types/Courses';

// Importamos el componente CourseCard que creamos previamente
import CourseCard from './CourseCard.vue';
// Definimos las props, donde `courses` es una lista de objetos de tipo Course
const props = defineProps<{
  courses: Course[]; // Un array de Course
}>();
</script>

<template>
  <!-- Grid para mostrar múltiples CourseCard -->
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mt-6">
    <!-- Iteramos sobre la lista de cursos y mostramos un CourseCard para cada uno -->
    <CourseCard
      v-for="course in props.courses"
      :key="course.id"
      :course="course"
    />
  </div>
</template>
