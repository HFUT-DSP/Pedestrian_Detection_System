<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="24">
        <el-card shadow="never" class="table-container">
          <el-row class="video-grid">
            <el-col :span="6" v-for="camera in pageData" :key="camera.id">
              <div class="video-cell">
                <el-table
                  v-loading="loading"
                  :data="[camera]"
                  @selection-change="handleSelectionChange"
                >
                  <el-table-column type="selection" width="50" align="center" />
                  <el-table-column v-bind:label="camera.cameraName" fixed="right" width="480" align="center">
                    <template #default="scope">
                      <el-button
                        v-hasPerm="['sys:camera:video']"
                        type="primary"
                        size="small"
                        link
                        @click="startStreaming(scope.row)"
                      >
                        <i-ep-monitor /> 实时监控
                      </el-button>
                      <video
                        :id="'video' + scope.row.id"
                        controls
                        autoplay
                        mute
                        style="object-fit: fill"
                      ></video>
                    </template>
                  </el-table-column>
                </el-table>
              </div>
            </el-col>
          </el-row>

          <pagination
            v-if="total > 0"
            v-model:total="total"
            v-model:page="queryParams.pageNum"
            v-model:limit="queryParams.pageSize"
            @pagination="handleQuery"
          />
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
defineOptions({
  name: "Camera",
  inheritAttrs: false,
});

import { ref, reactive, onMounted, onBeforeUnmount } from "vue";
import { ElForm, ElMessage, ElMessageBox } from "element-plus";
import { useThrottleFn } from "@vueuse/core";
import CameraAPI, { CameraForm, CameraPageQuery, CameraPageVO } from "@/api/camera";

const videoElements = reactive<{ [key: string]: HTMLVideoElement }>({});
const webRtcServers = reactive<{ [key: string]: any }>({});
const cameraIp = "127.0.0.1:8000";
const dialogVisible = ref(false);
const queryFormRef = ref<InstanceType<typeof ElForm>>();
const cameraFormRef = ref<InstanceType<typeof ElForm>>();
const loading = ref(false);
const removeIds = ref<number[]>([]);
const total = ref(0);
const pageData = ref<CameraPageVO[]>([]);
const queryParams = reactive<CameraPageQuery>({
  pageNum: 1,
  pageSize: 10,
});
const dateTimeRange = ref<string | null>("");

watch(dateTimeRange, (newVal) => {
  if (newVal) {
    queryParams.startTime = newVal[0];
    queryParams.endTime = newVal[1];
  } else {
    queryParams.startTime = undefined;
    queryParams.endTime = undefined;
  }
});

const dialog = reactive({
  visible: false,
  title: "",
});

const formData = reactive<CameraForm>({
  status: 1,
});

const rules = reactive({
  cameraName: [{ required: true, message: "设备名不能为空", trigger: "blur" }],
});

function handleQuery() {
  loading.value = true;
  CameraAPI.getPage(queryParams)
    .then((data) => {
      console.log("handleQuery", data);
      pageData.value = data.list;
      total.value = data.total;
    })
    .finally(() => {
      loading.value = false;
    });
}

function handleResetQuery() {
  queryFormRef.value?.resetFields();
  dateTimeRange.value = "";
  queryParams.pageNum = 1;
  queryParams.startTime = undefined;
  queryParams.endTime = undefined;
  handleQuery();
}

function handleSelectionChange(selection: CameraPageVO[]) {
  removeIds.value = selection.map(item => item.id);
}

function startStreaming(row: CameraPageVO) {
  const videoId = 'video' + row.id;
  if (!webRtcServers[row.id]) {
    const videoElement = document.getElementById(videoId) as HTMLVideoElement;
    if (videoElement) {
      const webRtcServer = new window.WebRtcStreamer(videoId, location.protocol + "//" + cameraIp);
      webRtcServer.connect(row.cameraRTSP);
      webRtcServers[row.id] = webRtcServer;
    }
  }
}

onBeforeUnmount(() => {
  for (const key in webRtcServers) {
    if (webRtcServers[key]) {
      webRtcServers[key].disconnect();
      delete webRtcServers[key];
    }
  }
});
function handleOpenImportDialog() {
  importDialogVisible.value = true;
}

onMounted(() => {
  handleQuery();
});
</script>
<style scoped>
.video-grid {
  display: flex;
  flex-wrap: wrap;
}

.video-cell {
  margin-bottom: 20px; /* 控制格子之间的间距 */
  height: 400px; /* 设置每个视频格子的高度 */
}

/* 调整视频元素样式 */
.video-cell video {
  width: 550px; /* 宽度占满格子 */
  height: 300px; /* 高度占满格子 */
  object-fit: fill; /* 填充整个视频元素 */
}
</style>
