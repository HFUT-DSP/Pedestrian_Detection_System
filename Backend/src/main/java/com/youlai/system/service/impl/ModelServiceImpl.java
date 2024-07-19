package com.youlai.system.service.impl;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.youlai.system.converter.ModelConverter;
import com.youlai.system.mapper.ModelMapper;
import com.youlai.system.model.entity.Model;
import com.youlai.system.model.entity.SysDict;
import com.youlai.system.model.entity.SysDictItem;
import com.youlai.system.model.form.ModelForm;
import com.youlai.system.model.form.DictForm;
import com.youlai.system.model.query.ModelPageQuery;
import com.youlai.system.model.vo.ModelpageVO;
import com.youlai.system.service.ModelService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 模型详情
 */
@Service
@RequiredArgsConstructor
public class ModelServiceImpl extends ServiceImpl<ModelMapper, Model> implements ModelService {

    private final ModelConverter modelConverter;

    /**
     * 获取设备分页详情
     * @param queryParams
     * @return
     */
    @Override
    public IPage<ModelpageVO> listPagedUsers(ModelPageQuery queryParams) {
        // 参数构建
        int pageNum = queryParams.getPageNum();
        int pageSize = queryParams.getPageSize();

        // 查询数据
        IPage<ModelpageVO> modelpageVOIPage = this.baseMapper.listPagedModels(new Page<>(pageNum, pageSize), queryParams);
        return modelpageVOIPage;
    }

    /**
     * 获取模型表单详情
     * @param id
     * @return
     */
    @Override
    public ModelForm getModelForm(Long id) {
        // 获取模型
        Model entity = this.baseMapper.getById(id);
        Assert.isTrue(entity != null, "模型不存在");
        ModelForm modelForm = modelConverter.convertToForm(entity);

        return modelForm;
    }

    /**
     * 修改模型
     * @param id
     * @param modelForm
     * @retutn
     */
    @Override
    public boolean updateDict(Long id, ModelForm modelForm){
        String modelName = modelForm.getModelName();
        long count = this.count(new LambdaQueryWrapper<Model>()
                .eq(Model::getModelName, modelName)
                .ne(Model::getId, id)
        );
        Assert.isTrue(count == 0, "模型已存在");

        // form -> entity
        Model entity = modelConverter.convertToEntity(modelForm);

        // 修改用户
        boolean result = this.updateById(entity);
        return result;
    }

    /**
     * 新增模型
     * @param modelForm
     * @return
     */
    @Override
    public boolean saveDict(ModelForm modelForm){
        // 保存模型
        Model entity = modelConverter.convertToEntity(modelForm);

        // 校验 code 是否唯一
        long count = this.count(new LambdaQueryWrapper<Model>()
                .eq(Model::getModelName, entity.getModelName())
        );
        Assert.isTrue(count == 0, "模型已存在");

        boolean result = this.save(entity);
        return result;
    }

    /**
     * 删除模型
     * @param ids
     */
    @Override
    @Transactional
    public boolean deleteDictByIds(String ids) {
        Assert.isTrue(StrUtil.isNotBlank(ids), "请选择需要删除的模型");
        // 逻辑删除
        List<Long> idList = Arrays.stream(ids.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());

        return this.removeByIds(idList);
    }

}
