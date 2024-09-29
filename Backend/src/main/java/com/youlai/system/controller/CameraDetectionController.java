package com.youlai.system.controller;

import ai.onnxruntime.OnnxTensor;
import ai.onnxruntime.OrtEnvironment;
import ai.onnxruntime.OrtException;
import ai.onnxruntime.OrtSession;
import com.youlai.system.common.result.Result;
import com.youlai.system.config.ODConfig;
import com.youlai.system.detection.FrameWebSocketHandler;
//import com.youlai.system.domain.ODResult;
import com.youlai.system.model.form.CameraForm;
//import com.youlai.system.utils.ImageUtil;
//import com.youlai.system.utils.Letterbox;
import com.youlai.system.detection.Detection;
import org.opencv.core.*;
import org.opencv.highgui.HighGui;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.videoio.VideoCapture;
import org.opencv.videoio.Videoio;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.socket.TextMessage;

import java.nio.FloatBuffer;
import java.util.Base64;
import java.util.HashMap;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

/**
 * 摄像头实时检测，仅支持运行在有摄像头的电脑上
 * @author pj
 */

@RestController
public class CameraDetectionController {

//    private byte[] latestFrame; // 存储最新帧的字节数组

    private static String base64String;
    @PostMapping("/api/v1/detection/init")
    public void init(@RequestBody CameraForm cameraForm) throws OrtException {
        FrameWebSocketHandler frameWebSocketHandler = new FrameWebSocketHandler();
        System.out.println("目标检测到这一步了");
    }

    @PostMapping("/api/v1/detection/start")
    public Result<CameraForm> startDetection(@RequestBody CameraForm cameraForm) throws OrtException {
        System.out.println("目标检测开始");
        nu.pattern.OpenCV.loadLocally();

        String model_path = "src/main/resources/model/yolov7-tiny.onnx"; // 使用正斜杠
        Detection detection = new Detection(); // 创建 Detection 实例

        VideoCapture video = new VideoCapture();
        video.open(cameraForm.getCameraRTSP());
        if (!video.isOpened()) {
            System.err.println("打开视频流失败，请先用vlc软件测试链接是否可以播放！");
            return Result.failed("打开视频流失败，请先用vlc软件测试链接是否可以播放！");
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("打开视频流失败，请先用vlc软件测试链接是否可以播放！");
        }

        String s = detection.detectAndEncode(video, model_path);// 调用 detectAndEncode 方法进行目标检测并编码为 Base64 字符串
        CameraForm cameraForm1 = new CameraForm();
        cameraForm1.setCameraRTSP(s);
        return Result.success(cameraForm1);
    }
}
