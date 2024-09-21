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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * 控制层
 *
 * @author Ray
 * @since 2022/10/16
 */
@Tag(name = "012.接口")
@RestController
@RequestMapping("/api/v1/retrieval")
@RequiredArgsConstructor
public class MilvusController {

    private final MilvusService milvusService;

    @PostMapping
    @Operation(summary = "上传")
    @PreventRepeatSubmit
    public Result<MilvusFrom> uploadFile(@RequestParam("file") MilvusFrom milvusFrom) {
        System.out.println("进入里面");
        ///***在这边写
        return Result.success(milvusFrom);
    }

}