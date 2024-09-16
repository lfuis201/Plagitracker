<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  props: {
    modelValue: [String, Number],
    label: String,
    type: String,
    placeholder: String,
    customClasses: String,
    required: {
      type: Boolean,
      default: false
    }
  },
  emits: ['update:modelValue'],
  setup(props, { emit }) {
    const updateValue = (event: Event) => {
      const target = event.target as HTMLInputElement
      emit('update:modelValue', target.value)
    }

    return { updateValue }
  }
})
</script>

<template>
  <div :class="customClasses">
    <label class="mb-2.5 block text-black dark:text-white">
      {{ label }}
      <span v-if="required" class="text-meta-1">*</span>
    </label>
    <input
      :value="modelValue"
      @input="updateValue"
      :type="type"
      :placeholder="placeholder"
      class="w-full rounded border-[1.5px] text-black border-stroke bg-transparent py-3 px-5 font-normal outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:text-white dark:border-form-strokedark dark:bg-form-input dark:focus:border-primary"
    />
  </div>
</template>