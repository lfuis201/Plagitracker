<script setup lang="ts">
import type { Course } from '@/types/Course'
import CourseService from '@/services/CourseService'
import Swal from 'sweetalert2' // Importa SweetAlert2

const props = defineProps<{
  course: Course
}>()

// Función para manejar la eliminación del curso
const handleDelete = async (courseId: string) => {
  const { isConfirmed } = await Swal.fire({
    title: 'Are you sure?',
    text: "You won't be able to revert this!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, delete it!',
    cancelButtonText: 'Cancel'
  })

  if (isConfirmed) {
    try {
      await CourseService.deleteCourse(courseId)
      Swal.fire('Deleted!', 'Your course has been deleted.', 'success')
      console.log('Course deleted:', courseId)
      // Opcional: redirige o actualiza la vista después de eliminar
    } catch (error) {
      console.error('Error deleting course:', error)
      Swal.fire('Error!', 'There was a problem deleting your course.', 'error')
    }
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
        <p class="text-sm text-muted-foreground">ING-VII</p>
        <p class="text-sm text-muted-foreground">Soporte Informático</p>
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
      </div>
    </div>
  </div>
  <!-- Card Item End -->
</template>
