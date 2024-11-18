<script setup lang="ts">
import type { Assignment } from '@/types/Assigment'
import { computed } from 'vue'
import { useRouter } from 'vue-router'

// Define una prop que recibe un objeto de tipo Assignment
const props = defineProps<{
  assignment: Assignment
}>()

const router = useRouter()

const navigateToTask = () => {
  router.push({ name: 'StudentSubmit', params: { id: props.assignment.id } }) // Navega usando el ID de la asignación
}

const isOverdue = computed(() => {
  const dueDate = new Date(props.assignment.submissionDate)
  return new Date() > dueDate
})
</script>

<template>
  <div
    :class="[
      'flex items-center p-4 shadow-md cursor-pointer',
      { 'bg-red': isOverdue, 'bg-white': !isOverdue }
    ]"
  >
    <!-- Icono -->
    <div class="flex-shrink-0">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 1024 1024">
        <path
          :fill="isOverdue ? 'white' : '#666666'"
          d="M832 384H576V128H192v768h640zm-26.496-64L640 154.496V320zM160 64h480l256 256v608a32 32 0 0 1-32 32H160a32 32 0 0 1-32-32V96a32 32 0 0 1 32-32m160 448h384v64H320zm0-192h160v64H320zm0 384h384v64H320z"
        />
      </svg>
    </div>

    <!-- Contenido de la notificación -->
    <div @click="navigateToTask" class="ml-4 flex-1">
      <!-- Título de la asignación -->
      <h3
        :class="{
          'text-gray': isOverdue,
          'text-zinc-800 dark:text-primary-foreground': !isOverdue
        }"
        class="text-lg font-semibold"
      >
        {{ assignment.title }}
      </h3>
      <!-- Fecha de entrega y última modificación -->
      <p :class="{ 'text-gray': isOverdue, 'text-muted-foreground': !isOverdue }" class="text-sm">
        <strong>Fecha de entrega:</strong>
        {{
          new Date(assignment.submissionDate).toLocaleString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: true
          })
        }}
      </p>
    </div>

    <!-- Conditionally render check icon if submitted is true -->
    <div class="flex-shrink-0">
      <p v-if="props.assignment.submitted" class="flex items-center text-green-600 font-semibold">
        <!-- Checkmark SVG -->
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          class="mr-2"
        >
          <path
            fill="currentColor"
            d="M4 21a1 1 0 0 0 .24 0l4-1a1 1 0 0 0 .47-.26L21 7.41a2 2 0 0 0 0-2.82L19.42 3a2 2 0 0 0-2.83 0L4.3 15.29a1.06 1.06 0 0 0-.27.47l-1 4A1 1 0 0 0 3.76 21A1 1 0 0 0 4 21M18 4.41L19.59 6L18 7.59L16.42 6zM5.91 16.51L15 7.41L16.59 9l-9.1 9.1l-2.11.52z"
          />
        </svg>

        <!-- Submission text -->
        Submission
      </p>

      <p v-else class="text-red font-semibold">URL not uploaded</p>
    </div>
  </div>
</template>

<style scoped>
/* Añadir cualquier estilo adicional si es necesario */
</style>
