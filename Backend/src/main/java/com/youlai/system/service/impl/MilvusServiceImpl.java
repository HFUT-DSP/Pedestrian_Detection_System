package com.youlai.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.youlai.system.mapper.MilvusMapper;
import com.youlai.system.model.entity.Milvus;
import com.youlai.system.service.MilvusService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MilvusServiceImpl extends ServiceImpl<MilvusMapper, Milvus> implements MilvusService {

}