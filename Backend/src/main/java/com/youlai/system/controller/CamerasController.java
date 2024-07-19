package com.youlai.system.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.youlai.system.common.result.PageResult;
import com.youlai.system.common.result.Result;
import com.youlai.system.enums.LogModuleEnum;
import com.youlai.system.model.form.CameraForm;
import com.youlai.system.model.form.DictForm;
import com.youlai.system.model.query.CameraPageQuery;
import com.youlai.system.model.vo.CamerapageVO;
import com.youlai.system.plugin.norepeat.annotation.PreventRepeatSubmit;
import com.youlai.system.plugin.syslog.annotation.LogAnnotation;
import com.youlai.system.service.CameraService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 认证控制层
 *
 * @author Ray
 * @since 2022/10/16
 */
@Tag(name = "011.设备管理中心")
@RestController
@RequestMapping("/api/v1/cameras")
@RequiredArgsConstructor
@Slf4j
public class CamerasController {

    private final CameraService cameraService;

    @Operation(summary = "设备管理分页列表")
    @GetMapping("/page")
    @LogAnnotation( value = "设备管理分页列表",module = LogModuleEnum.USER)
    public PageResult<CamerapageVO> listPagedUsers(
            CameraPageQuery cameraPageQuery
    ){
        IPage<CamerapageVO> result = cameraService.listPagedUsers(cameraPageQuery);
        return PageResult.success(result);
    }

    @Operation(summary = "设备管理表单")
    @GetMapping("/{id}/form")
    public Result<CameraForm> getDictForm(
            @Parameter(description = "摄像头ID") @PathVariable Long id
    ) {
        CameraForm formData = cameraService.getCameraForm(id);
        return Result.success(formData);
    }


    @Operation(summary = "修改设备")
    @PutMapping("/{id}")
    public Result updateDict(
            @PathVariable Long id,
            @RequestBody CameraForm cameraForm
    ) {
        boolean result = cameraService.updateDict(id, cameraForm);
        return Result.judge(result);
    }


    @Operation(summary = "新增设备")
    @PostMapping
    @PreventRepeatSubmit
    public Result saveDict(@RequestBody CameraForm cameraForm) {
        boolean result = cameraService.saveDict(cameraForm);
        return Result.judge(result);
    }

    @Operation(summary = "删除设备")
    @DeleteMapping("/{ids}")
    public Result deleteDictionaries(
            @Parameter(description = "设备ID，多个以英文逗号(,)拼接") @PathVariable String ids
    ) {
        boolean result = cameraService.deleteDictByIds(ids);
        return Result.judge(result);
    }



}
