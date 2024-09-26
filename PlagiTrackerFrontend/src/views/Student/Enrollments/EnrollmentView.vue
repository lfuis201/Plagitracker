<script setup lang="ts">
import DefaultLayout from '@/layouts/DefaultLayout.vue'
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue'
import CoursesList from '@/components/Student/Enrollement/CoursesList.vue';
import { ref } from 'vue';


const pageTitle = ref('Enrollement')

</script>

<template>
  <DefaultLayout>
    <BreadcrumbDefault :pageTitle="pageTitle" />

    <CoursesList/>
  </DefaultLayout>
</template>
