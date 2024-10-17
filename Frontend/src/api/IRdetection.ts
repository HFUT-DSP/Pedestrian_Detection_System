import request from "@/utils/request";

const DETECTION_BASE_URL = "/api/v1/IRdetection";

class DetectionAPI {
  static init(data: CameraForm) {
    return request<any, CameraForm>({
      url: `${DETECTION_BASE_URL}/init`, // Endpoint for starting detection
      method: "POST",
      data: data,
    });
  }
  /**
   * 开始检测
   * @detectionParams
   */
  static startDetection(data: CameraForm) {
    return request<any, CameraForm>({
      url: `${DETECTION_BASE_URL}/start`, // Endpoint for starting detection
      method: "POST",
      data: data,
    });
  }

  // /**
  //  * 获取检测结果图像
  //  * @returns Promise<Response>
  //  */
  // static getDetectionResult() {
  //   return request<Response, any>({
  //     url: `${DETECTION_BASE_URL}/result`, // Endpoint for getting detection result
  //     method: "GET",
  //     responseType: "blob", // Expecting a blob response for image
  //   });
  // }
}

export default DetectionAPI;

/** 设备表单类型 */
export interface CameraForm {
  /** 设备ID */
  id?: number;
  /** 设备状态(1:正常;0:禁用) */
  status?: number;
  /** 设备名 */
  cameraName?: string;
  /** 设备地址 */
  cameraRTSP?: string;
}
