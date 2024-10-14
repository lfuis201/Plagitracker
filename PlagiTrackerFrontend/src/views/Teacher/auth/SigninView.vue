<script setup lang="ts">
import DefaultAuthCard from '@/components/Auths/DefaultAuthCard.vue'
import InputGroup from '@/components/Auths/InputGroup.vue'
import FullScreenLayout from '@/layouts/FullScreenLayout.vue'
import { ref } from 'vue'
import { encrypt } from '@/utils/cryptoUtils'
import router from '@/router'
import { useUserStore } from '@/stores/userStore'
import { loginSchema } from '@/schemas/loginSchema'
import { z } from 'zod'

const email = ref<string>('')
const password = ref<string>('')
const errorMessage = ref<string>('') // Variable para el mensaje de error
const isLoading = ref<boolean>(false) // Estado para controlar la carga
const remainingAttempts = ref<number | null>(null) // Intentos restantes de inicio de sesión
const unlockDate = ref<Date | null>(null) // Fecha en la que la cuenta será desbloqueada
const showPassword = ref<boolean>(false) // Estado para mostrar/ocultar la contraseña

const errors = ref<{ [key: string]: string }>({}) // Object to manage errors

const userStore = useUserStore() // Usar el store generalizado

// Manejo del formulario
const handleSubmit = async (event: Event) => {
  event.preventDefault() // Evitar que el formulario recargue la página
  errorMessage.value = '' // Limpiar cualquier mensaje de error previo
  isLoading.value = true

  errors.value = {} // Limpiar todos los errores previos

  try {
    // Encripta la contraseña antes de enviarla

    loginSchema.parse({
      email: email.value,
      password: password.value
    })

    const encryptedPassword = encrypt(password.value)

    // Llama al método login del store
    await userStore.login(email.value, encryptedPassword, 'teacher')

    // Si el login es exitoso, redirigir al dashboard
    //console.log('Login successful:', userStore.getUser)
    //alert('Login successful:');

    // Redirigir al dashboard
    router.push('/profile')
  } catch (error: any) {
    console.error('Error logging in:', error)
    if (error instanceof z.ZodError) {
      error.errors.forEach((err) => {
        errors.value[err.path[0]] = err.message // Store the error message in the object
      })
    } else {
      // Verificar si el error es una respuesta del servidor con el código 404
      if (error.response && error.response.status === 404) {
        if (error.response.data && error.response.data.message === 'Account not found.') {
          errorMessage.value = 'Account not found. Please check your email and password.'
        } else {
          errorMessage.value = 'Endpoint not found. Please contact support.' // Caso genérico de 404
        }
      } // Verificar si el error es 401 Unauthorized con "Invalid password"
      else if (error.response && error.response.status === 401) {
        if (error.response.data && error.response.data.message === 'Invalid password.') {
          errorMessage.value = `Invalid password. Please try again.`
          remainingAttempts.value = error.response.data.remainingLogInAttempts
        }
        if (error.response.data && error.response.data.message === 'Account is locked.') {
          errorMessage.value = 'Your account is locked.'
          unlockDate.value = new Date(error.response.data.unlockDate) // Parsear la fecha de desbloqueo
        } else {
          errorMessage.value = 'Unauthorized. Please check your credentials.'
        }
      } else {
        // Otro tipo de error (como problemas de conexión)
        errorMessage.value = 'Error logging in, please try again.'
      }
    }

    isLoading.value = false // Detener el spinner
  }
}
</script>

