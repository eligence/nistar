<template>
  <LayoutMain :header="'contact'">
    <template #details>
      <div class="flex flex-col gap-8 min-w-full text-center">
        <h3 class="mb-12 text-center">Eli Jayson</h3>
        <p><a href="mailto:eligence@gmail.com">eligence@gmail.com</a></p>
        <p><a href="tel:3864513843">386 451 3843</a></p>
        <p><a href="https://www.instagram.com/nistar_band/">instagram</a></p>
      </div>
    </template>
  </LayoutMain>
</template>
<script setup lang="ts">
useHead({
  title: 'Contact Nistar - Booking & Inquiries',
  meta: [
    {
      name: 'description',
      content: 'Contact Nistar for booking inquiries, collaborations, or just to say hello. We\'d love to hear from you!'
    }
  ]
});
</script>
