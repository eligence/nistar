<template>
  <PageLayout :header="'listen'">
    <div class="flex flex-col justify-center items-center w-full gap-4 lg:gap-12 max-w-4xl mx-auto">
      <!-- Single Video -->
      <div class="w-full lg:w-4/5 xl:w-3/4">
        <YouTubeEmbed
          video-id="8vcHAquLtDY"
          title="NISTAR Performance"
          :params="'rel=0&modestbranding=1'"
        />
      </div>

      <!-- Playlist -->
      <div class="w-full lg:w-4/5 xl:w-3/4">
        <YouTubeEmbed
          video-id="PLW7giUR5NtXgXVdPU8ObvsjMuDNaHkyvk"
          :is-playlist="true"
          title="NISTAR Playlist"
          :params="'rel=0&modestbranding=1'"
        />
      </div>
    </div>

    <template #details>
      <p>Ary Baldioceda - drums</p>
      <p>Eli Jayson - keyboards and saxophone</p>
      <p>Chris Patsis - bass</p>
    </template>
  </PageLayout>
</template>
