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
<div id="easyContainer"></div>

<a class="btn btn-small btn-success" onclick="save()" style="float:  right;margin-right: 20px;margin-top:10px;">保存</a>
<div id ="imgInput" style="display: none">
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

			$(".easy_upload_delbtn btn noselect").hide();

		});

		function save() {
		    debugger;
		    var input = {};
		    input.id = '${id}';
		    input.projectName = '${projectName}';
            var array=new Array()
            $(".image").each(function (index,elem) {
                array.push($(this).val());
            })
			input.images = array;
			$.ajax({
				url:'<%=basePath%>adIssue/saveImages.do',
                async: false,
                traditional: true,
				method:"post",
				data: input,
				success: function() {
                    top.Dialog.alert("保存成功!", function() {
                        top.Dialog.close();
					});

				}
			})
            //;
		}

        $('#easyContainer').easyUpload({
            allowFileTypes: '*.jpg',//允许上传文件类型，格式';*.doc;*.pdf'
            allowFileSize: 100000,//允许上传文件大小(KB)
            selectText: '选择文件',//选择文件按钮文案
            multi: true,//是否允许多文件上传
            multiNum: 5,//多文件上传时允许的文件数
            showNote: true,//是否展示文件上传说明
            note: '提示：支持格式为jpg',//文件上传说明
            showPreview: true,//是否显示文件预览
            url: '<%=basePath%>pictures/save2.do',//上传文件地址
            fileName: 'file',//文件filename配置参数
            formParam: {
            },//文件filename以外的配置参数，格式：{key1:value1,key2:value2}
            timeout: 30000,//请求超时时间
            okCode: 200,//与后端返回数据code值一致时执行成功回调，不配置默认200
            successFunc: function(res) {
                debugger;
                var index = res.success.length - 1;
                $("#imgInput").append('<input class="image" value="' + res.success[index].images + '" />')
                console.log('成功回调', res);
            },//上传成功回调函数
            errorFunc: function(res) {
                console.log('失败回调', res);
            },//上传失败回调函数
            deleteFunc: function(res) {
                console.log('删除回调', res);
            }//删除文件回调函数
        });

        function addImage(){
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag=true;
            diag.Title ="新增图片";
            diag.URL = '<%=basePath%>issue/goImageAdd.do';
            diag.Width = 600;
            diag.Height = 500;
            diag.CancelEvent = function(){ //关闭事件

                diag.close();
            };
            diag.show();
        }
		</script>





</body>
</html>