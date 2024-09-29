package com.youlai.system.controller;//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

import ai.onnxruntime.OnnxTensor;
import ai.onnxruntime.OrtEnvironment;
import ai.onnxruntime.OrtException;
import ai.onnxruntime.OrtSession;
import io.milvus.Response.DescCollResponseWrapper;
import io.milvus.Response.GetCollStatResponseWrapper;
import io.milvus.Response.QueryResultsWrapper;
import io.milvus.Response.SearchResultsWrapper;
import io.milvus.client.MilvusServiceClient;
import io.milvus.grpc.CalcDistanceResults;
import io.milvus.grpc.DataType;
import io.milvus.grpc.DescribeCollectionResponse;
import io.milvus.grpc.DescribeIndexResponse;
import io.milvus.grpc.GetCollectionStatisticsResponse;
import io.milvus.grpc.GetIndexBuildProgressResponse;
import io.milvus.grpc.GetIndexStateResponse;
import io.milvus.grpc.ManualCompactionResponse;
import io.milvus.grpc.MutationResult;
import io.milvus.grpc.QueryResults;
import io.milvus.grpc.SearchResults;
import io.milvus.grpc.ShowCollectionsResponse;
import io.milvus.grpc.ShowPartitionsResponse;
import io.milvus.param.ConnectParam;
import io.milvus.param.IndexType;
import io.milvus.param.MetricType;
import io.milvus.param.R;
import io.milvus.param.RpcStatus;
import io.milvus.param.R.Status;
import io.milvus.param.collection.CreateCollectionParam;
import io.milvus.param.collection.DescribeCollectionParam;
import io.milvus.param.collection.DropCollectionParam;
import io.milvus.param.collection.FieldType;
import io.milvus.param.collection.GetCollectionStatisticsParam;
import io.milvus.param.collection.HasCollectionParam;
import io.milvus.param.collection.LoadCollectionParam;
import io.milvus.param.collection.ReleaseCollectionParam;
import io.milvus.param.collection.ShowCollectionsParam;
import io.milvus.param.control.ManualCompactionParam;
import io.milvus.param.dml.CalcDistanceParam;
import io.milvus.param.dml.DeleteParam;
import io.milvus.param.dml.InsertParam;
import io.milvus.param.dml.QueryParam;
import io.milvus.param.dml.SearchParam;
import io.milvus.param.index.CreateIndexParam;
import io.milvus.param.index.DescribeIndexParam;
import io.milvus.param.index.DropIndexParam;
import io.milvus.param.index.GetIndexBuildProgressParam;
import io.milvus.param.index.GetIndexStateParam;
import io.milvus.param.partition.CreatePartitionParam;
import io.milvus.param.partition.DropPartitionParam;
import io.milvus.param.partition.HasPartitionParam;
import io.milvus.param.partition.ReleasePartitionsParam;
import io.milvus.param.partition.ShowPartitionsParam;
import java.io.File;
import java.nio.FloatBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Random;
import java.util.Set;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;
import nu.pattern.OpenCV;
import org.opencv.core.Mat;
import org.opencv.core.Size;
import org.opencv.highgui.HighGui;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;

public class GeneralExample {
    private static final MilvusServiceClient milvusClient;
    private static Map<String, String> imagespath_Allmap;
    private static Map<Integer, String> id_imagepath = new HashMap();

    private static final String COLLECTION_NAME = "example_sample";
    private static final String ID_FIELD = "userID";
    private static final String VECTOR_FIELD = "archive_feature";
    private static final Integer VECTOR_DIM = 1000;
    private static final String AGE_FIELD = "userAge";
    private static final IndexType INDEX_TYPE = IndexType.IVF_FLAT;
    private static final String INDEX_PARAM = "{\"nlist\":128}";
    private static final Integer SEARCH_K = 3;
    private static final String SEARCH_PARAM = "{\"nprobe\":10}";

    static {
        OpenCV.loadLocally();
        ConnectParam connectParam = ConnectParam.newBuilder().withHost("localhost").withPort(19530).build();
        milvusClient = new MilvusServiceClient(connectParam);
    }


    public GeneralExample() {
    }


    private void handleResponseStatus(R<?> r) {
        if (r.getStatus() != Status.Success.getCode()) {
            throw new RuntimeException(r.getMessage());
        }
    }

