package com.youlai.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.youlai.system.model.entity.Camera;
import com.youlai.system.model.query.CameraPageQuery;
import com.youlai.system.model.vo.CamerapageVO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CameraMapper extends BaseMapper<Camera> {

    /**
     *获取设备分页详情
     * @param objectPage
     * @param queryParams
     * @return
     */
    IPage<CamerapageVO> listPagedCameras(Page<Object> objectPage, CameraPageQuery queryParams);

    /**
     * 获取设备表单详情
     * @param id
     * @return
     */
    @Select("select * from camera where id = #{id}")
    Camera getById(Long id);


}
