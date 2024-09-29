package com.youlai.system.controller;

import com.youlai.system.common.result.Result;
import com.youlai.system.model.dto.FileInfo;
import com.youlai.system.model.entity.Milvus;
import com.youlai.system.model.form.MilvusFrom;
import com.youlai.system.plugin.norepeat.annotation.PreventRepeatSubmit;
import com.youlai.system.service.CameraService;
import com.youlai.system.service.MilvusService;
import io.milvus.param.R;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.opencv.core.Mat;
import org.opencv.core.MatOfByte;
import org.opencv.imgcodecs.Imgcodecs;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

/**
 * 控制层
 *
 * @author Ray
 * @since 2022/10/16
 */
@Tag(name = "012.接口")
@RestController
@RequestMapping("/api/v1/recognition")
@RequiredArgsConstructor
public class MilvusController {

    private final MilvusService milvusService;

    @PostMapping
    @Operation(summary = "上传")
    @PreventRepeatSubmit
    public Result<String[]> uploadFile(
            @RequestParam(value = "file") MultipartFile file
    ) throws IOException {
        System.out.println("进入识别检索部分");
        byte[] bytes = file.getBytes();
        R<Boolean> booleanR = milvusService.hasCollection();
        if (!booleanR.getData()) return Result.failed("数据库当前不存在");
        milvusService.describeCollection();
        milvusService.showCollections();
        String[] strings = milvusService.searchOneImage(bytes);
        System.out.println(strings);
//        MilvusFrom milvusFrom = new MilvusFrom();
//        milvusFrom.setSimilarImageUrl(s);
        return Result.success(strings);
    }

}