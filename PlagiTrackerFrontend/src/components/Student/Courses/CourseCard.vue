<script setup lang="ts">
import type { Course } from '@/types/Course'
import Swal from 'sweetalert2' // Importa SweetAlert2
import EnrollmentService from '@/services/EnrollmentService';
import { useUserStore } from '@/stores/userStore';

const userStore = useUserStore();

const user = userStore.getUser; // Obtener el usuario desde el store

const props = defineProps<{
  course: Course
}>()

// Función para manejar la eliminación del curso
const handleDelete = async (courseId: string, studentId: string) => {
  const { isConfirmed } = await Swal.fire({
    title: 'Are you sure?',
    text: "You won't be able to recover this enrollment!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, delete it!',
    cancelButtonText: 'Cancel'
  });


  if (isConfirmed) {
    try {
      await EnrollmentService.deleteEnrollment(courseId, studentId)
      Swal.fire('Deleted!', 'Your enrollment has been deleted.', 'success');
      console.log('Course deleted:', courseId)
      // Opcional: redirige o actualiza la vista después de eliminar
    } catch (error) {
      console.error('Error deleting course:', error)
      Swal.fire('Error!', 'There was a problem deleting your enrollment.', 'error');
    }
  }
}
</script>

<template>
  <!-- Usa router-link para hacer que toda la tarjeta sea clicable -->
  <div class="max-w-sm overflow-hidden border border-stroke shadow-lg bg-card text-card-foreground">
    <router-link :to="`/student/assigments/${props.course.id}`" class="block">
      <div class="bg-accent p-4">
        <h2 class="text-lg font-bold truncate" style="max-width: 100%">
          {{ props.course.name }}
        </h2>
        <p class="text-sm text-muted-foreground">PlagiTracker</p>
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
        @click="handleDelete(props.course.id, user.id)"
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

      
    </div>

    </div>

   
  </div>
  <!-- Card Item End -->
</template>
