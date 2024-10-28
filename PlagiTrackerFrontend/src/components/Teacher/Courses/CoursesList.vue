<script setup lang="ts">
import { onMounted } from 'vue';
import { useCoursesStore } from '@/stores/coursesStore'; // Import the courses store
import CourseCard from './CourseCard.vue'; // Make sure to import the CourseCard component

// Use the courses store
const coursesStore = useCoursesStore();

// Fetch courses function
const fetchCourses = async () => {
  await coursesStore.fetchCoursesByTeacher();
  console.log(coursesStore.courses);
};

// Call fetchCoursesByTeacher when the component is mounted
onMounted(() => {
  fetchCourses(); // Load courses when the component mounts
});
</script>

<template>
  <!-- Loading screen -->
  <div v-if="coursesStore.isLoading" class="flex items-center justify-center min-h-screen">
    <div class="animate-spin rounded-full h-16 w-16 border-t-4 border-b-4 border-blue-500"></div>
  </div>


  <!-- Show message if no courses are available -->
  <div v-if="!coursesStore.isLoading && coursesStore.courses.length === 0" class="text-gray-500 text-center mt-6">
    No courses available.
  </div>

  <!-- List of courses -->
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mt-6">
    <!-- Iterate over the list of courses and show a CourseCard for each one -->
    <CourseCard
      v-for="course in coursesStore.courses"
      :key="course.id"
      :course="course"
      @course-deleted="fetchCourses"
    />
  </div>
</template>
