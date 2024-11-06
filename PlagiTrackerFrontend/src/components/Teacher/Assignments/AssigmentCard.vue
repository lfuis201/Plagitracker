<script setup lang="ts">
import type { Assignment } from '@/types/Assigment'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import EditAssigment from './EditAssigment .vue'
import { useAssignmentStore } from '@/stores/assigmentStore'
import AssignmentService from '@/services/AssigmentService'
import Swal from 'sweetalert2' // Importa SweetAlert2

// Define una prop que recibe un objeto de tipo Assignment
const props = defineProps<{
  assignment: Assignment
}>()

// Inicializa el store
const assignmentStore = useAssignmentStore()

const router = useRouter()

const isEditing = ref(false) // Estado para controlar la visibilidad del modal

const deleteAssignment = async () => {
  const result = await Swal.fire({
    title: 'Are you sure?',
    text: "You won't be able to revert this!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, delete it!',
    cancelButtonText: 'No, cancel'
  })

  if (result.isConfirmed) {
    try {
      // Delete the assignment using the service
      await AssignmentService.deleteAssignment(props.assignment.id)

      // Reload the assignments from the store
      await assignmentStore.fetchAssignmentsByCourse(props.assignment.courseId)

      console.log('Assignment deleted successfully')

      // Show success message
      await Swal.fire('Deleted!', 'The assignment has been deleted.', 'success')
    } catch (error) {
      console.error('Error deleting the assignment:', error)
      await Swal.fire('Oops!', 'Something went wrong while deleting the assignment.', 'error')
    }
  }
}

const editAssignment = () => {
  isEditing.value = true // Abre el modal de edición
}

const navigateToTask = () => {
  router.push({ name: 'teacherSubmissions', params: { id: props.assignment.id } }) // Navega usando el ID de la asignación
}
</script>

<template>
  <div class="flex items-center p-4 bg-white shadow-md dark:bg-card cursor-pointer">
    <!-- Icono -->
    <div class="flex-shrink-0">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 1024 1024">
        <path
          fill="#666666"
          d="M832 384H576V128H192v768h640zm-26.496-64L640 154.496V320zM160 64h480l256 256v608a32 32 0 0 1-32 32H160a32 32 0 0 1-32-32V96a32 32 0 0 1 32-32m160 448h384v64H320zm0-192h160v64H320zm0 384h384v64H320z"
        />
      </svg>
    </div>

    <!-- Contenido de la notificación -->
    <div @click="navigateToTask" class="ml-4 flex-1">
      <!-- Título de la asignación -->
      <h3 class="text-lg font-semibold text-zinc-800 dark:text-primary-foreground">
        {{ assignment.title }}
      </h3>
      <!-- Fecha de entrega y última modificación -->
      <p class="text-sm text-muted-foreground">
        <strong>Fecha de entrega:</strong>
        {{
          new Date(assignment.submissionDate).toLocaleString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            hour12: true,
            timeZone: 'UTC'
          })
        }}
      </p>
    </div>

    <!-- Botones de eliminar y editar -->
    <div class="flex items-center space-x-2">
      <!-- Botón de borrar -->
      <button
        aria-label="Delete Assignment"
        @click="deleteAssignment"
        class="text-muted hover:text-red transition-colors duration-200"
      >
        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24">
          <path
            fill="none"
            stroke="currentColor"
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M4 7h16m-10 4v6m4-6v6M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2l1-12M9 7V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v3"
          />
        </svg>
      </button>

      <!-- Botón de editar -->
      <button
        @click="editAssignment"
        aria-label="Edit Assignment"
        class="text-muted hover:text-blue-500 transition-colors duration-200"
      >
        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24">
          <path
            fill="currentColor"
            d="M15.748 2.947a2 2 0 0 1 2.828 0l2.475 2.475a2 2 0 0 1 0 2.829L9.158 20.144l-6.38 1.076l1.077-6.38zm-.229 3.057l2.475 2.475l1.643-1.643l-2.475-2.474zm1.06 3.89l-2.474-2.475l-8.384 8.384l-.503 2.977l2.977-.502z"
          />
        </svg>
      </button>
    </div>

    <EditAssigment :modalOpen="isEditing" :assignment="assignment" @close="isEditing = false" />
  </div>
</template>

<style scoped>
/* Añadir cualquier estilo adicional si es necesario */
</style>
