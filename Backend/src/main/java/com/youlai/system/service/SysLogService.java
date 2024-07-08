package com.youlai.system.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.youlai.system.model.entity.SysLog;
import com.baomidou.mybatisplus.extension.service.IService;
import com.youlai.system.model.query.LogPageQuery;
import com.youlai.system.model.query.RolePageQuery;
import com.youlai.system.model.vo.LogPageVO;
import com.youlai.system.model.vo.VisitTrendVO;

import java.time.LocalDate;

/**
 * 系统日志 服务接口
 *
 * @author Ray
 * @since 2.10.0
 */
public interface SysLogService extends IService<SysLog> {

    /**
     * 获取日志分页列表
     *
     * @param queryParams 查询参数
     * @return
     */
    Page<LogPageVO> listPagedLogs(LogPageQuery queryParams);


    /**
     * 获取访问趋势
     *
     * @param startDate 开始时间
     * @param endDate   结束时间
     * @return
     */
    VisitTrendVO getVisitTrend(LocalDate startDate, LocalDate endDate);
}
