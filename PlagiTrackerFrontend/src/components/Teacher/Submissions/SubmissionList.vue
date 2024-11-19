<script setup lang="ts">
import SubmissionService from '@/services/SubmissionService'
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router' // Import useRoute
import DolosFrame from '../DolosFrame.vue';
// Use the useRoute to get route parameters
const route = useRoute()
const assignmentId = ref(route.params.id) // Assuming your route is set up to pass an 'id' parameter
const submissionsList = ref([]) // Cambiar a un array vacío para almacenar las entregas

const fetchSubmissions = async () => {
  if (!assignmentId.value) {
    console.error('No assignment ID provided')
    return
  }

  try {
    const submissions = await SubmissionService.getAllByAssignment(assignmentId.value)
    submissionsList.value = submissions
    console.log(submissions)
    console.log(submissionsList)
  } catch (error) {
    console.error('Failed to fetch submissions:', error)
  }
}

// Helper function to format date and time
const formatDateTime = (dateString: string) => {
  const date = new Date(dateString);
  return date.toLocaleString(); // This will return date with time, adjust if needed based on locale
};

onMounted(() => {
  fetchSubmissions() // Llamar a la función para obtener las envíos al montar el componente
})


</script>

<template>
  <div
    class="rounded-sm border border-stroke bg-white px-5 pt-6 pb-2.5 shadow-default dark:border-strokedark dark:bg-boxdark sm:px-7.5 xl:pb-1"
  >
    <div class="max-w-full overflow-x-auto">
      <table class="w-full table-auto">
        <thead>
          <tr class="bg-gray-2 text-left dark:bg-meta-4">

            <th class="min-w-[220px] py-4 px-4 font-medium text-black dark:text-white xl:pl-11">
              Student Name
            </th>


            <th class="min-w-[220px] py-4 px-4 font-medium text-black dark:text-white xl:pl-11">
              Student Email
            </th>

            <th class="min-w-[220px] py-4 px-4 font-medium text-black dark:text-white xl:pl-11">
              Url
            </th>

            <th class="min-w-[150px] py-4 px-4 font-medium text-black dark:text-white">
              Submission Date
            </th>
            
          </tr>
        </thead>
        <tbody>
          <tr v-if="submissionsList.length === 0">
            <td colspan="3" class="py-5 px-4 text-center text-gray-500">
              No submissions have been made.
            </td>
          </tr>
          <tr v-for="(item, index) in submissionsList" :key="index">

            <td class="py-5 px-4 pl-9 xl:pl-11">
              <h5 class="font-medium text-black dark:text-white">{{ item.studentFirstName }} {{ item.studentLastName }}</h5>
            </td>

            <td class="py-5 px-4 pl-9 xl:pl-11">
              <h5 class="font-medium text-black dark:text-white">{{ item.studentEmail }}</h5>
            </td>
            <td class="py-5 px-4">
              <a :href="item.url" target="_blank" class="text-primary underline">
                {{ item.url }}
              </a>
            </td>

            <td class="py-5 px-4">
              <p class="text-black dark:text-white">{{ formatDateTime(item.submissionDate) }}</p>
            </td>

          
           
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
