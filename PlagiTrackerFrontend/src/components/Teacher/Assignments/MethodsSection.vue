<template>
  <div class="mt-2">
    <h6 class="font-semibold">Methods</h6>
    <button
      type="button"
      class="mt-1 mb-2 bg-purple-500 text-white px-2 py-1 rounded"
      @click="addMethod"
    >
      Add Method
    </button>

    <div v-for="(method, methodIndex) in classData.methods" :key="methodIndex" class="border p-2 rounded mb-1">
      <label class="block mb-1">Method Name</label>
      <input
        type="text"
        v-model="method.name"
        class="border rounded w-full px-2 py-1"
        required
      />

      <label class="block mb-1 mt-2">Method Type</label>
      <input
        type="text"
        v-model="method.type"
        class="border rounded w-full px-2 py-1"
      />

      <label class="block mb-1 mt-2">Method Description</label>
      <textarea
        v-model="method.description"
        class="border rounded w-full px-2 py-1"
        rows="2"
      ></textarea>

      <!-- Parameters Section -->
      <ParametersSection
        v-for="(param, paramIndex) in method.parameters"
        :key="paramIndex"
        :paramData="param"
        :exerciseIndex="exerciseIndex"
        :classIndex="classIndex"
        :methodIndex="methodIndex"
      />

      <!-- Variables Section -->
      <VariablesSection
        v-for="(variable, varIndex) in method.variables"
        :key="varIndex"
        :variableData="variable"
        :exerciseIndex="exerciseIndex"
        :classIndex="classIndex"
        :methodIndex="methodIndex"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { defineProps } from 'vue'
import ParametersSection from './ParametersSection.vue'
import VariablesSection from './VariablesSection.vue'
import type { Method, Class, Exercise } from '@/types/Assigment'

const props = defineProps({
  methodData: {
    type: Object as () => Method, // Type the prop as Method
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

const addMethod = () => {
  const newMethod: Method = {
    name: '',
    type: '',
    description: '',
    parameters: [],
    variables: []
  }
  props.classData.methods.push(newMethod)
}
</script>
