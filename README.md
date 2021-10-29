# YMATE-MAVEN-ARCHETYPES

本项目为快速搭建基于 [YMP - 轻量级 Java 应用开发框架](https://ymate.net/) 的工程代码而提供的一系列 Maven Archetypes 模板。



目前支持构建以下四种项目类型：

- **Quickstart：** 标准 Java 工程，已集成 YMP 核心依赖和参数配置；

- **Webapp：** 标准 Web 工程，已集成 WebMVC 相关依赖和参数配置；

- **Module：** 标准 Maven 多模块工程，已集成 Assembly 插件的自定义打包规则和命令行启动脚本；

- **Microservice：** 基于 YMP 框架的微服务多模块工程（***暂仅内部使用***）；



## 安装与配置

本项目依赖于 [Maven](http://maven.apache.org/) 环境，假设你已具备，编写本文所使用的 Maven 版本为：

```shell
$ mvn -version
Apache Maven 3.1.1 (0728685237757ffbf44136acec0402957f723d9a; 2013-09-17 23:22:22+0800)
Maven home: /Users/....../Java/apache-maven-3.1.1
Java version: 1.8.0_271, vendor: Oracle Corporation
Java home: /Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home/jre
Default locale: zh_CN, platform encoding: UTF-8
OS name: "mac os x", version: "10.15.7", arch: "x86_64", family: "mac"
```

由于本项目仍在不断的优化和完善中，因此并未提交至 Maven 中央库，所以在首次使用时需要下载源码并安装到本地 Maven 仓库中，操作步骤如下：



### STEP 1：下载最新源码



**执行命令：**

- GitHub：

```shell
git clone https://github.com/suninformation/ymate-maven-archetypes.git
```

- 码云：

```shell
git clone https://gitee.com/suninformation/ymate-maven-archetypes.git
```



### STEP 2：编译安装到本地 Maven 仓库



**执行命令：**

```shell
cd ymate-maven-archetypes
mvn clean install
```



> **小提示！**
>
> 为了保持代码是最新的，一定要记得经常使用 `git pull` 命令进行更新！



## 操作说明



### STEP 1：运行工程构建向导

**执行命令：**

```shell
mvn archetype:generate -DarchetypeCatalog=local
```



> **小技巧！**
>
> 为了方便书写，可以通过 `alias` 命令为其创建一个别名（如：`createprj`），设置方法如下：
>
> - 编辑 `~/.bash_profile` 文件并添加以下内容：
>
> ```shell
> alias createprj="mvn archetype:generate -DarchetypeCatalog=local"
> ```
>
> - 使配置生效
>
> ```shell
> source ~/.bash_profile
> ```
>
> - 测试命令
>
> ```shell
> createprj
> ```
>
> *（注：该方法适用于 Linux 和 Mac OS）*



**控制台输出：**

```shell
......
1: local -> net.ymate.maven.archetypes:ymate-archetype-microservice (microservice)
2: local -> net.ymate.maven.archetypes:ymate-archetype-quickstart (quickstart)
3: local -> net.ymate.maven.archetypes:ymate-archetype-module (module)
4: local -> net.ymate.maven.archetypes:ymate-archetype-webapp (webapp)
Choose a number or apply filter (format: [groupId:]artifactId, case sensitive contains): :
```

> **小提示！**
>
> 若命令执行后没有显示上述内容，请执行 `mvn archetype:crawl` 命令后再试！



### STEP 2：选择模板并按提示设置

本例演示如何创建 Web 工程，所以此处按屏幕提示应选择 `4` 号模板类型，输入数字并按屏幕提示设置坐标系等信息，如下所示：

```shell
Define value for property 'groupId': : net.ymate.platform.examples
Define value for property 'artifactId': : ymp-examples-webapp
Define value for property 'version':  1.0-SNAPSHOT: :
Define value for property 'package':  net.ymate.platform.examples: :
Confirm properties configuration:
groupId: net.ymate.platform.examples
artifactId: ymp-examples-webapp
version: 1.0-SNAPSHOT
package: net.ymate.platform.examples
 Y: :
```

若以上信息确认无误，按回车键确认并开始生成工程文件。



至此，基于 Maven Archetypes 模板快速搭建 YMP 工程构建完毕！



## One More Thing

YMP 不仅提供便捷的 Web 及其它 Java 项目的快速开发体验，也将不断提供更多丰富的项目实践经验。

感兴趣的小伙伴儿们可以加入官方 QQ 群：480374360，一起交流学习，帮助 YMP 成长！

如果喜欢 YMP，希望得到你的支持和鼓励！

![Donation Code](https://ymate.net/img/donation_code.png)

了解更多有关 YMP 框架的内容，请访问官网：[https://ymate.net](https://ymate.net)
