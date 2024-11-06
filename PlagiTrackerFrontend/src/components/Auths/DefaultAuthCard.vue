<script setup lang="ts">
const props = defineProps(['banner', 'subtitle', 'title', 'customClasses'])
</script>

<template>
  <!-- ====== Forms Section Start -->
  <div
    class="relative rounded-sm border border-stroke bg-white shadow-default dark:border-strokedark dark:bg-boxdark"
  >
    <!-- Home Button in the Top Left Corner -->
    <router-link
      to="/"
      class="absolute top-4 left-4 xl:flex hidden items-center justify-center w-10 h-10 bg-blue-500 text-white rounded-full hover:bg-blue-600"
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        viewBox="0 0 24 24"
        class="text-white"
      >
        <g fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2">
          <path d="M5 12H3l9-9l9 9h-2M5 12v7a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-7"/>
          <path d="M9 21v-6a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v6"/>
        </g>
      </svg>
    </router-link>


    <div class="flex flex-wrap items-center">
      <div class="hidden w-full xl:block xl:w-1/2">
        <div class="py-17.5 px-26 text-center">
          <router-link class="mb-5.5 flex items-center justify-center" to="/">
            <span class="text-xl font-bold dark:text-white">PlagiTracker</span>
          </router-link>
          <p class="font-medium 2xl:px-20 text-blue-500">
            {{ props.banner }}
          </p>

          <span class="mt-15 inline-block">
            <img src="@/assets/images/illustration/illustration-03.svg" alt="illustration" />
          </span>
        </div>
      </div>
      <div class="w-full border-stroke dark:border-strokedark xl:w-1/2 xl:border-l-2">
        <div class="w-full p-4 sm:p-12.5 xl:p-17.5">
          <span class="mb-1.5 block font-medium">{{ props.subtitle }}</span>
          <h2 class="mb-9 text-2xl font-bold text-black dark:text-white sm:text-title-xl2">
            {{ props.title }}
          </h2>

          <slot></slot>
        </div>
      </div>
    </div>
  </div>
  <!-- ====== Forms Section End -->
</template>
