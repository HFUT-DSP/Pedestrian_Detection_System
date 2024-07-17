<template>
  <div style="padding: 30px">
    <el-link
      href="https://gitee.com/youlaiorg/vue3-element-admin/blob/master/src/views/demo/multi-level/level1.vue"
      type="primary"
      target="_blank"
      class="mb-10"
      >示例源码 请点击>>>></el-link
    >

    <el-alert :closable="false" title="菜单一级">
      <router-view />
    </el-alert>
  </div>
</template>
<!-- <template>
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
      videoUrl: "http://localhost:8989/stream.m3u8", // 确保后端提供的HLS地址正确
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
</style> -->
