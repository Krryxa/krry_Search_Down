<%@ page language="java" import="java.util.*,com.tz.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title>Java开发批量采集图片系统 - krry</title>
		<meta name="keywords" content="关键词,关键词">
		<meta name="description" content="">
		
		<style type="text/css">
			*{margin:0;padding:0;}
			body{background:url("images/bg.jpg");background-size:cover;font-size:12px;font-family:"微软雅黑";color:#666;}
			
			/*search start*/
			.search{width:600px;height:100px;margin:60px auto;}
			.search h1{text-align:center;font-weight:300;font-size:22px;color:#fff;}
			.search .s-box .s-txt{width:480px;height:36px;border:none;padding-left:10px;outline:none;border-radius:3px 0px 0px 3px;}
			.search .s-box{margin-top:20px;}
			.search .s-box .s-btn{float: right;width:110px;height:36px;background:#3CBD38;border:none;outline:none;cursor: pointer;color:#fff;border-radius:0 3px 3px 0;}
			.search .s-box .s-btn:hover{background:#329f2f;}
			/*end search*/

			/*files start*/
			.files{width:1000px;margin:0 auto;}
			.files ul li{width:132px;background:#fff;padding:5px;float:left;margin:12px;position:relative;}
			.files ul li:hover{background:#d8d8d8;}
			.files ul li p{overflow: hidden;white-space: nowrap;text-overflow: ellipsis;line-height:20px;text-align:center;}
			.files ul li .f-close{width:30px;height:30px;display:block;background:url("images/tz_image_box.png") -40px 0px;}
			.files ul li .f-close{position:absolute;right:-15px;top:-13px;display:none;}
			.files ul li:hover .f-close{display:block;}
			/*end files*/

		</style>
	
		<link type="text/css" rel="stylesheet" href="sg/css/sg.css"></link>

	</head>
<body>

	<%
		// 网址
		String url = request.getParameter("url");
		// 编码集
		String encoding = "utf-8";
		
		if(null != url){
			// 下载图像的工具类
			List<HashMap<String,Object>> list = DataDownUtil.findImages(url, encoding);
			// 存储在作用域中
			pageContext.setAttribute("list", list);
		}
	
	%>

	<!--search start-->
	<form action="index.jsp" method="get" onkeydown="if(event.keyCode==13)return false;">
	<div class="search">
		<h1>Java开发批量采集图片系统</h1>
		<div class="s-box">
			<input type="text" class="s-txt" name="url" placeholder="请输入需要下载地址 ..."/>
			<input type="button" value="开始下载"  class="s-btn" />
			<input type="submit" style="display:none;" id="sub"/>
		</div>
	</div>
	</form>
	<!--end search-->

	<!--files start-->
	<div class="files">
		<ul>
			<c:forEach items="${list}" var="img">
				<li class="tz_item">
					<a href="${img.src}" target="_blank"><img src="${img.src}" alt="${img.title}" width="132" height="132" class="tzImgbox" /></a>
					<p>${img.name}</p>
					<p>${img.title}</p>
					<a href="#" class="f-close" onclick="mydel(this);"></a>
				</li>
			</c:forEach>	
		</ul>
	</div>
	<!--end files-->
	
<!-- 引入jQuery官方类库 -->	
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="sg/sg.js"></script>
<script type="text/javascript" src="sg/tz_util.js"></script>
<script type="text/javascript">

	loading("数据正在加载中 ...",3);

	$(".tzImgbox").tzImgbox();
	
	// 删除
	function mydel(obj){
		$.tzAlert({content:"您确定要删除吗？",callback:function(ok){
			if(ok){
				$(obj).parents(".tz_item").fadeOut(1000,function(){
					$(this).remove();
				});
			}
		}});
		
	}
	
	$(".s-btn").click(function(){
		var urll = $(".s-txt").val();
		if(isEmpty(urll)){
			$.tzAlert({content:"请输入网址"});
		}else{
			$("#sub").click();
		}
	});
	
	
	/**
	 * 判断非空
	 * 
	 * @param val
	 * @returns {Boolean}
	 */
	function isEmpty(val) {
		val = $.trim(val);
		if (val == null)
			return true;
		if (val == undefined || val == 'undefined')
			return true;
		if (val == "")
			return true;
		if (val.length == 0)
			return true;
		if (!/[^(^\s*)|(\s*$)]/.test(val))
			return true;
		return false;
	}
	

</script>

</body>
</html>