package com.youlai.system.converter;

import com.youlai.system.model.entity.Camera;
import com.youlai.system.model.entity.SysDict;
import com.youlai.system.model.form.CameraForm;
import com.youlai.system.model.form.DictForm;
import org.mapstruct.Mapper;

/**
 * 摄像头 对象转换器
 *
 * @author Ray Hao
 * @since 2022/6/8
 */
@Mapper(componentModel = "spring")
public interface CameraConverter {

    CameraForm convertToForm(Camera entity);

    Camera convertToEntity(CameraForm cameraForm);
}
