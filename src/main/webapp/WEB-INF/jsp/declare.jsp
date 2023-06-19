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
  <title>故障申报</title>
  <style>
    #bg{
      padding: 15px;
      margin-left: 20%;
      width: 500px;
    }
  </style>
</head>
<body>

<div class="layui-body">
  <!-- 内容主体区域 -->
  <div id="bg" style="padding: 15px;">

    <div class="layui-card layui-panel">

      <div class="layui-card-header">

        <blockquote class="layui-elem-quote layui-text">
          <div class="title">故障申报</div>
        </blockquote>
      </div>

      <div class="layui-card-body">

          <form class="layui-form layui-form-pane" id="my-form" >

            <div class="layui-form-item">
              <div class="layui-form-label">故障申报</div>
              <div class="layui-input-inline">

                <select name="sortId"  id="xlk">
                  <option value="${requestScope.order.sortId}" id="sortId">请选择故障类型</option>
                </select>

              </div>
            </div>


            <div class="layui-form-item">
              <label class="layui-form-label">故障名称</label>
              <div class="layui-input-inline" >
                <input type="text" name="orderName"  placeholder="请输入故障概述" value="${requestScope.order.orderName}" lay-verify="required" autocomplete="off" class="layui-input">
              </div>
            </div>

            <div class="layui-form-item layui-form-text">
              <label class="layui-form-label">故障描述</label>
              <div class="layui-input-block">
                <textarea placeholder="${requestScope.order.orderDesc}" name="orderDesc"  class="layui-textarea">${requestScope.order.orderDesc}</textarea>
              </div>
            </div>


            <div class="layui-form-item">
              <input  class="layui-btn" lay-submit lay-filter="demo2" value="提交">
              <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
          </form>

        </div>
      </div>
      <br><br>
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

  $(function (){
    $.ajax({
      type:'post',
      url:"${pageContext.request.contextPath}/sort/getSortList",
      dataType:"json",
      success:function (data){
        let option="";
        const selectElement = document.getElementById("sortId")
        const selectedValue = selectElement.value
        const role = document.getElementById("xlk");
        $.each(data,function (i, n){
          if (n.sortId == selectedValue) {
            option += "<option value=" + n.sortId + " selected>" + n.sortName + "</option>"
            role.removeChild(role.options[0])
          }else{
          option+="<option value="+n.sortId+">"+n.sortName+"</option>"
        }
        })
        $("#xlk").append(option)
        renderForm();
      }
    })
  })
  function renderForm() {
    layui.use('form', function () {
      let form = layui.form;
      form.render();
    });
  }


  layui.use(['form'], function () {

    let form = layui.form;
    let id = ${empty requestScope.order ? 0 : requestScope.order.id};

      form.on('submit(demo2)', function (data) {

        if(id != 0) {
          data.field.id = id
        }else {
          data.field.id = 0
        }
        $.ajax({
          url: "${pageContext.request.contextPath}/order/addDeclare", // 用自己的接口地址代替
          type: "post",
          data: data.field,
          success: function () {

            setTimeout(function (){

              LoadIndex('${pageContext.request.contextPath}/order/toOrder')
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
</body>
</html>
