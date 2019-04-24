<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<html>
<head>
<%@ include file="blueThemes.jsp"%>
<script type="text/javascript">
	$(function() {
		//导航切换
		$(".menuson .header").click(function() {
			var $parent = $(this).parent();
			$(".menuson>li.active").not($parent).removeClass("active open").find('.sub-menus').hide();

			$parent.addClass("active");
			if (!!$(this).next('.sub-menus').size()) {
				if ($parent.hasClass("open")) {
					$parent.removeClass("open").find('.sub-menus').hide();
				} else {
					$parent.addClass("open").find('.sub-menus').show();
				}


			}
		});

		// 三级菜单点击
		$('.sub-menus li').click(function(e) {
			$(".sub-menus li.active").removeClass("active")
			$(this).addClass("active");
		});

		$('.title').click(function() {
			var $ul = $(this).next('ul');
			$('dd').find('.menuson').slideUp();
			if ($ul.is(':visible')) {
				$(this).next('.menuson').slideUp();
			} else {
				$(this).next('.menuson').slideDown();
			}
		});
	})
</script>

</head>
<body style="background:#f0f9fd;">
	<div class="lefttop">
		<span></span>菜单
	</div>

	<dl class="leftmenu">

		<dd>
			<div class="title">
				<span><img src="<%=basePath%>resources/blueThemes/images/leftico01.png" /></span>案例
			</div>
			<ul class="menuson">

				<li class="active">
					<div class="header">
						<cite></cite> <a href="<%=basePath%>case1/initPage" target="rightFrame">案例1</a> <i></i>
					</div>
				</li>
				<li>
					<div class="header">
						<cite></cite> <a href="<%=basePath%>case2/testWs" target="rightFrame">案例2</a> <i></i>
					</div>
				</li>
				<li>
					<div class="header">
						<cite></cite> <a href="right.html" target="rightFrame">数据列表</a> <i></i>
					</div>
					<ul class="sub-menus">
						<li><a href="javascript:;">文件数据</a></li>
						<li><a href="javascript:;">学生数据列表</a></li>
						<li><a href="javascript:;">我的数据列表</a></li>
						<li><a href="javascript:;">自定义</a></li>
					</ul>
				</li>

				<li><cite></cite><a href="right.html"
					target="rightFrame">数据列表</a><i></i></li>
				<li><cite></cite><a href="imgtable.html" target="rightFrame">图片数据表</a><i></i></li>
				<li><cite></cite><a href="form.html" target="rightFrame">添加编辑</a><i></i></li>
				<li><cite></cite><a href="imglist.html" target="rightFrame">图片列表</a><i></i></li>
				<li><cite></cite><a href="imglist1.html" target="rightFrame">自定义</a><i></i></li>
				<li><cite></cite><a href="tools.html" target="rightFrame">常用工具</a><i></i></li>
				<li><cite></cite><a href="filelist.html" target="rightFrame">信息管理</a><i></i></li>
				<li><cite></cite><a href="tab.html" target="rightFrame">Tab页</a><i></i></li>
				<li><cite></cite><a href="error.html" target="rightFrame">404页面</a><i></i></li>
			</ul>
		</dd>


		<dd>
			<div class="title">
				<span><img src="<%=basePath%>resources/blueThemes/images/leftico02.png" /></span>其他设置
			</div>
			<ul class="menuson">
				<li><cite></cite><a href="flow.html" target="rightFrame">流程图</a><i></i></li>
				<li><cite></cite><a href="project.html" target="rightFrame">项目申报</a><i></i></li>
				<li><cite></cite><a href="search.html" target="rightFrame">档案列表显示</a><i></i></li>
				<li><cite></cite><a href="tech.html" target="rightFrame">技术支持</a><i></i></li>
			</ul>
		</dd>


		<dd>
			<div class="title">
				<span><img src="<%=basePath%>resources/blueThemes/images/leftico03.png" /></span>编辑器
			</div>
			<ul class="menuson">
				<li><cite></cite><a href="#">自定义</a><i></i></li>
				<li><cite></cite><a href="#">常用资料</a><i></i></li>
				<li><cite></cite><a href="#">信息列表</a><i></i></li>
				<li><cite></cite><a href="#">其他</a><i></i></li>
			</ul>
		</dd>


		<dd>
			<div class="title">
				<span><img src="<%=basePath%>resources/blueThemes/images/leftico04.png" /></span>日期管理
			</div>
			<ul class="menuson">
				<li><cite></cite><a href="#">自定义</a><i></i></li>
				<li><cite></cite><a href="#">常用资料</a><i></i></li>
				<li><cite></cite><a href="#">信息列表</a><i></i></li>
				<li><cite></cite><a href="#">其他</a><i></i></li>
			</ul>

		</dd>

	</dl>

</body>
</html>
