package com.youlai.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.youlai.system.model.entity.Model;
import com.youlai.system.model.form.ModelForm;
import com.youlai.system.model.query.ModelPageQuery;
import com.youlai.system.model.vo.ModelpageVO;

public interface ModelService extends IService<Model> {
    /**
     * 模型分页界面
     * @param modelPageQuery
     * @return
     */
    IPage<ModelpageVO> listPagedUsers(ModelPageQuery modelPageQuery);

    /**
     * 模型表单获取
     * @param id
     * @return
     */
    ModelForm getModelForm(Long id);

    /**
     * 修改模型
     * @param id
     * @param modelForm
     * @retutn
     */
    boolean updateDict(Long id, ModelForm modelForm);

    /**
     * 新增模型
     * @param modelForm
     * @return
     */
    boolean saveDict(ModelForm modelForm);

    /**
     * 删除模型
     * @param ids
     */
    boolean deleteDictByIds(String ids);
}
