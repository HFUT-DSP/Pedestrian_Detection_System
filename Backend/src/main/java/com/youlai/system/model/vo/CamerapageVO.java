package com.youlai.system.model.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.Date;

/**
 * 摄像头页视图对象
 *
 * @author tyh
 * @since 2022/1/15 9:41
 */
@Schema(description ="摄像头分页对象")
@Data
public class CamerapageVO {

    @Schema(description="摄像头ID")
    private Long id;

    @Schema(description="设备名")
    private String cameraName;

    @Schema(description="摄像头地址")
    private String cameraRTSP;

    @Schema(description="摄像头状态(1:启用;0:禁用)")
    private Integer status;

    @Schema(description="创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTime;
}
