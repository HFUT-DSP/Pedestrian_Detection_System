package com.youlai.system.detection;

import ai.onnxruntime.OnnxTensor;
import ai.onnxruntime.OrtEnvironment;
import ai.onnxruntime.OrtException;
import ai.onnxruntime.OrtSession;
import com.youlai.system.config.ODConfig;
import com.youlai.system.domain.ODResult;
import com.youlai.system.utils.ImageUtil;
import com.youlai.system.utils.Letterbox;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.MatOfByte;
import org.opencv.core.Scalar;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.opencv.videoio.VideoCapture;
import org.opencv.core.Point;
import org.opencv.videoio.Videoio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.nio.FloatBuffer;
import java.util.Base64;
import java.util.HashMap;

@Component
public class Detection {
    private String[] labels;
    private ODConfig odConfig;
    private OrtSession session;
    private Letterbox letterbox;

    public Detection()  {

    }

    @Autowired
//    private FrameWebSocketHandler frameWebSocketHandler;// 注入 WebSocket 处理器
    FrameWebSocketHandler frameWebSocketHandler = new FrameWebSocketHandler();
    public String detectAndEncode(VideoCapture video, String modelPath) throws OrtException{
        String[] labels = {"person", "bicycle", "car", "motorcycle", "airplane", "bus", "train",
                "truck", "boat", "traffic light", "fire hydrant", "stop sign", "parking meter",
                "bench", "bird", "cat", "dog", "horse", "sheep", "cow", "elephant", "bear",
                "zebra", "giraffe", "backpack", "umbrella", "handbag", "tie", "suitcase",
                "frisbee", "skis", "snowboard", "sports ball", "kite", "baseball bat",
                "baseball glove", "skateboard", "surfboard", "tennis racket", "bottle",
                "wine glass", "cup", "fork", "knife", "spoon", "bowl", "banana", "apple",
                "sandwich", "orange", "broccoli", "carrot", "hot dog", "pizza", "donut",
                "cake", "chair", "couch", "potted plant", "bed", "dining table", "toilet",
                "tv", "laptop", "mouse", "remote", "keyboard", "cell phone", "microwave",
                "oven", "toaster", "sink", "refrigerator", "book", "clock", "vase", "scissors",
                "teddy bear", "hair drier", "toothbrush"
        };
        // 加载标签及颜色
        ODConfig odConfig = new ODConfig();
        // 加载ONNX模型
        OrtEnvironment environment = OrtEnvironment.getEnvironment();
        OrtSession.SessionOptions sessionOptions = new OrtSession.SessionOptions();
        OrtSession session = environment.createSession(modelPath, sessionOptions);

        int detect_skip = 3;
        int detect_skip_index = 1;
        float[][] outputData = null;
        Letterbox letterbox = new Letterbox();
        OnnxTensor tensor;

        // 在这里先定义下框的粗细、字的大小、字的类型、字的颜色(按比例设置大小粗细比较好一些)
        int minDwDh = Math.min((int)video.get(Videoio.CAP_PROP_FRAME_WIDTH), (int)video.get(Videoio.CAP_PROP_FRAME_HEIGHT));
        int thickness = minDwDh / ODConfig.lineThicknessRatio;
        double fontSize = minDwDh / ODConfig.fontSizeRatio;
        int fontFace = Imgproc.FONT_HERSHEY_SIMPLEX;

        Mat img = new Mat();
        System.out.println("目标检测到这一步了");
        while(video.read(img)){
            System.out.println("这里正常");
            if ((detect_skip_index % detect_skip == 0) || outputData == null) {
                Mat image = letterbox.letterbox(img.clone());
                Imgproc.cvtColor(image, image, Imgproc.COLOR_BGR2RGB);
                image.convertTo(image, CvType.CV_32FC1, 1. / 255);
                float[] whc = new float[3 * 640 * 640];
                image.get(0, 0, whc);
                float[] chw = ImageUtil.whc2cwh(whc);

                FloatBuffer inputBuffer = FloatBuffer.wrap(chw);
                tensor = OnnxTensor.createTensor(environment, inputBuffer, new long[]{1, 3, 640, 640});
                HashMap<String, OnnxTensor> inputMap = new HashMap<>();
                inputMap.put(session.getInputInfo().keySet().iterator().next(), tensor);

                try {
                    OrtSession.Result output = session.run(inputMap);
                    outputData = (float[][]) output.get(0).getValue();
                } catch (OrtException e) {
                    System.err.println("Failed to run inference: " + e.getMessage());
                    return null;
                }
            } else {
                detect_skip_index++;
            }

            if (outputData != null) {
                for (float[] x : outputData) {
                    ODResult odResult = new ODResult(x);
                    Point topLeft = new Point((odResult.getX0() - letterbox.getDw()) / letterbox.getRatio(),
                            (odResult.getY0() - letterbox.getDh()) / letterbox.getRatio());
                    Point bottomRight = new Point((odResult.getX1() - letterbox.getDw()) / letterbox.getRatio(),
                            (odResult.getY1() - letterbox.getDh()) / letterbox.getRatio());
                    Scalar color = new Scalar(odConfig.getOtherColor(odResult.getClsId()));

                    Imgproc.rectangle(img, topLeft, bottomRight, color, thickness);
                    String boxName = labels[odResult.getClsId()];
                    Point boxNameLoc = new Point((odResult.getX0() - letterbox.getDw()) / letterbox.getRatio(),
                            (odResult.getY0() - letterbox.getDh()) / letterbox.getRatio() - 3);
                    Imgproc.putText(img, boxName, boxNameLoc, fontFace, 0.7, color, thickness);
                    System.out.println(odResult + "   " + boxName);
                }
            }

            MatOfByte matOfByte = new MatOfByte();
            Imgcodecs.imencode(".jpg", img, matOfByte);
            byte[] imageBytes = matOfByte.toArray();
//            String base64String = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageBytes);
            String base64String = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageBytes);
            return base64String;
//            frameWebSocketHandler.broadcastImage(base64String);
//            // 检查并清理 Base64 字符串
//            if (base64String.startsWith("data:image/jpeg;base64,")) {
//                base64String = base64String.substring("data:image/jpeg;base64,".length());
//            }
//
//            // 将 Base64 字符串转换为字节数组并推送到前端
//            try {
//                imageBytes = Base64.getDecoder().decode(base64String);
//                String imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
//                frameWebSocketHandler.broadcastImage(imageBase64); // 广播图像
////                return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(imageBytes);
//            } catch (IllegalArgumentException e) {
//                System.err.println("Base64 解码失败：" + e.getMessage());
//            }

        }

        return null; // 如果没有帧可读，返回204无内容
    }
}
