<template>
  <div class="mt-2">
    <h6 class="font-semibold">Parameters</h6>
    <button
      type="button"
      class="mt-1 mb-2 bg-teal-500 text-white px-2 py-1 rounded"
      @click="addParameter"
    >
      Add Parameter
    </button>

    <div v-for="(param, paramIndex) in methodData.parameters" :key="paramIndex" class="border p-2 rounded mb-1">
      <label class="block mb-1">Parameter Name</label>
      <input
        type="text"
        v-model="param.name"
        class="border rounded w-full px-2 py-1"
        required
      />

      <label class="block mb-1 mt-2">Parameter Type</label>
      <input
        type="text"
        v-model="param.type"
        class="border rounded w-full px-2 py-1"
      />

      <label class="block mb-1 mt-2">Parameter Description</label>
      <textarea
        v-model="param.description"
        class="border rounded w-full px-2 py-1"
        rows="2"
      ></textarea>
    </div>
  </div>
</template>

<script setup lang="ts">
import { defineProps } from 'vue'
import type { Parameter, Method, Exercise } from '@/types/Assigment'

const props = defineProps({
  paramData: {
    type: Object as () => Parameter, // Type the prop as Parameter
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

const addParameter = () => {
  const newParam: Parameter = {
    name: '',
    type: '',
    description: ''
  }
  props.methodData.parameters.push(newParam)
}
</script>
