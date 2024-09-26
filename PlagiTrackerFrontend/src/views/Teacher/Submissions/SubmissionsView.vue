<script setup lang="ts">

import DefaultLayout from '@/layouts/DefaultLayout.vue'
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue';
import SubmissionList from '@/components/Teacher/Submissions/SubmissionList.vue';
import { ref } from 'vue';
import { useRoute } from 'vue-router';


const pageTitle = ref('Submissions')
const isModalOpen = ref(false)
// Obtener el id del curso desde la ruta
const route = useRoute();
const courseId = route.params.id; // Acceder al id de la ruta

</script>


<template>
  <DefaultLayout>


    
    <BreadcrumbDefault :pageTitle="pageTitle" />
    <SubmissionList/>

  </DefaultLayout>
</template>
