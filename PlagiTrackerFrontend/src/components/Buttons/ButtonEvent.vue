<script setup lang="ts">
const props = defineProps({
  label: {
    type: String,
    required: true,
  },
  customClasses: {
    type: String,
    required: false,
  },
  onClick: {
    type: Function,
    default: () => {}, // Valor predeterminado: función vacía
  }
});
</script>

<template>
  <button
    class="inline-flex items-center justify-center gap-2.5 py-4 px-10 text-center font-medium hover:bg-opacity-90 lg:px-8 xl:px-10"
    :class="props.customClasses"
    @click.prevent="props.onClick"
  >
    <slot></slot>
    {{ props.label }}
  </button>
</template>