<template>
  <FullScreenLayout>
    <DefaultAuthCard subtitle="Welcome teacher" title="Sign In to PlagiTracker">
      <form @submit="handleSubmit">
        <InputGroup v-model="email" label="Email" type="text" placeholder="Enter your email">
          <svg
            class="fill-current"
            width="22"
            height="22"
            viewBox="0 0 22 22"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <g opacity="0.5">
              <path
                d="M19.2516 3.30005H2.75156C1.58281 3.30005 0.585938 4.26255 0.585938 5.46567V16.6032C0.585938 17.7719 1.54844 18.7688 2.75156 18.7688H19.2516C20.4203 18.7688 21.4172 17.8063 21.4172 16.6032V5.4313C21.4172 4.26255 20.4203 3.30005 19.2516 3.30005ZM19.2516 4.84692C19.2859 4.84692 19.3203 4.84692 19.3547 4.84692L11.0016 10.2094L2.64844 4.84692C2.68281 4.84692 2.71719 4.84692 2.75156 4.84692H19.2516ZM19.2516 17.1532H2.75156C2.40781 17.1532 2.13281 16.8782 2.13281 16.5344V6.35942L10.1766 11.5157C10.4172 11.6875 10.6922 11.7563 10.9672 11.7563C11.2422 11.7563 11.5172 11.6875 11.7578 11.5157L19.8016 6.35942V16.5688C19.8703 16.9125 19.5953 17.1532 19.2516 17.1532Z"
                fill=""
              />
            </g>
          </svg>
        </InputGroup>
        <!-- Error de validación para el email -->
        <div v-if="errors.email" class="text-red mb-2">{{ errors.email }}</div>

        <InputGroup
          v-model="password"
          label="Password"
          :type="showPassword ? 'text' : 'password'"
          placeholder="Enter your password"
        >
          <button type="button" @click="showPassword = !showPassword">
            <svg
              v-if="showPassword"
              xmlns="http://www.w3.org/2000/svg"
              width="22"
              height="22"
              class="fill-current"
              fill="none"
              viewBox="0 0 256 256"
            >
              <path
                fill="currentColor"
                d="M247.31 124.76c-.35-.79-8.82-19.58-27.65-38.41C194.57 61.26 162.88 48 128 48S61.43 61.26 36.34 86.35C17.51 105.18 9 124 8.69 124.76a8 8 0 0 0 0 6.5c.35.79 8.82 19.57 27.65 38.4C61.43 194.74 93.12 208 128 208s66.57-13.26 91.66-38.34c18.83-18.83 27.3-37.61 27.65-38.4a8 8 0 0 0 0-6.5M128 192c-30.78 0-57.67-11.19-79.93-33.25A133.5 133.5 0 0 1 25 128a133.3 133.3 0 0 1 23.07-30.75C70.33 75.19 97.22 64 128 64s57.67 11.19 79.93 33.25A133.5 133.5 0 0 1 231.05 128c-7.21 13.46-38.62 64-103.05 64m0-112a48 48 0 1 0 48 48a48.05 48.05 0 0 0-48-48m0 80a32 32 0 1 1 32-32a32 32 0 0 1-32 32"
              />
            </svg>

            <svg
              v-else
              xmlns="http://www.w3.org/2000/svg"
              width="22"
              height="22"
              viewBox="0 0 256 256"
              fill="none"
            >
              <path
                fill="currentColor"
                d="M228 175a8 8 0 0 1-10.92-3l-19-33.2A123.2 123.2 0 0 1 162 155.46l5.87 35.22a8 8 0 0 1-6.58 9.21a8.4 8.4 0 0 1-1.29.11a8 8 0 0 1-7.88-6.69l-5.77-34.58a133 133 0 0 1-36.68 0l-5.77 34.58A8 8 0 0 1 96 200a8.4 8.4 0 0 1-1.32-.11a8 8 0 0 1-6.58-9.21l5.9-35.22a123.2 123.2 0 0 1-36.06-16.69L39 172a8 8 0 1 1-13.94-8l20-35a153.5 153.5 0 0 1-19.3-20a8 8 0 1 1 12.46-10c16.6 20.54 45.64 45 89.78 45s73.18-24.49 89.78-45a8 8 0 1 1 12.44 10a153.5 153.5 0 0 1-19.3 20l20 35a8 8 0 0 1-2.92 11"
              />
            </svg>
          </button>
        </InputGroup>
        <div v-if="errors.password" class="text-red mb-2">{{ errors.password }}</div>

        <!-- Mensaje de error (solo se mostrará si existe un error) -->
        <p v-if="errorMessage" class="text-red mt-2">{{ errorMessage }}</p>
        <!-- Mostrar intentos restantes solo si la cuenta no está bloqueada -->
        <div v-if="remainingAttempts !== null && unlockDate === null" class="text-yellow-500 mb-4">
          {{ remainingAttempts }} login attempts remaining.
        </div>

        <!-- Mostrar mensaje si la cuenta está bloqueada -->
        <div v-if="unlockDate !== null" class="text-yellow-500 mb-4">
          Your account is locked. It will be unlocked on {{ unlockDate.toLocaleString() }}.
        </div>

        <div class="mb-5 mt-6">
          <button
            type="submit"
            :disabled="isLoading"
            class="relative w-full flex items-center justify-center cursor-pointer rounded-lg border border-primary bg-primary p-4 font-medium text-white transition hover:bg-opacity-90 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <!-- Texto del botón que cambia según el estado de carga -->
            <span v-if="!isLoading">Login</span>
            <span v-else>Login...</span>

            <svg
              v-if="isLoading"
              xmlns="http://www.w3.org/2000/svg"
              width="20"
              height="20"
              viewBox="0 0 24 24"
              class="ml-4"
            >
              <path
                fill="none"
                stroke="#ffffff"
                stroke-dasharray="16"
                stroke-dashoffset="16"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M12 3c4.97 0 9 4.03 9 9"
              >
                <animate fill="freeze" attributeName="stroke-dashoffset" dur="0.2s" values="16;0" />
                <animateTransform
                  attributeName="transform"
                  dur="1.5s"
                  repeatCount="indefinite"
                  type="rotate"
                  values="0 12 12;360 12 12"
                />
              </path>
            </svg>
          </button>
        </div>

        <div class="mt-6 text-center">
          <p class="font-medium">
            Don’t have any account?
            <router-link to="/teacher/auth/signup" class="text-primary">Sign up</router-link>
          </p>
        </div>

        <div class="mt-6 text-center">
          <p class="font-medium">
            Forgot your password?
            <router-link to="/forgotPassword" class="text-primary"
              >Recover it here</router-link
            >
          </p>
        </div>
      </form>
    </DefaultAuthCard>
  </FullScreenLayout>
</template>
