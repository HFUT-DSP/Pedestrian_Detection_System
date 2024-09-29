<!-- <template>
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
          <img
            v-if="similarImageUrl"
            :src="similarImageUrl"
            alt="Similar Image"
          />
          <p v-else>最相似图像</p>
        </div>
      </div>

      <div class="result-placeholder">
        <h3>相关视频{{ cameraName ? `：拍摄自${cameraName}` : "" }}</h3>
        <div class="video-placeholder">
          <video v-if="videoUrl" :src="videoUrl" controls></video>
          <p v-else>相关视频</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import ImageAPI from "@/api/recognition"; // 引入定义好的接口

export default defineComponent({
  setup() {
    const imageUrl = ref<string | null>(null); // 上传的图片URL
    const imageFile = ref<File | null>(null); // 图片文件
    const similarImageUrl = ref<string | null>(null); // 最相似图片的URL
    const videoUrl = ref<string | null>(null); // 视频URL
    const cameraName = ref<string | null>(null); // 摄像机名称

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
        alert("请先上传图片！");
        return;
      }

      try {
        // 调用上传图片接口
        const response = await ImageAPI.upload(imageFile.value);
        similarImageUrl.value = response.similarImageUrl;
        videoUrl.value = response.videoUrl;
        cameraName.value = response.cameraName;
        console.log("Similar Image URL:", similarImageUrl.value);
      } catch (error) {
        console.error("识别检索时出错:", error);
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
</script> -->

<!-- <template>
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
          <img
            v-if="similarImageData"
            :src="similarImageData"
            alt="Similar Image"
          />
          <p v-else>最相似图像</p>
        </div>
      </div>

      <div class="result-placeholder">
        <h3>相关视频{{ cameraName ? `：拍摄自${cameraName}` : "" }}</h3>
        <div class="video-placeholder">
          <video
            v-if="videoData"
            :src="'data:video/mp4;base64,' + videoData"
            controls
          ></video>
          <p v-else>相关视频</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import ImageAPI from "@/api/recognition"; // 引入定义好的接口

export default defineComponent({
  setup() {
    const imageUrl = ref<string | null>(null); // 上传的图片URL
    const imageFile = ref<File | null>(null); // 图片文件
    const similarImageData = ref<string | null>(null); // 最相似图片的base64数据
    const videoData = ref<string | null>(null); // 视频base64数据
    const cameraName = ref<string | null>(null); // 摄像机名称

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
        alert("请先上传图片！");
        return;
      }

      try {
        // 调用上传图片接口
        const response = await ImageAPI.upload(imageFile.value);
        similarImageData.value = response.similarImageUrl;
        videoData.value = response.videoUrl;
        cameraName.value = response.cameraName;
        console.log("Similar Image Data:", similarImageData.value);
      } catch (error) {
        console.error("识别检索时出错:", error);
      }
    };

    return {
      imageUrl,
      similarImageData,
      videoData,
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
  background-color: #4caf50;
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

.image-placeholder,
.video-placeholder {
  width: 100%;
  height: 300px;
  border: 2px dashed #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f9f9f9;
}

.image-placeholder img,
.video-placeholder video {
  max-width: 100%;
  max-height: 100%;
}
</style> -->

<!-- <template>
  <div class="container">
    <div class="left-section">
      <div class="upload-section">
        <h3>上传检索图片</h3>
        <div class="placeholder">
          <img v-if="imageUrl" :src="imageUrl" alt="Uploaded Image" />
          <p v-else>上传图片预览</p>
        </div>
        <input type="file" @change="onFileChange" accept="image/*" />
        <button class="search-button" @click="search">识别检索</button>
      </div>
    </div>

    <div class="right-section">
      <div class="result-section">
        <div
          class="result-card"
          v-for="(image, index) in images"
          :key="index"
        >
          <div class="image-placeholder">
            <img :src="image" alt="Result Image" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script lang="ts">
import { defineComponent, ref } from "vue";
import ImageAPI from "@/api/recognition";

export default defineComponent({
  setup() {
    const imageUrl = ref<string | null>(null);
    const imageFile = ref<File | null>(null);
    const images = ref<string[]>(Array(10).fill(null)); // 用于存储最多10张图像

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
        alert("请先上传图片！");
        return;
      }

      try {
        // 调用上传图片接口并接收多张图像
        const response = await ImageAPI.upload(imageFile.value);
        images.value = response.images; // 假设后端返回的图像数组字段为 images
      } catch (error) {
        console.error("识别检索时出错:", error);
      }
    };

    return {
      imageUrl,
      images,
      onFileChange,
      search,
    };
  },
});
</script> -->
<template>
  <div class="container">
    <div class="left-section">
      <div class="upload-section">
        <h3>上传检索图片</h3>
        <div class="placeholder">
          <img v-if="imageUrl" :src="imageUrl" alt="Uploaded Image" />
          <p v-else>上传图片预览</p>
        </div>
        <input type="file" @change="onFileChange" accept="image/*" />
        <button class="search-button" @click="search">识别检索</button>
      </div>
    </div>

    <div class="right-section">
      <div class="result-section">
        <div class="result-card" v-for="(image, index) in images" :key="index">
          <div class="image-placeholder">
            <img :src="image" alt="检索结果" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import RecognitionAPI from "@/api/recognition";

export default defineComponent({
  setup() {
    const imageUrl = ref<string | null>(null);
    const imageFile = ref<File | null>(null);
    const images = ref<string[]>(Array(10).fill(null));

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
        alert("请先上传图片！");
        return;
      }

      try {
        const response = await RecognitionAPI.upload(imageFile.value);
        images.value = response;
        console.log(images.value);
      } catch (error) {
        console.error("识别检索时出错:", error);
      }
    };

    return {
      imageUrl,
      images,
      onFileChange,
      search,
    };
  },
});
</script>

<style scoped>
/* 背景及整体容器样式 */
/* 背景及整体容器样式 */
/* 背景及整体容器样式 */
.container {
  display: flex; /* 使用 flex 布局 */
  max-width: 90%; /* 增加宽度占比 */
  margin: 0 auto;
  padding: 20px;
  font-family: "Arial", sans-serif;
  background-color: #f0f4f8;
  background-image: linear-gradient(
      rgba(255, 255, 255, 0.8),
      rgba(255, 255, 255, 0.8)
    ),
    url("/path/to/background-image.png");
  background-size: cover;
  background-position: center;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* 左边上传部分 */
.left-section {
  flex: 1;
  margin-right: 20px;
}

.upload-section {
  background-color: rgba(255, 255, 255, 0.9);
  border: 1px solid #ddd;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
  text-align: center;
  width: 100%;
}

.placeholder {
  width: 100%;
  max-width: 300px; /* 上传图片框大小 */
  height: 400px;
  border: 2px dashed #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 20px auto;
  background-color: rgba(249, 249, 249, 0.9);
  border-radius: 12px;
}

.placeholder img {
  max-width: 100%;
  max-height: 100%;
  object-fit: cover;
  border-radius: 8px;
}

.search-button {
  padding: 12px 24px;
  background-image: linear-gradient(to right, #4facfe, #00f2fe);
  color: white;
  border: none;
  border-radius: 24px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.search-button:hover {
  background-image: linear-gradient(to right, #3b82f6, #00c3ff);
}

/* 右边显示检索结果 */
.right-section {
  flex: 2; /* 比例增加，分配更多空间 */
}

.result-section {
  display: grid;
  grid-template-columns: repeat(5, 1fr); /* 每行5列 */
  grid-gap: 20px;
  width: 100%;
  margin-top: 20px;
}

.result-card {
  background-color: rgba(255, 255, 255, 0.9);
  border: 1px solid #ddd;
  border-radius: 12px;
  padding: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  text-align: center;
}

.image-placeholder {
  width: 100%;
  height: 250px; /* 调整为适合的高度 */
  border: 2px dashed #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: rgba(249, 249, 249, 0.9);
  border-radius: 12px;
}

.image-placeholder img {
  max-width: 100%;
  max-height: 100%;
  object-fit: cover;
  border-radius: 8px;
}
</style>
