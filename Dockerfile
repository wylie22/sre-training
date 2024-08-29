# 基础镜像
FROM openjdk:17
# author
LABEL version="0.01" author="Bingo" description="Bingo Core"
#运行命令，每次run都会生成一个图层，所以最好将命令合并
#RUN apt-get update \
#    && apt-get install -y vim
# 挂载目录
VOLUME ["/home/logs"]
# 指定工作路径
WORKDIR /home/app
# 复制jar文件到路径
#COPY build/libs/*.jar Bingo.jar
COPY bingo-2024042202.jar Bingo.jar
# 启动网关服务
ENTRYPOINT ["java","-jar","Bingo.jar"]
#构建容器后调用，也就是在容器启动时才进行调用  相当于我们给容器启动过程增加参数
CMD ["--spring.profiles.active=qat"]


#sudo docker run --name bingo -p 9090:9090 -v $PWD/logs:/home/logs -d bingo/last
