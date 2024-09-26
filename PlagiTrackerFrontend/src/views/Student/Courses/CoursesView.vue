<script setup lang="ts">
import DefaultLayout from '@/layouts/DefaultLayout.vue'
import CoursesList from '@/components/Student/Courses/CoursesList.vue' // Asegúrate de que la ruta sea correcta
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue'
import { ref } from 'vue';


const pageTitle = ref('Courses')

</script>

<template>
  <DefaultLayout>
    <BreadcrumbDefault :pageTitle="pageTitle" />

    <CoursesList/>
  </DefaultLayout>
</template>
