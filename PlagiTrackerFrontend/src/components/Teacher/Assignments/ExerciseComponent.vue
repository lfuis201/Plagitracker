<template>
  <div class="mb-4">
    <div class="border p-4 rounded mb-4">
      <label class="block mb-2">Exercise Name</label>
      <input
        type="text"
        v-model="exercise.name"
        class="border rounded w-full px-3 py-2"
        required
      />

      <label class="block mb-2 mt-4">Exercise Description</label>
      <textarea
        v-model="exercise.description"
        class="border rounded w-full px-3 py-2"
        rows="3"
      />

      <label class="block mb-2 mt-4">Has Body?</label>
      <input
        type="checkbox"
        v-model="exercise.haveBody"
        class="mr-2"
      />
      <span>{{ exercise.haveBody ? 'Yes' : 'No' }}</span>

      <!-- Add Class Button -->
      <button
        type="button"
        class="mt-2 mb-4 bg-blue-500 text-white px-4 py-2 rounded"
        @click="addClass"
      >
        Add Class
      </button>

      <!-- Classes Section -->
      <div v-for="(cls, classIndex) in exercise.classes" :key="classIndex">
        <ClassesSection
          :classData="cls"
          :exerciseIndex="exerciseIndex"
          :classIndex="classIndex"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { defineProps } from 'vue'
import ClassesSection from './ClassesSection.vue'
import type { Exercise, Class, Method, Parameter, Variable } from '@/types/Assigment'

// Define the props for the exercise and exercise index
const props = defineProps({
  exercise: {
    type: Object as () => Exercise, 
    required: true
  },
  exerciseIndex: {
    type: Number,
    required: true
  }
})

// Method to add a new class to the exercise's classes array
const addClass = () => {
  // Add a new empty class based on the Class interface structure
  props.exercise.classes.push({
    name: '',  // Name of the class
    description: '',  // Description of the class
    childClasses: [],  // Array of child classes
    methods: []  // Array of methods in the class
  })
}
</script>
