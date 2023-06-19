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
    <title>用户主页</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/swiper-bundle.min.css" media="all" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />
    <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/swiper-bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>

    <style>
        #index img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>

<body >
    <ul class="layui-nav layui-bg-cyan">
        <li class="layui-nav-item">
            <a  href="javascript:void(0);">家电售后服务平台</a>
        </li>

        <li class="layui-nav-item">
                    <a href="javascript:void(0);" onclick="LoadIndex('${pageContext.request.contextPath}/user/toUser')">个人信息</a>
        </li>


        <li class="layui-nav-item">
                    <a href="javascript:void(0);" onclick="LoadIndex('${pageContext.request.contextPath}/order/declare')">故障申报</a>
        </li>

        <li class="layui-nav-item">
                    <a href="javascript:void(0);" onclick="LoadIndex('${pageContext.request.contextPath}/order/toOrder')">申报记录</a>
        </li>

        <li class="layui-nav-item layui-hide layui-show-sm-inline-block" style="float: right">
            <a href="javascript:;">
                <img src="${pageContext.request.contextPath}/img${sessionScope.userInfo.img}" id="img" class="layui-nav-img">
                ${sessionScope.userInfo.userName}
            </a>
            <dl class="layui-nav-child">
                <dt><a href="javascript:logout();">退出登录</a></dt>
            </dl>
        </li>
    </ul>
</div>


    
<div id="index">
    <!-- 内容主体区域 -->
        <div class="swiper-container">
            <div class="swiper-wrapper"  id="lunbotu">
                <div class="swiper-slide"><img src="${pageContext.request.contextPath}/img/01.jpg" alt="" id="lunbotuId"></div>
                <div class="swiper-slide"><img src="${pageContext.request.contextPath}/img/02.jpg" alt=""></div>
                <div class="swiper-slide"><img src="${pageContext.request.contextPath}/img/03.jpg" alt=""></div>
                <div class="swiper-slide"><img src="${pageContext.request.contextPath}/img/04.jpg" alt=""></div>
                <div class="swiper-slide"><img src="${pageContext.request.contextPath}/img/06.jpg" alt=""></div>
            </div>
            <!-- 如果需要分页器 -->
            <div class="swiper-pagination"></div>

            <!-- 如果需要导航按钮 -->
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>

            <!-- 如果需要滚动条 -->
            <div class="swiper-scrollbar"></div>
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


    var mySwiper = new Swiper('.swiper-container', {
        direction: 'horizontal', // 水平切换选项
        loop: true, // 循环模式选项

        // 如果需要分页器
        pagination: {
            el: '.swiper-pagination',
            clickable :true,
        },

        // 如果需要前进后退按钮
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },

        // 如果需要滚动条
        scrollbar: {
            el: '.swiper-scrollbar',
        },
        //自动播放
        autoplay: {
            delay: 3000,
            stopOnLastSlide: false,
            disableOnInteraction: true,
        },
    })



</script>
</html>
