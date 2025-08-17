<template>
  <PageLayout :header="'listen'">
    <div class="flex justify-center align-center w-full">
      <iframe
        class="w-100 lg:w-lg xl:w-xl aspect-video"
        src="https://www.youtube.com/embed/videoseries?list=PLW7giUR5NtXgXVdPU8ObvsjMuDNaHkyvk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
    <template #details>
      <p>Ary Baldioceda - drums</p>
      <p>Eli Jayson - keyboards and saxophone</p>
      <p>Chris Patsis - bass</p>
    </template>
  </PageLayout>
</template>

<script setup lang="ts">

</script>
<style scoped>

</style>
