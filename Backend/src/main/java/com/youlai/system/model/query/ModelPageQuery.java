package com.youlai.system.model.query;

import com.youlai.system.common.base.BasePageQuery;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 模型查询对象
 */
@Schema(description ="模型分页查询对象")
@Data
public class ModelPageQuery extends BasePageQuery {
    @Schema(description="关键字(用户名/昵称/手机号)")
    private String keywords;

    @Schema(description="用户状态")
    private Integer status;

    @Schema(description="部门ID")
    private Long deptId;

    @Schema(description="创建时间-开始时间")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String startTime;

    @Schema(description="创建时间-结束时间")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String endTime;
}
