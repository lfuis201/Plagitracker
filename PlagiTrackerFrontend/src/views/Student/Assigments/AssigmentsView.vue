<script setup lang="ts">
import DefaultLayout from '@/layouts/DefaultLayout.vue';
import BreadcrumbDefault from '@/components/Breadcrumbs/BreadcrumbDefault.vue';
import AssigmentsLists from '@/components/Student/Assigments/AssigmentsLists.vue';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import CourseService from '@/services/CourseService';

const pageTitle = ref('Courses');
const route = useRoute();
const courseId = route.params.id; // Acceder al id de la ruta

// Nuevas propiedades reactivas
const courseExists = ref(true);
const errorMessage = ref('');


// Función para cargar el curso
const loadCourse = async () => {
  try {
    await CourseService.getCourseById(courseId);
  } catch (error: any) {
    // Comprobar si el error tiene respuesta y un código de estado
    if (error.response && error.response.status === 400) {
      console.error('Bad Request - Course not found:', error);
      courseExists.value = false; // Cambia a false si el curso no se encuentra
      errorMessage.value = 'The course you are looking for was not found.'; // Mensaje de error
    } else {
      console.error('An error occurred while fetching the course:', error);
      courseExists.value = false; // Cambia a false para cualquier otro error
      errorMessage.value = 'An unexpected error occurred. Please try again later.'; // Mensaje de error general
    }
  }
};

// Cargar el curso al montar el componente
onMounted(() => {
  loadCourse();
});
</script>

<template>
  <DefaultLayout>
    <BreadcrumbDefault :pageTitle="pageTitle" />

    <!-- Mostrar mensaje si el curso no existe -->
    <div v-if="!courseExists" class="flex flex-col justify-center items-center w-full bg-gray-50 inset-0 z-10 p-4 sm:p-8 md:p-12 lg:p-16">
      <h3 class="font-semibold text-red-600 text-2xl">{{ errorMessage }}</h3>
      <router-link to="/student/courses" class="mt-4">
        <button class="bg-blue-500 text-white hover:bg-blue-600 px-6 py-3 rounded-md transition duration-200 ease-in-out transform hover:scale-105">
          Go to Home
        </button>
      </router-link>
    </div>

    <!-- Mostrar la lista de asignaciones si el curso existe -->
    <div v-if="courseExists">
      <AssigmentsLists :courseId="courseId" />
    </div>
  </DefaultLayout>
</template>
