<script setup lang="ts">
import FullScreenLayout from '@/layouts/FullScreenLayout.vue'
</script>

<template>
  <FullScreenLayout>
    <div class="flex items-center justify-center min-h-screen bg-gray-100">
      <div class="text-center">
        <h1 class="text-4xl font-bold text-red-600">Authentication Required</h1>
        <p class="mt-4 text-lg text-gray-700">
          You need to be authenticated to access this page. Please choose your login method below.
        </p>
        <div class="mt-6 flex justify-center space-x-4">
          <!-- Button to redirect to the teacher login page -->
          <router-link
            to="/teacher/auth/signin"
            class="px-6 py-3 text-sm font-semibold text-white bg-blue-600 rounded hover:bg-blue-700"
          >
            Teacher Login
          </router-link>

          <!-- Button to redirect to the student login page -->
          <router-link
            to="/student/auth/signin"
            class="px-6 py-3 text-sm font-semibold text-white bg-green-600 rounded hover:bg-green-700"
          >
            Student Login
          </router-link>
        </div>
      </div>
    </div>
  </FullScreenLayout>
</template>
