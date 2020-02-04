/*
 Navicat Premium Data Transfer

 Source Server         : 本地数据库
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : sxblog

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 04/02/2020 17:46:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appreciation` bit(1) NOT NULL,
  `commentabled` bit(1) NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `first_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `published` bit(1) NOT NULL,
  `recommend` bit(1) NOT NULL,
  `share_statement` bit(1) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `views` int(11) NULL DEFAULT NULL,
  `type_id` bigint(20) NULL DEFAULT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK292449gwg5yf7ocdlmswv9w4j`(`type_id`) USING BTREE,
  INDEX `FK8ky5rrsxh01nkhctmo7d48p82`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES (1, b'0', b'0', '创建一个交互式容器：\r\ndocker run -i -t --name c1 centos /bin/bash\r\n参数意义：\r\n-i:交互式容器\r\n-t:tty终端（分配一个终端 操作容器）\r\n--name:指定容器的名称(唯一，不能重复)\r\n\r\n创建守护式容器：（后台运行）\r\ndocker run -d --name c2 centos /bin/bash\r\n\r\n进入守护式容器：\r\ndocker -it  /容器名称 /bin/bash', '2020-01-23 21:25:58', 'https://picsum.photos/536/354', '', b'0', b'1', b'0', 'Docker创建容器', '2020-01-25 13:28:18', 0, 9, 1, '创建一个交互式容器：\r\ndocker run -i -t --name c1 centos /bin/bash\r\n参数意义：\r\n-i:交互式容器\r\n-t:tty终端（分配一个终端 操作容器）\r\n--name:指定容器的名称(唯一，不能重复)\r\n\r\n创建守护式容器：（后台运行）');
INSERT INTO `t_blog` VALUES (3, b'1', b'0', '### 6.4 jackson封装解决字段序列化及反序列化\r\n\r\n主要针对一些数据进行过滤设置，使用jackson来实现，比如一些自增的id值或者一些混淆的属性，在互联网传输的过程中最好不要轻易暴露在外面，这样安全性就比较低，应该对这些自增的值进行加密混淆。\r\n\r\n日期处理：在网络上进行传输的时候不要直接传输日期的格式，传输的格式为13位时间戳，如果在每个日期字段都手动设置的话是比较费时费力的，所以也可以做成自动转换，用的也是jackson来完成\r\n\r\n主要的类包括：\r\n\r\n- IdEncrypt 自定义注解  作用在需要混淆的字段属性上，用于非id的属性上   在model包下\r\n- DateDeserializer  用于处理日期输入反序列化                       \r\n- DateSerializer    用于日期的序列化输出\r\n- ConfusionSerializer    用于序列化自增数字的混淆\r\n- ConfusionDeserializer   用于反序列化自增数字的混淆解密\r\n- ConfusionSerializerModifier   用于过滤序列化时处理的字段\r\n- ConfusionDeserializerModifier    用于过滤反序列化时处理的字段\r\n- ConfusionModule  用于注册模块和修改器\r\n- InitJacksonConfig   提供自动化配置默认ObjectMapper，让整个框架自动处理日期和id混淆\r\n\r\n### 6.5 通用环境说明\r\n\r\n#### 6.5.1 多环境切换\r\n\r\n在每一个微服务的工程中的根目录下创建三个文件，方便各个环境的切换\r\n\r\n（1）maven_dev.properties  \r\n\r\n​	定义开发环境的配置\r\n\r\n（2）maven_prod.properties  \r\n\r\n​	定义生产环境的配置\r\n\r\n（3）maven_test.properties   \r\n\r\n​	定义测试环境的配置，开发阶段使用这个测试环境\r\n\r\n**默认加载的环境为test，在打包的过程中也可以指定参数打包  package -P test/prod/dev**\r\n\r\n具体配置，请查看父工程下的maven插件的profiles配置\r\n\r\n```xml\r\n<profiles>\r\n    <profile>\r\n        <id>dev</id>\r\n        <build>\r\n            <filters>\r\n                <filter>maven_dev.properties</filter>\r\n            </filters>\r\n        </build>\r\n    </profile>\r\n    <profile>\r\n        <id>test</id>\r\n        <activation>\r\n            <activeByDefault>true</activeByDefault>\r\n        </activation>\r\n        <build>\r\n            <filters>\r\n                <filter>maven_test.properties</filter>\r\n            </filters>\r\n        </build>\r\n    </profile>\r\n    <profile>\r\n        <id>prod</id>\r\n        <build>\r\n            <filters>\r\n                <filter>maven_prod.properties</filter>\r\n            </filters>\r\n        </build>\r\n    </profile>\r\n</profiles>\r\n```\r\n\r\n#### 6.5.2 mysql的环境配置\r\n\r\n在heima-leadnews-common设置配置文件mysql-core-jdbc.properties\r\n\r\n```properties\r\n### ======================= 核心数据库连接配置 =========================\r\n# 数据库连接字符串\r\nmysql.core.jdbc-url=${mysql.core.jdbc.url}\r\n# 数据库连接名称\r\nmysql.core.jdbc-user-name=${mysql.core.jdbc.username}\r\n# 数据库连接密码，密码需要反转\r\nmysql.core.jdbc-password=${mysql.core.jdbc.password}\r\n# 数据库连接驱动\r\nmysql.core.jdbc-driver=${mysql.core.jdbc.driver}\r\n# mybatis mapper.xml存放在classpath下的根文件夹名称\r\nmysql.core.root-mapper=${mysql.core.root.mapper}\r\n# mybatis pojo对象别名扫描包\r\nmysql.core.aliases-package=${mysql.core.aliases.package}\r\n# 事务扫描包自动代理扫描包\r\nmysql.core.tx-scan-package=${mysql.core.tx.scan.package}\r\n```\r\n\r\n这里面的内容统统都是从maven_test.properties读取\r\n\r\n```properties\r\nmysql.core.jdbc.url=jdbc:mysql://localhost:3306/heima-leadnews?autoReconnect=true&useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai\r\nmysql.core.jdbc.username=root\r\nmysql.core.jdbc.password=toor\r\n\r\nmysql.core.jdbc.driver=com.mysql.jdbc.Driver\r\nmysql.core.root.mapper=mappers\r\nmysql.core.aliases.package=com.heima.model.**\r\nmysql.core.tx.scan.package=execution(* com.heima..service.*.*(..))\r\n```\r\n\r\n自动化配置核心数据库的连接配置com.heima.common.mysql.core.MysqlCoreConfig\r\n\r\n```java\r\n/**\r\n * 自动化配置核心数据库的连接配置\r\n */\r\n@Setter\r\n@Getter\r\n@Configuration\r\n@ConfigurationProperties(prefix = \"mysql.core\")\r\n@PropertySource(\"classpath:mysql-core-jdbc.properties\")\r\n@MapperScan(basePackages = \"com.heima.model.mappers\", sqlSessionFactoryRef = \"mysqlCoreSqlSessionFactory\")\r\npublic class MysqlCoreConfig {\r\n    String jdbcUrl;\r\n    String jdbcUserName;\r\n    String jdbcPassword;\r\n    String jdbcDriver;\r\n    String rootMapper;//mapper文件在classpath下存放的根路径\r\n    String aliasesPackage;//别名包\r\n\r\n    /**\r\n     * 这是最快的数据库连接池\r\n     *\r\n     * @return\r\n     */\r\n    @Bean\r\n    public DataSource mysqlCoreDataSource() {\r\n        HikariDataSource hikariDataSource = new HikariDataSource();\r\n        hikariDataSource.setUsername(this.getJdbcUserName());\r\n        hikariDataSource.setPassword(this.getRealPassword());\r\n        hikariDataSource.setJdbcUrl(this.getJdbcUrl());\r\n        //最大连接数\r\n        hikariDataSource.setMaximumPoolSize(50);\r\n        //最小连接数\r\n        hikariDataSource.setMinimumIdle(5);\r\n        hikariDataSource.setDriverClassName(this.getJdbcDriver());\r\n        return hikariDataSource;\r\n    }\r\n\r\n    /**\r\n     * 这是Mybatis的Session\r\n     *\r\n     * @return\r\n     * @throws IOException\r\n     */\r\n    @Bean\r\n    public SqlSessionFactoryBean mysqlCoreSqlSessionFactory(@Qualifier(\"mysqlCoreDataSource\") DataSource mysqlCoreDataSource) throws IOException {\r\n        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();\r\n        //创建sqlSessionFactory工厂对象\r\n        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();\r\n        //数据源\r\n        sessionFactory.setDataSource(mysqlCoreDataSource);\r\n        //mapper文件的路径\r\n        sessionFactory.setMapperLocations(resolver.getResources(this.getMapperFilePath()));\r\n        //别名\r\n        sessionFactory.setTypeAliasesPackage(this.getAliasesPackage());\r\n        //开启自动驼峰标识转换\r\n        org.apache.ibatis.session.Configuration mybatisConf = new org.apache.ibatis.session.Configuration();\r\n        mybatisConf.setMapUnderscoreToCamelCase(true);\r\n        sessionFactory.setConfiguration(mybatisConf);\r\n        return sessionFactory;\r\n    }\r\n\r\n    /**\r\n     * 密码反转，简单示意密码在配置文件中的加密处理\r\n     *\r\n     * @return\r\n     */\r\n    public String getRealPassword() {\r\n        return StringUtils.reverse(this.getJdbcPassword());\r\n    }\r\n\r\n    /**\r\n     * 拼接Mapper.xml文件的存放路径\r\n     *\r\n     * @return\r\n     */\r\n    public String getMapperFilePath() {\r\n        return new StringBuffer().append(\"classpath:\").append(this.getRootMapper()).append(\"/**/*.xml\").toString();\r\n    }\r\n\r\n\r\n}\r\n```\r\n\r\n通用事务管理配置类com.heima.common.mysql.core.TransactionConfig\r\n\r\n```java\r\n@Setter\r\n@Getter\r\n@Aspect\r\n@EnableAspectJAutoProxy\r\n@EnableTransactionManagement\r\n@Configuration\r\n@ConfigurationProperties(prefix=\"mysql.core\")\r\n@PropertySource(\"classpath:mysql-core-jdbc.properties\")\r\npublic class TransactionConfig {\r\n\r\n    String txScanPackage;\r\n\r\n    /**\r\n     * 初始化事务管理器\r\n     * @param dataSource\r\n     * @return\r\n     */\r\n    @Bean\r\n    public DataSourceTransactionManager mysqlCoreDataSourceTransactionManager(@Qualifier(\"mysqlCoreDataSource\") DataSource dataSource){\r\n        DataSourceTransactionManager dataSourceTransactionManager = new DataSourceTransactionManager();\r\n        dataSourceTransactionManager.setDataSource(dataSource);\r\n        return dataSourceTransactionManager;\r\n    }\r\n\r\n    /**\r\n     * 设置事务拦截器\r\n     * @param dataSourceTransactionManager\r\n     * @return\r\n     */\r\n    @Bean\r\n    public TransactionInterceptor mysqlCoreDataSourceTxAdvice(@Qualifier(\"mysqlCoreDataSourceTransactionManager\") DataSourceTransactionManager dataSourceTransactionManager) {\r\n        // 默认事务\r\n        DefaultTransactionAttribute defAttr = new DefaultTransactionAttribute(TransactionDefinition.PROPAGATION_REQUIRED);\r\n        // 查询只读事务\r\n        DefaultTransactionAttribute queryAttr = new DefaultTransactionAttribute(TransactionDefinition.PROPAGATION_REQUIRED);\r\n        queryAttr.setReadOnly(true);\r\n        // 设置拦截的方法\r\n        NameMatchTransactionAttributeSource source = new NameMatchTransactionAttributeSource();\r\n        source.addTransactionalMethod(\"save*\", defAttr);\r\n        source.addTransactionalMethod(\"insert*\", defAttr);\r\n        source.addTransactionalMethod(\"delete*\", defAttr);\r\n        source.addTransactionalMethod(\"update*\", defAttr);\r\n        source.addTransactionalMethod(\"exec*\", defAttr);\r\n        source.addTransactionalMethod(\"set*\", defAttr);\r\n        source.addTransactionalMethod(\"add*\", defAttr);\r\n        source.addTransactionalMethod(\"get*\", queryAttr);\r\n        source.addTransactionalMethod(\"query*\", queryAttr);\r\n        source.addTransactionalMethod(\"find*\", queryAttr);\r\n        source.addTransactionalMethod(\"list*\", queryAttr);\r\n        source.addTransactionalMethod(\"count*\", queryAttr);\r\n        source.addTransactionalMethod(\"is*\", queryAttr);\r\n\r\n        return new TransactionInterceptor(dataSourceTransactionManager, source);\r\n    }\r\n\r\n    @Bean\r\n    public Advisor txAdviceAdvisor(@Qualifier(\"mysqlCoreDataSourceTxAdvice\") TransactionInterceptor mysqlCoreDataSourceTxAdvice) {\r\n        AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();\r\n        pointcut.setExpression(txScanPackage);\r\n        return new DefaultPointcutAdvisor(pointcut, mysqlCoreDataSourceTxAdvice);\r\n    }\r\n\r\n}\r\n```\r\n\r\n#### 6.4.3 实体类及mapper', '2020-01-25 13:29:35', 'https://picsum.photos/536/356', '翻译', b'0', b'0', b'1', 'jackson封装解决字段序列化及反序列化11111', '2020-01-25 13:29:27', 0, 4, 1, '主要针对一些数据进行过滤设置，使用jackson来实现，比如一些自增的id值或者一些混淆的属性，在互联网传输的过程中最好不要轻易暴露在外面，这样安全性就比较低，应该对这些自增的值进行加密混淆。');
INSERT INTO `t_blog` VALUES (5, b'1', b'1', '测试描述字段', '2020-01-25 13:24:20', 'https://picsum.photos/seed/picsum/800/450', '', b'1', b'1', b'1', '测试描述', '2020-01-25 13:24:20', 0, 6, 1, '测试描述字段');
INSERT INTO `t_blog` VALUES (6, b'0', b'0', '# **Git学习笔记**\r\n\r\n\r\n\r\n- **进入git 管理目录，初始化**\r\n\r\n  ```\r\n  git init\r\n  ```\r\n\r\n  \r\n\r\n\r\n\r\n​	查看文件状态\r\n\r\n```\r\n	git  status \r\n```\r\n\r\n\r\n\r\n提交到缓存\r\n\r\n```\r\ngit  add 文件名（*所有文件），（.所有未提交文件）\r\n```\r\n\r\n  提交到仓库\r\n\r\n```\r\ngit commit -m \"备注\"\r\n```\r\n\r\n\r\n\r\n查看提交的版本 \r\n\r\n```\r\ngit  log\r\n```\r\n\r\n\r\n\r\n回退版本\r\n\r\n```\r\ngit  reset --hard  \"版本号\"\r\n```\r\n\r\n\r\n\r\n查看回退之前的log\r\n\r\n\r\n\r\n```\r\ngit reflog\r\n```\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n**分支**\r\n\r\n查看分支：\r\n\r\n```\r\ngit branch\r\n```\r\n\r\n\r\n\r\n创建分支\r\n\r\n```\r\ngit branch  分支名字\r\n\r\n```\r\n\r\n\r\n\r\n切换分支\r\n\r\n```\r\ngit checkout \"切换到分支的名字\"\r\n\r\n```\r\n\r\n\r\n\r\n分支合并\r\n\r\n```\r\ngit  merge 要合并的分支（可能产生冲突）\r\n\r\n```\r\n\r\n注意;切花到主分支在合并\r\n\r\n\r\n\r\n删除分支\r\n\r\n```\r\ngit branch -d 分支名称\r\n\r\n```\r\n\r\n\r\n\r\n**工作流**\r\n\r\n\r\n\r\n\r\n\r\n###### **云端代码管理**\r\n\r\n给远程仓库起别名：\r\n\r\n```\r\ngit remote add origin（可起别名） 仓库地址\r\n\r\n```\r\n\r\n\r\n\r\n向远程仓库推送代码\r\n\r\n```\r\n git push -u origin 分支\r\n\r\n```\r\n\r\n\r\n\r\n\r\n\r\n克隆远程仓库代码\r\n\r\n```\r\ngit clone 远程仓库地址（内部已实现了git remote add origin 起别名）\r\n\r\n```\r\n\r\n切换分支\r\n\r\n```\r\ngit checkout 分支名称\r\n\r\n```\r\n\r\n\r\n\r\n在公司进行开发\r\n\r\n```\r\n1、切换到dev分支\r\ngit checkout dev\r\n2、把master分支合并到dev分支[仅一次]\r\n git merge master\r\n \r\n3、修改代码\r\ngit add.\r\ngit commit\r\ngit push origin dev\r\n\r\n4、回家，继续写代码\r\n git checkout dev\r\n git pull origin dev\r\n \r\n git add.\r\n git commit\r\n git push origin dev\r\n \r\n\r\n```\r\n\r\n### **rebase**\r\n\r\nrebase(变基)：使git提交记录简介\r\n\r\n', '2020-01-25 15:37:37', 'https://picsum.photos/536/354', '', b'0', b'1', b'0', 'git 常用命令', '2020-01-25 15:37:37', 0, 8, 1, 'Git学习笔记');
INSERT INTO `t_blog` VALUES (7, b'1', b'1', '## Docker学习笔记\r\n\r\n#### 安装参考：\r\n\r\n**1.官网中文安装参考手册**\r\nhttps://docs.docker-cn.com/engine/installation/linux/docker-ce/centos/#prerequisites\r\n\r\n2、（CentOS7安装）参考博客：\r\n\r\nhttps://blog.csdn.net/li1325169021/article/details/90780627\r\n\r\n\r\n\r\n#### 基本命令使用\r\n\r\n启动系统：\r\n\r\n```\r\nsystemctl start docker\r\n```\r\n\r\n查看docker状态：\r\n\r\n```\r\nsystemctl status docker\r\n```\r\n\r\n停止Docker\r\n\r\n```\r\nsystemctl stop docker\r\n```\r\n\r\n重启Docker\r\n\r\n```\r\nsystemctl restart docker\r\n```\r\n\r\n常用命令：\r\n\r\n查看Docker版本：\r\n\r\n```\r\ndocker version\r\n```\r\n\r\n查看Docker手册\r\n\r\n```\r\ndocker --help\r\n```\r\n\r\n列出本地镜像：\r\n\r\n```\r\ndocker images\r\n```\r\n\r\n拉取镜像：\r\n\r\n```\r\ndocker pull 镜像名称（不带版本号则默认最新版）\r\n```\r\n\r\n删除镜像：\r\n\r\n```\r\n1、删除一个镜像\r\ndocker rmi 镜像名称/id\r\n\r\n2、删除多个镜像\r\ndocker rmi 镜像名称/id 镜像名称/id ....\r\n\r\n3、删除所有镜像\r\ndocker rmi \'docker images -q\'\r\n\r\n```\r\n\r\n创建容器：\r\n\r\n```\r\n创建一个交互式容器：\r\ndocker run -i -t --name c1 centos /bin/bash\r\n参数意义：\r\n-i:交互式容器\r\n-t:tty终端（分配一个终端 操作容器）\r\n--name:指定容器的名称(唯一，不能重复)\r\n\r\n创建守护式容器：（后台运行）\r\ndocker run -d --name c2 centos /bin/bash\r\n\r\n进入守护式容器：\r\ndocker -it  /容器名称 /bin/bash\r\n\r\n```\r\n\r\n\r\n\r\n查看容器：\r\n\r\n```\r\ndocker ps 查看正在运行的容器\r\ndocker ps -a:查询运行过的容器（历史）\r\ndocker ps -l:查询最后一次运行的容器\r\n```\r\n\r\n\r\n\r\n容器的启动与通知：\r\n\r\n```\r\ndocker start 容器名\r\ndocker stop 容器名\r\ndocker restart 容器名\r\n\r\n\r\n```\r\n\r\n\r\n\r\n查看容器详细信息：\r\n\r\n```\r\ndocker inspect 容器名称\r\n\r\n```\r\n\r\n删除容器：\r\n\r\n```\r\ndocker  rm 容器名称\r\n\r\n```\r\n\r\n\r\n\r\n查看容器日志：\r\n\r\n```\r\ndocker logs 容器名称/id\r\n\r\n```\r\n\r\n\r\n\r\n\r\n\r\n**Docker架构图**\r\n\r\n\r\ndocker整体整体架构为C/S架构\r\n\r\n\r\n\r\n#### 文件拷贝\r\n\r\n容器与宿主机文件相互拷贝\r\n\r\n```\r\ndocker cp 需要拷贝文件或目录 容器名称:容器目录\r\n例如：docker cp 1.txt c2:/root\r\n\r\n```\r\n\r\n也可以将文件从容器中拷贝出来\r\n\r\n```\r\ndocker cp 容器名称：容器目录 需要拷贝文件或目录\r\n例如：docker cp:/root/2.txt /root\r\n\r\n```\r\n\r\n#### 目录挂载\r\n\r\n我们可以在创建容器的时候，将宿主机的目录与容器内的目录进行映射，这样我们就可以通过修改宿主机某个目录的文件从而去影响 容器。\r\n\r\n创建容器 添加-v参数后边为 宿主机目录：容器目录\r\n\r\n```\r\ndocker run -id --name=c4 -v /opt/:/usr/local/myhtml centos\r\n\r\n```\r\n\r\n', '2020-01-25 15:40:24', 'https://picsum.photos/596/354', '', b'0', b'1', b'1', 'Docker学习笔记', '2020-01-26 17:43:30', 0, 9, 1, 'Docker学习笔记\r\n安装参考：\r\n1.官网中文安装参考手册\r\nhttps://docs.docker-cn.com/engine/installation/linux/docker-ce/centos/#prerequisites\r\n\r\n2、（CentOS7安装）参考博客：\r\n\r\nhttps://blog.csdn.net/li1325169021/article/details/90780627');
INSERT INTO `t_blog` VALUES (8, b'1', b'1', 'bug修复', '2020-02-04 16:39:01', 'https://picsum.photos/seed/picsum/800/450', '', b'1', b'1', b'1', 'bug修复', '2020-02-04 16:39:01', 0, 1, 1, 'bug修复');

-- ----------------------------
-- Table structure for t_blog_tags
-- ----------------------------
DROP TABLE IF EXISTS `t_blog_tags`;
CREATE TABLE `t_blog_tags`  (
  `blogs_id` bigint(20) NOT NULL,
  `tags_id` bigint(20) NOT NULL,
  INDEX `FK5feau0gb4lq47fdb03uboswm8`(`tags_id`) USING BTREE,
  INDEX `FKh4pacwjwofrugxa9hpwaxg6mr`(`blogs_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of t_blog_tags
-- ----------------------------
INSERT INTO `t_blog_tags` VALUES (1, 4);
INSERT INTO `t_blog_tags` VALUES (1, 3);
INSERT INTO `t_blog_tags` VALUES (3, 5);
INSERT INTO `t_blog_tags` VALUES (3, 4);
INSERT INTO `t_blog_tags` VALUES (5, 3);
INSERT INTO `t_blog_tags` VALUES (5, 4);
INSERT INTO `t_blog_tags` VALUES (6, 3);
INSERT INTO `t_blog_tags` VALUES (7, 5);
INSERT INTO `t_blog_tags` VALUES (7, 4);
INSERT INTO `t_blog_tags` VALUES (8, 3);
INSERT INTO `t_blog_tags` VALUES (8, 4);

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `blog_id` bigint(20) NULL DEFAULT NULL,
  `parent_comment_id` bigint(20) NULL DEFAULT NULL,
  `admin_comment` bit(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKke3uogd04j4jx316m1p51e05u`(`blog_id`) USING BTREE,
  INDEX `FK4jj284r3pb7japogvo6h72q95`(`parent_comment_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (1, 'https://img03.sogoucdn.com/app/a/100520146/7B03EEAF32EB550DDD60836D25670F0F', '写的不错', '2020-01-26 17:33:33', '304208719@qq.com', 'Alex', 7, NULL, b'0');
INSERT INTO `t_comment` VALUES (2, 'https://img03.sogoucdn.com/app/a/100520146/7B03EEAF32EB550DDD60836D25670F0F', '我也觉得', '2020-01-26 17:37:09', '1688607856@qq.com', 'Daiwei', 7, NULL, b'0');
INSERT INTO `t_comment` VALUES (3, 'https://img03.sogoucdn.com/app/a/100520146/7B03EEAF32EB550DDD60836D25670F0F', '看来没少努力吧', '2020-01-26 17:37:36', '1688607856@qq.com', 'Yang', 7, 2, b'0');
INSERT INTO `t_comment` VALUES (4, 'https://unsplash.it/100/100?image=1005', 'oko', '2020-01-26 17:43:50', '304208719@qq.com', 'Alex', 7, NULL, b'1');
INSERT INTO `t_comment` VALUES (5, 'https://unsplash.it/100/100?image=1005', '博主威武', '2020-01-26 17:44:38', '2020@qq.com', 'xinxin', 7, NULL, b'1');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (3, 'test');
INSERT INTO `t_tag` VALUES (4, 'Docker');
INSERT INTO `t_tag` VALUES (5, 'Json');
INSERT INTO `t_tag` VALUES (6, 'ceceef');

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO `t_type` VALUES (1, '错误日志');
INSERT INTO `t_type` VALUES (2, '认知升价');
INSERT INTO `t_type` VALUES (3, 'Java');
INSERT INTO `t_type` VALUES (4, 'Spring');
INSERT INTO `t_type` VALUES (5, '缓存');
INSERT INTO `t_type` VALUES (6, '测试');
INSERT INTO `t_type` VALUES (7, '框架');
INSERT INTO `t_type` VALUES (8, '工具');
INSERT INTO `t_type` VALUES (9, '运维');
INSERT INTO `t_type` VALUES (10, '开发');
INSERT INTO `t_type` VALUES (11, '前端');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tag` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'https://unsplash.it/100/100?image=1005', '2020-01-22 21:12:32', '304208719@qq.com', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, '2020-01-22 21:13:30', 'Alex', NULL);

SET FOREIGN_KEY_CHECKS = 1;
