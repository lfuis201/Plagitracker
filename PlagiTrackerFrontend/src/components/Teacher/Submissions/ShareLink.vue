<template>
  <!-- ModalLayout that emits the 'close' event -->
  <ModalLayout :modalOpen="modalOpen" @close="handleClose" :disableClose="isSubmitting">
    <template #default>
      <h3 class="pb-2 text-xl font-bold text-black dark:text-white sm:text-2xl">
        Share Report
      </h3>
      <form @submit.prevent="handleSubmit">
    

        <!-- Email Input for sharing URL -->
        <div class="mt-4">
          <label for="email" class="block mb-2">Email Address</label>
          <input
            type="email"
            id="email"
            v-model="email"
            class="border rounded w-full px-3 py-2"
            required
            placeholder="Enter email to share the report"
          />
        </div>

        <button
          type="submit"
          :disabled="isSubmitting"
          :class="[ 'mt-4 block w-full rounded p-3 text-white', isSubmitting ? 'bg-blue-300 cursor-not-allowed' : 'bg-blue-500 hover:bg-blue-600' ]"
        >
          {{ isSubmitting ? 'Analyzing...' : 'Share' }}
        </button>
      </form>
    </template>
  </ModalLayout>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import ModalLayout from '@/layouts/ModalLayout.vue'
import Swal from 'sweetalert2'
import AssignmentService from '@/services/AssigmentService'
import { useAssignmentStore } from '@/stores/assigmentStore'

const props = defineProps({
  modalOpen: Boolean,
  courseId: String
})

const emit = defineEmits(['close'])

const isSubmitting = ref(false)
const email = ref('') // New reactive variable for the email
const assignment = ref({
  title: ''
})

const handleSubmit = async () => {
  if (!email.value) {
    alert('Please enter a valid email address.');
    return;
  }

  await analyzeCourse(email.value)
}

// Function to analyze the assignment and share URL
const analyzeCourse = async (email: string) => {
  try {
    isSubmitting.value = true
    console.log('Analyzing...')

    // Replace with the correct call to analyze the assignment
    const result = await AssignmentService.analyzeWithDolos(props.courseId, email)

    const dolosUrl = result.data.htmL_URL
    console.log(dolosUrl)

    handleClose()
    // Show success message
    await Swal.fire({
      title: 'Analysis Complete',
      text: 'Your report is downloading now!',
      icon: 'success',
      confirmButtonText: 'Great'
    })

    // Optionally: you can send the URL to the provided email here

  } catch (error) {
    console.error('Error during assignment analysis:', error)
    await Swal.fire({
      title: 'Error!',
      text: 'There was a problem analyzing your assignment. Please try again later.',
      icon: 'error',
      confirmButtonText: 'OK'
    })
   // alert('Analysis failed. Please try again.')
  } finally {
    isSubmitting.value = false
  }
}

const handleClose = () => {
  emit('close')
}

</script>

<style scoped>
/* Additional optional styling */
</style>
