<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.fh.entity.qizhe.ProjectAuditHelper" %>

<%
	request.setAttribute("upperCaseInfo", ProjectAuditHelper.UPPER_CASE_INFO);
	request.setAttribute("projectHelp", ProjectAuditHelper.PROJECT_HELP);
	request.setAttribute("projectInfos", ProjectAuditHelper.PROJECT_INFO);
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
<form id="formData" action="<%=basePath%>adIssue/saveAudit.do">
	<div id="zhongxin">
<div style="margin: 10px; ">
	<br />
	<c:set var="nameSm" value="${pd.projectName}sm"></c:set>
	<h4>加油站名称：${project.qname}</h4>
	<hr />
	<span>考核内容：${projectInfos[pd.projectName]}</span>
	<br /><br />
	<span>考核说明：${projectHelp[pd.projectName]}</span>
	<br /><br />
	<span>扣分情况：${project[pd.projectName]}</span>
	<br /><br />
	<span>扣分原因：${project[nameSm]}</span>
	<br />
	<div>
		<c:forEach items="${images}" var="img">
			<a target="_blank" href="<%=basePath%>${img.resource}"><img src="<%=basePath%>${img.resource}" style="margin-top:  10px; width: 200px; margin-left: 10px; margin-right:  10px;"></a>
		</c:forEach>
	</div>

	<input type="hidden" name="scpcid" value="${project.ID}">
	<input name="projectName" type="hidden" value="${pd.projectName}">
	<input name="id" type="hidden" value="${audit2Info.id}" >
	<h3>网点申诉一次申诉</h3>
	<hr />
	<div id="type1">
		<div id="imageOne" style="margin: 5px">
			<c:if test="${audit2Info.content1img != null}">
				<label>申诉图片</label>
				<a target="_blank" href="<%=basePath%>${audit2Info.content1img}"><img src="<%=basePath%>${audit2Info.content1img}" style="margin-top:  10px; width: 200px; margin-left: 10px; margin-right:  10px;"></a>
			</c:if>
		</div>
		<label>申诉理由</label>
		<textarea id="appeal" style="width: 562px;height: 118px" name="content1">${audit2Info.content1}</textarea>
		<br />
		<input type="hidden" id="img1Path" name="content1img" value="${audit2Info.content1img}" >
		<a class="btn btn-small icon-edit" onclick="image1.click()">点击上传申诉图片</a>
		<input type="file" name="file" id="image1" onchange="setImg1(this);" class="selectedLogoImgId"
			   accept="image/jpg,image/jpeg,image/png,image/bmp" style="display: none;" multiple/>

		<label>考评员考核</label>
		<textarea name="audit1" style="width: 562px;height: 118px">${audit2Info.audit1}</textarea>
	</div>

	<h3>网点申诉二次申诉</h3>
	<hr />
	<div id="type1">
		<div id="imageTwo" style="margin: 5px">
			<c:if test="${audit2Info.content2img != null}">
				<label>二次申诉图片</label>
				<a target="_blank" href="<%=basePath%>${audit2Info.content2img}"><img src="<%=basePath%>${audit2Info.content2img}" style="margin-top:  10px; width: 200px; margin-left: 10px; margin-right:  10px;"></a>
			</c:if>
		</div>
		<label>二次申诉理由</label>
		<textarea id="appeal" style="width: 562px;height: 118px" name="content2">${audit2Info.content2}</textarea>
		<br />
		<input type="hidden" id="img2Path" name="content2img" value="${audit2Info.content2img}" >
		<a class="btn btn-small icon-edit" onclick="image2.click()">点击上传二次申诉图片</a>
		<input type="file" name="file" id="image2" onchange="setImg2(this);" class="selectedLogoImgId"
			   accept="image/jpg,image/jpeg,image/png,image/bmp" style="display: none;" multiple/>

		<label>项目负责人审核意见</label>
		<textarea name="audit2" style="width: 562px;height: 118px">${audit2Info.audit2}</textarea>
	</div>

	<a class="btn btn-small btn-success" onclick="formData.submit(this)" style="float:  right;margin-right: 20px;margin-top:10px;">保存</a>
</div>
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




    function setImg1() {
        $.ajaxFileUpload({
            url:"<%=basePath%>pictures/save2.do",//需要链接到服务器地址
            secureuri:false,
            fileElementId:"image1",//文件选择框的id属性  ,//文件选择框的id属性
            dataType: 'json',   //json
            contentType: false,    //不可缺
            processData: false,    //不可缺
            success: function (data){
				debugger;
                var path = data.images[0];
                var html = '<label>申诉图片</label><a target="_blank" href="<%=basePath%>'+ path +'"><img src="<%=basePath%>' + path +'" style="margin-top:  10px; width: 200px; margin-left: 10px; margin-right:  10px;"></a>\n'
                $("#imageOne").empty();
				$("#imageOne").append(html);
                $("#img1Path").val(path);
			},
            error:function(XMLHttpRequest, textStatus, errorThrown){
                alertLayel("上传失败，请检查网络后重试");
                $("#url").val("");
                $(obj).val('');
            }
        });
    }


    function setImg2() {
        $.ajaxFileUpload({
            url:"<%=basePath%>pictures/save2.do",//需要链接到服务器地址
            secureuri:false,
            fileElementId:"image2",//文件选择框的id属性  ,//文件选择框的id属性
            dataType: 'json',   //json
            contentType: false,    //不可缺
            processData: false,    //不可缺
            success: function (data){
                debugger;
                var path = data.images[0];
                var html = '<label>二次申诉图片</label><a target="_blank" href="<%=basePath%>'+ path +'"><img src="<%=basePath%>' + path +'" style="margin-top:  10px; width: 200px; margin-left: 10px; margin-right:  10px;"></a>\n'
                $("#imageTwo").empty();
                $("#imageTwo").append(html);
                $("#img2Path").val(path);
            },
            error:function(XMLHttpRequest, textStatus, errorThrown){
                alertLayel("上传失败，请检查网络后重试");
                $("#url").val("");
                $(obj).val('');
            }
        });
    }

</script>





</body>
</html>