<template>
  <div class="container">
    <div class="upload-section">
      <h3>上传检索图片</h3>
      <div class="placeholder">
        <img v-if="imageUrl" :src="imageUrl" alt="Uploaded Image" />
        <p v-else>上传图片预览</p>
      </div>
      <input type="file" @change="onFileChange" accept="image/*" />
    </div>

    <button class="search-button" @click="search">识别检索</button>

    <div class="result-section">
      <div class="result-placeholder">
        <h3>最相似图像</h3>
        <div class="image-placeholder">
          <img v-if="similarImageUrl" :src="similarImageUrl" alt="Similar Image" />
          <p v-else>最相似图像</p>
        </div>
      </div>

      <div class="result-placeholder">
        <h3>相关视频{{ cameraName ? `：拍摄自${cameraName}` : '' }}</h3>
        <div class="video-placeholder">
          <video v-if="videoUrl" :src="videoUrl" controls />
          <p v-else>相关视频</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import { uploadImage } from '@/api/recognition'; // 引入定义好的接口

export default defineComponent({
  setup() {
    const imageUrl = ref<string | null>(null);  // 上传的图片URL
    const imageFile = ref<File | null>(null);   // 图片文件
    const similarImageUrl = ref<string | null>(null);  // 最相似图片的URL
    const videoUrl = ref<string | null>(null);  // 视频URL
    const cameraName = ref<string | null>(null);  // 摄像机名称

    const onFileChange = (event: Event) => {
      const input = event.target as HTMLInputElement;
      const file = input.files ? input.files[0] : null;
      if (file) {
        imageUrl.value = URL.createObjectURL(file);
        imageFile.value = file;
      }
    };

    const search = async () => {
      if (!imageFile.value) {
        alert('请先上传图片！');
        return;
      }

      try {
        // 调用上传图片接口
        const response = await uploadImage(imageFile.value);
        similarImageUrl.value = response.data.similarImageUrl;
        videoUrl.value = response.data.videoUrl;
        cameraName.value = response.data.cameraName;
      } catch (error) {
        console.error('识别检索时出错:', error);
      }
    };

    return {
      imageUrl,
      similarImageUrl,
      videoUrl,
      cameraName,
      onFileChange,
      search,
    };
  },
});
</script>

<style scoped>
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.upload-section {
  margin-bottom: 20px;
}

.placeholder {
  width: 300px;
  height: 300px;
  border: 2px dashed #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 10px;
  background-color: #f9f9f9;
}

.placeholder img {
  max-width: 100%;
  max-height: 100%;
}

.search-button {
  padding: 10px 20px;
  background-color: #4CAF50;
  color: white;
  border: none;
  cursor: pointer;
}

.search-button:hover {
  background-color: #45a049;
}

.result-section {
  display: flex;
  justify-content: space-between;
  width: 100%;
  max-width: 800px;
  margin-top: 20px;
}

.result-placeholder {
  width: 48%;
}

.image-placeholder, .video-placeholder {
  width: 100%;
  height: 300px;
  border: 2px dashed #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f9f9f9;
}

.image-placeholder img, .video-placeholder video {
  max-width: 100%;
  max-height: 100%;
}
</style>
