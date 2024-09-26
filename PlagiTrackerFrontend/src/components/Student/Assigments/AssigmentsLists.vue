<script setup lang="ts">
import { ref, onMounted } from 'vue';
import AssigmentCard from './AssigmentCard.vue';
import AssignmentService from '@/services/AssigmentService';
import type { Assignment } from '@/types/Assigment';

// Definir la prop para recibir el ID del curso
const props = defineProps({
  courseId: {
    type: String,
    required: true
  }
});

// Definir el estado para almacenar las asignaciones
const assignments = ref<Assignment[]>([]);
const isLoading = ref(false);
const errorMessage = ref('');

// Función para obtener las asignaciones del curso usando el servicio
const fetchAssignments = async () => {
  try {
    isLoading.value = true;
    assignments.value = await AssignmentService.getAssignmentsByCourse(props.courseId);
    console.log(assignments.value);
  } catch (error) {
    console.error('Error fetching assignments:', error);
    errorMessage.value = 'Failed to load assignments';
  } finally {
    isLoading.value = false;
  }
};

// Ejecutar la función cuando el componente se monte
onMounted(() => {
  fetchAssignments();
});
</script>

<template>
  <div class="grid grid-cols-1 gap-4 my-4">
    <!-- Mostrar un mensaje de carga mientras se obtienen los datos -->
    <div v-if="isLoading">Loading assignments...</div>

    <!-- Mostrar un mensaje de error si ocurre algún problema -->
    <div v-if="errorMessage">{{ errorMessage }}</div>

    <!-- Iteramos sobre la lista de asignaciones y mostramos una tarjeta para cada una -->
    <AssigmentCard
      v-for="(assignment, index) in assignments"
      :key="index"
      :assignment="assignment"
    />
  </div>
</template>

<style scoped>
/* Añadir estilos adicionales si es necesario */
</style>
