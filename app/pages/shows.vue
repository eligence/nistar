<template>
  <PageLayout>
    <h1 class="text-3xl font-bold mb-8 text-center">Upcoming Shows</h1>

    <div v-if="shows.length === 0" class="text-center py-12">
      <p class="text-xl text-gray-400 mb-4">No upcoming shows scheduled at the moment.</p>
      <p class="text-gray-500">Check back soon for updates or follow us on social media!</p>
    </div>

    <div v-else class="space-y-6">
      <div v-for="(show, index) in shows" :key="index"
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
    </div>

    <section class="mt-16 text-center">
      <h2 class="text-2xl font-semibold mb-6">Booking Information</h2>
      <p class="mb-4">Interested in booking Nistar for your event? We'd love to bring our unique sound to your venue or special occasion.</p>
      <div class="space-y-2">
        <p><span class="font-medium">Email:</span> <a href="mailto:eligence@gmail.com" class="text-blue-300 hover:text-blue-400">eligence@gmail.com</a></p>
        <p><span class="font-medium">Phone:</span> <a href="tel:+13864513843" class="text-blue-300 hover:text-blue-400">(386) 451-3843</a></p>
      </div>
    </section>
  </PageLayout>
</template>

<script setup lang="ts">
interface Show {
  date: string
  venue: string
  location: string
  ticketUrl?: string
  time?: string
  address?: string
}

useHead({
  title: 'Shows | Nistar - Live Performances',
  meta: [
    {
      name: 'description',
      content: 'Upcoming tour dates and booking information for Nistar. Experience our Chassidic funk, soul, and jazz fusion live in concert.'
    }
  ]
});
</script>
