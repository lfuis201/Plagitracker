<template>
  <div class="flex items-center justify-center min-h-screen bg-gray-100">
    <div class="bg-white p-8 rounded-lg shadow-md w-full max-w-md">
      <h2 class="text-2xl font-semibold text-center text-gray-800 mb-6">Login</h2>
      <form @submit.prevent="handleSubmit" class="space-y-6">
        <div class="form-group">
          <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
          <input
            v-model="username"
            id="username"
            type="text"
            required
            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
          />
        </div>

        <div class="form-group">
          <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
          <input
            v-model="password"
            id="password"
            type="password"
            required
            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
          />
        </div>

        <button
          type="submit"
          class="w-full bg-indigo-600 text-white py-2 px-4 rounded-md hover:bg-indigo-700 focus:ring-2 focus:ring-indigo-500 focus:ring-opacity-50"
        >
          Submit
        </button>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

import { encrypt } from '@/utils/cryptoUtils';
import TeacherService from '@/services/TeacherService';
// Definir variables reactivas para almacenar el nombre de usuario y la contraseña
const username = ref<string>('');
const password = ref<string>('');

// Función para manejar el envío del formulario
const handleSubmit = async () => {
  try {
    // Cifrar la contraseña antes de enviarla
    const encryptedPassword = encrypt(password.value);

    // Llamar al servicio de login
    const response = await TeacherService.loginTeacher(username.value, encryptedPassword);

    // Manejar la respuesta del servidor (por ejemplo, almacenar el token de autenticación)
    console.log('Login successful:', response);
    alert('Login successful:');

  } catch (error) {
    console.error('Error logging in:', error);
  }
};
</script>

<style scoped>
/* Tailwind CSS ya está integrado, no se necesita más CSS personalizado */
</style>