    private R<RpcStatus> createCollection(long timeoutMilliseconds) {
        System.out.println("========== createCollection() ==========");
        FieldType fieldType1 = FieldType.newBuilder().withName("userID").withDescription("user identification").withDataType(DataType.Int64).withPrimaryKey(true).withAutoID(true).build();
        FieldType fieldType2 = FieldType.newBuilder().withName("archive_feature").withDescription("face embedding").withDataType(DataType.FloatVector).withDimension(VECTOR_DIM).build();
        FieldType fieldType3 = FieldType.newBuilder().withName("userAge").withDescription("user age").withDataType(DataType.Int32).build();
        CreateCollectionParam createCollectionReq = CreateCollectionParam.newBuilder().withCollectionName("example_sample").withDescription("customer info").withShardsNum(2).addFieldType(fieldType1).addFieldType(fieldType2).addFieldType(fieldType3).build();
        R<RpcStatus> response = milvusClient.withTimeout(timeoutMilliseconds, TimeUnit.MILLISECONDS).createCollection(createCollectionReq);
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<RpcStatus> dropCollection() {
        System.out.println("========== dropCollection() ==========");
        R<RpcStatus> response = milvusClient.dropCollection(DropCollectionParam.newBuilder().withCollectionName("example_sample").build());
        System.out.println(response);
        return response;
    }

    private R<Boolean> hasCollection() {
        System.out.println("========== hasCollection() ==========");
        R<Boolean> response = milvusClient.hasCollection(HasCollectionParam.newBuilder().withCollectionName("example_sample").build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<RpcStatus> loadCollection() {
        System.out.println("========== loadCollection() ==========");
        R<RpcStatus> response = milvusClient.loadCollection(LoadCollectionParam.newBuilder().withCollectionName("example_sample").build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<RpcStatus> releaseCollection() {
        System.out.println("========== releaseCollection() ==========");
        R<RpcStatus> response = milvusClient.releaseCollection(ReleaseCollectionParam.newBuilder().withCollectionName("example_sample").build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<DescribeCollectionResponse> describeCollection() {
        System.out.println("========== describeCollection() ==========");
        R<DescribeCollectionResponse> response = milvusClient.describeCollection(DescribeCollectionParam.newBuilder().withCollectionName("example_sample").build());
        this.handleResponseStatus(response);
        DescCollResponseWrapper wrapper = new DescCollResponseWrapper((DescribeCollectionResponse)response.getData());
        System.out.println(wrapper.toString());
        return response;
    }

    private R<GetCollectionStatisticsResponse> getCollectionStatistics() {
        System.out.println("========== getCollectionStatistics() ==========");
        R<GetCollectionStatisticsResponse> response = milvusClient.getCollectionStatistics(GetCollectionStatisticsParam.newBuilder().withCollectionName("example_sample").build());
        this.handleResponseStatus(response);
        GetCollStatResponseWrapper wrapper = new GetCollStatResponseWrapper((GetCollectionStatisticsResponse)response.getData());
        System.out.println("Collection row count: " + wrapper.getRowCount());
        return response;
    }

    private R<ShowCollectionsResponse> showCollections() {
        System.out.println("========== showCollections() ==========");
        R<ShowCollectionsResponse> response = milvusClient.showCollections(ShowCollectionsParam.newBuilder().build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<RpcStatus> createPartition(String partitionName) {
        System.out.println("========== createPartition() ==========");
        R<RpcStatus> response = milvusClient.createPartition(CreatePartitionParam.newBuilder().withCollectionName("example_sample").withPartitionName(partitionName).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<RpcStatus> dropPartition(String partitionName) {
        System.out.println("========== dropPartition() ==========");
        R<RpcStatus> response = milvusClient.dropPartition(DropPartitionParam.newBuilder().withCollectionName("example_sample").withPartitionName(partitionName).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<Boolean> hasPartition(String partitionName) {
        System.out.println("========== hasPartition() ==========");
        R<Boolean> response = milvusClient.hasPartition(HasPartitionParam.newBuilder().withCollectionName("example_sample").withPartitionName(partitionName).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<RpcStatus> releasePartition(String partitionName) {
        System.out.println("========== releasePartition() ==========");
        R<RpcStatus> response = milvusClient.releasePartitions(ReleasePartitionsParam.newBuilder().withCollectionName("example_sample").addPartitionName(partitionName).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<ShowPartitionsResponse> showPartitions() {
        System.out.println("========== showPartitions() ==========");
        R<ShowPartitionsResponse> response = milvusClient.showPartitions(ShowPartitionsParam.newBuilder().withCollectionName("example_sample").build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<RpcStatus> createIndex() {
        System.out.println("========== createIndex() ==========");
        R<RpcStatus> response = milvusClient.createIndex(CreateIndexParam.newBuilder().withCollectionName("example_sample").withFieldName("archive_feature").withIndexType(INDEX_TYPE).withMetricType(MetricType.L2).withExtraParam("{\"nlist\":128}").withSyncMode(Boolean.TRUE).build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<RpcStatus> dropIndex() {
        System.out.println("========== dropIndex() ==========");
        R<RpcStatus> response = milvusClient.dropIndex(DropIndexParam.newBuilder().withCollectionName("example_sample").withFieldName("archive_feature").build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<DescribeIndexResponse> describeIndex() {
        System.out.println("========== describeIndex() ==========");
        R<DescribeIndexResponse> response = milvusClient.describeIndex(DescribeIndexParam.newBuilder().withCollectionName("example_sample").withFieldName("archive_feature").build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<GetIndexStateResponse> getIndexState() {
        System.out.println("========== getIndexState() ==========");
        R<GetIndexStateResponse> response = milvusClient.getIndexState(GetIndexStateParam.newBuilder().withCollectionName("example_sample").withFieldName("archive_feature").build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<GetIndexBuildProgressResponse> getIndexBuildProgress() {
        System.out.println("========== getIndexBuildProgress() ==========");
        R<GetIndexBuildProgressResponse> response = milvusClient.getIndexBuildProgress(GetIndexBuildProgressParam.newBuilder().withCollectionName("example_sample").build());
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<MutationResult> delete(String partitionName, String expr) {
        System.out.println("========== delete() ==========");
        DeleteParam build = DeleteParam.newBuilder().withCollectionName("example_sample").withPartitionName(partitionName).withExpr(expr).build();
        R<MutationResult> response = milvusClient.delete(build);
        this.handleResponseStatus(response);
        System.out.println(response.getData());
        return response;
    }

    private R<SearchResults> searchFace(String expr) {
        System.out.println("========== searchFace() ==========");
        long begin = System.currentTimeMillis();
        List<String> outFields = Collections.singletonList("userAge");
        List<List<Float>> vectors = this.generateFloatVectors(expr);
        SearchParam searchParam = SearchParam.newBuilder().withCollectionName("example_sample").withMetricType(MetricType.L2).withOutFields(outFields).withTopK(SEARCH_K).withVectors(vectors).withVectorFieldName("archive_feature").withParams("{\"nprobe\":10}").build();
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
            System.out.println(wrapper.getFieldData("userAge", i));
            List<?> fieldData = wrapper.getFieldData("userAge", i);

            for(int j = 0; j < fieldData.size(); ++j) {
                String fieldstring = fieldData.get(j).toString();
                System.out.println(fieldstring);
                int n = Integer.parseInt(fieldstring);
                String s = (String)id_imagepath.get(n);
                disployimage("G:\\dsp1\\Pedestrian_Detection_System\\Backend\\images\\" + s);
            }
        }

        return response;
    }

    private R<CalcDistanceResults> calDistance() {
        System.out.println("========== calDistance() ==========");
        Random ran = new Random();
        List<Float> vector1 = new ArrayList();
        List<Float> vector2 = new ArrayList();

        for(int d = 0; d < VECTOR_DIM; ++d) {
            vector1.add(ran.nextFloat());
            vector2.add(ran.nextFloat());
        }

        CalcDistanceParam calcDistanceParam = CalcDistanceParam.newBuilder().withVectorsLeft(Collections.singletonList(vector1)).withVectorsRight(Collections.singletonList(vector2)).withMetricType(MetricType.L2).build();
        R<CalcDistanceResults> response = milvusClient.calcDistance(calcDistanceParam);
        this.handleResponseStatus(response);
        System.out.println(response);
        return response;
    }

    private R<QueryResults> query(String expr) {
        System.out.println("========== query() ==========");
        List<String> fields = Arrays.asList("userID", "userAge");
        QueryParam test = QueryParam.newBuilder().withCollectionName("example_sample").withExpr(expr).withOutFields(fields).build();
        R<QueryResults> response = milvusClient.query(test);
        this.handleResponseStatus(response);
        QueryResultsWrapper wrapper = new QueryResultsWrapper((QueryResults)response.getData());
        System.out.println("userID:" + wrapper.getFieldWrapper("userID").getFieldData().toString());
        System.out.println("userAge:" + wrapper.getFieldWrapper("userAge").getFieldData().toString());
        System.out.println("Query row count: " + wrapper.getFieldWrapper("userID").getRowCount());
        return response;
    }

    private R<ManualCompactionResponse> compact() {
        System.out.println("========== compact() ==========");
        R<ManualCompactionResponse> response = milvusClient.manualCompaction(ManualCompactionParam.newBuilder().withCollectionName("example_sample").build());
        this.handleResponseStatus(response);
        return response;
    }

    private R<MutationResult> insert(String partitionName, int count) {
        System.out.println("========== insert() ==========");
        List<List<Float>> vectors = this.generateFloatVectors("images/");
        int ranInt = 0;
        List<Integer> ages = new ArrayList();
        Set<Integer> usedAges = new HashSet();
        Iterator<String> iterator = imagespath_Allmap.keySet().iterator();

        for(long i = 0L; i < (long)count; ++i) {
            do {
                ranInt++;
            } while(usedAges.contains(ranInt));

            usedAges.add(ranInt);
            ages.add(ranInt);
            id_imagepath.put(ranInt, (String)iterator.next());
        }

        System.out.println("我要搜索图像的milvus_ip是：" + ages.get(0));
        List<InsertParam.Field> fields = new ArrayList();
        fields.add(new InsertParam.Field("userAge", DataType.Int32, ages));
        fields.add(new InsertParam.Field("archive_feature", DataType.FloatVector, vectors));
        InsertParam insertParam = InsertParam.newBuilder().withCollectionName("example_sample").withPartitionName(partitionName).withFields(fields).build();
        R<MutationResult> response = milvusClient.insert(insertParam);
        this.handleResponseStatus(response);
        return response;
    }

    private List<List<Float>> generateFloatVectors(String imagePath) {
        String model_path = "src\\main\\resources\\model\\resnet50.onnx";
        OrtEnvironment environment = OrtEnvironment.getEnvironment();
        OrtSession.SessionOptions sessionOptions = new OrtSession.SessionOptions();

        try {
            OrtSession session = environment.createSession(model_path, sessionOptions);
            String meteStr = (String)session.getMetadata().getCustomMetadata().get("names");
            List<List<Float>> vectors = new ArrayList();
            imagespath_Allmap = getImagePathMap(imagePath);
            Iterator var8 = imagespath_Allmap.keySet().iterator();

            while(true) {
                while(var8.hasNext()) {
                    String fileName = (String)var8.next();
                    Mat image = Imgcodecs.imread(imagePath + fileName);
                    long[] inputShape = new long[]{1L, 3L, 224L, 224L};
                    float[] inputData = new float[150528];

                    if (image.empty()) {
                        System.out.println("图片出现问题:" + fileName);
                    } else {
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
                }

                session.close();
                environment.close();
                System.out.println("特征向量准备完毕！！");
                return vectors;
            }
        } catch (OrtException var27) {
            OrtException e = var27;
            throw new RuntimeException(e);
        }
    }

    public static Map<String, String> getImagePathMap(String imagePath) {
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

    public static void disployimage(String imagePath) {
        Mat src = Imgcodecs.imread(imagePath);
        if (src.empty()) {
            System.out.println("Error: Could not open or find the image.");
        } else {
            Size targetSize = new Size(224.0, 224.0);
            Mat dst = new Mat();
            Imgproc.resize(src, dst, targetSize);
            HighGui.imshow("Image", dst);
            HighGui.waitKey(10000);
            HighGui.destroyAllWindows();
        }
    }

    public static void main(String[] args) throws OrtException {
        GeneralExample example = new GeneralExample();
        example.dropCollection();
        example.createCollection(2000L);
        example.hasCollection();
        example.describeCollection();
        example.showCollections();
        example.createIndex();
        example.loadCollection();
        String partitionName = "p1";
        example.createPartition("p1");
        example.hasPartition("p1");
        example.showPartitions();

        int row_count = 0;
        List<Long> deleteIds = new ArrayList();
        Random ran = new Random();
        R<MutationResult> result = example.insert("p1", 437);
//        MutationResultWrapper wrapper = new MutationResultWrapper((MutationResult)result.getData());
//        List<Long> ids = wrapper.getLongIDs();
//        deleteIds.add((Long)ids.get(ran.nextInt(437)));
//        example.getCollectionStatistics();
//        example.describeIndex();
//        example.getIndexBuildProgress();
//        example.getIndexState();
////        String searchExpr = "search_image/";
////        example.searchFace(searchExpr);
        example.searchFace("search_image1/");

//        example.compact();
//        example.getCollectionStatistics();
//        example.releaseCollection();
//        example.dropPartition("p1");
//        example.dropIndex();
//        example.dropCollection();
    }
}
