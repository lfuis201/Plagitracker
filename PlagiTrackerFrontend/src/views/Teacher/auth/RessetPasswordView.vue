<script setup lang="ts">
import { ref } from 'vue'
import { z } from 'zod' // Importamos Zod
import DefaultAuthCard from '@/components/Auths/DefaultAuthCard.vue'
import InputGroup from '@/components/Auths/InputGroup.vue'
import FullScreenLayout from '@/layouts/FullScreenLayout.vue'
import TeacherService from '@/services/TeacherService'
// Importar el esquema de validación
import changePasswordSchema from '@/schemas/changePasswordSchema'
import { encrypt } from '@/utils/cryptoUtils'

// Variables reactivas
const email = ref('') // Variable reactiva para el email
const verificationCode = ref('') // Variable reactiva para el código de verificación
const errorMessage = ref('') // Para manejar errores
const successMessage = ref('') // Para manejar mensajes de éxito
const password = ref<string>('') // Nueva contraseña
const confirmPassword = ref<string>('') // Confirmación de la nueva contraseña
const newPasswordHash = ref<string>('') // Hash de la nueva contraseña
const errors = ref<{ [key: string]: string }>({}) // Object to manage errors

// Manejar el envío del formulario
const handleSubmit = async () => {
  try {
    successMessage.value = ''
    errorMessage.value = ''
    errors.value = {} // Reset errors

    // Crear el objeto con los datos del formulario
    const formData = {
      email: email.value,
      verificationCode: verificationCode.value,
      newPasswordHash: password.value
    }
    changePasswordSchema.parse(formData)

    // Validar el código de verificación
    const verificationResponse = await TeacherService.resetPasswordVerification(formData.email, parseInt(formData.verificationCode))
    console.log('Verification response:', verificationResponse) // Log para verificar la respuesta


    // Realizar transformaciones después de la validación
    formData.newPasswordHash = encrypt(formData.newPasswordHash) // Encriptar la nueva contraseña

    // Llamar al servicio para cambiar la contraseña
    const response = await TeacherService.resetPassword(formData) // Llamar al método de restablecimiento
    console.log(response) // Mostrar la respuesta del servidor

    // Mensaje de éxito
    successMessage.value = 'Your password has been successfully changed.'
  } catch (error: any) {
    // Manejar el error
    if (error instanceof z.ZodError) {
      error.errors.forEach((err) => {
        errors.value[err.path[0]] = err.message // Store the error message in the object
      })
    } else if (error.response) {
      if (error.response.status === 400) {
        if (error.response.data.message === "Code expired.") {
          errorMessage.value = 'The verification code has expired. Please request a new code.'
        } else {
          errorMessage.value = 'Invalid verification code. Please check and try again.'
        }
      } else {
        errorMessage.value = 'Failed to change password. Please try again.'
      }
    } else {
      errorMessage.value = 'Failed to change password. Please try again.' // Manejo de errores general
    }
  }
}
</script>

