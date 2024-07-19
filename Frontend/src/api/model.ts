import request from "@/utils/request";

const MODEL_BASE_URL = "/api/v1/models";

class ModelAPI {
  /**
   * 获取模型分页列表
   *
   * @param queryParams 查询参数
   */
  static getPage(queryParams: ModelPageQuery) {
    return request<any, PageResult<ModelPageVO[]>>({
      url: `${MODEL_BASE_URL}/page`,
      method: "get",
      params: queryParams,
    });
  }

  /**
   * 获取模型表单详情
   *
   * @param modelId 模型ID
   * @returns 模型表单详情
   */
  static getFormData(modelId: number) {
    return request<any, ModelForm>({
      url: `${MODEL_BASE_URL}/${modelId}/form`,
      method: "get",
    });
  }

  /**
   * 添加模型
   *
   * @param data 模型表单数据
   */
  static add(data: ModelForm) {
    return request({
      url: `${MODEL_BASE_URL}`,
      method: "post",
      data: data,
    });
  }

  /**
   * 修改模型
   *
   * @param id 模型ID
   * @param data 模型表单数据
   */
  static update(id: number, data: ModelForm) {
    return request({
      url: `${MODEL_BASE_URL}/${id}`,
      method: "put",
      data: data,
    });
  }

  /**
   * 批量删除模型，多个以英文逗号(,)分割
   *
   * @param ids 模型ID字符串，多个以英文逗号(,)分割
   */
  static deleteByIds(ids: string) {
    return request({
      url: `${MODEL_BASE_URL}/${ids}`,
      method: "delete",
    });
  }
}

export default ModelAPI;

/** 登录模型信息 */
// export interface UserInfo {
//   /** 用户ID */
//   UserId?: number;

//   /** 用户名 */
//   Username?: string;

//   /** 昵称 */
//   nickname?: string;

//   /** 头像URL */
//   avatar?: string;

//   /** 角色 */
//   roles: string[];

//   /** 权限 */
//   perms: string[];
// }

/**
 * 模型分页查询对象
 */
export interface ModelPageQuery extends PageQuery {
  /** 搜索关键字 */
  keywords?: string;

  /** 模型状态 */
  status?: number;

  /** 开始时间 */
  startTime?: string;

  /** 结束时间 */
  endTime?: string;
}

/** 模型分页对象 */
export interface ModelPageVO {
  /** 创建时间 */
  createTime?: Date;
  /** 模型ID */
  id?: number;
  /** 模型状态(1:启用;0:禁用) */
  status?: number;
  /** 模型名 */
  modelName?: string;
  /** 模型类型 */
  modelType?: string;
}

/** 模型表单类型 */
export interface ModelForm {
  /** 模型ID */
  id?: number;
  /** 模型状态(1:正常;0:禁用) */
  status?: number;
  /** 模型名 */
  modelName?: string;
  /** 模型类型 */
  modelType?: string;
}
