<template>
  <div class="app-container">
    <!-- Video Display Section -->
    <div class="left-area" >
    <el-card class="video-card" shadow="hover">
    <div class="container video-container" >
      <div  class="video-display">
        <video
          v-if="selectedCamera"
          :id="'video' + selectedCamera.id"
          controls
          autoplay
          style="object-fit: fill; width: 100%; height: 100%"
        ></video>
      </div>
    </div>
  </el-card>
  <el-card class="table-card" shadow="hover">
  <div class="camera-selection-container">
    <!-- 相机选择项 -->
    <div
      v-for="(camera, index) in filledCameras"
      :key="index"
      class="camera-item"
      :class="{'empty-slot': !camera}"
    >
      <div v-if="camera" class="camera-info">
        <p>{{ camera.cameraName }}</p>
      </div>
      <div v-if="camera" class="camera-actions">
        <el-button
          v-hasPerm="['sys:camera:video']"
          type="primary"
          size="small"
          @click="startStreaming(camera)"
        >
          <i-ep-monitor /> 实时视频
        </el-button>
      </div>
    </div>
  </div>

    <!-- 分页控制和每页展示数量选择 -->
    <div class="right-area">
    <div class="pagination-controls">
      <el-select v-model="pageSize" placeholder="每页数量" @change="handleQuery">
        <el-option label="6" :value="6"></el-option>
        <el-option label="9" :value="9"></el-option>
        <el-option label="12" :value="12"></el-option>
        <el-option label="15" :value="15"></el-option>
      </el-select>
      <el-pagination
        v-if="totalCameras > 0"
        background
        layout="prev, pager, next"
        :page-size="pageSize"
        :current-page.sync="currentPage"
        :total="totalCameras"
        @current-change="handlePageChange"
      />
    </div>
  </div>
</el-card>
  <!-- <div class="camera-selection-container">
    <div
      v-for="(camera, index) in pageData"
      :key="camera.id"
      class="camera-item"
    >
      <div class="camera-info">
        <p>{{ camera.cameraName }}</p>
      </div>
      <div class="camera-actions">
        <el-button
          v-hasPerm="['sys:camera:video']"
          type="primary"
          size="small"
          @click="startStreaming(camera)"
        >
          <i-ep-monitor /> 实时视频
        </el-button>
      </div>
    </div>
  </div> -->

    <!-- Table Section -->
    <!-- <el-card class="table-card" shadow="hover"> -->
    <!-- <div class="container table-container">
      <el-table
        v-loading="loading"
        :data="pageData"
        @selection-change="handleSelectionChange"
        style="width: 100%"
      >
        <el-table-column type="selection" width="100" />
        <el-table-column
          prop="cameraName"
          label="Camera Name"
          width="400"
          align="center"
        />
        <el-table-column label="Actions" width="400" align="center">
          <template #default="scope">
            <el-button
              v-hasPerm="['sys:camera:video']"
              type="primary"
              size="small"
              @click="startStreaming(scope.row)"
            >
              <i-ep-monitor /> 实时视频
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination
        v-if="total > 0"
        v-model:total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="handleQuery"
      />
    </div> -->
  <!-- </el-card> -->

    <!-- Detection Result Video -->
    <!-- <div class="container detection-result-container">
      <div class="detection-result">
        <video
          v-if="detectionVideo"
          :src="detectionVideo"
          controls
          autoplay
          style="width: 100%; height: 100%; object-fit: cover"
        ></video>
      </div>
    </div> -->
    <!-- Detection Result Image -->
    <el-card class="detection-video-card" shadow="hover">
    <div class="container detection-result-container">
      <div class="detection-result">
        <img
          v-if="detectionImage"
          :src="detectionImage"
          alt="Detection Result"
          style="width: 100%; height: auto"
        />
      
      </div>
    </div>
    </el-card>

    <!-- Detection Button -->
    <div class="container detection-button-container" align="center">
      <el-button type="success" @click="startDetection" size="big">
        开始检测
      </el-button>
    </div>
  </div>
</div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, onBeforeUnmount } from "vue";
import CameraAPI, { CameraPageQuery, CameraPageVO } from "@/api/camera";
import DetectionAPI, { CameraForm } from "@/api/IRdetection";

const loading = ref(false);
const total = ref(0);
const pageData = ref<CameraPageVO[]>([]);
const selectedCamera = ref<CameraPageVO | null>(null);
const detectionVideo = ref<string | null>(null);
const detectionImage = ref<string | null>(null); // 用于存储检测结果的图像
const queryParams = reactive<CameraPageQuery>({
  pageNum: 1,
  pageSize: 20,
});
const webRtcServers = reactive<{ [key: string]: any }>({});
const cameraIp = "127.0.0.1:8000";
// const videoStreamUrl ="http://localhost:8080/api/v1/detection/video";
const totalCameras = ref(0); // 总相机数量
const currentPage = ref(1); // 当前页
const pageSize = ref(9); // 每页展示数量，默认为9

// 计算当前页显示的相机数据
const pagedCameras = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value;
  const end = start + pageSize.value;
  return pageData.value.slice(start, end);
});
function handleQuery() {
  CameraAPI.getPage({ pageNum: 1, pageSize: 100 }) // 获取相机数据
    .then((data) => {
      pageData.value = data.list;
      totalCameras.value = data.total; // 设置总数量
    });
}

