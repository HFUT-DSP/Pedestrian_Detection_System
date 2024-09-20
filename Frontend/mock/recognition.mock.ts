import { defineMock } from "./base";

export default defineMock({
  url: "/retrieval",
  method: ["POST"],
  body({ body }) {
    return {
      code: "00000",
      data: {
        similarImageUrl: "/mock-data/similar_image.jpg", // 模拟最相似图像的URL
        videoUrl: "/mock-data/video.mp4", // 模拟返回的视频URL
        cameraName: "一号摄像头", // 模拟返回的摄像头名称
      },
    };
  },
});
