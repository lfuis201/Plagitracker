<script setup lang="ts">

</script>

<template>
<div class="flex flex-col p-4 bg-white text-foreground rounded-lg shadow-md">
  <div class="flex items-center mb-2">
    <img aria-hidden="true" alt="document-icon" src="https://openui.fly.dev/openui/24x24.svg?text=📄" class="mr-2" />
    <h2 class="text-xl font-bold">Evidencia 02</h2>
  </div>
  <p class="text-zinc-600">Maribel Rosario Quiroz Pilco • 18 sept</p>
  <p class="mt-2">Simulación del método de encriptación de David-Prasad usando el Tango Atac.</p>

</div>
<div class="flex flex-col p-4 bg-white text-foreground rounded-lg shadow-md mt-4">
  <h3 class="font-semibold">Tu trabajo</h3>
  <p class="text-zinc-600">Asignado</p>
  <div class="mt-2">
      <!-- Input para ingresar URL -->
      <label for="url-input" class="font-semibold text-sm mb-2 block">Añadir URL del trabajo</label>
      <input
        id="url-input"
        type="url"
        placeholder="https://tutrabajo.com"
        class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
      />
    </div>

    <div class="flex items-center mt-4">
     
      <button
        class="bg-blue-500 text-white hover:bg-blue-600 px-4 py-2 rounded-md ml-2"
      >
        Marcar como completado
      </button>
    </div>
</div>
</template>
