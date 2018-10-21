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

		<link rel="stylesheet" href="static/easy-upload.css">

		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script src="static/jquery-2.2.3.min.js"></script>
		<script src="static/ajaxfileupload.js"></script>
		<script src="static/easyUpload.js"></script>
		<script type="text/javascript">


		</script>

	</head>
<body>

<div style="margin: 10px;">
	<h3>申诉次数${auditCount}</h3>
	<div id="type1">
		<label>申诉原因</label>
		<textarea id="appeal" style="width: 562px;height: 118px">${audit.appeal}</textarea>
		<c:if test="${audit.appealDate != null}">申诉时间：<fmt:formatDate value="${audit.appealDate}" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>
	</div>
	<div id="type2">
		<label>回复</label>
		<textarea id="appealReply" style="width: 562px;height: 118px">${audit.appealReply}</textarea>
		<c:if test="${audit.appealReplyDate != null}">回复时间：<fmt:formatDate value="${audit.appealReplyDate}" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>
		<div id="isReply">
		是否需要总公司回复:<input  type="checkbox" class="ace-switch ace-switch-3" style="position: inherit;opacity: inherit" id="islastRppeal"  />
		</div>
	</div>
	<div id="type3">
		<label>总公司批复</label>
		<textarea id="lastReply" style="width: 562px;height: 118px">${audit.lastReply}</textarea>
		<c:if test="${audit.lastReplyDate != null}">批复时间：<fmt:formatDate value="${audit.lastReplyDate}" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>
	</div>

	<a class="btn btn-small btn-success" onclick="save()" style="float:  right;margin-right: 20px;margin-top:10px;">保存</a>
</div>


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

			debugger;
			var id = '${audit.id}';
			if (id == '') {
			    $("#type2").hide();
                $("#type3").hide();
            } else {
                var status = '${audit.status}';
                if (status == '') {
                    $("#type2").hide();
                    $("#type3").hide();
                } else if (status == '1') {
                    $("#appeal").attr("readOnly", "readOnly");
                    $("#type3").hide();
                } else if (status == '2' || status == '4') {
                    $("#appeal").attr("readOnly", "readOnly");
                    $("#appealReply").attr("readOnly", "readOnly");
                    $("#lastReply").attr("readOnly", "readOnly");
                }

                else if (status == '3') {
                    $("#appeal").attr("readOnly", "readOnly");
                    $("#appealReply").attr("readOnly", "readOnly");
                    $("#isReply").hide();
                }
            }

		});


		function save() {
		    debugger;
			var input = {};
			input.appeal = $("#appeal").val();
			input.appealReply = $("#appealReply").val();
			input.lastReply = $("#lastReply").val();
			input.scpcid = '${pd.id}';
			input.projectName = '${pd.projectName}';
			input.scpcid = '${pd.scpcid}'
			input.id = '${audit.id}';


            var status = '${audit.status}';
			if (status == '') {
			    input.status = '1';
            } else if (status == '1'  || status == '2') {
                var state = $("#islastRppeal").prop('checked');

                if (state) {
                    input.status = '3'; //需要总公司回复
                } else {
                    input.status = '2';
                }
            } else if (status == '3') {
                input.status = '4';
            }
			$.ajax({
				url: '<%=basePath%>adIssue/auditSave.do',
				data: input,
				success: function () {
                    top.Dialog.alert("保存成功!", function() {
                        top.Dialog.close();
                    });
                }
			})
		}
		</script>





</body>
</html>