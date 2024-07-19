package com.youlai.system.converter;

import com.youlai.system.model.entity.Model;
import com.youlai.system.model.form.ModelForm;
import org.mapstruct.Mapper;

/**
 * 模型对象转换器
 */
@Mapper(componentModel = "spring")
public interface ModelConverter {
    ModelForm convertToForm(Model entity);

    Model convertToEntity(ModelForm modelForm);
}