<template>
  <FullScreenLayout>
    <DefaultAuthCard subtitle="Change your password" title="Reset your Password">
      <form @submit.prevent="handleSubmit">
        <!-- Input para el email -->
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
                fill="none"
              />
            </g>
          </svg>
        </InputGroup>
        <div v-if="errors.email" class="text-red mb-2">{{ errors.email }}</div>

        <!-- Input para el código de verificación -->
        <InputGroup
          v-model="verificationCode"
          label="Verification Code"
          type="text"
          placeholder="Enter the verification code sent to your email"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="fill-current"
            width="20"
            height="20"
            viewBox="0 0 56 56"
            fill="none"
          >
            <path
              fill=""
              d="M8.746 37.703h7.149l-2.133 10.594a4 4 0 0 0-.07.75c0 1.148.796 1.781 1.898 1.781c1.125 0 1.945-.61 2.18-1.758l2.296-11.367h11.086L29.02 48.297c-.07.234-.093.516-.093.75c0 1.148.797 1.781 1.922 1.781s1.945-.61 2.18-1.758L35.3 37.703h8.367c1.289 0 2.18-.937 2.18-2.203c0-1.031-.703-1.875-1.758-1.875h-7.946L38.63 21.25h8.203c1.29 0 2.18-.937 2.18-2.203c0-1.031-.703-1.875-1.758-1.875H39.45l1.922-9.445c.023-.141.07-.446.07-.75c0-1.149-.82-1.805-1.945-1.805c-1.312 0-1.898.726-2.133 1.828l-2.062 10.172H24.215l1.922-9.445c.023-.141.07-.446.07-.75c0-1.149-.844-1.805-1.945-1.805c-1.336 0-1.946.726-2.157 1.828l-2.062 10.172h-7.687c-1.29 0-2.18.984-2.18 2.273c0 1.055.703 1.805 1.758 1.805h7.289l-2.485 12.375h-7.57c-1.29 0-2.18.984-2.18 2.273c0 1.055.703 1.805 1.758 1.805m12.14-4.078l2.509-12.375H34.48l-2.508 12.375Z"
            />
          </svg>
        </InputGroup>
        <div v-if="errors.email" class="text-red mb-2">{{ errors.email }}</div>

        <InputGroup
          v-model="password"
          label="Password"
          type="password"
          placeholder="Enter your password"
        >
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
                d="M16.1547 6.80626V5.91251C16.1547 3.16251 14.0922 0.825009 11.4797 0.618759C10.0359 0.481259 8.59219 0.996884 7.52656 1.95938C6.46094 2.92188 5.84219 4.29688 5.84219 5.70626V6.80626C3.84844 7.18438 2.33594 8.93751 2.33594 11.0688V17.2906C2.33594 19.5594 4.19219 21.3813 6.42656 21.3813H15.5016C17.7703 21.3813 19.6266 19.525 19.6266 17.2563V11C19.6609 8.93751 18.1484 7.21876 16.1547 6.80626ZM8.55781 3.09376C9.31406 2.40626 10.3109 2.06251 11.3422 2.16563C13.1641 2.33751 14.6078 3.98751 14.6078 5.91251V6.70313H7.38906V5.67188C7.38906 4.70938 7.80156 3.78126 8.55781 3.09376ZM18.1141 17.2906C18.1141 18.7 16.9453 19.8688 15.5359 19.8688H6.46094C5.05156 19.8688 3.91719 18.7344 3.91719 17.325V11.0688C3.91719 9.52189 5.15469 8.28438 6.70156 8.28438H15.2953C16.8422 8.28438 18.1141 9.52188 18.1141 11V17.2906Z"
                fill=""
              />
              <path
                d="M10.9977 11.8594C10.5852 11.8594 10.207 12.2031 10.207 12.65V16.2594C10.207 16.6719 10.5508 17.05 10.9977 17.05C11.4102 17.05 11.7883 16.7063 11.7883 16.2594V12.6156C11.7883 12.2031 11.4102 11.8594 10.9977 11.8594Z"
                fill=""
              />
            </g>
          </svg>
        </InputGroup>

        <InputGroup
          v-model="confirmPassword"
          label="Re-type Password"
          type="password"
          placeholder="Re-enter your password"
        >
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
                d="M16.1547 6.80626V5.91251C16.1547 3.16251 14.0922 0.825009 11.4797 0.618759C10.0359 0.481259 8.59219 0.996884 7.52656 1.95938C6.46094 2.92188 5.84219 4.29688 5.84219 5.70626V6.80626C3.84844 7.18438 2.33594 8.93751 2.33594 11.0688V17.2906C2.33594 19.5594 4.19219 21.3813 6.42656 21.3813H15.5016C17.7703 21.3813 19.6266 19.525 19.6266 17.2563V11C19.6609 8.93751 18.1484 7.21876 16.1547 6.80626ZM8.55781 3.09376C9.31406 2.40626 10.3109 2.06251 11.3422 2.16563C13.1641 2.33751 14.6078 3.98751 14.6078 5.91251V6.70313H7.38906V5.67188C7.38906 4.70938 7.80156 3.78126 8.55781 3.09376ZM18.1141 17.2906C18.1141 18.7 16.9453 19.8688 15.5359 19.8688H6.46094C5.05156 19.8688 3.91719 18.7344 3.91719 17.325V11.0688C3.91719 9.52189 5.15469 8.28438 6.70156 8.28438H15.2953C16.8422 8.28438 18.1141 9.52188 18.1141 11V17.2906Z"
                fill=""
              />
              <path
                d="M10.9977 11.8594C10.5852 11.8594 10.207 12.2031 10.207 12.65V16.2594C10.207 16.6719 10.5508 17.05 10.9977 17.05C11.4102 17.05 11.7883 16.7063 11.7883 16.2594V12.6156C11.7883 12.2031 11.4102 11.8594 10.9977 11.8594Z"
                fill=""
              />
            </g>
          </svg>
        </InputGroup>
        <div v-if="errors.newPasswordHash" class="text-red mb-2">{{ errors.newPasswordHash }}</div>

        <!-- Mostrar mensaje de éxito o error -->
        <div v-if="successMessage" class="text-green-600">{{ successMessage }}</div>
        <div v-if="errorMessage" class="text-red">{{ errorMessage }}</div>
        <div v-if="password !== confirmPassword" class="text-red mb-2">Passwords do not match!</div>

        <div class="mb-5 mt-6">
          <button
            type="submit"
            class="w-full cursor-pointer rounded-lg border border-primary bg-primary p-4 font-medium text-white transition hover:bg-opacity-90"
          >
            Change Password
          </button>
        </div>

        <div class="mt-6 text-center">
          <p class="font-medium">
            Remembered your password?
            <router-link to="/student/auth/signin" class="text-primary">Sign in</router-link>
          </p>
        </div>
      </form>
    </DefaultAuthCard>
  </FullScreenLayout>
</template>
