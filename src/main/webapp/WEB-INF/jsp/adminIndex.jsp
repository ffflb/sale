<%--
  Created by IntelliJ IDEA.
  User: 范
  Date: 2023/6/7
  Time: 17:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>客服主页</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />
    <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <style>
        #index img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">系统后台管理</div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-sm-inline-block">
                <a href="javascript:;">
                    <img src="${pageContext.request.contextPath}/img${sessionScope.adminInfo.img}" class="layui-nav-img">
                    ${sessionScope.adminInfo.adminName}
                </a>
                <dl class="layui-nav-child">

                    <dt><a href="javascript:logout();">退出登录</a></dt>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">

        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">

                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:void(0);">个人信息</a>
                    <dl class="layui-nav-child">
                        <dt><a href="javascript:void (0);" onclick="LoadIndex('${pageContext.request.contextPath}/admin/toAdmin')">编辑个人信息</a></dt>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:void(0);">用户管理</a>
                    <dl class="layui-nav-child">
                        <dt><a href="javascript:void(0);" onclick="LoadIndex('${pageContext.request.contextPath}/user/toUserTable')">用户信息管理</a></dt>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:void(0);">订单管理</a>
                    <dl class="layui-nav-child">
                        <dt><a href="javascript:void(0);" onclick="LoadIndex('${pageContext.request.contextPath}/order/toOrderTable')">订单信息管理</a></dt>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:void(0);">历史记录</a>
                    <dl class="layui-nav-child">
                        <dt><a href="javascript:void(0);" onclick="LoadIndex('${pageContext.request.contextPath}/recode/toRecodeTable')">历史订单管理</a></dt>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:void(0);">故障统计</a>
                    <dl class="layui-nav-child">
                        <dt><a href="javascript:void(0);" onclick="LoadIndex('${pageContext.request.contextPath}/order/toEcharts')">电器故障统计</a></dt>
                    </dl>
                </li>

            </ul>
        </div>
    </div>


<div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">


            <div id="index">
                <h2 style="text-align: center">家电售后服务系统</h2>
            </div>

            <br><br>
        </div>

    </div>
</div>

</body>
<script>

    function LoadIndex(url){
        $("#index").load(url)
    }

    function logout(){
        parent.location.href="${pageContext.request.contextPath}/toLogin/login"
    }
</script>
</html>
