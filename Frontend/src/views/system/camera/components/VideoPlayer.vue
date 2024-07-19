<template>
  <div class="video-container">
    <video ref="videoElement" controls autoplay class="video-player"></video>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from "vue";

const props = defineProps<{
  type: "video/flv";
  videoUrl: string;
}>();

const videoElement = ref<HTMLVideoElement | null>(null);

watch(
  () => props.videoUrl,
  (newUrl) => {
    if (videoElement.value) {
      videoElement.value.src = newUrl;
      videoElement.value.play().catch((error) => {
        console.error("Error playing video:", error);
      });
    }
  },
  { immediate: true }
);

onMounted(() => {
  if (videoElement.value && props.videoUrl) {
    videoElement.value.src = props.videoUrl;
    videoElement.value.play().catch((error) => {
      console.error("Error playing video:", error);
    });
  }
});
</script>

<style scoped>
.video-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}

.video-player {
  width: 100%;
  height: 100%;
}
</style>
