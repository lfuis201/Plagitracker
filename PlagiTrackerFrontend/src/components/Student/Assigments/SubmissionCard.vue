<script setup lang="ts"></script>

<template>
  <div class="flex flex-col p-4 bg-white text-foreground rounded-lg shadow-md">
    <div class="flex items-center mb-2">
      <img
        aria-hidden="true"
        alt="document-icon"
        src="https://openui.fly.dev/openui/24x24.svg?text=📄"
        class="mr-2"
      />
      <h2 class="text-xl font-bold">Evidencia 02</h2>
    </div>
    <p class="text-zinc-600">Maribel Rosario Quiroz Pilco • 18 sept</p>
    <p class="mt-2">Simulación del método de encriptación de David-Prasad usando el Tango Atac.</p>
  </div>
  <div class="flex flex-col p-4 bg-white text-foreground rounded-lg shadow-md mt-4">
    <h3 class="font-semibold">Tu trabajo</h3>
    <p class="text-zinc-600">Asignado</p>
    <div class="mt-2">
      <!-- Input para ingresar URL -->
      <!-- Input for entering URL -->
      <label for="url-input" class="font-semibold text-sm mb-2 block">Añadir URL del trabajo</label>
      <input
        id="url-input"
        type="url"
        v-model="submissionUrl"
        placeholder="https://tutrabajo.com"
        class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
      />
    </div>
  </div>

  <div class="flex items-center mt-4">
    <button
      @click="submitLink"
      class="bg-blue-500 text-white hover:bg-blue-600 px-4 py-2 rounded-md ml-2"
    >
      Marcar como completado
    </button>
  </div>
</template>
<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { useUserStore } from '@/stores/userStore'
import SubmissionService from '@/services/SubmissionService'
import type { Submission } from '@/types/Submission'

// Using the store to get the current user
const userStore = useUserStore()
const user = computed(() => userStore.getUser)

// Using the route to extract the assignment ID
const route = useRoute()
const assignmentId = route.params.id as string // Extract the ID from the route params

// Input binding for the URL
const submissionUrl = ref('')

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

    console.log(submission);

    await SubmissionService.createSubmission(submission)
    alert('Submission uploaded successfully!')
  } catch (error) {
    console.error('Error submitting link:', error)
    alert('There was an issue submitting your link.')
  }
}
</script>
