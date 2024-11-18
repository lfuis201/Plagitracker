<template>
  <div class="border p-4 rounded mb-4">
    <label class="block mb-2">Class Name</label>
    <input
      type="text"
      v-model="classData.name"
      class="border rounded w-full px-3 py-2"
      required
    />

    <label class="block mb-2 mt-4">Class Description</label>
    <textarea
      v-model="classData.description"
      class="border rounded w-full px-3 py-2"
      rows="3"
    />

    <label class="block mb-2 mt-4">Child Classes</label>
    <input
      type="text"
      v-model="classData.childClasses"
      class="border rounded w-full px-3 py-2"
      placeholder="Comma separated list of child classes"
    />

    <!-- Add Method Button -->
    <button
      type="button"
      class="mt-2 mb-4 bg-blue-500 text-white px-4 py-2 rounded"
      @click="addMethod"
    >
      Add Method
    </button>

    <!-- Methods Section -->
    <div v-for="(method, methodIndex) in classData.methods" :key="methodIndex" class="border p-2 rounded mb-2">
      <label class="block mb-1">Method Name</label>
      <input
        type="text"
        v-model="method.name"
        class="border rounded w-full px-2 py-1"
        required
      />

      <label class="block mb-1 mt-2">Method Description</label>
      <input
        type="text"
        v-model="method.description"
        class="border rounded w-full px-2 py-1"
      />

      <label class="block mb-1 mt-2">Method Type</label>
      <input
        type="text"
        v-model="method.type"
        class="border rounded w-full px-2 py-1"
      />

      <!-- Parameters Section -->
      <div v-for="(param, paramIndex) in method.parameters" :key="paramIndex" class="mt-2">
        <input
          type="text"
          v-model="param.name"
          class="border rounded w-full px-2 py-1 mb-1"
          placeholder="Parameter Name"
        />
        <input
          type="text"
          v-model="param.type"
          class="border rounded w-full px-2 py-1"
          placeholder="Parameter Type"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { defineProps } from 'vue'
import type { Class, Method, Parameter } from '@/types/Assigment'

const props = defineProps({
  classData: {
    type: Object as () => Class, // Type the prop as Class
    required: true
  },
  exerciseIndex: {
    type: Number,
    required: true
  },
  classIndex: {
    type: Number,
    required: true
  }
})

// Method to add a new method to the class's methods array
const addMethod = () => {
  // Add a new empty method based on the Method interface structure
  props.classData.methods.push({
    name: '', // Method name
    description: '', // Method description
    type: '', // Method type
    parameters: [] // Empty array for method parameters
  })
}
</script>
