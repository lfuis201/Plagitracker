<script setup lang="ts">
import DefaultLayout from '@/layouts/DefaultLayout.vue';
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue';
import SubmissionList from '@/components/Teacher/Submissions/SubmissionList.vue';
import ButtonEvent from '@/components/Buttons/ButtonEvent.vue';
import { ref } from 'vue';
import { useRoute } from 'vue-router';
import AssignmentService from '@/services/AssigmentService'; // Importa el AssignmentService

const pageTitle = ref('Submissions');

// Obtener el id del curso desde la ruta
const route = useRoute();

const AssigmentId = route.params.id ; // Acceder al id de la ruta
console.log(AssigmentId)
// Función para realizar el análisis del curso
const analyzeCourse = async () => {
  try {
    // Llama a la función analyzeAssignment pasando el id del curso como parámetro
    console.log("analizyng...")

    console.log(AssigmentId)
    const result = await AssignmentService.analyzeAssignment(AssigmentId);
    // Si la respuesta es exitosa, muestra un mensaje de éxito
    alert('Analysis successful: ' + JSON.stringify(result)); 
  } catch (error) {
    // Si ocurre un error, muestra un mensaje de alerta
    console.error('Error during assignment analysis:', error);
    alert('Analysis failed. Please try again.');
  }
};
</script>

<template>
  <DefaultLayout>
    <!-- Breadcrumb para mostrar el título de la página -->
    <BreadcrumbDefault :pageTitle="pageTitle" />
      <!-- Botón de Análisis -->
      <div class="mb-4">
      <button
        class="bg-primary text-white py-2 px-4 rounded hover:bg-blue-700 transition duration-300"
        @click="analyzeCourse"
      >
        <span class="flex items-center">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="20"
            height="20"
            viewBox="0 0 24 24"
            class="mr-2"
          >
            <g fill="none" stroke="#ffffff" stroke-linecap="round" stroke-linejoin="round" stroke-width="2">
              <path
                d="M20 11a8.1 8.1 0 0 0-6.986-6.918A8.1 8.1 0 0 0 4.995 8M4 13a8.1 8.1 0 0 0 15 3"
              />
              <path d="M18 16a1 1 0 1 0 2 0a1 1 0 1 0-2 0M4 8a1 1 0 1 0 2 0a1 1 0 1 0-2 0m5 4a3 3 0 1 0 6 0a3 3 0 1 0-6 0" />
            </g>
          </svg>
          Analyze
        </span>
      </button>
    </div>
  

    <!-- Componente para la lista de entregas -->
    <SubmissionList />
  </DefaultLayout>
</template>

<style scoped>
/* Puedes agregar estilos específicos aquí si es necesario */
</style>
