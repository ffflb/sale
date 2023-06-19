<%--
  Created by IntelliJ IDEA.
  User: 范
  Date: 2023/6/9
  Time: 17:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
</head>
<style>
    /* 编辑弹出层样式 */
    #edit-layer {
        padding: 20px;
    }

    #edit-layer .layui-form-item {
        margin-bottom: 15px;
    }

    #edit-layer .layui-form-label {
        padding: 9px 15px;
        width: 90px;
        text-align: center;
    }

    #edit-layer .layui-input-block {
        margin-left: 105px;
    }

    #edit-layer .layui-btn {
        margin-right: 10px;
    }
</style>
<body>

<div class="layui-body">

    <!-- 内容主体区域 -->
    <div style="padding: 15px;">

        <div class="layui-card layui-panel">

            <div class="layui-card-header">

                <blockquote class="layui-elem-quote layui-text">
                    <div class="title">用户管理界面</div>
                </blockquote>
            </div>

            <div class="layui-card-body">

                <form class="layui-form layui-form-pane" id="my-form" >
                    <div class="layui-form-item">
                        <label class="layui-form-label">请输入待查询的用户名称:</label>
                        <div class="layui-input-inline">
                            <input type="text" name="userName" value="${userName}" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <button class="layui-btn" lay-submit lay-filter="demo1">搜索</button>
                        <button class="layui-btn" lay-submit id="delBatchOrder">批量删除</button>
                    </div>

                </form>

                <table class="layui-hide" id="ID-table-demo-data"></table>

                <script type="text/html" id="barDemo">
                    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                </script>

            </div>

        </div>
        <br><br>
    </div>

    <!-- 编辑弹出层内容 -->
    <div id="edit-layer" style="display: none;">
        <form class="layui-form" lay-filter="layui-edit-form" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block">
                    <input type="text" name="userName" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户密码</label>
                <div class="layui-input-block">
                    <input type="password" name="userPwd" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户手机号</label>
                <div class="layui-input-block">
                    <input type="text" name="userTel" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户地址</label>
                <div class="layui-input-block">
                    <input type="text" name="address" required lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="edit-form">修改</button>
                    <button type="reset" class="layui-btn layui-btn-primary">清空</button>
                </div>
            </div>
        </form>
    </div>




</div>


<script type="textml" id="imgTable">
    <div class="layui-table-cell laytable-cell-1-0"><img src="{{d.img}}"/></div>
</script>


<script>
    //JS
    layui.use(['element', 'layer', 'util'], function(){
        var element = layui.element;
        var layer = layui.layer;
        var util = layui.util;
        var $ = layui.$;
    });
    function getData() {
        let jsonData;
        jsonData = ${requestScope.users}

        return jsonData;
    }


    layui.use('table', function(){

        let data = getData();
        var table = layui.table;

        // 已知数据渲染
        var inst = table.render({
            elem: '#ID-table-demo-data',

            cols: [[ //标题栏
                {checkbox: true, fixed: true},
                {field: 'id', title: 'ID', width: 80, sort: true},
                {field: 'img', title: '用户头像', width: 160,templet: '#imgTable'},
                {field: 'userName', title: '用户姓名', width: 120},
                {field: 'userPwd', title: '用户密码', width: 120},
                {field: 'userTel', title: '用户手机号', width: 200},
                {field: 'address', title: '用户地址', width: 120},
                {
                    title: '操作',
                    toolbar: '#barDemo'
                }
            ]],
            data: data,
            page: true, // 是否显示分页
            lineStyle: 'height: 200px;',
            limits: [5, 10, 15],
            limit: 5 // 每页默认显示的数量
        });

        table.on('tool(ID-table-demo-data)', function(obj) {
            let data = obj.data; //当前行的数据对象
            let id = data.id; //获取当前行的id值

            let form = layui.form;

            if (obj.event === 'del') { //删除

                layer.confirm('真的删除吗', function (index) {
                    console.log("rowId" + id)

                    $.ajax({
                        type:"POST",
                        url:"${pageContext.request.contextPath}/user/delUser",
                        data:{id},
                        async:false,
                        success:function (data){
                            layer.msg('删除成功', {icon: 1});
                            LoadIndex("${pageContext.request.contextPath}/user/toUserTable")
                        },
                        error: function(jqxhr, status, error) {
                            layer.msg('删除失败', {icon: 2});
                        }
                    })

                });
            } else if (obj.event === 'edit') { //编辑
                <%--LoadIndex("${pageContext.request.contextPath}/order/declare?id="+id)--%>

                layer.open({
                    type: 1,
                    title: '编辑用户信息',
                    area: ['500px', '350px'],
                    content: $('#edit-layer').html(),

                    success: function(layero, index){

                        form.val("layui-edit-form", {
                            "userName": data.userName,
                            "userPwd": data.userPwd,
                            "userTel":data.userTel,
                            "address":data.address,
                        })
                        let id = data.id
                        // 监听表单提交事件
                        form.on('submit(edit-form)', function(data){
                            // TODO：提交表单后的处理逻辑
                            data.field.id = id

                            $.ajax({
                                url: '${pageContext.request.contextPath}/user/userIndex',
                                type: "post",
                                data: data.field,
                                success: function () {
                                        LoadIndex("${pageContext.request.contextPath}/user/toUserTable")

                                    layer.msg('操作成功',{icon: 1});

                                },
                                error: function () {
                                    layer.msg('操作失败',{icon: 2});
                                }

                            });
                            layer.close(index); // 关闭弹出层

                            return false; // 阻止表单跳转
                        });
                    }
                });


            }
        })

        $('#delBatchOrder').click(function(){
            let checkStatus = table.checkStatus('ID-table-demo-data');
            let idArray = new Array();
            $.each(checkStatus.data, function(index, item){
                let id = item.id

                idArray.push(id)
            })
            if (idArray.length <= 0) {
                alert("请至少选择一条记录");
                return
            }
            let ids = "";
            for(let i=0;i<idArray.length;i++){
                if(i<idArray.length-1){
                    ids+="id="+idArray[i]+"&";
                }else {
                    ids+="id="+idArray[i];
                }
            }
            console.log("JSON.stringify(idArray) = "+ ids)
            $.ajax({
                url: '${pageContext.request.contextPath}/user/delBatchUser?'+ids,
                type: "get",
                data: {idArray},
                success: function () {
                    LoadIndex("${pageContext.request.contextPath}/user/toUserTable")
                    layer.msg('删除成功');
                },
                error: function () {
                    layer.msg('删除失败');
                }
            });
            return false;

        })

    });


    layui.use(['form'], function () {
        let form = layui.form;

        form.on('submit(demo1)', function (data) {

            let userName = data.field.userName
            $.ajax({
                url: '${pageContext.request.contextPath}/user/toUserTable',
                type: "post",
                data: {userName},
                success: function () {
                        LoadIndex("${pageContext.request.contextPath}/user/toUserTable?userName="+userName)

                    layer.msg('搜索成功');
                },
                error: function () {
                    layer.msg('搜索失败');
                }
            });
            return false;
        });
    });


    document.getElementById("my-form").addEventListener("submit", function(event) {
        event.preventDefault();
    });


</script>
</body>
</html>