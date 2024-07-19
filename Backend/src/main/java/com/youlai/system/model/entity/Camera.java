package com.youlai.system.model.entity;

import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.youlai.system.common.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;

/**
 * 摄像机 实体
 *
 * @author Ray
 * @since 2024/06/23
 */
@Getter
@Setter
public class Camera extends BaseEntity {

    /**
     * 摄像机 ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 用户名
     */
    private String cameraName;

    /**
     * 摄像头地址
     */
    private String cameraRTSP;
    /**
     * 状态((1-正常 0-禁用)
     */
    private Integer status;

    /**
     * 创建人 ID
     */
    private Long createBy;

    /**
     * 更新人 ID
     */
    private Long updateBy;

}
