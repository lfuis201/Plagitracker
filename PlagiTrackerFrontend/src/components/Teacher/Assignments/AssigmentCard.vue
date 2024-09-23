<template>
  <div @click="navigateToTask" class="flex items-center p-4 border rounded-lg bg-white shadow-md dark:bg-card cursor-pointer">
    <!-- Icono -->
    <div class="flex-shrink-0 bg-blue-300 rounded-full p-2">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 1024 1024">
        <path fill="#666666" d="M832 384H576V128H192v768h640zm-26.496-64L640 154.496V320zM160 64h480l256 256v608a32 32 0 0 1-32 32H160a32 32 0 0 1-32-32V96a32 32 0 0 1 32-32m160 448h384v64H320zm0-192h160v64H320zm0 384h384v64H320z"/>
      </svg>
    </div>
    
    <!-- Contenido de la notificación -->
    <div class="ml-4 flex-1">
      <!-- Título de la notificación -->
      <h3 class="text-lg font-semibold text-zinc-800 dark:text-primary-foreground">
        Leydi Beatriz Manrique Tejada ha publicado una nueva tarea: Material Taller 2 : Analisis de Ries...
      </h3>
      <!-- Fecha -->
      <p class="text-sm text-muted-foreground">12 sept (Última modificación: 12 sept)</p>
    </div>

    <!-- Botón de opciones -->
    <div class="flex-shrink-0">
      <button class="text-zinc-500 hover:text-zinc-700 dark:hover:text-zinc-300">...</button>
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router';

const router = useRouter();

// Mock assignment ID, in a real-world scenario, this could be a prop or fetched data.
const assignmentId = '123'; // Replace with the actual ID

const navigateToTask = () => {
  router.push({ name: 'Submit', params: { id: assignmentId } });
};
</script>

<style scoped>
/* Añadir cualquier estilo adicional si es necesario */
</style>
