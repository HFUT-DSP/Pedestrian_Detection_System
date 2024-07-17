import { defineMock } from "./base";

export default defineMock([
  // {
  //   url: "models/me",
  //   method: ["GET"],
  //   body: {
  //     code: "00000",
  //     data: {
  //       modelId: 100,
  //       modelName: "1号摄像头",
  //       modelRTSP: "https://www.hfut.edu.cn",
  //       // avatar:
  //       //   "https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif",
  //       // roles: ["ROOT"],
  //       perms: [
  //         // "sys:menu:delete",
  //         // "sys:dept:edit",
  //         // "sys:dict_type:add",
  //         // "sys:dict:edit",
  //         // "sys:dict:delete",
  //         // "sys:dict_type:edit",
  //         // "sys:menu:add",
  //         // "sys:user:add",
  //         // "sys:role:edit",
  //         // "sys:dept:delete",
  //         // "sys:user:edit",
  //         // "sys:user:delete",
  //         // "sys:user:password:reset",
  //         // "sys:dept:add",
  //         // "sys:role:delete",
  //         // "sys:dict_type:delete",
  //         // "sys:menu:edit",
  //         // "sys:dict:add",
  //         // "sys:role:add",
  //         // "sys:user:query",
  //         // "sys:user:export",
  //         "sys:model:query",
  //         "sys:model:add",
  //         "sys:model:video",
  //         "sys:model:delete",
  //         "sys:model:edit",
  //       ],
  //     },
  //     msg: "一切ok",
  //   },
  // },

  {
    url: "models/page",
    method: ["GET"],
    body: {
      code: "00000",
      data: {
        list: [
          {
            id: 1001,
            modelName: "模型一号",
            modelType: "第一种模型",
            // gender: 1,
            // avatar:
            //   "https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif",
            // email: "",
            status: 1,
            // deptId: 1,
            // roleIds: [2],
          },
          {
            id: 1002,
            modelName: "模型二号",
            modelType: "第二种模型",
            // gender: 1,
            // avatar:
            //   "https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif",
            // email: "",
            status: 1,
            // deptId: 1,
            // roleIds: [2],
          },
        ],
        total: 2,
      },
      msg: "一切ok",
    },
  },

  // 新增模型
  {
    url: "models",
    method: ["POST"],
    body({ body }) {
      return {
        code: "00000",
        data: null,
        msg: "新增设备" + body.modelName + "成功",
      };
    },
  },

  // 获取设备表单数据
  {
    url: "models/:modelId/form",
    method: ["GET"],
    body: ({ params }) => {
      return {
        code: "00000",
        data: modelMap[params.modelId],
        msg: "一切ok",
      };
    },
  },
  // 修改设备
  {
    url: "models/:modelId",
    method: ["PUT"],
    body({ body }) {
      return {
        code: "00000",
        data: null,
        msg: "修改用户" + body.modelName + "成功",
      };
    },
  },

  // 删除设备
  {
    url: "models/:modelId",
    method: ["DELETE"],
    body({ params }) {
      return {
        code: "00000",
        data: null,
        msg: "删除用户" + params.id + "成功",
      };
    },
  },

  // // 重置密码
  // {
  //   url: "users/:userId/password",
  //   method: ["PATCH"],
  //   body({ query }) {
  //     return {
  //       code: "00000",
  //       data: null,
  //       msg: "重置密码成功，新密码为：" + query.password,
  //     };
  //   },
  // },

  // 导出Excel
  // {
  //   url: "users/_export",
  //   method: ["GET"],
  //   headers: {
  //     "Content-Disposition":
  //       "attachment; filename=%E7%94%A8%E6%88%B7%E5%88%97%E8%A1%A8.xlsx",
  //     "Content-Type":
  //       "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  //   },
  // },
]);

// 设备映射表数据
const modelMap: Record<string, any> = {
  1001: {
    id: 1001,
    modelName: "模型一号",
    modelType: "第一种模型",
    // gender: 1,
    // avatar:
    //   "https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif",
    // email: "",
    status: 1,
    // deptId: 1,
    // roleIds: [2],
  },
  1002: {
    id: 1002,
    modelName: "模型二号",
    modelType: "第二种模型",
    // gender: 1,
    // avatar:
    //   "https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif",
    // email: "",
    status: 1,
    // deptId: 1,
    // roleIds: [2],
  },
};
