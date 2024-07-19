package com.youlai.system.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.youlai.system.common.base.BaseEntity;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * 模型 实体
 */
@Data
public class Model extends BaseEntity {
    /**
     * 模型 ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 模型名称
     */
    private String modelName;

    /**
     * 模型类型
     */
    private String modelType;
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
