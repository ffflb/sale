<%--
  Created by IntelliJ IDEA.
  User: 范
  Date: 2023/6/10
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>故障统计</title>
</head>
<body>
<div id="main" style="width: 600px;height:400px;"></div>
</body>
<script>
    $(function () {
        let data = getData();

        let chartDom = document.getElementById('main');
        let myChart = echarts.init(chartDom);
        let option;

        option = {
            tooltip: {
                trigger: 'item'
            },
            legend: {
                top: '5%',
                left: 'center'
            },
            series: [
                {
                    name: 'Access From',
                    type: 'pie',
                    radius: ['40%', '70%'],
                    avoidLabelOverlap: false,
                    itemStyle: {
                        borderRadius: 10,
                        borderColor: '#fff',
                        borderWidth: 2
                    },
                    label: {
                        show: false,
                        position: 'center'
                    },
                    emphasis: {
                        label: {
                            show: true,
                            fontSize: 40,
                            fontWeight: 'bold'
                        }
                    },
                    labelLine: {
                        show: false
                    },
                    data: data
                }
            ]
        };

        option && myChart.setOption(option);
    })

    function getData() {
        let jsonData;
        $.ajax({
            type:"post",
            url:"${pageContext.request.contextPath}/order/getEchartsDate",
            dataType:"json",
            async:false,
            success:function (data){
                console.log(data)
                jsonData=data;
            }
        })
        return jsonData;
    }

</script>
</html>