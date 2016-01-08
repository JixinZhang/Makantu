服务器域名：XXXXX

请求的URL格式为：[域名]/项目名称/[controller]/[action]

# 注册 #
/user/register

**提交格式：**

提交方式：POST

提交参数：<font color = "red">（本文档除图片数据之外均应提交NSString类型）</font>
 
- username (参考示例：username = testProject)
- password (参考示例：password = 1q2w3e)

**返回格式：**


请求成功：应返回如下信息

{  
"status":1,  
"data":{  
"user_id":"1",  
"username":"testProject"  
},  
"message":"register success"  
}

请求失败，返回相关提示。  
相关的提示有：

- 缺少参数，提示**"Missing parameter"**
- 该用户名已注册，提示**"username exists"**
- 密码长度不在6-20个字符之内，提示**"Password length must be in [6,20]"**

# 登录 #
/user/login

**提交格式：**

提交方式：POST

提交参数：

- username (参考示例：username = testProject)
- password (参考示例：password = 1q2w3e)

**返回格式：**

请求成功：应返回如下信息  
{
"status":"1",
"data":{
"user_id":"1",
"username":"testProject",
"avator":"头像的URL"
},
"message":"Login success"
}

请求失败，返回相关提示。  
相关的提示有：

- 缺少参数，提示**"Missing parameter"**
- 该用户名未注册，提示**"No such user"**
- 密码不正确，提示**"Wrong password"**

# 上传头像 #

/user/avator

**提交格式：**

提交方式：POST

提交参数：

- user_id (参考示例:user\_id = 1)
- data    (参考示例:data = "头像的图片数据")

**返回格式**

