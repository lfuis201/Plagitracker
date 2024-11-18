<template>
  <div class="mt-2">
    <h6 class="font-semibold">Variables</h6>
    <button
      type="button"
      class="mt-1 mb-2 bg-orange-500 text-white px-2 py-1 rounded"
      @click="addVariable"
    >
      Add Variable
    </button>

    <div v-for="(variable, varIndex) in methodData.variables" :key="varIndex" class="border p-2 rounded mb-1">
      <label class="block mb-1">Variable Name</label>
      <input
        type="text"
        v-model="variable.name"
        class="border rounded w-full px-2 py-1"
        required
      />

      <label class="block mb-1 mt-2">Variable Type</label>
      <input
        type="text"
        v-model="variable.type"
        class="border rounded w-full px-2 py-1"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { defineProps } from 'vue'
import type { Variable, Method, Exercise } from '@/types/Assigment'

const props = defineProps({
  variableData: {
    type: Object as () => Variable, // Type the prop as Variable
    required: true
  },
  exerciseIndex: {
    type: Number,
    required: true
  },
  classIndex: {
    type: Number,
    required: true
  },
  methodIndex: {
    type: Number,
    required: true
  }
})

const addVariable = () => {
  const newVariable: Variable = {
    name: '',
    type: ''
  }
  props.methodData.variables.push(newVariable)
}
</script>
