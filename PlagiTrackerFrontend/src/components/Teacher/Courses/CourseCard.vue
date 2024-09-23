<script setup lang="ts">
import type { Course } from '@/types/Courses'

// Importa el tipo Course desde tu archivo de tipos

// Define los props, donde `course` es un objeto que sigue la interfaz `Course`
const props = defineProps<{
  course: Course
}>()
</script>

<template>
  <!-- Usa router-link para hacer que toda la tarjeta sea clicable -->
  <router-link :to="`/teacher/assigments/${props.course.id}`" class="block">
    <div class="max-w-sm overflow-hidden border border-stroke shadow-lg bg-card text-card-foreground">
      <div class="bg-accent p-4">
        <h2 class="text-lg font-bold truncate" style="max-width: 100%;">
          {{ props.course.name }}
        </h2>
        <p class="text-sm text-muted-foreground">ING-VII</p>
        <p class="text-sm text-muted-foreground">Soporte Informático</p>
      </div>
      <div class="flex items-center bg-white justify-between p-4">
        <div
          class="w-10 h-10 rounded-full bg-purple-600 flex items-center justify-center text-white font-bold"
        >
          S
        </div>
        <div class="flex space-x-2">
          <!-- Botón dentro de la tarjeta -->
          <button aria-label="Files" @click.stop class="text-muted hover:text-muted-foreground">
            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 256 256">
              <path fill="#666666" d="M216 72h-84.69L104 44.69A15.86 15.86 0 0 0 92.69 40H40a16 16 0 0 0-16 16v144.62A15.4 15.4 0 0 0 39.38 216h177.51A15.13 15.13 0 0 0 232 200.89V88a16 16 0 0 0-16-16M40 56h52.69l16 16H40Zm176 144H40V88h176Z"/>
            </svg>
          </button>
        </div>
      </div>
    </div>
  </router-link>
  <!-- Card Item End -->
</template>
