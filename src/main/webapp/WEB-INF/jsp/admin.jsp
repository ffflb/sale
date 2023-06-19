<%--
  Created by IntelliJ IDEA.
  User: 范
  Date: 2023/6/9
  Time: 18:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员信息</title>
</head>
<body>

<div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;">

        <div class="layui-card layui-panel">

            <div class="layui-card-header">

                <blockquote class="layui-elem-quote layui-text">
                    <div class="title">个人信息</div>
                </blockquote>
            </div>



            <div class="layui-card-body">
                <form class="layui-form layui-form-pane" id="my-form" >

                    <div class="layui-form-item">
                        <div class="layui-input-inline" id="ID-upload-demo-btn" style="height: 200px; width: 200px;background-color: blue; border-radius: 50%; margin-left: 50px" >
                            <input id="adminImg" type="text" name="img" hidden>
                            <img src="${pageContext.request.contextPath}/img${requestScope.admin.img}" id="ID-upload-demo-img" class="layui-nav-img">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">客服名称</label>
                        <div class="layui-input-inline">
                            <input type="text" name="adminName" value="${requestScope.admin.adminName}" lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">客服密码</label>
                        <div class="layui-input-inline">
                            <input type="text" name="adminPwd" value="${requestScope.admin.adminPwd}"  lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">手机号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="adminTel" value="${requestScope.admin.adminTel}"  lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">客服地址</label>
                        <div class="layui-input-inline">
                            <input type="text" name="address"value="${requestScope.admin.address}"  lay-verify="required" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <button class="layui-btn" lay-submit lay-filter="demo2">修改</button>

                    </div>
                </form>
            </div>
        </div>
        <br><br>
    </div>
</div>

</body>

<script>
    //JS
    layui.use(['element', 'layer', 'util'], function(){
        var element = layui.element;
        var layer = layui.layer;
        var util = layui.util;
        var $ = layui.$;
        var upload = layui.upload;

        var uploadInst = upload.render({
            elem: '#ID-upload-demo-btn',
            url: '${pageContext.request.contextPath}/user/uploadImg', // 此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
            before: function(obj){
                // 预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#ID-upload-demo-img').attr('src', result); // 图片链接（base64）
                });

                element.progress('filter-demo', '0%'); // 进度条复位
                layer.msg('上传中', {icon: 16, time: 0});
            },
            done: function(res){

                // 若上传失败
                if(res.code != 200){
                    return layer.msg('上传失败');
                }
                var inputElement = document.getElementById('adminImg');
                // 更改输入框的值
                inputElement.value = res.msg;
                console.log("inputElement.value = "+inputElement.value)
                layer.msg('上传成功',{icon: 1});

                $('#ID-upload-demo-text').html(''); // 置空上传失败的状态
            },
            error: function(){
                // 演示失败状态，并实现重传
                var demoText = $('#ID-upload-demo-text');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            },
            // 进度条
            progress: function(n, elem, e){
                element.progress('filter-demo', n + '%'); // 可配合 layui 进度条元素使用
                if(n == 100){
                    layer.msg('上传完毕', {icon: 1});
                }
            }
        });
    });

    function LoadIndex(url){
        $("#index").load(url)
    }

    layui.use(['form'], function () {
        let form = layui.form;
        let id = ${requestScope.admin.id}

            form.on('submit(demo2)', function (data) {

                data.field.id = id
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/adminIndex',
                    type: "post",
                    data: data.field,
                    async:false,
                    success: function () {
                        setTimeout(function (){
                            LoadIndex("${pageContext.request.contextPath}/admin/toAdmin");
                        },1000)
                        layer.msg('操作成功');
                    },
                    error: function () {
                        layer.msg('操作失败');
                    }
                });
                return false;
            });

    });


    document.getElementById("my-form").addEventListener("submit", function(event) {
        event.preventDefault();
    });



</script>

</html>
