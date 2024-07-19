package com.youlai.system.model.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

/**
 * 模型页视图对象
 */
@Schema(description ="模型分页对象")
@Data
public class ModelpageVO {
    @Schema(description="模型 ID")
    private Long id;

    @Schema(description="模型名称")
    private String modelName;

    @Schema(description="模型类型")
    private String modelType;

    @Schema(description="模型状态(1:启用;0:禁用)")
    private Integer status;

    @Schema(description="创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTime;
}
