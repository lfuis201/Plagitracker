<template>
    <div class="flex flex-col items-center justify-center h-screen">
      <h1 class="text-3xl font-bold mb-8">Welcome to Pragitacker</h1>
      <div class="flex space-x-4">
        <router-link to="/student/auth/signin">
          <button class="bg-blue-500 text-white py-2 px-6 rounded-lg hover:bg-blue-700 transition ease-in-out duration-300">
            Try Pragitacker as a Student
          </button>
        </router-link>
        <router-link to="/teacher/auth/signin">
          <button class="bg-blue-500 text-white py-2 px-6 rounded-lg hover:bg-blue-700 transition ease-in-out duration-300">
            Try Pragitacker as a Teacher
          </button>
        </router-link>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: 'HomeView',
  };
  </script>
  
  <!-- No custom styles needed, as we are using Tailwind -->
  