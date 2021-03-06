<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'showStudentInfo.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!-- 知乎前10赞同数，用圆饼图展示 -->
</head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/echarts.js"></script>
<body>
	<!-- 显示Echarts图表 -->
	<div id="main" style="width: 500px;height: 300px;"></div>

	<div id="main2" style="width: 500px;height: 300px;"></div>
	<script>	//初始化echarts var pieCharts =
		//初始化echarts
		var pieCharts = echarts.init(document.getElementById("main"));
		//var pieCharts = echarts.init(document.getElementById("main2"));
		//设置属性
		pieCharts.setOption({
			title : {
				text : '赞同数',
				subtext : '赞同数比',
				left : "center", //left 的值可以是像 20 这样的具体像素值，可以是像 '20%' 这样相对于容器高宽的百分比，也可以是 'left', 'center', 'right',如果 left 的值为'left', 'center', 'right'，组件会根据相应的位置自动对齐。
				right : "auto", //right 的值可以是像 20 这样的具体像素值，可以是像 '20%' 这样相对于容器高宽的百分比。
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			//图例
			legend : {
				orient : 'vertical',
				x : 'left',
				data : []
			},
			//工具箱
			toolbox : {
				show : true,
				feature : {
					mark : {
						show : true
					},
					//数据视图
					dataView : {
						show : true,
						readOnly : false
					},
					restore : {
						show : true
					},
					//是否可以保存为图片
					saveAsImage : {
						show : true
					}
				}
			},
			calculable : true,
			//数据
			series : [
				{
					name : '赞同数',
					type : 'pie',
					radius : '50%', //半径
					center : [ '50%', '50%' ], //圆心位置
					data : []
				}
			]
		});
	
	
		//显示一段动画
		pieCharts.showLoading();
	
		var names = [];
		//异步请求数据
		$.ajax({
			type : "post",
			async : true,
			url : '${pageContext.request.contextPath}/echarts/agreePie',
			data : [],
			dataType : "json",
			success : function(result) {
	
				if (result) {
					for (var i = 0; i < result.length; i++) {
						names.push(result[i].name); //挨个取出类别并填入类别数组
					}
					pieCharts.hideLoading(); //隐藏加载动画
					pieCharts.setOption({
						series : [
							{
								data : result
							}
						],
						legend : {
							data : names
						}
					});
				} else {
					//返回的数据为空时显示提示信息
					alert("图表请求数据为空，可能服务器暂未录入近五天的观测数据，您可以稍后再试！");
					pieCharts.hideLoading();
				}
			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败，可能是服务器开小差了");
				pieCharts.hideLoading();
			}
		})
	</script>
</body>
</html>
