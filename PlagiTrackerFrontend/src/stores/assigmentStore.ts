// src/stores/assignmentStore.ts
import { defineStore } from 'pinia';
import { ref } from 'vue';
import AssignmentService from '@/services/AssigmentService';
import type { Assignment } from '@/types/Assigment';

export const useAssignmentStore = defineStore('assignment', () => {
  // Estado reactivo
  const assignments = ref<Assignment[]>([]);
  const isLoading = ref(false);
  const errorMessage = ref('');

  // Función para obtener las asignaciones por curso
  const fetchAssignmentsByCourse = async (courseId: string) => {
    isLoading.value = true;
    errorMessage.value = ''; // Reiniciar el mensaje de error
    assignments.value = []; // Limpiar asignaciones antes de cargar nuevas
    await new Promise(resolve => setTimeout(resolve, 2000));

    try {
      assignments.value = await AssignmentService.getAssignmentsByCourse(courseId);
      console.log(assignments.value);
    } catch (error) {
      console.error('Error fetching assignments:', error);
      errorMessage.value = 'Failed to load assignments';
    } finally {
      isLoading.value = false;
    }
  };

  return {
    assignments,
    isLoading,
    errorMessage,
    fetchAssignmentsByCourse,
  };
});
