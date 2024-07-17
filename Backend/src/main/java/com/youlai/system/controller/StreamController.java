// package com.youlai.system.controller;
// import jakarta.servlet.http.HttpServletResponse;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.RestController;

// import java.io.IOException;
// import java.io.InputStream;
// import java.io.OutputStream;
// @RestController
// public class StreamController {

//     @GetMapping("/stream.m3u8")
//     public void streamVideo(HttpServletResponse response) {
//         System.out.println("----------------------------进入StreamController----------------------------");
//         try {
//             ProcessBuilder processBuilder = new ProcessBuilder("ffmpeg", "-i", "rtsp://admin:1111111a@114.213.211.99/Streaming/Channels/101", "-f", "hls", "-hls_time", "2", "-hls_list_size", "3", "-hls_flags", "delete_segments", "-");
//             Process process = processBuilder.start();
//             response.setContentType("application/vnd.apple.mpegurl");
//             InputStream inputStream = process.getInputStream();
//             OutputStream outputStream = response.getOutputStream();
//             byte[] buffer = new byte[1024];
//             int len;
//             while ((len = inputStream.read(buffer)) != -1) {
//                 outputStream.write(buffer, 0, len);
//             }
//         } catch (IOException e) {
//             e.printStackTrace();
//         }
//     }
// }



