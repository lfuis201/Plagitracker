<script setup lang="ts">
import AssigmentCard from './AssigmentCard.vue';
// Definimos una lista de tareas de ejemplo
const assignments = [
  {
    title: 'Material Taller 1: Introducción a la Seguridad Informática',
    date: '10 sept',
    lastModified: '11 sept',
  },
  {
    title: 'Material Taller 2: Análisis de Riesgos',
    date: '12 sept',
    lastModified: '12 sept',
  },
  {
    title: 'Material Taller 3: Auditoría de Sistemas',
    date: '15 sept',
    lastModified: '16 sept',
  },
  {
    title: 'Material Taller 4: Ciberseguridad y Protección de Datos',
    date: '18 sept',
    lastModified: '19 sept',
  }
];
</script>

<template>
  <div class="grid grid-cols-1 gap-4">
    <!-- Iteramos sobre la lista de tareas y mostramos una tarjeta para cada una -->
    <AssigmentCard
      v-for="(assignment, index) in assignments"
      :key="index"
      :title="assignment.title"
      :date="assignment.date"
      :lastModified="assignment.lastModified"
    />
  </div>
</template>

<style scoped>
/* Añadir estilos adicionales si es necesario */
</style>
