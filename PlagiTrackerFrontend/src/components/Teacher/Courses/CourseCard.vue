<script setup lang="ts">
import type { Course } from '@/types/Course'
import CourseService from '@/services/CourseService'
import { useCoursesStore } from '@/stores/coursesStore'
import EditCourseModal from './EditCourseModal.vue'

import Swal from 'sweetalert2'
import { ref } from 'vue'

const props = defineProps<{
  course: Course
}>()

// Define emits for the component
const emit = defineEmits<{
  (event: 'course-deleted'): void; // Define an event for course deletion
}>();

const modalOpen = ref(false) // State to control modal visibility

const coursesStore = useCoursesStore()
// Function to open the modal
const openModal = () => {
  modalOpen.value = true
}

// Function to close the modal
const closeModal = () => {
  modalOpen.value = false
}

// Función para manejar la eliminación del curso
const handleDelete = async (courseId: string) => {
  const { isConfirmed } = await Swal.fire({
    title: 'Are you sure?',
    text: "You won't be able to revert this once archived!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, archive it!',
    cancelButtonText: 'Cancel'
  })

  if (isConfirmed) {
    try {
      await CourseService.deleteCourse(courseId)
      Swal.fire('Archived!', 'Your course has been archived', 'success')
      console.log('Course deleted:', courseId)
      await coursesStore.fetchCoursesByTeacher()
      emit('course-deleted'); // Emit the event to notify the parent component
      // Opcional: redirige o actualiza la vista después de eliminar
    } catch (error) {
      console.error('Error deleting course:', error)
      Swal.fire('Error!', 'There was a problem archiving your course.', 'error')
    }
  }
}

const copyLinkToClipboard = async (courseId: string) => {
  try {
    await navigator.clipboard.writeText(courseId)
    Swal.fire('Copied!', 'The course code has been copied to your clipboard.', 'success')
  } catch (error) {
    console.error('Error copying link:', error)
    Swal.fire('Error!', 'Failed to copy the link. Please try again.', 'error')
  }
}
</script>

<template>
  <!-- Usa router-link para hacer que toda la tarjeta sea clicable -->
  <div class="max-w-sm overflow-hidden border border-stroke shadow-lg bg-card text-card-foreground">
    <router-link :to="`/teacher/assigments/${props.course.id}`" class="block">
      <div class="bg-accent p-4">
        <h2 class="text-lg font-bold truncate" style="max-width: 100%">
          {{ props.course.name }}
        </h2>
        <p class="text-sm text-muted-foreground">{{ props.course.id }}</p>
      </div>
    </router-link>

    <div class="flex items-center bg-white justify-between p-4">
      <div
        class="w-10 h-10 rounded-full bg-purple-600 flex items-center justify-center text-white font-bold"
      >
        S
      </div>
      <div class="flex space-x-2">
        <!-- Botón de borrar -->
        <button
          @click="handleDelete(props.course.id)"
          aria-label="Files"
          @click.stop
          class="text-muted hover:text-red transition-colors duration-200"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24">
            <path
              fill="none"
              stroke="currentColor"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M4 7h16m-10 4v6m4-6v6M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2l1-12M9 7V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v3"
            />
          </svg>
        </button>

        <!-- Botón de Editar -->
        <button
          @click="openModal"
          aria-label="Edit Course"
          class="text-muted hover:text-blue-500 transition-colors duration-200"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M15.748 2.947a2 2 0 0 1 2.828 0l2.475 2.475a2 2 0 0 1 0 2.829L9.158 20.144l-6.38 1.076l1.077-6.38zm-.229 3.057l2.475 2.475l1.643-1.643l-2.475-2.474zm1.06 3.89l-2.474-2.475l-8.384 8.384l-.503 2.977l2.977-.502z"
            />
          </svg>
        </button>

        <button
          @click="copyLinkToClipboard(props.course.id)"
          aria-label="Share Course Link"
          class="text-muted hover:text-green-500 transition-colors duration-200"
        >
          <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 32 32">
            <path
              fill="currentColor"
              d="M23 20a5 5 0 0 0-3.89 1.89l-7.31-4.57a4.46 4.46 0 0 0 0-2.64l7.31-4.57A5 5 0 1 0 18 7a4.8 4.8 0 0 0 .2 1.32l-7.31 4.57a5 5 0 1 0 0 6.22l7.31 4.57A4.8 4.8 0 0 0 18 25a5 5 0 1 0 5-5m0-16a3 3 0 1 1-3 3a3 3 0 0 1 3-3M7 19a3 3 0 1 1 3-3a3 3 0 0 1-3 3m16 9a3 3 0 1 1 3-3a3 3 0 0 1-3 3"
            />
          </svg>
        </button>
      </div>
    </div>

    <EditCourseModal :modalOpen="modalOpen" :course="props.course" @close="closeModal" />
  </div>

  <!-- Card Item End -->
</template>
