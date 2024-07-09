package com.youlai.system.mapper;

/*
 * 菜单 访问层
 *
 * @author Ray
 * @since 2022/1/24
 */

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.youlai.system.model.entity.SysMenu;
import com.youlai.system.model.bo.RouteBO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Set;

@Mapper
public interface SysMenuMapper extends BaseMapper<SysMenu> {

    List<RouteBO> listRoutes(Set<String> roles);

}
