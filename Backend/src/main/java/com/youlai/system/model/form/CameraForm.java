package com.youlai.system.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

/**
 * 设备表单对象
 *
 * @author tyh
 * @since 2.9.0
 */
@Schema(description = "设备")
@Data
public class CameraForm {

    @Schema(description = "摄像头ID",example = "1")
    private Long id;

    @Schema(description = "摄像头名称",example = "摄像头1")
    private String cameraName;

    @Schema(description = "摄像头地址", example ="rstp://")
    private String cameraRTSP;

    @Schema(description = "字典状态（1-启用，0-禁用）", example = "1")
    private Integer status;
}
