应用服务器地址：http://115.28.47.37:8080  
请求的URL格式为：[域名]/[controller]/[action]  

图片服务器地址：http://v0.api.upyuncom/

#1 注册 #
/user/register

**提交格式：**

提交方式：POST

提交参数：<font color = "red">（本文档除图片数据之外均应提交NSString类型）</font>
 
- userName (参考示例：userName = testProject)
- password (参考示例：password = 1q2w3e)

**返回格式：**


请求成功：应返回如下信息

{  
"status":1,  
"data":{  
"id":"1",  
"userName":"testProject",  
"avator":"头像的URL",  
"authCode":"授权码"  
},  
"message":"register success"  
}

请求失败，返回相关提示。  
相关的提示有：

- 缺少参数，提示**"缺少参数"**
- 该用户名已注册，提示**"用户已存在"**

#2 登录 #
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
"id":"1",
"userName":"testProject",
"avator":"头像的URL"
"authCode":"授权码"  
},
"message":"登录成功"
}

请求失败，返回相关提示。  
相关的提示有：

- 缺少参数，提示**"Missing parameter"**
- 该用户名未注册，提示**"无该用户信息"**
- 密码不正确，提示**"密码错误"**

#3 上传头像 #

## 上传到图片服务器  
http://v0.api.upyuncom/  
**提交格式：**

提交方式：POST

提交参数：

- useSaveKey (参考示例:userSaveKey = testProject/2016/1/xxxxxxxxxx.jpg)
- data    	(参考示例:data = "头像的图片数据")

**返回格式**

请求成功：应返回如下信息  
{
"code":"200",
"image-frames":"1"
"image-height":"626",
"image-width":"413",
"image-type":"JPEG",
"message":"of",
"time":"145302759",
"url:"testProject/2016/1/xxxxxxxxxx.jpg"
}

## 上传到应用服务器

/user/updateAvator

**提交格式：**

提交方式：POST

提交参数：

- id        (参考示例:id = 1)
- avator    (参考示例:avator = "testProject/2016/1/xxxxxxxxxx.jpg")

**返回格式**

请求成功：应返回如下信息  
{
"status":"1",
"message":"个人图像更新成功"
}

#4 更改授权码

/user/updateAuthCode

**提交格式：**

提交方式：POST

提交参数：

- id        (参考示例:id = 1)
- authCode    (参考示例:authCode = "12234567890")

**返回格式**

请求成功：应返回如下信息  
{
"status":"1",
"message":"授权码更新成功"
}

#5 上传图片 #

## 上传到图片服务器  
http://v0.api.upyuncom/  
**提交格式：**

提交方式：POST

提交参数：

- useSaveKey (参考示例:userSaveKey = testProject/2016/1/xxxxxxxxxx.jpg)
- data    	(参考示例:data = "头像的图片数据")

**返回格式**

请求成功：应返回如下信息  
{
"code":"200",
"image-frames":"1"
"image-height":"626",
"image-width":"413",
"image-type":"JPEG",
"message":"ok",
"time":"145302759",
"url:"testProject/2016/1/xxxxxxxxxx.jpg"
}

## 上传到应用服务器

/pic/upload

**提交格式：**

提交方式：POST

提交参数：

- userName  (参考示例:userName = testProject)
- authCode  (参考示例:authCode = "************")
- originalUrl (参考示例:orginalUrl = testProject/2016/1/xxxxxxxxxx.jpg)
- smallUrl  (参考示例:smallUrl = nil)
- height	    (参考示例:height = 626)
- width		(参考示例:width = 413)
- remark		(参考示例:remark = nil)

**返回格式** 

请求成功：应返回如下信息  
{
"status":"1",
"message":"图片上传成功"
}