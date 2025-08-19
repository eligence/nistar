<template>
  <LayoutMain :header="'about'">
    <p>Chassidic Funk, Soul, Jazz Originals</p>
    <p>Imbuing music with Divine meditation</p>
    <p>Opening mind and heart to trust and faith in The Creator with improvisation</p>
    <p>Strengthening our connection to our essential being with wordless song</p>
    <template #details>
      <p>Ary Baldioceda - drums</p>
      <p>Eli Jayson - keyboards and saxophone</p>
    </template>
  </LayoutMain>
</template>

<script setup lang="ts">
useHead({
  title: 'About Nistar - Chassidic Funk, Soul & Jazz',
  meta: [
    {
      name: 'description',
      content: 'Learn about Nistar, a Florida-based band fusing Chassidic melodies with contemporary funk, soul, and jazz. Discover our mission and meet the musicians.'
    }
  ]
});
</script>
