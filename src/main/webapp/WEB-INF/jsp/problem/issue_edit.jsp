<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
	
	
	//保存
	function save(){
//		if($("#ISAD").val()==""){
//			$("#ISAD").tips({
//				side:3,
//	            msg:'请输入0-正常1-广告',
//	            bg:'#AE81FF',
//	            time:2
//	        });
//			$("#ISAD").focus();
//			return false;
//		}
//		if($("#USERID").val()==""){
//			$("#USERID").tips({
//				side:3,
//	            msg:'请输入创建问题的人',
//	            bg:'#AE81FF',
//	            time:2
//	        });
			$("#USERID").focus();
			return false;
		}
		if($("#TITLE").val()==""){
			$("#TITLE").tips({
				side:3,
	            msg:'请输入问题标题',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TITLE").focus();
			return false;
		}
		if($("#CONTENT").val()==""){
			$("#CONTENT").tips({
				side:3,
	            msg:'请输入问题内容',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#CONTENT").focus();
			return false;
		}
		if($("#TAGS").val()==""){
			$("#TAGS").tips({
				side:3,
	            msg:'请输入标签',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TAGS").focus();
			return false;
		}
		if($("#TYPE").val()==""){
			$("#TYPE").tips({
				side:3,
	            msg:'请输入1-问题2-话题',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TYPE").focus();
			return false;
		}
		if($("#SOURCE").val()==""){
			$("#SOURCE").tips({
				side:3,
	            msg:'请输入来源',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SOURCE").focus();
			return false;
		}
		if($("#FAVORITES_RATE").val()==""){
			$("#FAVORITES_RATE").tips({
				side:3,
	            msg:'请输入收藏数',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#FAVORITES_RATE").focus();
			return false;
		}
		if($("#ANSWER_RATE").val()==""){
			$("#ANSWER_RATE").tips({
				side:3,
	            msg:'请输入回答数',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ANSWER_RATE").focus();
			return false;
		}
		if($("#ISDELETED").val()==""){
			$("#ISDELETED").tips({
				side:3,
	            msg:'请输入是否删除',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ISDELETED").focus();
			return false;
		}
		if($("#CREATE_TIME").val()==""){
			$("#CREATE_TIME").tips({
				side:3,
	            msg:'请输入创建时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#CREATE_TIME").focus();
			return false;
		}
		if($("#LINK").val()==""){
			$("#LINK").tips({
				side:3,
	            msg:'请输入广告链接',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LINK").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="issue/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr style="display: none;">
				<td style="width:80px;text-align: center;padding-top: 13px;">0-正常1-广告:</td>
				<td><input type="number" name="ISAD" id="ISAD" value="0" maxlength="32" placeholder="这里输入0-正常1-广告" title="0-正常1-广告"/></td>
			</tr>
			<tr style="display: none;">
				<td style="width:80px;text-align: center;padding-top: 13px;">创建人:</td>
				<td><input type="number" name="USERID" id="USERID" value="1" maxlength="32" placeholder="这里输入创建问题的人" title="创建问题的人"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: center;padding-top: 13px;">1-问题2-话题:</td>
				<td><input type="number" name="TYPE" id="TYPE" value="${pd.TYPE}" maxlength="32" placeholder="这里输入1-问题2-话题" title="1-问题2-话题"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: center;padding-top: 13px;">问题标题:</td>
				<td><input type="text" name="TITLE" id="TITLE" value="${pd.TITLE}" maxlength="32" placeholder="这里输入问题标题" title="问题标题"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: center;padding-top: 13px;">问题内容:</td>
				<td><input type="text" name="CONTENT" id="CONTENT" value="${pd.CONTENT}" maxlength="32" placeholder="这里输入问题内容" title="问题内容"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: center;padding-top: 13px;">标签:</td>
				<td><input type="text" name="TAGS" id="TAGS" value="${pd.TAGS}" maxlength="32" placeholder="这里输入标签" title="标签"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: center;padding-top: 13px;">来源:</td>
				<td><input type="text" name="SOURCE" id="SOURCE" value="${pd.SOURCE}" maxlength="32" placeholder="这里输入来源" title="来源"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: center;padding-top: 13px;">收藏数:</td>
				<td><input type="number" name="FAVORITES_RATE" id="FAVORITES_RATE" value="${pd.FAVORITES_RATE}" maxlength="32" placeholder="这里输入收藏数" title="收藏数"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: center;padding-top: 13px;">回答数:</td>
				<td><input type="number" name="ANSWER_RATE" id="ANSWER_RATE" value="${pd.ANSWER_RATE}" maxlength="32" placeholder="这里输入回答数" title="回答数"/></td>
			</tr>
			<tr>
				<td style="width:80px;text-align: center;padding-top: 13px;">广告链接:</td>
				<td>
					<input type="text" name="LINK" id="LINK" value="${pd.LINK}" maxlength="32" placeholder="这里输入广告链接" title="广告链接"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		</script>
</body>
</html>