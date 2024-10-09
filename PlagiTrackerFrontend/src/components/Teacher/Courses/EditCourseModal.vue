<template>
    <div>
      <!-- ModalLayout that emits the 'close' event -->
      <ModalLayout :modalOpen="modalOpen" @close="handleClose">
        <template #default>
          <h3 class="pb-2 text-xl font-bold text-black dark:text-white sm:text-2xl">Edit Course</h3>
          <form @submit.prevent="handleSubmit">
            <!-- Course Name -->
            <div>
              <label for="courseName" class="block mb-2">Course Name</label>
              <input
                type="text"
                id="courseName"
                v-model="course.name"
                class="border rounded w-full px-3 py-2"
                required
              />
            </div>
  
            <!-- Course Description (optional) -->
            <div class="mt-4">
              <label for="courseDescription" class="block mb-2">Course Description</label>
              <textarea
                id="courseDescription"
                v-model="course.description"
                class="border rounded w-full px-3 py-2"
                rows="4"
              />
            </div>
  
            <!-- Course Teacher ID (hidden field for reference) -->
            <input type="hidden" v-model="course.teacherId" />
  
            <button
              type="submit"
              class="mt-4 block w-full rounded bg-blue-500 p-3 text-white hover:bg-blue-600"
            >
              Update Course
            </button>
          </form>
        </template>
      </ModalLayout>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, watch } from 'vue';
  import ModalLayout from '@/layouts/ModalLayout.vue';
  import type { Course } from '@/types/Course'; // Ensure Course type is defined
  import CourseService from '@/services/CourseService'; // Import CourseService
  
  // Define the properties the component receives from the parent
  const props = defineProps<{
    modalOpen: boolean; // This prop controls whether the modal is open
    course: Course; // The course object to edit
  }>();
  
  // Define the events the component can emit
  const emit = defineEmits(['close']);
  
  // State for the course, initialized with the received prop
  const course = ref<Course>({ ...props.course }); 
  
  // Watch for changes in props.course to update local state
  watch(() => props.course, (newCourse) => {
    course.value = { ...newCourse }; // Update local state when props change
  });
  
  // Function to close the modal and emit the 'close' event
  const handleClose = () => {
    emit('close');
  };
  
  // Function to handle form submission
  const handleSubmit = async () => {
    try {
      // Update the course using the service
      const updatedCourse = await CourseService.updateCourse(course.value);
      console.log('Course Updated:', updatedCourse);
      
      // Additional actions can be performed after updating, if necessary
  
      handleClose(); // Close the modal after updating the course
    } catch (error) {
      console.error('Error updating course:', error);
    }
  };
  </script>
  
  <style scoped>
  /* Optional additional styles */
  </style>
  