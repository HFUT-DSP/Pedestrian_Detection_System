# 行人跟踪识别系统

本项目旨在实现一个行人跟踪识别系统，主要包括行人检测、行人跟踪、行人属性识别、行人重识别等功能，以及前端展示和后端管理功能。

各文件夹说明：

-   设计文档以及会议记录见 `Documents/` 文件夹
-   前端代码见 `Frontend/` 文件夹
-   后端代码见 `Backend/` 文件夹

## 前端

参考前端地址：[youlaitech/vue3-element-admin: 🔥 基于 vue3 + vite5 + typescript + element-plus 构建的后台管理前端模板（配套后端源码），vue-element-admin 的 vue3 版本。 (github.com)](https://github.com/youlaitech/vue3-element-admin)

### 前端运行所需环境及运行方法：

1. 需下载 node.js >= 18（其中 20.6.0 版本不可用）
2. 运行命令：

    ```
    # 切换目录
    cd Frontend

    # 安装 pnpm
    npm install pnpm -g

    # 安装依赖
    pnpm install

    # 启动运行
    pnpm run dev
    ```

## 后端

参考后端地址：[haoxianrui/youlai-boot: 🌈 基于 Java 17 + Spring Boot 3 + Spring Security 6 + Vue 3 + Element-Plus 构建的前后端分离单体权限管理系统。 (github.com)](https://github.com/haoxianrui/youlai-boot)

### 后端运行所需环境及运行方法：

1. 需要 JDK 版本为 JDK17
2. 项目用到 mysql 数据库和 redis 数据库
3. 执行 youlai_boot.sql 脚本完成数据库创建、表结构和基础数据的初始化。
4. application-dev.yml 修改 MySQL、Redis 连接配置；
5. 运行 redis 服务，执行 SystemApplication.java 的 main 方法完成后端项目启动；（单独运行后端时，可访问接口文档地址 http://localhost:8989/doc.html 验证项目启动是否成功。）
