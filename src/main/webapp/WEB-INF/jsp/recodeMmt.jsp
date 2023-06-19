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
    <title>订单记录</title>
</head>
<body>

<div class="layui-body">

    <!-- 内容主体区域 -->
    <div style="padding: 15px;">

        <div class="layui-card layui-panel">

            <div class="layui-card-header">

                <blockquote class="layui-elem-quote layui-text">
                    <div class="title">订单管理界面</div>
                </blockquote>
            </div>

            <div class="layui-card-body">

                <form class="layui-form layui-form-pane" id="my-form" >
                    <div class="layui-form-item">
                        <label class="layui-form-label">订单名称:</label>
                        <div class="layui-input-inline">
                            <input type="text" name="orderName" value="${orderName}" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <button class="layui-btn" lay-submit lay-filter="demo1">搜索</button>
                        <button class="layui-btn" lay-submit id="delBatchOrder">批量删除</button>
                    </div>

                </form>

                <table class="layui-hide" id="ID-table-demo-data"></table>

                <script type="text/html" id="barDemo">
                    <%--                    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>--%>
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
                </script>

            </div>

        </div>
        <br><br>
    </div>
</div>


</div>

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
        jsonData = ${requestScope.RecodeAndSort}

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
                {field: 'sortName', title: '故障类型', width: 120},
                {field: 'orderName', title: '订单名称', width: 120},
                {field: 'orderDesc', title: '订单介绍', width: 200},
                {field: 'apple', title: '申请人', width: 120},
                {field: 'operation', title: '操作员', width: 120},
                {
                    title: '操作',
                    toolbar: '#barDemo'
                }
            ]],
            data: data,
            page: true, // 是否显示分页
            limits: [5, 10, 15],
            limit: 5 // 每页默认显示的数量
        });

        table.on('tool(ID-table-demo-data)', function(obj) {
            let data = obj.data; //当前行的数据对象
            let id = data.id; //获取当前行的id值

            if (obj.event === 'del') { //删除

                layer.confirm('真的删除吗', function (index) {

                    $.ajax({
                        type:"POST",
                        url:"${pageContext.request.contextPath}/recode/delRecode",
                        data:{id},
                        async:false,
                        success:function (data){
                            layer.msg('删除成功', {icon: 1});
                            LoadIndex("${pageContext.request.contextPath}/recode/toRecodeTable")
                        },
                        error: function() {
                            layer.msg('删除失败', {icon: 2});
                        }
                    })
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
                url: '${pageContext.request.contextPath}/recode/delBatchRecode?'+ids,
                type: "get",

                data: {idArray},
                success: function () {
                    LoadIndex("${pageContext.request.contextPath}/recode/toRecodeTable")
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

            let orderName = data.field.orderName

            $.ajax({
                url: '${pageContext.request.contextPath}/recode/toRecodeTable',
                type: "post",
                data: {orderName},
                success: function () {
                    LoadIndex("${pageContext.request.contextPath}/recode/toRecodeTable?orderName="+orderName)
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