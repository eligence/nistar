<template>
  <svg viewBox="0 0 400 600" xmlns="http://www.w3.org/2000/svg" style="background: transparent;">
    <!-- Connecting paths -->
    <g stroke="white" stroke-width="3" fill="none" opacity="0.8">
      <!-- From Keter to Chokmah and Binah -->
      <line x1="200" y1="80" x2="120" y2="160" />
      <line x1="200" y1="80" x2="280" y2="160" />

      <!-- From Keter to Tiferet -->
      <line x1="200" y1="80" x2="200" y2="300" />

      <!-- Between Chokmah and Binah -->
      <line x1="120" y1="160" x2="280" y2="160" />

      <!-- From Chokmah to Chesed -->
      <line x1="120" y1="160" x2="120" y2="240" />

      <!-- From Binah to Geburah -->
      <line x1="280" y1="160" x2="280" y2="240" />

      <!-- From Chokmah and Binah to Tiferet -->
      <line x1="120" y1="160" x2="200" y2="300" />
      <line x1="280" y1="160" x2="200" y2="300" />

      <!-- From Chesed and Geburah to Tiferet -->
      <line x1="120" y1="240" x2="200" y2="300" />
      <line x1="280" y1="240" x2="200" y2="300" />

      <!-- Between Chesed and Geburah -->
      <line x1="120" y1="240" x2="280" y2="240" />

      <!-- From Chesed to Netzach -->
      <line x1="120" y1="240" x2="120" y2="400" />

      <!-- From Geburah to Hod -->
      <line x1="280" y1="240" x2="280" y2="400" />

      <!-- From Tiferet to Netzach and Hod -->
      <line x1="200" y1="300" x2="120" y2="400" />
      <line x1="200" y1="300" x2="280" y2="400" />

      <!-- From Tiferet to Yesod -->
      <line x1="200" y1="300" x2="200" y2="480" />

      <!-- Between Netzach and Hod -->
      <line x1="120" y1="400" x2="280" y2="400" />

      <!-- From Netzach and Hod to Yesod -->
      <line x1="120" y1="400" x2="200" y2="480" />
      <line x1="280" y1="400" x2="200" y2="480" />

      <!-- From Yesod to Malkuth -->
      <line x1="200" y1="480" x2="200" y2="560" />

      <!-- Cross connections (additional paths) -->
      <line x1="120" y1="240" x2="280" y2="400" />
      <line x1="280" y1="240" x2="120" y2="400" />
    </g>

    <!-- Sephirot circles with matching colors -->

    <!-- Keter (Crown) - Light blue/white -->
    <circle cx="200" cy="80" r="25" fill="#E6F3FF" fill-opacity="0.3" stroke="#4A90E2" stroke-width="3"/>

    <!-- Chokmah (Wisdom) - Gray -->
    <circle cx="120" cy="160" r="22" fill="#D3D3D3" fill-opacity="0.3" stroke="#808080" stroke-width="3"/>

    <!-- Binah (Understanding) - Dark blue/black -->
    <circle cx="280" cy="160" r="22" fill="#1E1E2E" fill-opacity="0.3" stroke="#2C3E50" stroke-width="3"/>

    <!-- Chesed (Mercy) - Blue -->
    <circle cx="120" cy="240" r="22" fill="#4A90E2" fill-opacity="0.3" stroke="#2E5B8A" stroke-width="3"/>

    <!-- Geburah (Severity) - Red -->
    <circle cx="280" cy="240" r="22" fill="#E74C3C" fill-opacity="0.3" stroke="#C0392B" stroke-width="3"/>

    <!-- Tiferet (Beauty) - Yellow/Gold -->
    <circle cx="200" cy="300" r="25" fill="#F1C40F" fill-opacity="0.3" stroke="#D4AC0D" stroke-width="3"/>

    <!-- Netzach (Victory) - Green -->
    <circle cx="120" cy="400" r="22" fill="#27AE60" fill-opacity="0.3" stroke="#1E8449" stroke-width="3"/>

    <!-- Hod (Splendor) - Orange -->
    <circle cx="280" cy="400" r="22" fill="#E67E22" fill-opacity="0.3" stroke="#CA6F1E" stroke-width="3"/>

    <!-- Yesod (Foundation) - Purple -->
    <circle cx="200" cy="480" r="22" fill="#8E44AD" fill-opacity="0.3" stroke="#6C3483" stroke-width="3"/>

    <!-- Malkuth (Kingdom) - Brown/Earth tones -->
    <circle cx="200" cy="560" r="25" fill="#8B4513" fill-opacity="0.3" stroke="#5D2F0A" stroke-width="3"/>
  </svg>
</template>

<script setup lang="ts">

</script>

<style scoped>

</style>
