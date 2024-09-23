<script setup lang="ts">
import DefaultLayout from '@/layouts/DefaultLayout.vue'
import CoursesList from '@/components/Teacher/Courses/CoursesList.vue' // Asegúrate de que la ruta sea correcta
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue'
import ButtonDefault from '@/components/Buttons/ButtonDefault.vue'
import { ref } from 'vue'
// Definimos una lista de cursos como ejemplo
const courseList = [
  {
    id: '1',
    name: 'Introduction to Programming',
    teacherId: '123'
  },
  {
    id: '2',
    name: 'Advanced Mathematics',
    teacherId: '456'
  },
  {
    id: '3',
    name: 'Data Structures',
    teacherId: '789'
  },
  {
    id: '4',
    name: 'Web Development',
    teacherId: '012'
  },
  {
    id: '5',
    name: 'Algorithms',
    teacherId: '345'
  }
]

const pageTitle = ref('Courses')
import ModalExample from '@/components/Modal/ModalExample.vue'
import ButtonEvent from '@/components/Buttons/ButtonEvent.vue'
import CreateCourseModal from '@/components/Teacher/Courses/CreateCourseModal.vue'
const isModalOpen = ref(false)

// Función para abrir el modal
const openModal = () => {
  isModalOpen.value = true
}

// Función para cerrar el modal
const handleModalClose = () => {
  isModalOpen.value = false
}
</script>

<template>
  <DefaultLayout>
    <BreadcrumbDefault :pageTitle="pageTitle" />

    <ButtonEvent label="Add Course" customClasses="bg-primary text-white" :onClick="openModal">
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

    <!-- Componente ModalExample con control del estado desde el padre -->
    <CreateCourseModal :modalOpen="isModalOpen" @close="handleModalClose" />
    <CoursesList :courses="courseList" />
  </DefaultLayout>
</template>
