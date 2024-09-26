<script setup lang="ts">
import EnrollmentService from '@/services/EnrollmentService';
import { useUserStore } from '@/stores/userStore';
import type { Course } from '@/types/Course'

const props = defineProps<{
  course: Course
}>()
const userStore = useUserStore();

const enrollInCourse = async () => {
  try {
    const studentId = userStore.getUser?.id; // Obtener el ID del estudiante desde el store de usuario
    if (!studentId) {
      throw new Error('El usuario no está autenticado.');
    }

    // Llamar al servicio de inscripción
    const response = await EnrollmentService.createEnrollment(props.course.id, studentId);
    console.log('Inscripción exitosa:', response);
    alert('Te has inscrito exitosamente al curso.');
  } catch (error) {
    console.error('Error al inscribirse:', error);
    alert('Ocurrió un error al intentar inscribirte.');
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
        @click="enrollInCourse"

          @click.stop
          class="text-muted hover:text-blue-600 transition-colors duration-200 flex items-center justify-center space-x-2"
          >
        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 256 256"><path fill="currentColor" d="M256 136a8 8 0 0 1-8 8h-16v16a8 8 0 0 1-16 0v-16h-16a8 8 0 0 1 0-16h16v-16a8 8 0 0 1 16 0v16h16a8 8 0 0 1 8 8m-57.87 58.85a8 8 0 0 1-12.26 10.3C165.75 181.19 138.09 168 108 168s-57.75 13.19-77.87 37.15a8 8 0 0 1-12.25-10.3c14.94-17.78 33.52-30.41 54.17-37.17a68 68 0 1 1 71.9 0c20.65 6.76 39.23 19.39 54.18 37.17M108 152a52 52 0 1 0-52-52a52.06 52.06 0 0 0 52 52"/></svg>
        
        <span>Enroll</span>

      </button>
        
      </div>
    </div>
  </div>
  <!-- Card Item End -->
</template>
