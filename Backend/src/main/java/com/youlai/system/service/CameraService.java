package com.youlai.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.youlai.system.model.entity.Camera;
import com.youlai.system.model.form.CameraForm;
import com.youlai.system.model.form.DictForm;
import com.youlai.system.model.query.CameraPageQuery;
import com.youlai.system.model.vo.CamerapageVO;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 */
public interface CameraService extends IService<Camera> {
    /**
     * 摄像头分页界面
     * @param cameraPageQuery
     * @return
     */
    IPage<CamerapageVO> listPagedUsers(CameraPageQuery cameraPageQuery);

    /**
     * 摄像头表单获取
     * @param id
     * @return
     */
    CameraForm getCameraForm(Long id);

    /**
     * 修改摄像头设备
     * @param id
     * @param cameraForm
     * @return
     */
    boolean updateDict(Long id, CameraForm cameraForm);

    /**
     * 新增设备
     * @param cameraForm
     * @return
     */
    boolean saveDict(CameraForm cameraForm);

    /**
     * 删除设备
     * @param ids
     */
    boolean deleteDictByIds(String ids);

    /**
     *
     * @param id
     */
    HttpServletResponse openvideo(Long id, HttpServletResponse httpServletResponse);
}
