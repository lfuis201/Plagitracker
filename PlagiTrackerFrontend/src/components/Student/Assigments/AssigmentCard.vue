<script setup lang="ts">
import type { Assignment } from '@/types/Assigment';
import { useRouter } from 'vue-router';

// Define una prop que recibe un objeto de tipo Assignment
const props = defineProps<{
  assignment: Assignment;
}>();

const router = useRouter();

const navigateToTask = () => {
  router.push({ name: 'StudentSubmit', params: { id: props.assignment.id } }); // Navega usando el ID de la asignación
};
</script>

<template>
  <div class="flex items-center p-4 border rounded-lg bg-white shadow-md dark:bg-card cursor-pointer">
    <!-- Icono -->
    <div class="flex-shrink-0">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 1024 1024">
        <path fill="#666666" d="M832 384H576V128H192v768h640zm-26.496-64L640 154.496V320zM160 64h480l256 256v608a32 32 0 0 1-32 32H160a32 32 0 0 1-32-32V96a32 32 0 0 1 32-32m160 448h384v64H320zm0-192h160v64H320zm0 384h384v64H320z"/>
      </svg>
    </div>
    
    <!-- Contenido de la notificación -->
    <div  @click="navigateToTask" class="ml-4 flex-1">
      <!-- Título de la asignación -->
      <h3 class="text-lg font-semibold text-zinc-800 dark:text-primary-foreground">
        {{ assignment.title }}
      </h3>
      <!-- Fecha de entrega y última modificación -->
      <p class="text-sm text-muted-foreground">
        {{ new Date(assignment.submissionDate).toLocaleDateString() }} 
        (Última modificación: {{ assignment.lastModified ? new Date(assignment.lastModified).toLocaleDateString() : 'N/A' }})
      </p>
    </div>
    
  </div>
</template>

<style scoped>
/* Añadir cualquier estilo adicional si es necesario */
</style>
