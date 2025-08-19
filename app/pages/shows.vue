<template>
  <PageLayout class="px-4 mb-12">
    <h1 class="mb-8 text-center">Upcoming Shows</h1>

    <div v-if="upcomingShows.length === 0" class="text-center py-12">
      <p class="text-xl text-gray-400 mb-4">No upcoming shows scheduled at the moment.</p>
      <p class="text-gray-500">Check back soon for updates or follow us on social media!</p>
    </div>

    <div v-else class="space-y-6">
      <ShowCard v-for="(show, index) in upcomingShows" :key="index" :show="show"/>
    </div>

    <h3 class="text-center mb-8 mt-12">Previous Shows</h3>
    <div class="space-y-6">
      <ShowCard v-for="(show, index) in previousShows" :key="index" :show="show"/>
    </div>

    <section class="mt-16 text-center">
      <h2 class="mb-6">Booking Information</h2>
      <p class="mb-4">Interested in booking Nistar for your event? We'd love to bring our unique sound to your venue or special occasion.</p>
      <div class="space-y-2">
        <p><span class="text-lg font-medium">Contact:</span> Eli Jayson</p>
        <p><span class="font-medium">Email:</span> <a href="mailto:eligence@gmail.com" class="text-blue-300 hover:text-blue-400">eligence@gmail.com</a></p>
        <p><span class="font-medium">Phone:</span> <a href="tel:+13864513843" class="text-blue-300 hover:text-blue-400">(386) 451-3843</a></p>
      </div>
    </section>
  </PageLayout>
</template>

<script setup lang="ts">
useHead({
  title: 'Shows | Nistar - Live Performances',
  meta: [
    {
      name: 'description',
      content: 'Upcoming tour dates and booking information for Nistar. Experience our Chassidic funk, soul, and jazz fusion live in concert.'
    }
  ]
});

const upcomingShows = shows.filter(show => new Date(show.date) > new Date())
const previousShows = shows.filter(show => new Date(show.date) < new Date())
</script>
