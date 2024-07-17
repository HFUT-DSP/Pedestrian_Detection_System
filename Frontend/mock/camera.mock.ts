import { defineMock } from "./base";

export default defineMock([
  // {
  //   url: "cameras/me",
  //   method: ["GET"],
  //   body: {
  //     code: "00000",
  //     data: {
  //       cameraId: 100,
  //       cameraName: "1号摄像头",
  //       cameraRTSP: "https://www.hfut.edu.cn",
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
  //         "sys:camera:query",
  //         "sys:camera:add",
  //         "sys:camera:video",
  //         "sys:camera:delete",
  //         "sys:camera:edit",
  //       ],
  //     },
  //     msg: "一切ok",
  //   },
  // },

  {
    url: "cameras/page",
    method: ["GET"],
    body: {
      code: "00000",
      data: {
        list: [
          {
            id: 100,
            cameraName: "摄像头一号",
            cameraRTSP:
              "rtsp://admin:1111111a@114.213.211.99/Streaming/Channels/101",
            // gender: 1,
            // avatar:
            //   "https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif",
            // email: "",
            status: 1,
            // deptId: 1,
            // roleIds: [2],
          },
          {
            id: 101,
            cameraName: "摄像头二号",
            cameraRTSP:
              "rtsp://admin:1111111a@114.213.211.99/Streaming/Channels/101",
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

  // 新增用户
  {
    url: "cameras",
    method: ["POST"],
    body({ body }) {
      return {
        code: "00000",
        data: null,
        msg: "新增设备" + body.cameraName + "成功",
      };
    },
  },

  // 获取设备表单数据
  {
    url: "cameras/:cameraId/form",
    method: ["GET"],
    body: ({ params }) => {
      return {
        code: "00000",
        data: cameraMap[params.cameraId],
        msg: "一切ok",
      };
    },
  },
  // 修改设备
  {
    url: "cameras/:cameraId",
    method: ["PUT"],
    body({ body }) {
      return {
        code: "00000",
        data: null,
        msg: "修改用户" + body.cameraName + "成功",
      };
    },
  },

  // 删除设备
  {
    url: "cameras/:cameraId",
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
const cameraMap: Record<string, any> = {
  100: {
    id: 100,
    cameraName: "摄像头一号",
    cameraRTSP: "rtsp://admin:1111111a@114.213.211.99/Streaming/Channels/101",
    // gender: 1,
    // avatar:
    //   "https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif",
    // email: "",
    status: 1,
    // deptId: 1,
    // roleIds: [2],
  },
  101: {
    id: 101,
    cameraName: "摄像头二号",
    cameraRTSP: "rtsp://admin:1111111a@114.213.211.99/Streaming/Channels/101",
    // gender: 1,
    // avatar:
    //   "https://oss.youlai.tech/youlai-boot/2023/05/16/811270ef31f548af9cffc026dfc3777b.gif",
    // email: "",
    status: 1,
    // deptId: 1,
    // roleIds: [2],
  },
};
