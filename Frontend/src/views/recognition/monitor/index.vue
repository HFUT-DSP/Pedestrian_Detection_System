<template>
  <div>
    <video
      ref="videoPlayer"
      class="video-js vjs-default-skin"
      controls
      preload="auto"
      width="600"
      height="400"
    >
      <source :src="videoUrl" type="application/x-mpegURL" />
    </video>
  </div>
</template>

<script>
import videojs from "video.js";
import "video.js/dist/video-js.css";

export default {
  data() {
    return {
      videoUrl: "http://localhost:8989/video-stream", // 确保后端提供的HLS地址正确
    };
  },
  mounted() {
    this.player = videojs(this.$refs.videoPlayer, {
      autoplay: true,
      controls: true,
    });
  },
  beforeUnmount() {
    if (this.player) {
      this.player.dispose();
    }
  },
};
</script>

<style scoped>
.video-js {
  width: 100%;
  height: auto;
}
</style>
