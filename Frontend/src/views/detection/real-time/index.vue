<template>
  <div class="app-container">
    <!-- Video Display Section -->
    <div class="container video-container">
      <div class="video-display">
        <video
          v-if="selectedCamera"
          :id="'video' + selectedCamera.id"
          controls
          autoplay
          style="object-fit: fill; width: 100%; height: 100%"
        ></video>
      </div>
    </div>

    <!-- Table Section -->
    <div class="container table-container">
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
    </div>

    <!-- Detection Result Video -->
    <div class="container detection-result-container">
      <div class="detection-result">
        <video
          v-if="detectionVideo"
          :src="detectionVideo"
          controls
          autoplay
          style="width: 100%; height: 100%; object-fit: cover"
        ></video>

        <!--        <video-->
        <!--          v-else-if="selectedCamera"-->
        <!--          :id="'video' + selectedCamera.id"-->
        <!--          controls-->
        <!--          autoplay-->
        <!--          style="width: 100%; height: 100%; object-fit: cover;"-->
        <!--        ></video>-->
        <p v-else>No detection result available</p>
      </div>
    </div>
    <!-- Detection Result Image -->
    <div class="container detection-result-container">
      <div class="detection-result">
        <img
          v-if="detectionImage"
          :src="detectionImage"
          alt="Detection Result"
          style="width: 100%; height: auto"
        />
        <p v-else>No detection result available</p>
      </div>
    </div>

    <!-- Detection Button -->
    <div class="container detection-button-container" align="center">
      <el-button type="success" @click="startDetection" size="big">
        开始检测
      </el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, onBeforeUnmount } from "vue";
import CameraAPI, { CameraPageQuery, CameraPageVO } from "@/api/camera";
import DetectionAPI, { CameraForm } from "@/api/detection";

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

// Polling interval for detection result
const pollingInterval = ref(2000);
let detectionPolling: ReturnType<typeof setInterval> | null = null;

function handleQuery() {
  loading.value = true;
  CameraAPI.getPage(queryParams)
    .then((data) => {
      pageData.value = data.list;
      total.value = data.total;
    })
    .finally(() => {
      loading.value = false;
    });
}

function handleSelectionChange(selection: CameraPageVO[]) {
  if (selection.length > 0) {
    selectedCamera.value = selection[0];
    startPolling(); // 选择相机时开始轮询
  } else {
    selectedCamera.value = null;
    stopPolling(); // 如果没有选择相机，停止轮询
  }
}
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
.video-container,
.table-container,
.detection-result-container,
.detection-button-container {
  margin: 20px 0;
}
</style>
