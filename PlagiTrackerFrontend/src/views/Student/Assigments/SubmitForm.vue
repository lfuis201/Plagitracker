<script setup lang="ts">

import DefaultLayout from '@/layouts/DefaultLayout.vue'
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue';
import SubmissionCard from '@/components/Student/Assigments/SubmissionCard.vue';
import { ref } from 'vue';

const pageTitle = ref('Submit Assignment')


</script>


<template>
  <DefaultLayout>


    
    <BreadcrumbDefault :pageTitle="pageTitle" />
    <SubmissionCard/>
  </DefaultLayout>
</template>
