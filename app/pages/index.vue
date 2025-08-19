<template>
  <PageLayout>
    <span class="nistar-title fixed top-36 left-1/2 transform -translate-x-1/2 font-serif tracking-widest text-amber-300 text-4xl lg:text-5xl text-center">NISTAR</span>
    <Sparks />
    <h1 class="text-center">music is soul,</h1>
    <h1 class="text-center">soul is life</h1>
  </PageLayout>
</template>
<style scoped>
.nistar-title {
  opacity: 0;
  animation: floatUp 8s ease-in-out forwards;
  text-shadow:
      -1px -1px 0 rgba(139, 69, 19, 0.8),
      1px -1px 0 rgba(139, 69, 19, 0.8),
      -1px 1px 0 rgba(139, 69, 19, 0.8),
      1px 1px 0 rgba(139, 69, 19, 0.8),
      0 -2px 8px rgba(255, 140, 0, 0.4),
      0 0 3px rgba(255, 165, 0, 0.6),
      0 0 8px rgba(255, 140, 0, 0.5),
      0 0 20px rgba(255, 69, 0, 0.3),
      0 0 35px rgba(255, 69, 0, 0.2),
      0 3px 6px rgba(0, 0, 0, 0.7);
}

@keyframes floatUp {
  0% {
    opacity: 0;
    transform: translateZ(-300px) scale(0.3);
    filter: blur(5px) brightness(0.2);
  }
  30% {
    opacity: 0.4;
    transform: translateZ(-225px) scale(0.5);
    filter: blur(3px) brightness(0.4);
  }
  40% {
    opacity: 0.3;
    transform: translateZ(-250px) scale(0.5);
    filter: blur(4px) brightness(0.4);
  }
  60% {
    opacity: 0.7;
    transform: translateZ(-175px) scale(0.75);
    filter: blur(1px) brightness(0.7);
  }
  70% {
    opacity: 0.6;
    transform: translateZ(-225px) scale(0.75);
    filter: blur(2px) brightness(0.7);
  }
  80% {
    opacity: 0.9;
    transform: translateZ(-50px) scale(0.9);
    filter: blur(0) brightness(0.85);
  }
  100% {
    opacity: 1;
    transform: translateZ(0) scale(1);
    filter: blur(0) brightness(1);
  }
}
</style>
