package com.youlai.system.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 模型表单对象
 */
@Schema(description = "模型")
@Data
public class ModelForm {
    @Schema(description = "模型ID",example = "1")
    private Long id;

    @Schema(description = "模型名称",example = "MIANet")
    private String modelName;

    @Schema(description = "模型类型", example ="目标检测")
    private String modelType;

    @Schema(description = "字典状态（1-启用，0-禁用）", example = "1")
    private Integer status;
}
