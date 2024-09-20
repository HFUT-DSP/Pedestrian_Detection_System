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
        <h3>相关视频：拍摄自{{ cameraName }}</h3> <!-- 显示CameraName -->
        <div class="video-placeholder">
          <video v-if="videoUrl" :src="videoUrl" controls />
          <p v-else>相关视频</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      imageUrl: '', // 上传图片的URL
      imageFile: null, // 存储上传的图片文件
      similarImageUrl: '', // 后端返回的最相似图片的URL
      videoUrl: '', // 后端返回的视频资源的URL
      cameraName: '', // 从后端返回的CameraName
    };
  },
  methods: {
    onFileChange(event) {
      const file = event.target.files[0];
      if (file) {
        this.imageUrl = URL.createObjectURL(file);
        this.imageFile = file; // 保存上传的图片文件
      }
    },
    async search() {
      if (!this.imageFile) {
        alert("请先上传图片！");
      } else {
        const formData = new FormData();
        formData.append('file', this.imageFile);

        try {
          // 发送图片到后端
          const response = await axios.post("/dev-api/api/v1/retrieval", formData, {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          });
          // 处理后端返回的图像和视频URL及CameraName
          const responseData = response.data.data; // 解包数据
          this.similarImageUrl = responseData.similarImageUrl; // 后端返回的图片URL
          this.videoUrl = responseData.videoUrl; // 后端返回的视频URL
          this.cameraName = responseData.cameraName; // 后端返回的摄像机名称
          console.log("最相似图像地址: ", this.similarImageUrl);
          console.log("视频地址: ", this.videoUrl);
          console.log("摄像头名称: ", this.cameraName);
        } catch (error) {
          console.error('Error during image recognition:', error);
        }
      }
    },
  },
};
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
