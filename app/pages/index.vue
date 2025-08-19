<template>
  <PageLayout>
    <span class="nistar-title fixed top-36 left-1/2 transform -translate-x-1/2 font-serif tracking-widest text-amber-300 text-2xl lg:text-5xl text-center">NISTAR</span>
    <Sparks />
    <h1 class="text-center">music is soul,</h1>
    <h1 class="text-center">soul is life</h1>
  </PageLayout>
</template>
<style scoped>
.nistar-title {
  opacity: 0;
  animation: fadeIn 8s ease-in-out forwards;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
</style>
