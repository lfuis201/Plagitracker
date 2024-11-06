<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useUserStore } from '@/stores/userStore';
import CourseCard from './CourseCard.vue';
import CourseService from '@/services/CourseService';
import type { Course } from '@/types/Course';

// Estado reactivo para almacenar los cursos
const courses = ref<Course[]>([]); 

// Obtener el store del usuario
const userStore = useUserStore();

// Método para obtener los cursos del profesor
const fetchCourses = async () => {
  const user = userStore.getUser; // Obtener el usuario desde el store

  // Verifica que el usuario esté autenticado y tenga un ID
  if (user && user.id) {
    try {
      const response= await CourseService.getCoursesByStudent(user.id); 
      courses.value = response; // Llama al servicio para obtener cursos
      courses.value = response.map(item => item.course);  
    } catch (error) {
      console.error('Error fetching courses:', error);
    }

    console.log(courses)
  } else {
    console.error('User not authenticated or ID not available.');
  }
};

// Llama a fetchCourses al montar el componente
onMounted(() => {
  fetchCourses();
});
</script>

<template>
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mt-6">
    <!-- Iteramos sobre la lista de cursos y mostramos un CourseCard para cada uno -->
    <CourseCard
      v-for="course in courses"
      :key="course.id"
      :course="course"
    />
  </div>
</template>
