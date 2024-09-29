package com.youlai.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.youlai.system.model.entity.Milvus;
import io.milvus.grpc.*;
import io.milvus.param.R;
import io.milvus.param.RpcStatus;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface MilvusService extends IService<Milvus> {

    void handleResponseStatus(R<?> r);

    /**
     * 创建集合
     * @param timeoutMilliseconds
     * @return
     */
    R<RpcStatus> createCollection(long timeoutMilliseconds);

    /**
     * s删除集合
     * @return R<RpcStatus>
     */
    R<RpcStatus> dropCollection();

    R<Boolean> hasCollection();

    R<RpcStatus> releaseCollection();

    R<DescribeCollectionResponse> describeCollection();

    R<GetCollectionStatisticsResponse> getCollectionStatistics();

    R<ShowCollectionsResponse> showCollections();

    R<RpcStatus> createPartition(String partitionName);

    R<RpcStatus> dropPartition(String partitionName);

    R<Boolean> hasPartition(String partitionName);

    R<RpcStatus> releasePartition(String partitionName);

    R<ShowPartitionsResponse> showPartitions();

    R<RpcStatus> createIndex();

    R<RpcStatus> dropIndex();

    R<DescribeIndexResponse> describeIndex();

    R<GetIndexStateResponse> getIndexState();

//    R<GetIndexBuildProgressResponse> getIndexBuildProgress();

    R<MutationResult> delete(String partitionName, String expr);

    R<SearchResults> searchFace(String expr);

//    R<CalcDistanceResults> calDistance();

    R<QueryResults> query(String expr);

//    R<ManualCompactionResponse> compact();

    /**
     * 插入特征值
     * @param partitionName
     * @param count
     * @return
     */
    R<MutationResult> insert(String partitionName, int count);

    List<List<Float>> generateFloatVectors(String imagePath);

    Map<String, String> getImagePathMap(String imagePath);

    /**
     * 查找一张图片相似的照片
     * @param bytes
     * @return
     */
    String[] searchOneImage(byte[] bytes) throws IOException;
}