<template>
  <div class="youtube-embed">
    <lite-youtube
      :videoid="videoId"
      :playlist="isPlaylist"
      :params="params"
      :poster="poster"
      :title="title"
      @iframe-added="onIframeLoaded"
    />
  </div>
</template>

<script setup lang="ts">
import 'lite-youtube-embed/src/lite-yt-embed.css'
import LiteYoutube from 'lite-youtube-embed/src/lite-yt-embed.vue'

const props = defineProps({
  videoId: {
    type: String,
    required: true
  },
  isPlaylist: {
    type: Boolean,
    default: false
  },
  title: {
    type: String,
    default: 'YouTube video player'
  },
  poster: {
    type: String,
    default: 'hqdefault'
  },
  params: {
    type: String,
    default: 'rel=0&modestbranding=1'
  }
})

const onIframeLoaded = (iframe: HTMLIFrameElement) => {
  // Additional iframe setup if needed
  iframe.setAttribute('allowfullscreen', '')
}
</script>

<style scoped>
.youtube-embed {
  position: relative;
  width: 100%;
  aspect-ratio: 16/9;
  overflow: hidden;
  border-radius: 8px;
  box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
}

:deep(.yt-lite) {
  background-color: #000;
  position: relative;
  display: block;
  contain: content;
  background-position: center center;
  background-size: cover;
  cursor: pointer;
  width: 100%;
  height: 100%;
}

:deep(.lty-playbtn) {
  width: 68px;
  height: 48px;
  background-color: #212121;
  z-index: 1;
  opacity: 0.8;
  border-radius: 24px;
  transition: all 0.2s cubic-bezier(0, 0, 0.2, 1);
  border: 0;
}

:deep(.yt-lite:hover > .lty-playbtn) {
  background-color: #f00;
  opacity: 1;
}
</style>
