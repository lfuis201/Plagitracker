<template>
  <div>
    <!-- ModalLayout that emits the 'close' event -->
    <ModalLayout :modalOpen="modalOpen" @close="handleClose" :disableClose="isSubmitting">
      <template #default>
        <h3 class="pb-2 text-xl font-bold text-black dark:text-white sm:text-2xl">Update Course</h3>
        <form @submit.prevent="handleSubmit">
          <div>
            <label for="courseName" class="block mb-2">Course Name</label>
            <input
              type="text"
              id="courseName"
              v-model="course.name"
              class="border rounded w-full px-3 py-2"
              required
            />
          </div>

          <button
            :disabled="isSubmitting"
            :class="[
              'mt-4 block w-full rounded p-3 text-white',
              isSubmitting ? 'bg-blue-300 cursor-not-allowed' : 'bg-blue-500 hover:bg-blue-600'
            ]"
          >
            {{ isSubmitting ? 'Updating...' : 'Update Course' }}
          </button>
        </form>
      </template>
    </ModalLayout>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'
import ModalLayout from '@/layouts/ModalLayout.vue'
import type { Course } from '@/types/Course' // Ensure Course type is defined
import CourseService from '@/services/CourseService' // Import CourseService
import { useCoursesStore } from '@/stores/coursesStore'
import Swal from 'sweetalert2'

// Define the properties the component receives from the parent
const props = defineProps<{
  modalOpen: boolean // This prop controls whether the modal is open
  course: Course // The course object to edit
}>()

const coursesStore = useCoursesStore()

// Define the events the component can emit
const emit = defineEmits(['close'])

// State for the course, initialized with the received prop
const course = ref<Course>({ ...props.course })
const messageError = ref<string | null>(null) // Error message ref

const isSubmitting = ref(false)

// Watch for changes in props.course and update the course ref
watch(
  () => props.course,
  (newCourse) => {
    if (newCourse) {
      course.value = { ...newCourse } // Only update if props change
    }
  }
)

// Function to close the modal and emit the 'close' event
const handleClose = () => {
  emit('close')
}

// Function to handle form submission
const handleSubmit = async () => {
  try {
    // Check if submission date exists and format it to ISO if needed

    isSubmitting.value = true // Deshabilita el botón

    if (course.value.submissionDate) {
      course.value.submissionDate = new Date(course.value.submissionDate).toISOString()
    }

    // Update the course using the service
    const updatedCourse = await CourseService.updateCourse(course.value)
    console.log('Course Updated:', updatedCourse)
    await coursesStore.fetchCoursesByTeacher()

    // Fetch the updated list of courses for the teacher

    handleClose() // Close the modal after updating the course

    // Show success alert
    Swal.fire({
      title: 'Course Updated!',
      text: 'The course has been updated successfully.',
      icon: 'success',
      confirmButtonText: 'Ok'
    })
  } catch (error: any) {
    console.error('Error updating course:', error)
    // If the error code is 409 (conflict), handle the case where the course name is already the same
    if (
      error.response &&
      error.response.status === 409 &&
      error.response.data.message === 'The course name is already the same.'
    ) {
      messageError.value = 'The course name is already the same.'
    } else {
      messageError.value = 'An error occurred while updating the course.'
    }
    handleClose()
    // Display error using SweetAlert
    Swal.fire({
      title: 'Course Update Failed',
      text: messageError.value,
      icon: 'error',
      confirmButtonText: 'Try Again'
    })
  } finally {
    isSubmitting.value = false // Habilita el botón nuevamente
  }
}
</script>

<style scoped>
/* Optional additional styles */
</style>
