# simpleoj

## 本地部署调试
### 后台启动
  - 新建db，新建表
  - 后台配置好db之后，直接启动 springboot。
  
### 前端启动
  - npm install
  - npm run serve
  

## 服务器部署

  - docker pull wangdaowei/simpleojdocker:5.0 
  - docker run -d -p 10090:8181 -m 1g  wangdaowei/simpleojdocker:5.0
  - docker exec -it (容器id) /bin/bash 进入容器替换后台包
