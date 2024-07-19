package com.youlai.system.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.youlai.system.model.entity.Model;
import com.youlai.system.model.query.ModelPageQuery;
import com.youlai.system.model.vo.ModelpageVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ModelMapper extends BaseMapper<Model> {
    /**
     *获取模型分页详情
     * @param objectPage
     * @param queryParams
     * @return
     */
    IPage<ModelpageVO> listPagedModels(Page<Object> objectPage, ModelPageQuery queryParams);

    /**
     * 获取设备表单详情
     *
     * @param id
     * @return
     */
    @Select("select * from model where id = #{id}")
    Model getById(Long id);

}
