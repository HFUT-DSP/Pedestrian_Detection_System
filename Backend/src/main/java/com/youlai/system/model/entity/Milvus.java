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
public class Milvus extends BaseEntity {

    /**
     * 摄像机 ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    private String similarImageUrl; // 最相似图片的URL

    private String videoUrl; // 视频资源的URL

    private String cameraName; // 摄像机名称

    /**
     * 创建人 ID
     */
    private Long createBy;

    /**
     * 更新人 ID
     */
    private Long updateBy;

}
