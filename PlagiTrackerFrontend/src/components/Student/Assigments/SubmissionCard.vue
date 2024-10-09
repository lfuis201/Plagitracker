<template>
  <ItemNotFoundView
    v-if="assignmentNotFound"
    title="The assignment does not exist."
    description="The assignment you are looking for was not found."
    buttonText="Go to Home"
    link="/student/courses"
  />

  <div v-else class="flex flex-col p-4 bg-white text-foreground rounded-lg shadow-md">
    <div>
      <div class="flex items-center">
        <img
          aria-hidden="true"
          alt="document-icon"
          src="https://openui.fly.dev/openui/24x24.svg?text=📄"
          class="mr-2"
        />
        <h2 class="text-xl font-bold">{{ assignmentTitle }}</h2>
      </div>
      <h3 class="font-semibold mt-4">Your Work</h3>
      <p class="text-sm text-zinc-600 mt-2">{{ assignmentDescription }}</p>
      <p class="text-sm text-zinc-600 mt-2">
        <strong>Due Date:</strong> {{ assignmentSubmissionDate }}
      </p>
      <div class="mt-2">
        <label for="url-input" class="font-semibold text-sm mb-2 block">Add URL of the work</label>
        <input
          id="url-input"
          type="url"
          v-model="submissionUrl"
          placeholder="https://yourwork.com"
          class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
        />
      </div>
      <div class="flex items-center mt-4">
        <button
          @click="submitLink"
          class="bg-blue-500 text-white hover:bg-blue-600 px-4 py-2 rounded-md ml-2"
        >
          Mark as Completed
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useUserStore } from '@/stores/userStore'
import SubmissionService from '@/services/SubmissionService'
import AssignmentService from '@/services/AssigmentService'

import type { Submission } from '@/types/Submission'
import ItemNotFoundView from '@/views/ItemNotFoundView.vue'
// Using the store to get the current user
const userStore = useUserStore()
const user = computed(() => userStore.getUser)

// Using the route to extract the assignment ID
const route = useRoute()
const assignmentId = route.params.id as string // Extract the ID from the route params

// Input binding for the URL
const submissionUrl = ref('')
// Variables to hold assignment details
const assignmentTitle = ref<string>('')
const assignmentDescription = ref<string>('')
const assignmentSubmissionDate = ref<string>('')

// Error states
const error = ref<boolean>(false) // Track whether there's an error fetching the assignment
const assignmentNotFound = ref<boolean>(false) // Track whether the assignment is not found

// Function to load assignment details
const loadAssignmentDetails = async () => {
  try {
    const assignment: Assignment = await AssignmentService.getAssignmentById(assignmentId)
    assignmentTitle.value = assignment.title
    assignmentDescription.value = assignment.description
    assignmentSubmissionDate.value = new Date(assignment.submissionDate).toLocaleString('en-US', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      hour12: false
    })
    error.value = false // Reset error state if assignment is found
    assignmentNotFound.value = false // Reset not found state if assignment is found
  } catch (err) {
    if (err.response && err.response.data && err.response.data.errors.id) {
      // Check for specific validation error regarding the ID
      assignmentNotFound.value = true // Set not found state
    } else {
      error.value = true // Set error state if general error occurs
    }
    console.error('Error fetching assignment details:', err)
  }
}

// Function to handle the submission
const submitLink = async () => {
  if (!submissionUrl.value) {
    alert('Please enter a valid URL.')
    return
  }

  try {
    // Create the submission payload using the Submission type
    const submission: Omit<Submission, 'id'> = {
      url: submissionUrl.value,
      studentId: user.value.id,
      assignmentId: assignmentId,
      submissionDate: new Date()
    }

    // Call the submission service to create a submission
    console.log(submission)

    await SubmissionService.createSubmission(submission)
    alert('Submission uploaded successfully!')
  } catch (error) {
    console.error('Error submitting link:', error)
    alert('There was an issue submitting your link.')
  }
}

// Fetch assignment details on component mount
onMounted(() => {
  loadAssignmentDetails()
})
</script>
