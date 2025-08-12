<template>
  <!-- Floating Circles Background -->
  <div class="fixed inset-0 -z-10 overflow-hidden pointer-events-none">
    <!-- Large background circles -->
    <div 
      v-for="i in 5" 
      :key="'circle-bg-' + i"
      class="absolute rounded-full bg-gradient-to-br from-primary/5 to-primary/20"
      :class="getRandomPosition()"
      :style="{
        width: `${getRandomSize(200, 500)}px`,
        height: `${getRandomSize(200, 500)}px`,
        opacity: getRandomOpacity(0.1, 0.3),
        filter: 'blur(60px)'
      }"
    />
    
    <!-- Small animated dots -->
    <div 
      v-for="i in 20" 
      :key="'dot-' + i"
      class="absolute rounded-full bg-primary/30"
      :class="getRandomPosition()"
      :style="{
        width: `${getRandomSize(2, 6)}px`,
        height: `${getRandomSize(2, 6)}px`,
        animation: `pulse ${getRandomDuration(4, 8)}s infinite alternate`,
        animationDelay: `${getRandomDelay(0, 5)}s`
      }"
    />
    
    <!-- Subtle grid pattern -->
    <div class="absolute inset-0" style="background-image: radial-gradient(circle at 1px 1px, rgba(255,255,255,0.05) 1px, transparent 0); background-size: 40px 40px;"></div>
  </div>
  
  <!-- Hebrew letter particles -->
  <div class="fixed inset-0 -z-10 overflow-hidden pointer-events-none mix-blend-overlay">
    <span 
      v-for="(letter, i) in hebrewLetters"
      :key="'letter-' + i"
      class="absolute text-primary/20 font-hebrew text-2xl md:text-4xl select-none"
      :class="getRandomPosition()"
      :style="{
        transform: `rotate(${getRandomRotation()}deg)`,
        opacity: getRandomOpacity(0.1, 0.3),
        animation: `float ${getRandomDuration(15, 30)}s infinite ease-in-out`,
        animationDelay: `${getRandomDelay(0, 10)}s`
      }"
    >
      {{ letter }}
    </span>
  </div>
  
  <!-- Subtle corner decorations -->
  <div class="fixed top-0 left-0 w-32 h-32 border-t-2 border-l-2 border-primary/20 pointer-events-none"></div>
  <div class="fixed top-0 right-0 w-32 h-32 border-t-2 border-r-2 border-primary/20 pointer-events-none"></div>
  <div class="fixed bottom-0 left-0 w-32 h-32 border-b-2 border-l-2 border-primary/20 pointer-events-none"></div>
  <div class="fixed bottom-0 right-0 w-32 h-32 border-b-2 border-r-2 border-primary/20 pointer-events-none"></div>
</template>

<script setup>
// Hebrew letters with Kabbalistic significance
const hebrewLetters = [
  'א', 'ב', 'ג', 'ד', 'ה', 'ו', 'ז', 'ח', 'ט', 'י',
  'כ', 'ל', 'מ', 'נ', 'ס', 'ע', 'פ', 'צ', 'ק', 'ר',
  'ש', 'ת', 'ך', 'ם', 'ן', 'ף', 'ץ', '׃', '״', '׳'
];

// Helper functions
const getRandomPosition = () => {
  const positions = [
    'top-1/4 left-1/4',
    'top-1/3 right-1/3',
    'bottom-1/4 left-1/3',
    'top-2/3 right-1/4',
    'top-1/2 left-1/2',
    'top-1/4 right-1/4',
    'bottom-1/3 left-1/3',
    'top-2/3 left-1/4',
    'bottom-1/2 right-1/2',
  ];
  return positions[Math.floor(Math.random() * positions.length)];
};

const getRandomSize = (min, max) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

const getRandomOpacity = (min, max) => {
  return (Math.random() * (max - min) + min).toFixed(2);
};

const getRandomDuration = (min, max) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

const getRandomDelay = (min, max) => {
  return Math.random() * (max - min) + min;
};

const getRandomRotation = () => {
  return Math.floor(Math.random() * 360);
};
</script>

<style scoped>
@keyframes float {
  0%, 100% { 
    transform: translateY(0) rotate(0deg);
  }
  50% { 
    transform: translateY(-20px) rotate(5deg);
  }
}

@keyframes pulse {
  0% { 
    opacity: 0.2; 
    transform: scale(1);
  }
  100% { 
    opacity: 0.6; 
    transform: scale(1.5);
  }
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .fixed {
    display: none; /* Hide decorative elements on mobile for better performance */
  }
}
</style>
