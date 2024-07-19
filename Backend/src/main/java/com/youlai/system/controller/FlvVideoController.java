//package com.youlai.system.controller;
//
//
//import com.youlai.system.common.result.JsonResult;
//import com.youlai.system.factories.Converter;
//import com.youlai.system.registration.ConverterRegistration;
//import com.youlai.system.service.IFLVService;
//import io.swagger.v3.oas.annotations.Operation;
//import io.swagger.v3.oas.annotations.tags.Tag;
//import jakarta.servlet.http.HttpServletResponse;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.apache.commons.lang3.StringUtils;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.*;
//
//
//import java.util.Base64;
//import java.util.concurrent.ConcurrentHashMap;
//
///**
// * 功能：flv视频播放
// * @author xufeng
// * @version 1.0
// * @date 2020/5/12 下午 1:50
// **/
//@Tag(name = "010.flv视频播放")
//@RestController
//@RequestMapping("/api/v1/flv")
//@RequiredArgsConstructor
//
//public class FlvVideoController {
//
//	private static final Logger log = LoggerFactory.getLogger(FlvVideoController.class);
//	@Autowired
//	private IFLVService iflvService;
//
//	/**
//	 * 根据视频rtsp流链接打开转换，通过响应写出流到前台使用flvjs播放视频
//	 * @param url 视频链接
//	 * @param httpServletResponse 响应请求
//	 * @author tyh
//	 */
//	@Operation(summary = "视频链接")
//	@GetMapping("/open/{url}")
////	@RequestMapping(method = RequestMethod.GET, value = "/open/{url}")
//	public void open(
//			@PathVariable(value = "url") String url,
//			HttpServletResponse httpServletResponse)
//	{
//		System.out.println("视频链接");
//		try {
//			Base64.Decoder base64Decoder = Base64.getDecoder();
//			//获取当前登录用户主键
//			String userId = "1";
//			//String userId = UserContext.getCurrentUser().getId();
//			//为保持url长度，需要先对前端传来的url进行base64解码，再调用flvService接口
//			iflvService.open(new String(base64Decoder.decode(url)), userId, httpServletResponse)
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//	}
//
//	/**
//	 * 一个播放器销毁时，将对应转换器线程暂停
//	 * @author tyh
//	 * @param videoUrl 视频流链接
//	 * @return EosDataTransferObject
//	 */
//	@Operation(summary = "视频流链接")
//	@ResponseBody
//	@RequestMapping(method = RequestMethod.GET, value = "/closeTransThread")
//	public JsonResult closeTransThread(@RequestParam(value = "videoUrl") String videoUrl) {
//		try {
//			//视频流链接为空直接返回
//			if (StringUtils.isBlank(videoUrl)) {
//				return new JsonResult();
//			}
//			//获取当前登录用户主键
//			String userId = "1";
//			//String userId = UserContext.getCurrentUser().getId();
//			//使用主键获取当前所有转换器
//			ConcurrentHashMap<String, Converter> conMaps = ConverterRegistration.getAllConverters(userId);
//			//通过视频流链接取对应的转换器
//			Converter converter = ConverterRegistration.isExist(videoUrl, conMaps);
//			if (null != converter) {
//				//暂停转换器线程，1分钟无新线程创建，该线程即被销毁
//				converter.exit();
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return new JsonResult();
//	}
//
//}
