package com.youlai.system.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Schema(description = "milvus")
@Data
public class MilvusFrom {

    @Schema(description = "摄像头名称",example = "摄像头1")
    private String similarImageUrl;

    @Schema(description = "摄像头地址", example ="rstp://")
    private String videoUrl;

    @Schema(description = "字典状态（1-启用，0-禁用）", example = "1")
    private Integer cameraName;
}
