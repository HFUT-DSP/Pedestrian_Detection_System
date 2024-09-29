package com.youlai.system.service.impl;

import ai.onnxruntime.OnnxTensor;
import ai.onnxruntime.OrtEnvironment;
import ai.onnxruntime.OrtException;
import ai.onnxruntime.OrtSession;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.youlai.system.common.base.BaseMilvusQuery;
import com.youlai.system.mapper.MilvusMapper;
import com.youlai.system.model.entity.Milvus;
import com.youlai.system.service.MilvusService;
import io.milvus.Response.DescCollResponseWrapper;
import io.milvus.Response.GetCollStatResponseWrapper;
import io.milvus.Response.QueryResultsWrapper;
import io.milvus.Response.SearchResultsWrapper;
import io.milvus.client.MilvusServiceClient;
import io.milvus.grpc.*;
import io.milvus.param.ConnectParam;
import io.milvus.param.MetricType;
import io.milvus.param.R;
import io.milvus.param.RpcStatus;
import io.milvus.param.collection.*;
import io.milvus.param.control.ManualCompactionParam;
import io.milvus.param.dml.*;
import io.milvus.param.index.*;
import io.milvus.param.partition.*;
import lombok.RequiredArgsConstructor;
import nu.pattern.OpenCV;
import org.opencv.core.Mat;
import org.opencv.core.MatOfByte;
import org.opencv.core.Size;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.nio.FloatBuffer;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MilvusServiceImpl extends ServiceImpl<MilvusMapper, Milvus> implements MilvusService {

    private static Map<String, String> imagespath_Allmap;
    private static Map<Integer, String> id_imagepath = new HashMap();

    @Autowired
    private static MilvusServiceClient milvusClient;

    static {
        OpenCV.loadLocally();
        //必须部署milvus数据库
        ConnectParam connectParam = ConnectParam.newBuilder().withHost("localhost").withPort(19530).build();
        milvusClient = new MilvusServiceClient(connectParam);
    }

    @Override
    public void handleResponseStatus(R<?> r) {
        if (r.getStatus() != R.Status.Success.getCode()) {
            throw new RuntimeException(r.getMessage());
        }
    }

    /**
     * 创建集合
     * @param timeoutMilliseconds
     * @return R<RpcStatus>
     */
    @Override
    public R<RpcStatus> createCollection(long timeoutMilliseconds) {
        System.out.println("========== createCollection() ==========");
        FieldType fieldType1 = FieldType.newBuilder()
                .withName(BaseMilvusQuery.ID_FIELD)
                .withDescription("user identification")
                .withDataType(DataType.Int64)
                .withPrimaryKey(true)
                .withAutoID(true)
                .build();
        FieldType fieldType2 = FieldType
                .newBuilder()
                .withName(BaseMilvusQuery.VECTOR_FIELD)
                .withDescription("face embedding")
                .withDataType(DataType.FloatVector)
                .withDimension(BaseMilvusQuery.VECTOR_DIM)
                .build();
        FieldType fieldType3 = FieldType.newBuilder()
                .withName(BaseMilvusQuery.AGE_FIELD)
                .withDescription("user age")
                .withDataType(DataType.Int32)
                .build();
        CreateCollectionParam createCollectionReq = CreateCollectionParam.newBuilder()
                .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                .withDescription("customer info")
                .withShardsNum(2)
                .addFieldType(fieldType1)
                .addFieldType(fieldType2)
                .addFieldType(fieldType3)
                .build();
        R<RpcStatus> response = milvusClient.withTimeout(timeoutMilliseconds, TimeUnit.MILLISECONDS)
                .createCollection(createCollectionReq);
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }


    /**
     * s删除集合
     * @return R<RpcStatus>
     */
    @Override
    public R<RpcStatus> dropCollection() {
        System.out.println("========== dropCollection() ==========");
        R<RpcStatus> response = milvusClient.dropCollection(DropCollectionParam.newBuilder()
                .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                .build());
        System.out.println(response);
        return response;
    }

    /**
     * 判断是否有集合
     * @return R<RpcStatus>
     */
    @Override
    public R<Boolean> hasCollection() {
        System.out.println("========== hasCollection() ==========");
        R<Boolean> response = milvusClient.hasCollection(HasCollectionParam.newBuilder()
                .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                .build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }


    public R<RpcStatus> loadCollection() {
        System.out.println("========== loadCollection() ==========");
        R<RpcStatus> response = milvusClient.loadCollection(LoadCollectionParam
                .newBuilder()
                .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                .build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<RpcStatus> releaseCollection() {
        System.out.println("========== releaseCollection() ==========");
        R<RpcStatus> response = milvusClient.releaseCollection(
                ReleaseCollectionParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                        .build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<DescribeCollectionResponse> describeCollection() {
        System.out.println("========== describeCollection() ==========");
        R<DescribeCollectionResponse> response = milvusClient.describeCollection(
                DescribeCollectionParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME).build());
        this.handleResponseStatus(response);
        DescCollResponseWrapper wrapper = new DescCollResponseWrapper((
                DescribeCollectionResponse)response.getData());
        System.out.println(wrapper.toString());
        return response;
    }

    @Override
    public R<GetCollectionStatisticsResponse> getCollectionStatistics() {
        System.out.println("========== getCollectionStatistics() ==========");
        R<GetCollectionStatisticsResponse> response = milvusClient.getCollectionStatistics(
                GetCollectionStatisticsParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME).build());
        this.handleResponseStatus(response);
        GetCollStatResponseWrapper wrapper = new GetCollStatResponseWrapper((
                GetCollectionStatisticsResponse)response.getData());
        System.out.println("Collection row count: " + wrapper.getRowCount());
        return response;
    }

    @Override
    public R<ShowCollectionsResponse> showCollections() {
        System.out.println("========== showCollections() ==========");
        R<ShowCollectionsResponse> response = milvusClient.showCollections(
                ShowCollectionsParam.newBuilder().build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<RpcStatus> createPartition(String partitionName) {
        System.out.println("========== createPartition() ==========");
        R<RpcStatus> response = milvusClient.createPartition(
                CreatePartitionParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                        .withPartitionName(partitionName).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<RpcStatus> dropPartition(String partitionName) {
        System.out.println("========== dropPartition() ==========");
        R<RpcStatus> response = milvusClient.dropPartition(
                DropPartitionParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                        .withPartitionName(partitionName).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<Boolean> hasPartition(String partitionName) {
        System.out.println("========== hasPartition() ==========");
        R<Boolean> response = milvusClient.hasPartition(
                HasPartitionParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                        .withPartitionName(partitionName).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<RpcStatus> releasePartition(String partitionName) {
        System.out.println("========== releasePartition() ==========");
        R<RpcStatus> response = milvusClient.releasePartitions(
                ReleasePartitionsParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                        .addPartitionName(partitionName).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<ShowPartitionsResponse> showPartitions() {
        System.out.println("========== showPartitions() ==========");
        R<ShowPartitionsResponse> response = milvusClient.showPartitions(
                ShowPartitionsParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<RpcStatus> createIndex() {
        System.out.println("========== createIndex() ==========");
        R<RpcStatus> response = milvusClient.createIndex(
                CreateIndexParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                        .withFieldName(BaseMilvusQuery.VECTOR_FIELD)
                        .withIndexType(BaseMilvusQuery.INDEX_TYPE)
                        .withMetricType(MetricType.L2)
                        .withExtraParam(BaseMilvusQuery.INDEX_PARAM)
                        .withSyncMode(Boolean.TRUE).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<RpcStatus> dropIndex() {
        System.out.println("========== dropIndex() ==========");
        R<RpcStatus> response = milvusClient.dropIndex(
                DropIndexParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                        .withFieldName(BaseMilvusQuery.VECTOR_FIELD).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<DescribeIndexResponse> describeIndex() {
        System.out.println("========== describeIndex() ==========");
        R<DescribeIndexResponse> response = milvusClient.describeIndex(
                DescribeIndexParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                        .withFieldName(BaseMilvusQuery.VECTOR_FIELD).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    @Override
    public R<GetIndexStateResponse> getIndexState() {
        System.out.println("========== getIndexState() ==========");
        R<GetIndexStateResponse> response = milvusClient.getIndexState(
                GetIndexStateParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                        .withFieldName(BaseMilvusQuery.VECTOR_FIELD).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    /*@Override
    public R<GetIndexBuildProgressResponse> getIndexBuildProgress() {
        System.out.println("========== getIndexBuildProgress() ==========");
        R<GetIndexBuildProgressResponse> response = milvusClient.getIndexBuildProgress(
                GetIndexBuildProgressParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }*/

    @Override
    public R<MutationResult> delete(String partitionName, String expr) {
        System.out.println("========== delete() ==========");
        DeleteParam build = DeleteParam.newBuilder().withCollectionName(
                BaseMilvusQuery.COLLECTION_NAME)
                .withPartitionName(partitionName)
                .withExpr(expr).build();
        R<MutationResult> response = milvusClient.delete(build);
        this.handleResponseStatus(response);
        System.out.println(response.getData());
        return response;
    }

    @Override
    public R<SearchResults> searchFace(String expr) {
        System.out.println("========== searchFace() ==========");
        long begin = System.currentTimeMillis();
        List<String> outFields = Collections.singletonList(BaseMilvusQuery.AGE_FIELD);
        List<List<Float>> vectors = this.generateFloatVectors(expr);
        SearchParam searchParam = SearchParam.newBuilder()
                .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                .withMetricType(MetricType.L2)
                .withOutFields(outFields)
                .withTopK(BaseMilvusQuery.SEARCH_K)
                .withVectors(vectors)
                .withVectorFieldName(BaseMilvusQuery.VECTOR_FIELD)
                .withParams(BaseMilvusQuery.SEARCH_PARAM)
                .build();
        R<SearchResults> response = milvusClient.search(searchParam);
        long end = System.currentTimeMillis();
        long cost = end - begin;
        System.out.println("Search time cost: " + cost + "ms");
        this.handleResponseStatus(response);
        SearchResultsWrapper wrapper = new SearchResultsWrapper(((SearchResults)response.getData()).getResults());

        for(int i = 0; i < vectors.size(); ++i) {
            System.out.println("Search result of No." + i);
            List<SearchResultsWrapper.IDScore> scores = wrapper.getIDScore(i);
            System.out.println(scores);
            System.out.println("Output field data for No." + i);
            System.out.println(wrapper.getFieldData(BaseMilvusQuery.AGE_FIELD, i));
//            List<?> fieldData = wrapper.getFieldData(BaseMilvusQuery.AGE_FIELD, i);

//            for(int j = 0; j < fieldData.size(); ++j) {
//                String fieldstring = fieldData.get(j).toString();
//                System.out.println(fieldstring);
//                int n = Integer.parseInt(fieldstring);
//                String s = (String)id_imagepath.get(n);
//                disployimage("G:\\dsp1\\Pedestrian_Detection_System\\Backend\\images\\" + s);
//            }
        }

        return response;
    }

    /*@Override
    public R<CalcDistanceResults> calDistance() {
        System.out.println("========== calDistance() ==========");
        Random ran = new Random();
        List<Float> vector1 = new ArrayList();
        List<Float> vector2 = new ArrayList();

        for(int d = 0; d < BaseMilvusQuery.VECTOR_DIM; ++d) {
            vector1.add(ran.nextFloat());
            vector2.add(ran.nextFloat());
        }

        CalcDistanceParam calcDistanceParam = CalcDistanceParam.newBuilder()
                .withVectorsLeft(Collections.singletonList(vector1))
                .withVectorsRight(Collections.singletonList(vector2))
                .withMetricType(MetricType.L2)
                .build();
        R<CalcDistanceResults> response = milvusClient.calcDistance(calcDistanceParam);
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }*/

    @Override
    public R<QueryResults> query(String expr) {
        System.out.println("========== query() ==========");
        List<String> fields = Arrays.asList(BaseMilvusQuery.ID_FIELD, BaseMilvusQuery.AGE_FIELD);
        QueryParam test = QueryParam.newBuilder()
                .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                .withExpr(expr)
                .withOutFields(fields)
                .build();
        R<QueryResults> response = milvusClient.query(test);
        this.handleResponseStatus(response);
        QueryResultsWrapper wrapper = new QueryResultsWrapper((QueryResults)response.getData());
        System.out.println("userID:" + wrapper.getFieldWrapper(BaseMilvusQuery.ID_FIELD).getFieldData().toString());
        System.out.println("userAge:" + wrapper.getFieldWrapper(BaseMilvusQuery.AGE_FIELD).getFieldData().toString());
        System.out.println("Query row count: " + wrapper.getFieldWrapper(BaseMilvusQuery.ID_FIELD).getRowCount());
        return response;
    }

    /*@Override
    public R<ManualCompactionResponse> compact() {
        System.out.println("========== compact() ==========");
        R<ManualCompactionResponse> response = milvusClient.manualCompaction(
                ManualCompactionParam.newBuilder()
                        .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                        .build());
        this.handleResponseStatus(response);
        return response;
    }*/

    /**
     * 插入部分
     * @param partitionName
     * @param count
     * @return
     */
    @Override
    public R<MutationResult> insert(String partitionName, int count) {
        System.out.println("========== insert() ==========");
        List<List<Float>> vectors = this.generateFloatVectors(partitionName);
        int ranInt = 0;
        List<Integer> ages = new ArrayList();
        Set<Integer> usedAges = new HashSet();
        Iterator<String> iterator = imagespath_Allmap.keySet().iterator();
        Milvus milvus = new Milvus();

        for(long i = 0L; i < (long)count; ++i) {
            do {
                ranInt++;
            } while(usedAges.contains(ranInt));
            usedAges.add(ranInt);
            ages.add(ranInt);
            id_imagepath.put(ranInt, (String)iterator.next());
        }

//        System.out.println("我要搜索图像的milvus_ip是：" + ages.get(0));
        List<InsertParam.Field> fields = new ArrayList();
        fields.add(new InsertParam.Field(BaseMilvusQuery.AGE_FIELD, DataType.Int32, ages));
        fields.add(new InsertParam.Field(BaseMilvusQuery.VECTOR_FIELD, DataType.FloatVector, vectors));
        InsertParam insertParam = InsertParam.newBuilder()
                .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                .withPartitionName(partitionName)
                .withFields(fields)
                .build();
        R<MutationResult> response = milvusClient.insert(insertParam);
        this.handleResponseStatus(response);
        return response;
    }

    /**
     * 将图片利用模型转化成特征向量
     * @param imagePath
     * @return
     */
    @Override
    public List<List<Float>> generateFloatVectors(String imagePath) {
        OrtEnvironment environment = OrtEnvironment.getEnvironment();
        OrtSession.SessionOptions sessionOptions = new OrtSession.SessionOptions();

        try {
            OrtSession session = environment.createSession(BaseMilvusQuery.model_path, sessionOptions);
            String meteStr = (String)session.getMetadata().getCustomMetadata().get("names");
            List<List<Float>> vectors = new ArrayList();
            imagespath_Allmap = getImagePathMap(imagePath);
            Iterator var8 = imagespath_Allmap.keySet().iterator();


            while(var8.hasNext()) {
                String fileName = (String)var8.next();
                Mat image = Imgcodecs.imread(imagePath + fileName);
                long[] inputShape = new long[]{1L, 3L, 224L, 224L};
                float[] inputData = new float[150528];
                if (image.empty()) {
                    System.out.println("图片出现问题:" + fileName);
                    continue;
                }
                Size targetSize = new Size(224.0, 224.0);
                Mat resizedImage = new Mat();
                Imgproc.resize(image, resizedImage, targetSize);
                resizedImage.convertTo(resizedImage, 5, 0.00392156862745098);
                int index = 0;

                for(int i = 0; i < resizedImage.rows(); ++i) {
                    for(int j = 0; j < resizedImage.cols(); ++j) {
                        for(int k = 0; k < resizedImage.channels(); ++k) {
                            inputData[index++] = (float)resizedImage.get(i, j)[k];
                        }
                    }
                }

                OnnxTensor inputTensor = OnnxTensor.createTensor(environment, FloatBuffer.wrap(inputData), inputShape);
                Map<String, OnnxTensor> inputs = Map.of((String)session.getInputInfo().keySet().iterator().next(), inputTensor);
                OrtSession.Result output = session.run(inputs);
                OnnxTensor outputTensor = (OnnxTensor)output.get(0);
                FloatBuffer floatBuffer = outputTensor.getFloatBuffer();
                float[] outputData = floatBuffer.array();
                List<Float> arrayList = new ArrayList();
                float[] var23 = outputData;
                int var24 = outputData.length;

                for(int var25 = 0; var25 < var24; ++var25) {
                    float element = var23[var25];
                    arrayList.add(element);
                }

                vectors.add(arrayList);
                outputTensor.close();
                inputTensor.close();
                }
            session.close();
            environment.close();
            System.out.println("特征向量准备完毕！！");
            return vectors;
        } catch (OrtException var27) {
            OrtException e = var27;
            throw new RuntimeException(e);
        }
    }


    /**
     * 获得某个地址下全部文件的路径
     * @param imagePath
     * @return
     */
    @Override
    public Map<String, String> getImagePathMap(String imagePath) {
        Map<String, String> map = new TreeMap();
        File file = new File(imagePath);
        if (file.isFile()) {
            map.put(file.getName(), file.getAbsolutePath());
        } else if (file.isDirectory()) {
            File[] var3 = (File[])Objects.requireNonNull(file.listFiles());
            int var4 = var3.length;

            for(int var5 = 0; var5 < var4; ++var5) {
                File tmpFile = var3[var5];
                map.putAll(getImagePathMap(tmpFile.getPath()));
            }
        }

        return map;
    }

    /**
     * 查找一张图片相似的照片
     * @param bytes
     * @return
     */
    @Override
    public  String[] searchOneImage(byte[] bytes) throws IOException {
        OrtEnvironment environment = OrtEnvironment.getEnvironment();
        OrtSession.SessionOptions sessionOptions = new OrtSession.SessionOptions();

        Mat mat = Imgcodecs.imdecode(new MatOfByte(bytes), Imgcodecs.IMREAD_COLOR);
        List<List<Float>> vectors = new ArrayList();
        String[] resImages = new String[BaseMilvusQuery.SEARCH_K];

        try {
            OrtSession session = environment.createSession(BaseMilvusQuery.model_path, sessionOptions);
            long[] inputShape = new long[]{1L, 3L, 224L, 224L};
            float[] inputData = new float[150528];
            Size targetSize = new Size(224.0, 224.0);
            Mat resizedImage = new Mat();
            Imgproc.resize(mat, resizedImage, targetSize);
            resizedImage.convertTo(resizedImage, 5, 0.00392156862745098);
            int index = 0;

            for(int i = 0; i < resizedImage.rows(); ++i) {
                for(int j = 0; j < resizedImage.cols(); ++j) {
                    for(int k = 0; k < resizedImage.channels(); ++k) {
                        inputData[index++] = (float)resizedImage.get(i, j)[k];
                    }
                }
            }
            OnnxTensor inputTensor = OnnxTensor.createTensor(environment, FloatBuffer.wrap(inputData), inputShape);
            Map<String, OnnxTensor> inputs = Map.of((String)session.getInputInfo().keySet().iterator().next(), inputTensor);
            OrtSession.Result output = session.run(inputs);
            OnnxTensor outputTensor = (OnnxTensor)output.get(0);
            FloatBuffer floatBuffer = outputTensor.getFloatBuffer();
            float[] outputData = floatBuffer.array();
            List<Float> arrayList = new ArrayList();
            float[] var23 = outputData;
            int var24 = outputData.length;

            for(int var25 = 0; var25 < var24; ++var25) {
                float element = var23[var25];
                arrayList.add(element);
            }
            vectors.add(arrayList);
        } catch (OrtException e) {
            throw new RuntimeException(e);
        }
        System.out.println("========== searchFace() ==========");
        long begin = System.currentTimeMillis();
        List<String> outFields = Collections.singletonList(BaseMilvusQuery.AGE_FIELD);
        SearchParam searchParam = SearchParam.newBuilder()
                .withCollectionName(BaseMilvusQuery.COLLECTION_NAME)
                .withMetricType(MetricType.L2)
                .withOutFields(outFields)
                .withTopK(BaseMilvusQuery.SEARCH_K)
                .withVectors(vectors)
                .withVectorFieldName(BaseMilvusQuery.VECTOR_FIELD)
                .withParams(BaseMilvusQuery.SEARCH_PARAM)
                .build();
        R<SearchResults> response = milvusClient.search(searchParam);
        long end = System.currentTimeMillis();
        long cost = end - begin;
        System.out.println("Search time cost: " + cost + "ms");
        this.handleResponseStatus(response);
        SearchResultsWrapper wrapper = new SearchResultsWrapper(((SearchResults)response.getData()).getResults());
        Map<String, String> imagePathMap = getImagePathMap(BaseMilvusQuery.database_path);
        List<String> values = imagePathMap.values().stream().collect(Collectors.toList());

        for(int i = 0; i < vectors.size(); ++i) {
            System.out.println("Search result of No." + i);
            List<SearchResultsWrapper.IDScore> scores = wrapper.getIDScore(i);
            System.out.println(scores);
            System.out.println("Output field data for No." + i);
            System.out.println(wrapper.getFieldData(BaseMilvusQuery.AGE_FIELD, i));
            List<?> fieldData = wrapper.getFieldData(BaseMilvusQuery.AGE_FIELD, i);

            for (int j = 0; j < fieldData.size(); ++j) {
                String fieldstring = fieldData.get(j).toString();
                System.out.println(fieldstring);
                int n = Integer.parseInt(fieldstring);
                String res = values.get(n);

                // 读取图像文件
                File file = new File(res);
                BufferedImage image = ImageIO.read(file);
                // 将图像转换为字节数组
                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                ImageIO.write(image, "jpg", byteArrayOutputStream);
                byte[] imageBytes = byteArrayOutputStream.toByteArray();
                // 编码为 Base64 字符串
                String base64String = Base64.getEncoder().encodeToString(imageBytes);
                resImages[j] = "data:image/jpeg;base64," + base64String;
            }
        }

        return resImages;
    }

}