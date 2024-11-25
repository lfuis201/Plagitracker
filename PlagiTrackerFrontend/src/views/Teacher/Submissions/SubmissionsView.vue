<script setup lang="ts">
import DefaultLayout from '@/layouts/DefaultLayout.vue'
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue'
import SubmissionList from '@/components/Teacher/Submissions/SubmissionList.vue'
import ItemNotFoundView from '@/views/ItemNotFoundView.vue'
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import AssignmentService from '@/services/AssigmentService' // Importa el AssignmentService
import Swal from 'sweetalert2' // Importa SweetAlert2
import DolosFrame from '@/components/Teacher/DolosFrame.vue'
import { useUserStore } from '@/stores/userStore'
import ShareLink from '@/components/Teacher/Submissions/ShareLink.vue'
const pageTitle = ref('Submissions')
const userStore = useUserStore()

// Obtener el id del curso desde la ruta
const route = useRoute()
const loading = ref(false) // Estado de carga para el botón

const showShareLink = ref(false)


const AssigmentId = route.params.id // Acceder al id de la ruta
const assignmentNotFound = ref<boolean>(false)
const dolosUrl = ref<string | null>(null)
const dolosFrameRef = ref({})
console.log(userStore.getUser.email)
// Función para realizar el análisis del curso

const scrollToDolosFrame = () => {
  const element = document.getElementById('dolos-frame-container')
  if (element) {
    element.scrollIntoView({ behavior: 'smooth', block: 'start' })
  }
}

// Función para abrir el modal
const openModal = () => {
  showShareLink.value = true
}

// Función para cerrar el modal
const handleModalClose = () => {
  showShareLink.value = false
}

const analyzeCourse = async () => {
  try {
    // Llama a la función analyzeAssignment pasando el id del curso como parámetro
    loading.value = true // Cambiar el estado de carga a true

    console.log('analizyng...')

    //console.log(AssigmentId)
    const result = await AssignmentService.analyzeWithDolos(AssigmentId, userStore.getUser.email)
    // Si la respuesta es exitosa, muestra un mensaje de éxito
    dolosUrl.value = result.data.htmL_URL
    console.log(dolosUrl.value)
    // Si la respuesta es exitosa, muestra un mensaje de éxito con SweetAlert2
    await Swal.fire({
      title: 'Analysis Complete',
      text: 'Your report is downloading now!',
      icon: 'success',
      confirmButtonText: 'Great'
    })

    scrollToDolosFrame()

  } catch (error) {
    // Si ocurre un error, muestra un mensaje de alerta
    console.error('Error during assignment analysis:', error)
    await Swal.fire({
      title: 'Error!',
      text: 'There was a problem analyzing your assignment. Please try again later.',
      icon: 'error',
      confirmButtonText: 'OK'
    })
    alert('Analysis failed. Please try again.')
  } finally {
    loading.value = false // Cambiar el estado de carga a false cuando se complete
  }
}
// Función para verificar si la tarea existe
const checkAssignmentExists = async (): Promise<boolean> => {
  try {
    // Llamar al servicio para obtener la tarea por ID
    const assignment = await AssignmentService.getAssignmentById(AssigmentId)
    console.log('Assignment exists:', assignment)
  } catch (error: any) {
    console.error('Error fetching assignment:', error)

    // Manejar el error 400 específicamente para el assignmentId inválido
    // Check if the error is a 400 Bad Request
    if (error.response && error.response.status === 400) {
      assignmentNotFound.value = true // Mark as not found
    }
  }
  return false // La tarea no existe o hubo un error
}

// Llamar a checkAssignmentExists al cargar el componente
onMounted(async () => {
  await checkAssignmentExists()
})
</script>

<template>
  <DefaultLayout>
    <!-- Breadcrumb para mostrar el título de la página -->
    <BreadcrumbDefault :pageTitle="pageTitle" />
    <!-- Botón de Análisis -->

    <ItemNotFoundView
      v-if="assignmentNotFound"
      title="The assignment does not exist."
      description="The assignment you are looking for was not found."
      buttonText="Go to Home"
      link="/teacher/courses"
    />

    <template v-else>
      <div class="mb-4">
        <button
          :disabled="loading"
          :class="loading ? 'bg-blue-300 cursor-not-allowed' : 'bg-primary'"
          class="text-white py-2 px-4 rounded hover:bg-blue-700 transition duration-300"
          @click="analyzeCourse"
        >
          <span class="flex items-center">
            <!-- Mostrar spinner si loading es true, de lo contrario mostrar el icono -->
            <svg
              v-if="!loading"
              xmlns="http://www.w3.org/2000/svg"
              width="20"
              height="20"
              viewBox="0 0 24 24"
              class="mr-2"
            >
              <g
                fill="none"
                stroke="#ffffff"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
              >
                <path
                  d="M20 11a8.1 8.1 0 0 0-6.986-6.918A8.1 8.1 0 0 0 4.995 8M4 13a8.1 8.1 0 0 0 15 3"
                />
                <path
                  d="M18 16a1 1 0 1 0 2 0a1 1 0 1 0-2 0M4 8a1 1 0 1 0 2 0a1 1 0 1 0-2 0m5 4a3 3 0 1 0 6 0a3 3 0 1 0-6 0"
                />
              </g>
            </svg>
            <svg
              v-if="loading"
              class="animate-spin h-5 w-5 mr-2 text-white"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
            >
              <circle
                class="opacity-25"
                cx="12"
                cy="12"
                r="10"
                stroke="currentColor"
                stroke-width="4"
              ></circle>
              <path
                class="opacity-75"
                fill="currentColor"
                d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"
              ></path>
            </svg>

            <!-- Cambiar el texto del botón según el estado de carga -->
            <span v-if="!loading">Analyze</span>
            <span v-else>This might take a few minutes</span>
          </span>
        </button>
      </div>

      <!-- Componente para la lista de entregas -->
      <SubmissionList />
    </template>

    <div id="dolos-frame-container" class="mt-4">
      <DolosFrame v-if="dolosUrl" :url="dolosUrl" />
    </div>

    <ShareLink :modalOpen="showShareLink" :course-id="AssigmentId" @close="handleModalClose"/>


  </DefaultLayout>
</template>

<style scoped>
/* Puedes agregar estilos específicos aquí si es necesario */
</style>
