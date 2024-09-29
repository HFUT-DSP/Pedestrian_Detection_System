package com.youlai.system.common.base;


import io.milvus.param.IndexType;

public class BaseMilvusQuery {
    /**
     * 模型地址
     */
    public static final String model_path = "src\\main\\resources\\model\\resnet50.onnx";

    /**
     * 数据库地址
     */
    public static final String database_path = "images/";

    /**
     * 集合名称(库名)
     */
    public static final String COLLECTION_NAME = "example_sample";
    /**
     * 档案id
     */
    public static final String ID_FIELD = "userID";
    /**
     * 特征值名字
     */
    public static final String VECTOR_FIELD = "archive_feature";
    /**
     *特征值长度
     */
    public static final Integer VECTOR_DIM = 1000;
    /**
     *小区id
     */
    public static final String AGE_FIELD = "userAge";
    /**
     * 类型
     */
    public static final IndexType INDEX_TYPE = IndexType.IVF_FLAT;
    public static final String INDEX_PARAM = "{\"nlist\":128}";
    /**
     *选择多少个相似图片
     */
    public static final Integer SEARCH_K = 10;
    public static final String SEARCH_PARAM = "{\"nprobe\":10}";
}
