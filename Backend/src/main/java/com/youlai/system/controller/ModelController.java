package com.youlai.system.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.esotericsoftware.kryo.util.Null;
import com.youlai.system.common.result.PageResult;
import com.youlai.system.common.result.Result;
import com.youlai.system.enums.LogModuleEnum;
import com.youlai.system.model.form.ModelForm;
import com.youlai.system.model.query.CameraPageQuery;
import com.youlai.system.model.query.ModelPageQuery;
import com.youlai.system.model.vo.CamerapageVO;
import com.youlai.system.model.vo.ModelpageVO;
import com.youlai.system.plugin.norepeat.annotation.PreventRepeatSubmit;
import com.youlai.system.plugin.syslog.annotation.LogAnnotation;
import com.youlai.system.service.ModelService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 *模型管理页面
 */
@Tag(name = "012.模型管理接口")
@RestController
@RequestMapping("/api/v1/models")
@RequiredArgsConstructor
@Slf4j
public class ModelController {

    private final ModelService modelService;

    @Operation(summary = "模型管理分页列表")
    @GetMapping("/page")
    @LogAnnotation( value = "模型管理分页列表",module = LogModuleEnum.USER)
    public PageResult<ModelpageVO> listPagedUsers(
             ModelPageQuery modelPageQuery
    ){
        IPage<ModelpageVO> result = modelService.listPagedUsers(modelPageQuery);
        return PageResult.success(result);
    }

    @Operation(summary = "模型管理表单")
    @GetMapping("/{id}/form")
    public Result<ModelForm> getDictForm(
            @Parameter(description = "模型ID") @PathVariable Long id
    ){
        ModelForm formData = modelService.getModelForm(id);
        return Result.success(formData);
    }

    @Operation(summary = "修改模型")
    @PutMapping("/{id}")
    public Result updateDict(
            @PathVariable Long id,
            @RequestBody ModelForm modelForm
    ){
        boolean result = modelService.updateDict(id, modelForm);
        return Result.judge(result);
    }

    @Operation(summary = "新增模型")
    @PostMapping
    @PreventRepeatSubmit
    public Result saveDict(@RequestBody ModelForm modelForm){
        System.out.println(modelForm);
        boolean result = modelService.saveDict(modelForm);
        return Result.judge(result);
    }

    @Operation(summary = "删除模型")
    @DeleteMapping("/{ids}")
    public Result deleteDictionaries(
            @Parameter(description = "模型ID，多个以英文逗号(,)拼接") @PathVariable String ids
    ){
        boolean result = modelService.deleteDictByIds(ids);
        return Result.judge(result);
    }

}
