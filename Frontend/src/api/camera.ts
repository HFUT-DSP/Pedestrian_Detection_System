import request from "@/utils/request";

const CAMERA_BASE_URL = "/api/v1/cameras";
const FLV_BASE_URL = "/api/v1/flv";
class CameraAPI {
  /**
   * 获取设备分页列表
   *
   * @param queryParams 查询参数
   */
  static getPage(queryParams: CameraPageQuery) {
    return request<any, PageResult<CameraPageVO[]>>({
      url: `${CAMERA_BASE_URL}/page`,
      method: "get",
      params: queryParams,
    });
  }

  // static getVideo(url: string) {
  //   return request<any, PageResult<CameraPageVO[]>>({
  //     url: `${CAMERA_BASE_URL}/open/${url}`,
  //     method: "get",
  //   });
  // }
  /**
   * 打开视频流
   *
   * @param url 视频流地址
   */
  static async openVideo(url: string) {
    const fullUrl = `${FLV_BASE_URL}/open/${url}`;
    console.log("请求的完整URL:", fullUrl);
    try {
      const response = await request({
        url: fullUrl,
        method: "get",
        responseType: "blob",
      });
      console.log("请求成功，响应状态:", response.status);
      console.log("响应数据:", response.data);
      return response;
    } catch (error) {
      console.error("请求视频流数据失败:", error);
      throw error;
    }
  }
  /**
   * 获取设备表单详情
   *
   * @param cameraId 设备ID
   * @returns 设备表单详情
   */
  static getFormData(cameraId: number) {
    return request<any, CameraForm>({
      url: `${CAMERA_BASE_URL}/${cameraId}/form`,
      method: "get",
    });
  }

  /**
   * 添加设备
   *
   * @param data 设备表单数据
   */
  static add(data: CameraForm) {
    return request({
      url: `${CAMERA_BASE_URL}`,
      method: "post",
      data: data,
    });
  }

  /**
   * 修改设备
   *
   * @param id 设备ID
   * @param data 设备表单数据
   */
  static update(id: number, data: CameraForm) {
    return request({
      url: `${CAMERA_BASE_URL}/${id}`,
      method: "put",
      data: data,
    });
  }

  /**
   * 批量删除设备，多个以英文逗号(,)分割
   *
   * @param ids 设备ID字符串，多个以英文逗号(,)分割
   */
  static deleteByIds(ids: string) {
    return request({
      url: `${CAMERA_BASE_URL}/${ids}`,
      method: "delete",
    });
  }
}

export default CameraAPI;

/**
 * 设备分页查询对象
 */
export interface CameraPageQuery extends PageQuery {
  /** 搜索关键字 */
  keywords?: string;

  /** 设备状态 */
  status?: number;

  // /** 部门ID */
  // deptId?: number;

  /** 开始时间 */
  startTime?: string;

  /** 结束时间 */
  endTime?: string;
}

/** 设备分页对象 */
export interface CameraPageVO {
  /** 创建时间 */
  createTime?: Date;
  /** 设备ID */
  id?: number;
  /** 设备状态(1:启用;0:禁用) */
  status?: number;
  /** 设备名 */
  cameraName?: string;
  /** 设备地址 */
  cameraRTSP?: string;
}

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
