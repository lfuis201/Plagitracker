<script setup lang="ts">
import DefaultLayout from '@/layouts/DefaultLayout.vue'
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue'
import AssigmentsLists from '@/components/Teacher/Assignments/AssigmentsLists.vue'
import ButtonEvent from '@/components/Buttons/ButtonEvent.vue'
import CreateAssigment from '@/components/Teacher/Assignments/CreateAssigment.vue'
import ItemNotFoundView from '@/views/ItemNotFoundView.vue'

import { onMounted, ref } from 'vue'
import { useRoute } from 'vue-router'
import CourseService from '@/services/CourseService'

const pageTitle = ref('Assignments')
const isModalOpen = ref(false)
// Obtener el id del curso desde la ruta
const route = useRoute()
const courseId = route.params.id // Acceder al id de la ruta

// Nuevas propiedades reactivas
const courseExists = ref(false)
const courseTitle = ref('')
const loadCourse = async () => {
  try {
    const course = await CourseService.getCourseById(courseId)
    courseTitle.value = course.name
  } catch (error: any) {
    // Comprobar si el error tiene respuesta y un código de estado
    if (error.response && error.response.status === 400) {
      console.error('Bad Request - Course not found:', error)
      courseExists.value = true // Cambia a false si el curso no se encuentra
    } else {
      console.error('An error occurred while fetching the course:', error)
      courseExists.value = true // Cambia a false para cualquier otro error
    }
  }
}

// Función para abrir el modal
const openModal = () => {
  isModalOpen.value = true
}

// Función para cerrar el modal
const handleModalClose = () => {
  isModalOpen.value = false
}

// Cargar el curso al montar el componente
onMounted(() => {
  loadCourse()
})
</script>

<template>
  <DefaultLayout>
    <BreadcrumbDefault :pageTitle="`${pageTitle} - ${courseTitle}`" /> <!-- Use template literals to combine titles -->

    <!-- Show this error view when the course does not exist -->
    <ItemNotFoundView
      v-if="courseExists"
      title="The course does not exist."
      description="The course you are looking for was not found."
      buttonText="Go to Home"
      link="/teacher/courses"
    />

    <div v-else>
      <ButtonEvent
        label="Add Assignments"
        customClasses="bg-primary text-white"
        :onClick="openModal"
      >
        <span>
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
            <g fill="#ffffff" fill-rule="evenodd" clip-rule="evenodd">
              <path
                d="M2 12C2 6.477 6.477 2 12 2s10 4.477 10 10s-4.477 10-10 10S2 17.523 2 12m10-8a8 8 0 1 0 0 16a8 8 0 0 0 0-16"
              />
              <path
                d="M13 7a1 1 0 1 0-2 0v4H7a1 1 0 1 0 0 2h4v4a1 1 0 1 0 2 0v-4h4a1 1 0 1 0 0-2h-4z"
              />
            </g>
          </svg>
        </span>
      </ButtonEvent>

      <CreateAssigment :modalOpen="isModalOpen" @close="handleModalClose" :courseId="courseId" />

      <AssigmentsLists :courseId="courseId" />
    </div>
  </DefaultLayout>
</template>
