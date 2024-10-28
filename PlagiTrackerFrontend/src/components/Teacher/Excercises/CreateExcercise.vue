<template>
      <hr class="my-4 border-2 border-blue-400" />

  <form @submit.prevent="handleSubmit" class="space-y-4">
    <div>
      <label for="name" class="block mb-1 font-medium">Exercise Name</label>
      <input
        type="text"
        id="name"
        v-model="exerciseForm.name"
        class="border rounded w-full px-3 py-2"
        required
        placeholder="Enter exercise name"
      />
    </div>

    <div>
      <label for="description" class="block mb-1 font-medium">Description</label>
      <textarea
        id="description"
        v-model="exerciseForm.description"
        class="border rounded w-full px-3 py-2"
        rows="4"
        required
        placeholder="Enter exercise description"
      ></textarea>
    </div>

    <div class="flex items-center">
      <input
        type="checkbox"
        id="haveBody"
        v-model="exerciseForm.haveBody"
        class="mr-2"
      />
      <label for="haveBody" class="font-medium">Have Body</label>
    </div>
  </form>
</template>

<script lang="ts" setup>
import type { Exercise } from '@/types/Excercises';
import { ref, watch } from 'vue';

// Definimos la prop que recibirá un ejercicio
const props = defineProps<{
  exercise: Exercise;
}>();

// Estado interno del formulario, inicializado con el ejercicio recibido por prop
const exerciseForm = ref<Exercise>({ ...props.exercise });

// Observa cambios en la prop y actualiza el formulario cuando cambie
watch(
  () => props.exercise,
  (newExercise) => {
    exerciseForm.value = { ...newExercise };
  },
  { immediate: true }
);

// Maneja la sumisión del formulario
const handleSubmit = () => {
  console.log('Submitted Exercise:', exerciseForm.value);
  // Aquí podrías llamar a un servicio para guardar los datos,
  // e.g., ExerciseService.createExercise(exerciseForm.value);
};
</script>

<style scoped>
/* Estilos personalizados opcionales */
</style>
