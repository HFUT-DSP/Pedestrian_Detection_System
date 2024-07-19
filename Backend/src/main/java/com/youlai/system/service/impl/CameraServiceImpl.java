package com.youlai.system.service.impl;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.youlai.system.converter.CameraConverter;
import com.youlai.system.mapper.CameraMapper;
import com.youlai.system.model.entity.Camera;
import com.youlai.system.model.entity.SysDict;
import com.youlai.system.model.entity.SysDictItem;
import com.youlai.system.model.form.CameraForm;
import com.youlai.system.model.form.DictForm;
import com.youlai.system.model.query.CameraPageQuery;
import com.youlai.system.model.vo.CamerapageVO;
import com.youlai.system.service.CameraService;
import com.youlai.system.service.IFLVService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 设备详情
 */
@Service
@RequiredArgsConstructor
public class CameraServiceImpl extends ServiceImpl<CameraMapper, Camera> implements CameraService {

    private final CameraConverter cameraConverter;

    private final IFLVService iflvService;

    /**
     * 获取设备分页详情
     * @param queryParams
     * @return
     */
    @Override
    public IPage<CamerapageVO> listPagedUsers(CameraPageQuery queryParams) {
        // 参数构建
        int pageNum = queryParams.getPageNum();
        int pageSize = queryParams.getPageSize();

        // 查询数据
        IPage<CamerapageVO> camerapageVOIPage = this.baseMapper.listPagedCameras(new Page<>(pageNum, pageSize), queryParams);
        return camerapageVOIPage;
    }

    /**
     * 获取设备表单详情
     * @param id
     * @return
     */
    @Override
    public CameraForm getCameraForm(Long id) {
        // 获取设备
        Camera entity = this.baseMapper.getById(id);
        Assert.isTrue(entity != null, "设备不存在");
        CameraForm cameraForm = cameraConverter.convertToForm(entity);

        return cameraForm;
    }

    /**
     * 修改摄像头设备
     * @param id
     * @param cameraForm
     * @return
     */
    @Override
    public boolean updateDict(Long id, CameraForm cameraForm) {
        String cameraName = cameraForm.getCameraName();
        long count = this.count(new LambdaQueryWrapper<Camera>()
                .eq(Camera::getCameraName, cameraName)
                .ne(Camera::getId, id)
        );
        Assert.isTrue(count == 0, "摄像头已存在");

        // form -> entity
        Camera entity = cameraConverter.convertToEntity(cameraForm);

        // 修改用户
        boolean result = this.updateById(entity);
        return result;
    }

    /**
     * 新增设备
     * @param cameraForm
     * @return
     */
    @Override
    public boolean saveDict(CameraForm cameraForm) {
        // 保存设备
        Camera entity = cameraConverter.convertToEntity(cameraForm);

        // 校验 code 是否唯一
        long count = this.count(new LambdaQueryWrapper<Camera>()
                .eq(Camera::getCameraName, entity.getCameraName())
        );
        Assert.isTrue(count == 0, "摄像头已存在");

        boolean result = this.save(entity);
        return result;
    }

    /**
     * 删除设备
     * @param ids
     */
    @Override
    @Transactional
    public boolean deleteDictByIds(String ids) {
        Assert.isTrue(StrUtil.isNotBlank(ids), "请选择需要删除的设备");
        // 逻辑删除
        List<Long> idList = Arrays.stream(ids.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());

        return this.removeByIds(idList);
    }

    /**
     * 根据视频rtsp流链接打开转换，通过响应写出流到前台使用flvjs播放视频
     * @param id 视频链接对应的id
     * @param httpServletResponse 响应请求
     * @author tyh
     */
    @Override
    public HttpServletResponse openvideo(Long id, HttpServletResponse httpServletResponse) {
        Camera entity = this.baseMapper.getById(id);
        String url = entity.getCameraRTSP();
        try {
            //获取当前登录用户主键
            String userId = "1";
            //String userId = UserContext.getCurrentUser().getId();
            //为保持url长度，需要先对前端传来的url进行base64解码，再调用flvService接口
            httpServletResponse = iflvService.open(url, userId, httpServletResponse);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return httpServletResponse;
    }
}
