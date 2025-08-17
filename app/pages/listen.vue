<template>
  <PageLayout :header="'listen'">
    <div class="flex flex-col justify-center items-center w-full gap-4 lg:gap-12">
      <iframe class="w-100 lg:w-lg xl:w-xl aspect-video" src="https://www.youtube.com/embed/8vcHAquLtDY?si=HW9spTFvhjn7ltqS" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
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
