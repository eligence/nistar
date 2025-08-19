<template>
  <div
       class="bg-white/5 rounded-lg overflow-hidden hover:bg-white/10 transition-colors">
    <div class="p-6">
      <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h2 class="text-xl font-semibold">{{ show.venue }}</h2>
          <p class="text-gray-400">{{ show.location }}</p>
          <div class="mt-2 flex items-center text-sm text-gray-400">
            <span>{{ show.date }}</span>
            <template v-if="show.time">
              <span class="mx-2">•</span>
              <span>{{ show.time }}</span>
            </template>

          </div>
        </div>
        <a v-if="show.ticketUrl && show.ticketUrl !== '#'"
           :href="show.ticketUrl"
           target="_blank"
           rel="noopener noreferrer"
           class="px-6 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-full font-medium transition-colors whitespace-nowrap text-center">
          Get Tickets
        </a>
        <span v-else class="text-gray-400 text-sm">Details coming soon</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  show: null,
})
</script>
