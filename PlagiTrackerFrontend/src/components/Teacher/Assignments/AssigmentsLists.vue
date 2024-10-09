<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import AssigmentCard from './AssigmentCard.vue';
import { useAssignmentStore } from '@/stores/assigmentStore';

// Definir la prop para recibir el ID del curso
const props = defineProps({
  courseId: {
    type: String,
    required: true
  }
});

// Obtener el store de asignaciones
const assignmentStore = useAssignmentStore();

// Función para obtener las asignaciones del curso usando el store
const fetchAssignments = async () => {
  console.log(`Fetching assignments for course: ${props.courseId}`);
  await assignmentStore.fetchAssignmentsByCourse(props.courseId);
};

// Ejecutar la función cuando el componente se monte
onMounted(() => {
  fetchAssignments();
});

// Observar cambios en courseId y volver a cargar las asignaciones si cambia
watch(() => props.courseId, (newCourseId) => {
  console.log(`Course changed to: ${newCourseId}`);
  fetchAssignments(); // Cargar las nuevas asignaciones si el curso cambia
});
</script>

<template>
  <div class="grid grid-cols-1 gap-4 my-4">
    <div v-if="assignmentStore.isLoading">Loading assignments...</div>
    <div v-if="assignmentStore.errorMessage">{{ assignmentStore.errorMessage }}</div>
    <AssigmentCard
      v-for="(assignment, index) in assignmentStore.assignments"
      :key="assignment.id"
      :assignment="assignment"
    />
  </div>
</template>

<style scoped>
/* Añadir estilos adicionales si es necesario */
</style>
