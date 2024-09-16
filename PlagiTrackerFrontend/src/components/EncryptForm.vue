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
import { ref } from 'vue'
import CryptoJS from 'crypto-js'
import axios from 'axios'
// Accede a la variable de entorno usando process.env
const backendUrl = process.env.PLAGITRACKER_BACKEND_URL

console.log('Backend URL:', backendUrl)
// Definir clave secreta y IV (vector de inicialización)
const secretKey = CryptoJS.enc.Utf8.parse('1234567890123456') // 16 bytes para AES-128
const iv = CryptoJS.enc.Utf8.parse('1234567890123456') // Debe ser de 16 bytes

const username = ref<string>('')
const password = ref<string>('')

const encrypt = (text: string) => {
  const encrypted = CryptoJS.AES.encrypt(text, secretKey, { iv: iv }).toString()
  return encrypted
}

const decrypt = (ciphertext: string) => {
  const bytes = CryptoJS.AES.decrypt(ciphertext, secretKey, { iv: iv })
  return bytes.toString(CryptoJS.enc.Utf8)
}

const handleSubmit = async () => {
  try {
    const encryptedPassword = encrypt(password.value)
    console.log('Contraseña encriptada:', encryptedPassword)

    // Enviar la solicitud de inicio de sesión al servidor
    const response = await axios.post('http://localhost:5086/identity/login', {
      email: username.value, // Enviar el email en lugar de username
      password: encryptedPassword,
      twoFactorCode: '', // Deja estos valores vacíos si no se usan
      twoFactorRecoveryCode: ''
    })

    console.log('Respuesta del servidor:', response.data)

    // Maneja la respuesta del servidor (por ejemplo, almacenar el token de autenticación)
  } catch (error) {
    console.error('Error al iniciar sesión:', error)
  }
}
</script>

<style scoped>
/* Tailwind CSS ya está integrado, no se necesita más CSS personalizado */
</style>
