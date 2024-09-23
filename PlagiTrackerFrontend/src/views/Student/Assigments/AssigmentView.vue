<script setup lang="ts">

import DefaultLayout from '@/layouts/DefaultLayout.vue'
import CoursesList from '@/components/Teacher/Courses/CoursesList.vue'; // Asegúrate de que la ruta sea correcta
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue';
import ButtonDefault from '@/components/Buttons/ButtonDefault.vue';
import SubmissionCard from '@/components/Student/Assigments/SubmissionCard.vue';
import { ref } from 'vue';

const pageTitle = ref('Courses')

</script>


<template>
  <DefaultLayout>


    
    <BreadcrumbDefault :pageTitle="pageTitle" />
    <SubmissionCard/>
  </DefaultLayout>
</template>
