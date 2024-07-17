<!-- 设备管理 -->
<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!-- 设备列表 -->
      <el-col :lg="24" :xs="24">
        <div class="search-container">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="关键字" prop="keywords">
              <el-input
                v-model="queryParams.keywords"
                placeholder="设备名"
                clearable
                style="width: 200px"
                @keyup.enter="handleQuery"
              />
            </el-form-item>

            <el-form-item label="状态" prop="status">
              <el-select
                v-model="queryParams.status"
                placeholder="全部"
                clearable
                class="!w-[100px]"
              >
                <el-option label="启用" value="1" />
                <el-option label="禁用" value="0" />
              </el-select>
            </el-form-item>

            <el-form-item label="创建时间">
              <el-date-picker
                class="!w-[240px]"
                v-model="dateTimeRange"
                type="daterange"
                range-separator="~"
                start-placeholder="开始时间"
                end-placeholder="截止时间"
                value-format="YYYY-MM-DD"
              />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="handleQuery"
                ><i-ep-search />搜索</el-button
              >
              <el-button @click="handleResetQuery">
                <i-ep-refresh />
                重置</el-button
              >
            </el-form-item>
          </el-form>
        </div>

        <el-card shadow="never" class="table-container">
          <template #header>
            <div class="flex-x-between">
              <div>
                <el-button
                  v-hasPerm="['sys:camera:add']"
                  type="success"
                  @click="handleOpenDialog()"
                  ><i-ep-plus />新增</el-button
                >
                <el-button
                  v-hasPerm="['sys:camera:delete']"
                  type="danger"
                  :disabled="removeIds.length === 0"
                  @click="handleDelete()"
                  ><i-ep-delete />删除</el-button
                >
              </div>
            </div>
          </template>

          <el-table
            v-loading="loading"
            :data="pageData"
            @selection-change="handleSelectionChange"
          >
            <el-table-column type="selection" width="50" align="center" />
            <el-table-column
              key="id"
              label="编号"
              align="center"
              prop="id"
              width="100"
            />
            <el-table-column
              key="cameraName"
              label="设备名"
              align="center"
              prop="cameraName"
            />
            <el-table-column
              label="设备地址"
              width="200"
              align="center"
              prop="cameraRTSP"
            />

            <el-table-column label="状态" align="center" prop="status">
              <template #default="scope">
                <el-tag :type="scope.row.status == 1 ? 'success' : 'info'">{{
                  scope.row.status == 1 ? "启用" : "禁用"
                }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column
              label="创建时间"
              align="center"
              prop="createTime"
              width="180"
            />
            <el-table-column label="操作" fixed="right" width="220">
              <template #default="scope">
                <el-button
                  v-hasPerm="['sys:camera:video']"
                  type="primary"
                  size="small"
                  link
                  @click="realTimeMonitoring(scope.row)"
                  ><i-ep-monitor />实时监控</el-button
                >
                <el-button
                  v-hasPerm="['sys:camera:edit']"
                  type="primary"
                  link
                  size="small"
                  @click="handleOpenDialog(scope.row.id)"
                  ><i-ep-edit />编辑</el-button
                >
                <el-button
                  v-hasPerm="['sys:camera:delete']"
                  type="danger"
                  link
                  size="small"
                  @click="handleDelete(scope.row.id)"
                  ><i-ep-delete />删除</el-button
                >
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
        </el-card>
      </el-col>
    </el-row>

    <!-- 设备表单弹窗 -->
    <el-drawer
      v-model="dialog.visible"
      :title="dialog.title"
      append-to-body
      @close="handleCloseDialog"
    >
      <!-- 设备新增/编辑表单 -->
      <el-form
        ref="cameraFormRef"
        :model="formData"
        :rules="rules"
        label-width="80px"
      >
        <el-form-item label="设备名" prop="cameraName">
          <el-input
            v-model="formData.cameraName"
            :readonly="!!formData.id"
            placeholder="请输入设备名"
          />
        </el-form-item>

        <el-form-item label="设备地址" prop="cameraRTSP">
          <el-input
            v-model="formData.cameraRTSP"
            placeholder="请输入设备地址"
          />
        </el-form-item>

        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="formData.status">
            <el-radio :label="1">正常</el-radio>
            <el-radio :label="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>

      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="handleSubmit">确 定</el-button>
          <el-button @click="handleCloseDialog">取 消</el-button>
        </div>
      </template>
    </el-drawer>
  </div>
</template>

<script setup lang="ts">
defineOptions({
  name: "Camera",
  inheritAttrs: false,
});

import CameraAPI, {
  CameraForm,
  CameraPageQuery,
  CameraPageVO,
} from "@/api/camera";

const queryFormRef = ref(ElForm);
const cameraFormRef = ref(ElForm);

const loading = ref(false);
const removeIds = ref([]);
const total = ref(0);
const pageData = ref<CameraPageVO[]>();
/** 设备查询参数  */
const queryParams = reactive<CameraPageQuery>({
  pageNum: 1,
  pageSize: 10,
});

const dateTimeRange = ref("");
watch(dateTimeRange, (newVal) => {
  if (newVal) {
    queryParams.startTime = newVal[0];
    queryParams.endTime = newVal[1];
  } else {
    queryParams.startTime = undefined;
    queryParams.endTime = undefined;
  }
});

/**  设备弹窗对象  */
const dialog = reactive({
  visible: false,
  title: "",
});

/** 导入弹窗显示状态 */
const importDialogVisible = ref(false);

// 设备表单数据
const formData = reactive<CameraForm>({
  status: 1,
});

/** 设备表单校验规则  */
const rules = reactive({
  cameraName: [{ required: true, message: "设备名不能为空", trigger: "blur" }],
});

/** 查询 */
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

/** 重置查询 */
function handleResetQuery() {
  queryFormRef.value.resetFields();
  dateTimeRange.value = "";
  queryParams.pageNum = 1;
  // queryParams.deptId = undefined;
  queryParams.startTime = undefined;
  queryParams.endTime = undefined;
  handleQuery();
}

/** 行复选框选中记录选中ID集合 */
function handleSelectionChange(selection: any) {
  removeIds.value = selection.map((item: any) => item.id);
}

/** 实时监控 */
function realTimeMonitoring(row: { [key: string]: any }) {

}

/**
 * 打开弹窗
 *
 * @param cameraId 设备ID
 */
async function handleOpenDialog(cameraId?: number) {
  dialog.visible = true;
  loading.value = true; // 开始加载状态
  try {
    if (cameraId) {
      dialog.title = "修改设备";
      const data = await CameraAPI.getFormData(cameraId);
      if (data) {
        Object.assign(formData, data); // 更新formData
      } else {
        ElMessage.error("获取设备详情失败:未找到设备数据");
      }
    } else {
      dialog.title = "新增设备";
      // 清空或重置formData
      formData.id = undefined;
      formData.cameraName = "";
      formData.cameraRTSP = "";
      formData.status = 1;
    }
  } catch (error) {
    console.error("Error fetching device data:", error);
    ElMessage.error("获取设备详情失败：" + error.message);
  } finally {
    loading.value = false; // 结束加载状态
  }
}

/** 关闭弹窗 */
function handleCloseDialog() {
  dialog.visible = false;
  cameraFormRef.value.resetFields();
  cameraFormRef.value.clearValidate();

  formData.id = undefined;
  formData.status = 1;
}

/** 表单提交 */
const handleSubmit = useThrottleFn(() => {
  cameraFormRef.value.validate((valid: any) => {
    if (valid) {
      const cameraId = formData.id;
      loading.value = true;
      if (cameraId) {
        CameraAPI.update(cameraId, formData)
          .then(() => {
            ElMessage.success("修改设备成功");
            handleCloseDialog();
            handleResetQuery();
          })
          .finally(() => (loading.value = false));
      } else {
        CameraAPI.add(formData)
          .then(() => {
            ElMessage.success("新增设备成功");
            handleCloseDialog();
            handleResetQuery();
          })
          .finally(() => (loading.value = false));
      }
    }
  });
}, 3000);

/** 删除设备 */
function handleDelete(id?: number) {
  const cameraIds = [id || removeIds.value].join(",");
  if (!cameraIds) {
    ElMessage.warning("请勾选删除项");
    return;
  }

  ElMessageBox.confirm("确认删除设备?", "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  }).then(
    function () {
      loading.value = true;
      CameraAPI.deleteByIds(cameraIds)
        .then(() => {
          ElMessage.success("删除成功");
          handleResetQuery();
        })
        .finally(() => (loading.value = false));
    },
    function () {
      ElMessage.info("已取消删除");
    }
  );
}
/** 打开导入弹窗 */
function handleOpenImportDialog() {
  importDialogVisible.value = true;
}
onMounted(() => {
  handleQuery();
});
</script>
