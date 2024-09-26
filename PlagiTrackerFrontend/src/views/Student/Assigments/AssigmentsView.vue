<script setup lang="ts">

import DefaultLayout from '@/layouts/DefaultLayout.vue'
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue';
import AssigmentsLists from '@/components/Student/Assigments/AssigmentsLists.vue';
import { ref } from 'vue';
import { useRoute } from 'vue-router';

const pageTitle = ref('Courses')
const route = useRoute();
const courseId = route.params.id; // Acceder al id de la ruta

</script>


<template>
  <DefaultLayout>


    
    <BreadcrumbDefault :pageTitle="pageTitle" />
    <AssigmentsLists :courseId="courseId"/>
  </DefaultLayout>
</template>
