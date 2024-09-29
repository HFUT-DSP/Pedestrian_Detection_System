// import axios from 'axios';

// // 定义上传图像的请求接口
// interface UploadImageResponse {
//   code: string;
//   data: {
//     similarImageUrl: string;  // 最相似图片的URL
//     videoUrl: string;         // 视频资源的URL
//     cameraName: string;       // 摄像机名称
//   };
// }

// // 上传图片接口
// export const uploadImage = (file: File): Promise<UploadImageResponse> => {
//   const formData = new FormData();
//   formData.append('file', file);

//   return axios.post<UploadImageResponse>('/dev-api/api/v1/retrieval', formData, {
//     headers: {
//       'Content-Type': 'multipart/form-data',
//     },
//   }).then(response => response.data);
// };

// import request from "@/utils/request";

// class ImageAPI {
//   /**
//    * 上传文件
//    *
//    * @param file
//    */
//   static upload(file: File) {
//     const formData = new FormData();
//     formData.append("file", file);
//     return request<any, ImageInfo>({
//       url: "/api/v1/retrieval",
//       method: "post",
//       data: formData,
//       headers: {
//         "Content-Type": "multipart/form-data",
//       },
//     });
//   }
// }

// export default ImageAPI;

// /**
//  * 文件API类型声明
//  */
// export interface ImageInfo {
//   /** 文件名 */
//   similarImageUrl: string;
//   /** 文件路径 */
//   videoUrl: string;
//   /** 文件名*/
//   cameraName: string;
// }
import request from "@/utils/request";

const RECOGNITION_BASE_URL = "/api/v1/recognition";

class RecognitionAPI {
  /**
   * 上传图片并获取识别结果
      *
   * @param imageFile 上传的图片文件
   * @returns 包含识别结果图像的数组
      */
    static upload(imageFile: File) {

    const formData = new FormData();
    formData.append("file", imageFile);
    
    return request<any, RecognitionResponse>({
      url: `${RECOGNITION_BASE_URL}`,
      method: "post",
      data: formData,
      headers: { "Content-Type": "multipart/form-data" },
    });
  }
}

export default RecognitionAPI;

/** 识别响应结果 */
export interface RecognitionResponse {
  /** 识别返回的图像数组 */
  images: string[];
}