<script setup lang="ts">
import { ref, onMounted } from 'vue';
import AssigmentCard from './AssigmentCard.vue';
import AssignmentService from '@/services/AssigmentService';
import type { Assignment } from '@/types/Assigment';
import { useUserStore } from '@/stores/userStore';
import SubmissionService from '@/services/SubmissionService';

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
const userStore = useUserStore();

// Función para obtener las asignaciones del curso usando el servicio
const fetchAssignments = async () => {
  try {
    isLoading.value = true;

    const user = userStore.getUser;
    const studentId = user.id;


   // assignments.value = await AssignmentService.getAssignmentsByCourse(props.courseId);
   const response =await AssignmentService.getAllByCourseForStudent(studentId, props.courseId);

    assignments.value = response.map(item => item.assignment);
    console.log(assignments.value);
  } catch (error) {
    console.error('Error fetching assignments:', error);
    errorMessage.value = 'Failed to load assignments';
  } finally {
    isLoading.value = false;
  }
};


// Method to verify submissions for all assignments
const verifySubmissionsForAllAssignments = async () => {
  const studentId = userStore.getUser?.id;

  // Iterate through all assignments and verify submission for each one
  for (const assignment of assignments.value) {
    try {
      const exists = await SubmissionService.verifySubmission(assignment.id, studentId);
      
      // Add a `submitted` property to the assignment based on the verification result
      assignment.submitted = exists.submissionExists;  // `submitted` is true if exists, false otherwise
    } catch (error) {
      console.error(`Error verifying submission for assignment: ${assignment.title}`, error);
      assignment.submitted = false; // Assume not submitted if there's an error
    }
  }

  // Log each assignment with the `submitted` status
  console.log('Updated Assignments:', assignments.value);
};

// Ejecutar la función cuando el componente se monte
onMounted(async () => {
  await fetchAssignments();
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
