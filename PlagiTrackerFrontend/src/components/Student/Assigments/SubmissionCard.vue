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
          :disabled="isSubmissionClosed"
          placeholder="https://www.codiva.io/"
          class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
        />
      </div>
      <div class="flex items-center mt-4">
        <button
          @click="submitLink"
          :disabled="isSubmissionClosed"
          :class="isSubmissionClosed ? 'bg-blue-300 text-white cursor-not-allowed' : 'bg-blue-500 text-white hover:bg-blue-600'"
          class="px-4 py-2 rounded-md"
        >
          Mark as Completed
        </button>
      </div>

      <!-- Display message if submission is closed -->
      <p v-if="isSubmissionClosed" class="text-red mt-2">
        Submission deadline has passed. You cannot submit the link.
      </p>
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
import type { Assignment } from '@/types/Assigment'
import Swal from 'sweetalert2'
// Store references
const userStore = useUserStore()
const user = computed(() => userStore.getUser)

const route = useRoute()
const assignmentId = route.params.id as string
const router = useRouter()
// Input for submission URL
const submissionUrl = ref('')

// Assignment details
const assignmentTitle = ref<string>('')
const assignmentDescription = ref<string>('')
const assignmentSubmissionDate = ref<string>('')

// Track whether the assignment submission date has passed
const isSubmissionClosed = ref(false)

// Error tracking
const error = ref<boolean>(false)
const assignmentNotFound = ref<boolean>(false)

// Function to load assignment details
const loadAssignmentDetails = async () => {
  try {
    const assignment: Assignment = await AssignmentService.getAssignmentById(assignmentId)
    assignmentTitle.value = assignment.title
    assignmentDescription.value = assignment.description;

    const submissionDate = new Date(assignment.submissionDate)
    assignmentSubmissionDate.value = submissionDate.toLocaleString('en-US', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      hour12: false
    })

    // Check if the submission date has passed
    if (new Date() > submissionDate) {
      isSubmissionClosed.value = true
    }

    error.value = false
    assignmentNotFound.value = false
  } catch (err: any) {
    if (err.response && err.response.data && err.response.data.errors.id) {
      assignmentNotFound.value = true
    } else {
      error.value = true
    }
    console.error('Error fetching assignment details:', err)
  }
}

// Function to handle submission
// Function to handle submission
const submitLink = async () => {
  if (!submissionUrl.value) {
    Swal.fire({
      title: 'Error!',
      text: 'Please enter a valid URL.',
      icon: 'warning',
      confirmButtonText: 'OK'
    });
    return;
  }

  // Validate the URL
  const isCodivaUrl = submissionUrl.value.startsWith("https://www.codiva.io/");
  if (!isCodivaUrl) {
    Swal.fire({
      title: 'Invalid URL!',
      text: 'Please enter a URL that starts with "https://www.codiva.io/".',
      icon: 'warning',
      confirmButtonText: 'OK'
    });
    return;
  }

  try {
    const submission: Omit<Submission, 'id'> = {
      url: submissionUrl.value,
      studentId: user.value.id,
      assignmentId: assignmentId,
      submissionDate: new Date()
    };

    await SubmissionService.createSubmission(submission);
    Swal.fire({
      title: 'Success!',
      text: 'Submission uploaded successfully!',
      icon: 'success',
      confirmButtonText: 'OK'
    }).then(() => {
      router.push('/student/courses')  // Redirige a la página de cursos después de la confirmación
    });


    router.push('/student/courses')

  } catch (error) {
    console.error('Error submitting link:', error);
    Swal.fire({
      title: 'Error!',
      text: 'There was an issue submitting your link.',
      icon: 'warning',
      confirmButtonText: 'OK'
    });
  }
};


// Fetch assignment details on component mount
onMounted(() => {
  loadAssignmentDetails()
})
</script>
