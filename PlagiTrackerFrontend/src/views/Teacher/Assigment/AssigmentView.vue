<script setup lang="ts">

import DefaultLayout from '@/layouts/DefaultLayout.vue'
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue';
import AssigmentsLists from '@/components/Teacher/Assignments/AssigmentsLists.vue';
import ButtonEvent from '@/components/Buttons/ButtonEvent.vue';
import CreateAssigment from '@/components/Teacher/Assignments/CreateAssigment.vue';
import { ref } from 'vue';
import { useRoute } from 'vue-router';


const pageTitle = ref('Assigments')
const isModalOpen = ref(false)
// Obtener el id del curso desde la ruta
const route = useRoute();
const courseId = route.params.id; // Acceder al id de la ruta

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
    <ButtonEvent label="Add Assignments" customClasses="bg-primary text-white" :onClick="openModal">
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

    <CreateAssigment :modalOpen="isModalOpen" @close="handleModalClose" :courseId="courseId"/>


    <AssigmentsLists :courseId="courseId"/>

  </DefaultLayout>
</template>
