<%--
  Created by IntelliJ IDEA.
  User: 范
  Date: 2023/5/31
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录界面</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/swiper-bundle.min.css" media="all" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />
    <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>

    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
  <style>

    body{
      background-image: url("${pageContext.request.contextPath}/img/1.jpg");
      background-size: cover;
      background-repeat: no-repeat;
      background-position: center center;
      text-align: center;
    }
    #login-box {
      width: 520px;
      height: 350px;
      position: fixed;
      background-color: white;
      display: flex;
      justify-content: center;
      align-items: center;
      border: transparent;
      top: 50%;
      left: 50%;
      margin: -180px 0 0 -200px;
      border-radius: 5px;
      box-shadow: 0 0 20px #adadad;
    }

    .inp{
      width: 280px;
      height: 40px;
      margin-left: 20px;
      border-radius: 5px;
      border-color: rgb(102, 255, 233);
    }
    a {
      text-decoration: none;
      border-bottom: none;
    }
    .word{
      width: 50px;
    }
    #login{
      width: 300px;
      height: 40px;
      background-color: #00f0f0;
      margin-top: 5%;
      margin-left: 55px;
      border-radius: 5px;
      border-color: #00f0f0;
    }
    #register{
      margin-left: 60%;
      margin-top: 100%;
    }
    #img{
      float: right;
      margin-top: -60px;
      width: 70px;
      height: 40px;
    }
    form{
        flex: 1;

    }
    #tip{
      color: crimson;
      width: 300px;
      text-align: right;
    }
  </style>
</head>
<body>

<section id="login-box">



  <form autocomplete="off" action="${pageContext.request.contextPath}/toLogin/login" method="post">
      <h1>家电售后服务平台</h1>
      <h3 id="tip">${msg}</h3>
    <table>

        <label class="word">账&nbsp;&nbsp;&nbsp;号</label>
          <input name="userName" class="inp" placeholder="请输入账号"><br><br>


        <label class="word">密&nbsp;&nbsp;&nbsp;码</label>
          <input type="password" name="userPwd" placeholder="请输入密码" class="inp"><br><br>



        <label class="word">验证码</label>
          <input name="VerifyCode"  placeholder="请输入验证码" class="inp"><br><br>

          <a href="javascript:change()">
            <img src="${pageContext.request.contextPath}/getVerifyCode" id="img">
          </a>

    </table>

    <a href="javascript:toAdd()" id="register">没有账号?</a>
      <button value="登录" id="login">登录</button>


  </form>

</section>
</body>

<script>



  function change() {
    let img = document.getElementById("img")
    img.src = "${pageContext.request.contextPath}/getVerifyCode?time=" + new Date();
  }
  function toAdd(){
    window.location.href="${pageContext.request.contextPath}/user/toRegister"
  }


</script>

</html>