// 处理分页切换
function handlePageChange(page: number) {
  currentPage.value = page;
}
// 计算当前页需要填充的空白格子数量
const filledCameras = computed(() => {
  const camerasOnPage = pagedCameras.value;
  const slotsNeeded = pageSize.value - camerasOnPage.length;
  return [...camerasOnPage, ...Array(slotsNeeded).fill(null)];
});
// Polling interval for detection result
const pollingInterval = ref(2000);
let detectionPolling: ReturnType<typeof setInterval> | null = null;

// function handleQuery() {
//   loading.value = true;
//   CameraAPI.getPage(queryParams)
//     .then((data) => {
//       pageData.value = data.list;
//       total.value = data.total;
//     })
//     .finally(() => {
//       loading.value = false;
//     });
// }

// function handleSelectionChange(selection: CameraPageVO[]) {
//   if (selection.length > 0) {
//     selectedCamera.value = selection[0];
//     startPolling(); // 选择相机时开始轮询
//   } else {
//     selectedCamera.value = null;
//     stopPolling(); // 如果没有选择相机，停止轮询
//   }
// }
// function startPolling() {
//   if (detectionPolling) return; // 防止重复启动
//   detectionPolling = setInterval(async () => {
//     const response : Response = await DetectionAPI.getDetectionResult();
//     detectionImage.value = response.url;
//     // if (response.ok) {
//     //   const blob = await response.blob(); // 使用 response.blob() 获取 Blob 数据
//     //   const reader = new FileReader();
//     //   reader.onloadend = () => {
//     //     detectionImage.value = reader.result as string; // 将 Blob 转换为 Base64 URL
//     //   };
//       reader.readAsDataURL(blob);
//     } else {
//       console.error('Failed to fetch detection result:', response);
//     }
//   }, pollingInterval.value);
// }

function stopPolling() {
  if (detectionPolling) {
    clearInterval(detectionPolling);
    detectionPolling = null;
    detectionImage.value = null; // 清除检测结果图像
  }
}

function startStreaming(camera: CameraPageVO) {
  selectedCamera.value = camera;
  // Stop other streams except the selected one
  stopAllStreamsExcept(camera.cameraRTSP);

  const videoId = "video" + camera.id;
  const videoElement = document.getElementById(videoId) as HTMLVideoElement;

  if (videoElement && !webRtcServers[camera.id]) {
    // Start streaming the video from the selected camera
    const webRtcServer = new window.WebRtcStreamer(
      videoId,
      `${location.protocol}//${cameraIp}`
    );
    webRtcServer.connect(camera.cameraRTSP);
    webRtcServers[camera.id] = webRtcServer;

    // videoElement.src = camera.cameraRTSP; // Use the RTSP URL directly
  }
}

function stopAllStreamsExcept(currentCameraId: string | undefined) {
  for (const key in webRtcServers) {
    if (key !== currentCameraId && webRtcServers[key]) {
      webRtcServers[key].disconnect();
      delete webRtcServers[key];
    }
  }
}

async function startDetection() {
  if (selectedCamera.value) {
    const detectionParams: CameraForm = {
      id: selectedCamera.value.id,
      cameraName: selectedCamera.value.cameraName,
      cameraRTSP: selectedCamera.value.cameraRTSP,
    };
    while (true) {
      const response = await DetectionAPI.startDetection(detectionParams);
      detectionImage.value = response.cameraRTSP;
      console.log("Detection started successfully");
    }
    // const response = await DetectionAPI.getDetectionResult();
    //
    // if (response.ok) {
    //   const blob = await response.blob();
    //   this.image = URL.createObjectURL(blob); // 将 Blob 转换为 URL
    //   console.log('Detection started successfully:', response);
    // } else {
    //   console.error('Failed to start detection:');
    // }
  }
}

onBeforeUnmount(() => {
  stopPolling();
});

onMounted(() => {
  handleQuery();
});
</script>

<style scoped>
.app-container {
  background-image: url('background.jpg');
  background-size: cover;
  background-position: center;
  min-height: 100vh; /* 保证内容不超出可视区域 */
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.el-card {
  width: 100%;
  max-width: 1000px;
  margin-bottom: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
.video-container {
  width: 100%;
  max-width: 1000px;
  height: 600px;
  margin: 20px 0;
  position: relative;
  background-image: url('video.jpg'); /* 替换为你的背景图片路径 */
  background-size: cover;
  background-position: center;
}
.video-display {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.table-container {
  width: 50%;
  max-width: 1000px;
  height: 400px;
  margin: 20px 0;
  position: relative;
}
.detection-result-container{
  width: 100%;
  max-width: 1000px;
  height: 600px;
  margin: 20px 0;
  position: relative;
  background-image: url('video.jpg'); /* 替换为你的背景图片路径 */
  background-size: cover;
  background-position: center;
}
.detection-button-container {
  width: 100%;
  max-width: 1000px;
  height: 60px;
  margin: 10px 0;
  position: relative;
  justify-content: center; /* 水平居中 */
}
.camera-selection-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  gap: 10px;
  max-width: 1000px;
  margin: 20px auto;
}

.camera-item {
  background-color: #f3f3f3;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  padding: 20px;
  width: calc(33.333% - 10px);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-height: 150px; /* 设置每个格子的最小高度 */
}

.empty-slot {
  background-color: transparent;
  box-shadow: none;
}

.camera-info {
  text-align: center;
  font-weight: bold;
}

.camera-actions {
  display: flex;
  justify-content: center;
  margin-top: 5px;
}

.pagination-controls {
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
  align-items: center;
}

.el-pagination {
  display: flex;
  justify-content: center;
}
</style>
