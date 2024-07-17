// package com.youlai.system.handler;

// import lombok.extern.slf4j.Slf4j;
// import org.bytedeco.ffmpeg.global.avutil;
// import org.springframework.stereotype.Component;
// import org.springframework.web.socket.BinaryMessage;
// import org.springframework.web.socket.CloseStatus;
// import org.springframework.web.socket.WebSocketSession;
// import org.springframework.web.socket.handler.BinaryWebSocketHandler;
// import org.bytedeco.javacv.FFmpegFrameGrabber;
// import org.bytedeco.javacv.Java2DFrameConverter;

// import java.awt.image.BufferedImage;
// import java.io.ByteArrayOutputStream;
// import java.util.Base64;
// import javax.imageio.ImageIO;
// import java.util.concurrent.CopyOnWriteArrayList;

// @Slf4j
// @Component
// public class VideoStreamHandler extends BinaryWebSocketHandler {
//     private FFmpegFrameGrabber grabber;
//     private Java2DFrameConverter converter;
//     private CopyOnWriteArrayList<WebSocketSession> sessions;
//     private boolean isGrabbing;

//     public VideoStreamHandler() {
//         log.info("VideoStreamHandler instantiated");
//         // 在连接建立后开始获取RTSP摄像头视频流
//         String rtspUrl = "rtsp://admin:1111111a@114.213.211.99/Streaming/Channels/101";
//         grabber = new FFmpegFrameGrabber(rtspUrl);
//         // Set the correct pixel format
//         grabber.setMaxDelay(550);
//         avutil.av_log_set_level(avutil.AV_LOG_ERROR);
//         grabber.setOption("rtsp_transport", "tcp");
//         grabber.setOption("pix_fmt", "yuv420p"); // 尝试设置像素格式
//         grabber.setImageWidth(256);
//         grabber.setImageHeight(480);
//         converter = new Java2DFrameConverter();
//         sessions = new CopyOnWriteArrayList<>();
//         startGrabbing();
//     }

//     @Override
//     public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//         sessions.add(session);
//         log.info("WebSocket connection established. Total sessions: {}", sessions.size());
//     }

//     @Override
//     public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//         sessions.remove(session);
//         log.info("WebSocket connection closed. Total sessions: {}", sessions.size());
//     }

//     private void startGrabbing() {
//         new Thread(() -> {
//             log.info("Starting grabbing");
//             try {
//                 log.info("Grabbing started");
//                 grabber.start();
//                 isGrabbing = true;
//                 while (isGrabbing) {
//                     BufferedImage bufferedImage = converter.convert(grabber.grab());
//                     if (bufferedImage != null) {
//                         ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
//                         ImageIO.write(bufferedImage, "jpeg", outputStream);
//                         byte[] data = outputStream.toByteArray();
//                         String base64Image = Base64.getEncoder().encodeToString(data);
//                         sendImageToClients(base64Image);
//                     }
//                 }
//             } catch (Exception e) {
//                 e.printStackTrace();
//             } finally {
//                 try {
//                     grabber.stop();
//                     grabber.release();
//                 } catch (Exception e) {
//                     e.printStackTrace();
//                 }
//             }
//         }).start();
//     }

//     private void sendImageToClients(String base64Image) {
//         for (WebSocketSession session : sessions) {
//             try {
//                 session.sendMessage(new BinaryMessage(base64Image.getBytes()));
//             } catch (Exception e) {
//                 e.printStackTrace();
//             }
//         }
//     }
// }

