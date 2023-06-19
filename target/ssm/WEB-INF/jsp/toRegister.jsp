<%--
  Created by IntelliJ IDEA.
  User: 范
  Date: 2023/6/1
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />
    <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>
    <style>
        .demo-reg-container{width: 320px; margin: 21px auto 0;}
        .demo-reg-other .layui-icon{position: relative; display: inline-block; margin: 0 2px; top: 2px; font-size: 26px;}
        body{
            background-image: url("${pageContext.request.contextPath}/img/1.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            text-align: center;

            display: flex;
            justify-content: center;
            align-items: center;
        }
        form{
            background-color: white;
            width: 420px;
        }
    </style>
</head>

<body>


<form class="layui-form" id="form"  action="${pageContext.request.contextPath}/user/registerUser" method="post" >
    <div class="demo-reg-container">

        <h3>用户注册</h3>
        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-username"></i>
                </div>
                <input type="text" name="userName" value="" lay-verify="required" placeholder="用户昵称" autocomplete="off" class="layui-input" lay-affix="clear">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-row">
                <div class="layui-col-xs7">
                    <div class="layui-input-wrap">
                        <div class="layui-input-prefix">
                            <i class="layui-icon layui-icon-username"></i>
                        </div>
                        <input type="text" name="userTel" value="" lay-verify="required" placeholder="手机号" lay-reqtext="请填写手机号" autocomplete="off" class="layui-input" lay-affix="clear">
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-password"></i>
                </div>
                <input type="password" name="userPwd" value="" lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input" id="reg-password" lay-affix="eye">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-password"></i>
                </div>
                <input type="password" name="confirmUserPwd" value="" lay-verify="required|confirmPassword" placeholder="确认密码" autocomplete="off" class="layui-input" lay-affix="eye">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-wrap">
                <div class="layui-input-prefix">
                    <i class="layui-icon layui-icon-username"></i>
                </div>
                <input type="text" name="address" value="" lay-verify="required" placeholder="用户地址" autocomplete="off" class="layui-input" lay-affix="clear">
            </div>
        </div>

        <div class="layui-form-item">
            <input type="checkbox" name="agreement" lay-verify="required" lay-skin="primary" title="同意">
            <a href="#terms" target="_blank" style="position: relative; top: 6px; left: -15px;">
                <ins>用户协议</ins>
            </a>
        </div>
        <div class="layui-form-item">
            <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="demo-reg">注册</button>
        </div>

            <a href="${pageContext.request.contextPath}/toLogin/login">登录已有帐号</a>
        </div>
    </div>
</form>


<script>
    layui.use(function(){
        var $ = layui.$;
        var form = layui.form;
        var layer = layui.layer;
        var util = layui.util;

        // 自定义验证规则
        form.verify({
            // 确认密码
            confirmPassword: function(value, item){
                var passwordValue = $('#reg-password').val();
                if(value !== passwordValue){
                    return '两次密码输入不一致';
                }
            }
        });

        // 提交事件
        form.on('submit(demo-reg)', function(data){
            var field = data.field; // 获取表单字段值

            // 是否勾选同意
            if(!field.agreement){
                layer.msg('您必须勾选同意用户协议才能注册');
                return false;
            }
        });

    });
</script>
</body>
</html>