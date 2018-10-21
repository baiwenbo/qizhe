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

		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script src="static/jquery-2.2.3.min.js"></script>
		<script src="static/ajaxfileupload.js"></script>
		<script type="text/javascript">


		</script>
		<%--<script>  setTimeout(function(){--%>
            <%--$('input[type=text]').val(Math.random().toString(36).slice(2,8))--%>
            <%--$('.layer-date').val('2017-07-07')--%>
            <%--//$('input[type=number]').val(Math.floor(Math.random()*5))--%>
            <%--$('input[type=number]').val(5)--%>
            <%--$('textarea').val(18516528222)--%>
            <%--$('select').find('option:last').prop('selected',true)--%>
            <%--$('input[type=radio]').prop('checked',true)--%>
        <%--},1000)</script>--%>
<script>

    function setImg2(obj){//用于进行图片上传，返回地址
        var f=$(obj).val();
        if(f == null || f ==undefined || f == ''){
            return false;
        }else if(!/\.(?:png|jpg|bmp|gif|PNG|JPG|BMP|GIF)$/.test(f))
        {
            alertLayel("类型必须是图片(.png|jpg|bmp|gif|PNG|JPG|BMP|GIF)");
            $(obj).val('');
            return false;
        }else{
            //批量上传图片
            $.ajaxFileUpload({
                url:"<%=basePath%>pictures/save",//需要链接到服务器地址
                secureuri:false,
                fileElementId:"logoFile2",//文件选择框的id属性  ,//文件选择框的id属性
                dataType: 'json',   //json
                contentType: false,    //不可缺
                processData: false,    //不可缺
                success: function (data){
                    if(data!=null){
                        $.each(data,function(i,url){
                            //拼接图片列表
                            var id = $('#detailImgs li:last').attr('id');
                            id = id.substr(1);
                            id = parseInt(id) + 1;
                            var ids=id;
                            id = 'P'+id;
                            var a_hidden="<li id='"+ id +"'><input type='hidden' value='"+url+"' name='imgs'>";
                            var img_html="<img  src='"+url+"'  onclick='showOriginal(this)' original='"+url+"'>";
                            var a_html="<a href='javascript:void(0);' onclick='delespan1("+ids+")'>删除</a>";
                            //var datas="<li id='"+ id +"'><input type='hidden' value='"+data+"' name='beiyong5'>";
                            var li_html="</li>";
                            $('#detailImgs').append(a_hidden+img_html+a_html+li_html);
                        });
                    }else{
                        alertLayel("上传失败");
                        $("#url").val("");
                        $(obj).val('');
                    }
                },
                error:function(XMLHttpRequest, textStatus, errorThrown){
                    alertLayel("上传失败，请检查网络后重试");
                    $("#url").val("");
                    $(obj).val('');
                }
            });
        }
    }

    function delespan1(id){
        $('#P'+id).remove();
    }




</script>

	</head>
<body>
<form action="adIssue/${msg }.do" name="Form" id="Form" method="post" onsubmit="alert('提交成功')">
	<input type="hidden" name="ID" id="ID" value="${pd.ID}"/>
	<div id="zhongxin">
		<%--<a href="javascript:void(0);" class="btn_addPic">--%>
			<%--<span id="imgTitle">上传自定义详情图</span>--%>
			<%--<input type="file" name="file" id="logoFile2" onchange="setImg2(this);" class="selectedLogoImgId"--%>
				   <%--accept="image/jpg,image/jpeg,image/png,image/bmp" multiple/>--%>
		<%--</a>--%>
		<br />
		<span >审核月份:</span>
		<input style="width: 100px;" class="span10 date-picker" name="dateMonth" value="<fmt:formatDate value="${pd.dateMonth}" pattern="yyyy-MM-dd"/>"  type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="审核月份"  title="审核月份"/>
		<br/><font color="red"></font>
		<div class="cp-img" id="logoImgDiv6">
			<ul id="detailImgs" style="overflow: hidden;"   >
				<li style="display:none;" id="P0">
			</ul>
			<span id="hiddenss1"></span>
		</div>
		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b> </b></font></td>
		</tr>
		<tr class="text-center">
			<td valign="top">　</td>
			<table   class="table table-bordered" border="1" width="1000">
				<tr class="text-center">
					<td width="10%" align="left" valign="top"><div class="form-group">
						<label>加油站名称：</label>
						<c:if test="${varList == null }">
							<select class="form-control carModels" id="qname"  name="qname" >
									<option >${pd.qname}</option>
							</select>
						</c:if>
						<c:if test="${varList != null }">
						<select class="form-control carModels" id="qname"  name="qname" >
							<c:forEach items="${varList}" var="var" varStatus="vs">
							<option >${var.qname}</option>
							</c:forEach>
						</select>
						</c:if>
					</div></td>
					<td align="left" valign="top" width="40%">所属分公司：${pd.qgongsi}</td>
					<td align="left" width="13%" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所属片区:&nbsp;&nbsp;<input type="text" size=10 name="bumen" value="${pd.bumen}" ></td>

					<td align="left" width="21%" valign="top">洗手间（有/无）:<input type="text" size=10 name="wc" value="${pd.wc}" ></td>

				</tr>
				<tr class="text-center">
					<td width="16%" align="left" valign="top">油站编码：${pd.qnamehao}</td>
					<td align="left" width="13%" valign="top">便利店（有/无）:<input type="text" size=10 name="bianli" value="${pd.bianli}" ></td>
					<td align="left" valign="top" width="40%">所属类型（人工站/自助站）：<input type="text" size=10 name="type" value="${pd.type}" ></td>

					<td align="left" valign="top">访问员姓名：<input type="text" size=10 name="fname" value="${pd.fname}" ></td>
				</tr>
				<tr class="text-center">
					<td align="left" valign="top">进站时间：<input type="text" size=10 name="jinzhan" value="${pd.jinzhan}" ></td>
					<td width="10%" align="left" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	考评日期：&nbsp;&nbsp;&nbsp;<input type="text" size=10 name="jinzhandate" value="${pd.jinzhandate}" ></td>

					<td align="center" valign="middle" width="40%">工作日类别（工作日/周末日）:<input type="text" size=10 name="category" value="${pd.category}" ></td>
					<td align="left" valign="top" width="40%">加油站地址：${pd.address}</td>
				</tr>


				<tr class="text-center">



					<td align="left" valign="top">离站时间：<input type="text" size=30 name="lizhan" class="form-control"  value="${pd.lizhan}">　</td>


					<td align="left" valign="top"></td>
					<td align="left" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;油站得分：<input type="text" size=10 name="qscore" value="${pd.qscore}" ></td>

				</tr>

			</table>
		</tr>

		<%--<c:if test="${varList == null }">--%>
		<%--<tr>--%>
			<%--<td valign="top">申诉处理</td>--%>
			<%--<td>--%>
				<%--<font size="4"><b> </b></font></td>--%>
		<%--</tr>--%>
		<%--<tr class="text-center">--%>
			<%--<td valign="top">　</td>--%>
			<%--<td><table   class="table table-bordered" border="1" width="1000">--%>
				<%--<tr class="text-center">--%>
					<%--<td width="35%"><b>站点 申诉说明（下面填写）：</b>&nbsp;&nbsp;&nbsp;&nbsp;<font color=blue></font><br>--%>
						<%--<textarea name="beiyong1"  cols="60" rows="12" style="width:300px; height:200px">${pd.beiyong1}</textarea>--%>
						<%--<div class="row">--%>
							<%--<div class="col-md-4">--%>
								<%--<button type="submit" style="margin: 30px;" class="btn btn-sm btn-primary icon-check">提交</button>--%>
							<%--</div>--%>
						<%--</div></td>--%>

					<%--<td width="35%"><b>分公司申诉（下面填写）：</b>&nbsp;&nbsp;&nbsp;&nbsp;<font color=blue></font><br>--%>
						<%--<textarea name="fengongs"  cols="60" rows="12" style="width:300px; height:200px">${pd.fengongs}</textarea>--%>
						<%--<div class="row">--%>
							<%--<div class="col-md-4">--%>
								<%--<button type="submit" style="margin: 30px;" class="btn btn-sm btn-primary icon-check">提交</button>--%>
							<%--</div>--%>
						<%--</div></td>--%>

					<%--<td width="35%"><b>省公司批复（下面填写）：</b>&nbsp;&nbsp;&nbsp;&nbsp;<font color=blue></font><br>--%>
						<%--<textarea name="shenggs"  cols="60" rows="12" style="width:300px; height:200px">${pd.shenggs}</textarea>--%>
						<%--<div class="row">--%>
							<%--<div class="col-md-4">--%>
								<%--<button type="submit" style="margin: 30px;" class="btn btn-sm btn-primary icon-check">提交</button>--%>
							<%--</div>--%>
						<%--</div></td>--%>

					<%--<td width="35%"><b>启哲申诉答复:（下面填写）：</b>&nbsp;&nbsp;&nbsp;&nbsp;<font color=blue></font><br>--%>
						<%--<textarea name="beiyong2"  cols="60" rows="12" style="width:300px; height:200px">${pd.beiyong2}</textarea>--%>
						<%--<div class="row">--%>
							<%--<div class="col-md-4">--%>
								<%--<button type="submit" style="margin: 30px;" class="btn btn-sm btn-primary icon-check">提交</button>--%>
							<%--</div>--%>
						<%--</div>--%>
					<%--</td>--%>
				<%--</tr>--%>

			<%--</table>--%>
				<%--</c:if>--%>
		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b> </b></font></td>
		</tr>
		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b>A.基础管理 </b></font></td>
		</tr>
		<tr class="text-center">
			<td valign="top">　</td>
			<td><table   class="table table-bordered" border="1" width="1000">
				<tr class="text-center">
					<td width="10%" align="left" valign="top">序号</td>
					<td align="left" valign="top" width="40%">考核内容</td>
					<td width="16%" align="left" valign="top">扣分或加分</td>
					<td align="left" width="21%" valign="top">扣分或加分说明</td>
					<c:if test="${pd.ID != null}">
						<td align="left" width="50%" valign="top">扣分图片</td>
						<td align="left" width="50%" valign="top">申诉</td>
					</c:if>

					<td align="left" width="13%" valign="top">考核说明</td>
				</tr>

				<c:forEach items="${projectInfos}" var="projectInfo">
				<tr class="text-center">
					<c:set var="name" value="${projectInfo.key}" />
					<c:set var="nameSM" value="${projectInfo.key}sm" />
					<td width="10%" align="left" valign="top">${upperCaseInfo[name]}</td>
					<td align="center" valign="middle" width="40%">${projectInfo.value}</td>
					<td align="left" valign="top"><input type="text" size=10 name="${name}" value="${pd[name]}" >

					<td align="left" valign="top"><input type="text" size=30 name="${nameSM}" class="form-control"  value="${pd[nameSM]}">　</td>

					<c:if test="${pd.ID != null}">
						<td>
							<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', '${name}')">上传图片</a>
							<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', '${name}')">查看图片</a>
							<img src="<%=basePath%>uploadFiles/picture/${pd.qname}-${name}.png" alt=""></img><BR>
							<img src="<%=basePath%>uploadFiles/picture/${pd.qname}-${name}.jpg" alt=""></img><BR>
							<img src="<%=basePath%>uploadFiles/picture/${pd.qname}-${name}.JPG" alt=""></img><BR>
						</td>
						<td>
							<a href="<%=basePath%>adIssue/auditPage.do?projectName=${name}&ID=${pd.ID}">网点申诉</a>
						</td>
					</c:if>
					<td align="left" valign="top">${projectHelp[name]}</td>
				</tr>
				</c:forEach>


<%--
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A01</td>
					<td align="center" valign="middle" width="40%">未设置“加油站6S+管理”文件盒（F-01），扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a01" value="${pd.a01}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a01sm" class="form-control"  value="${pd.a01sm}">　</td>
					<c:if test="${pd.ID != null}">
						<td>
							<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'a01')">上传图片</a>
							<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'a01')">查看图片</a>
						</td>
						<td>
							<a href="<%=basePath%>adIssue/auditPage.do?projectName=a01&ID=${pd.ID}">网点申诉</a>
							<c:choose>
								<c:when test="${auditInfo['a01'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'a01', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['a01'].status == 1 || auditInfo['a01'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'a01', ${auditInfo['a01'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'a01', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'a01', ${auditInfo['a01'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A02</td>
					<td align="center" valign="middle" width="40%">定置管理图册未放置在“加油站6S+管理”文件盒里，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a02"  value="${pd.a02}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a02sm" class="form-control" value="${pd.a02sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A02')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A02')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A02'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A02', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A02'].status == 1 || auditInfo['A02'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A02', ${auditInfo['A02'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A02', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A02', ${auditInfo['A02'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A03</td>
					<td align="center" valign="middle" width="40%">红单物品未集中存放，扣1分（询问该物品放置位置，再评判，若无该物品，询问原因，不扣分，填写在扣分说明那栏）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a03" value="${pd.a03}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a03sm" class="form-control" value="${pd.a03sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A03')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A03')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A03'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A03', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A03'].status == 1 || auditInfo['A03'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A03', ${auditInfo['A03'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A03', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A03', ${auditInfo['A03'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　一定时期后应全部清除加油站</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A04</td>
					<td align="center" valign="middle" width="40%">无卫生管理责任制或部分区域管理责任不明确，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a04" value="${pd.a04}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a04sm" class="form-control"  value="${pd.a04sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A04')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A04')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A04'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A04', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A04'].status == 1 || auditInfo['A04'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A04', ${auditInfo['A04'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A04', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A04', ${auditInfo['A04'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　暂不考核</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A05</td>
					<td align="center" valign="middle" width="40%">无定置管理图册，扣20分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a05"  value="${pd.a05}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a05sm" class="form-control" value="${pd.a05sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A05')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A05')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A05'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A05', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A05'].status == 1 || auditInfo['A05'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A05', ${auditInfo['A05'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A05', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A05', ${auditInfo['A05'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">可用A4纸黑白打印装订成册　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A06</td>
					<td align="center" valign="middle" width="40%">办公室、收银区、便利店、加油现场（含站房四周）、配发电间、厨房餐厅、员工宿舍、活动室、卫生间、其它房间定置管理图册缺项，每项扣2分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a06" value="${pd.a06}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a06sm" class="form-control" value="${pd.a06sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A06')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A06')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A06'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A06', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A06'].status == 1 || auditInfo['A06'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A06', ${auditInfo['A06'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A06', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A06', ${auditInfo['A06'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">先期考核办公室、加油现场（含站房四周）、配发电间、厨房餐厅、员工宿舍、活动室，2018年7月起全面考核　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A07</td>
					<td align="center" valign="middle" width="40%">实际摆放物品（一级清单可移动物品）与定置管理图不符（正在使用的除外），或未按定位标识摆放，每个区域（房间）扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a07" value="${pd.a07}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a07sm" class="form-control"  value="${pd.a07sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A07')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A07')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A07'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A07', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A07'].status == 1 || auditInfo['A07'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A07', ${auditInfo['A07'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A07', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A07', ${auditInfo['A07'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">先期考核办公室、加油现场（含站房四周）、配发电间、厨房餐厅、员工宿舍、活动室，2018年7月起全面考核　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A08</td>
					<td align="center" valign="middle" width="40%">站内室外或室内出现过期海报，扣1分（2分封顶）（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a08"  value="${pd.a08}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a08sm" class="form-control" value="${pd.a08sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A08')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A08')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A08'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A08', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A08'].status == 1 || auditInfo['A08'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A08', ${auditInfo['A08'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A08', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A08', ${auditInfo['A08'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A09</td>
					<td align="center" valign="middle" width="40%">站内海报框外粘贴海报，或收银区、文件柜等设施设备上随意粘贴便条、价签等，每处扣1分（3分封顶）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a09" value="${pd.a09}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a09sm" class="form-control" value="${pd.a09sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A09')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A09')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A09'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A09', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A09'].status == 1 || auditInfo['A09'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A09', ${auditInfo['A09'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A09', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A09', ${auditInfo['A09'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　暂不考核，规范后考核</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A10</td>
					<td align="center" valign="middle" width="40%">设施设备不完好（锈蚀、损坏、墙面涂料剥落等），每件（处）扣1分（3分封顶）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a10" value="${pd.a10}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a10sm" class="form-control"  value="${pd.a10sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A10')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A10')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A10'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A10', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A10'].status == 1 || auditInfo['A10'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A10', ${auditInfo['A10'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A10', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A10', ${auditInfo['A10'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">其它项有考核的除外　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A11</td>
					<td align="center" valign="middle" width="40%">站内各区域、设施设备、商品等不整洁（有明显垃圾、积尘、积水、油污、污渍、蛛网，墙面明显污损），每处扣1分（3分封顶）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a11"  value="${pd.a11}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a11sm" class="form-control" value="${pd.a11sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A11')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A11')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A11'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A11', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A11'].status == 1 || auditInfo['A11'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A11', ${auditInfo['A11'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A11', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A11', ${auditInfo['A11'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">重点关注顾客可视的加油现场、加油设备、主立牌灯箱、罩棚、立柱、墙面、绿化等，其它项有考核的除外　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A12</td>
					<td align="center" valign="middle" width="40%">6S标识标牌制作不规范，每样扣１分（3分封顶）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a12" value="${pd.a12}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a12sm" class="form-control" value="${pd.a12sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A12')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A12')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A12'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A12', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A12'].status == 1 || auditInfo['A12'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A12', ${auditInfo['A12'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A12', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A12', ${auditInfo['A12'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　暂不考核，2018年7月起全面考核</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A13</td>
					<td align="center" valign="middle" width="40%">6S标识标牌安装使用不规范，每样扣１分（3分封顶）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a13" value="${pd.a13}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a13sm" class="form-control"  value="${pd.a13sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A13')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A13')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A13'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A13', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A13'].status == 1 || auditInfo['A13'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A13', ${auditInfo['A13'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A13', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A13', ${auditInfo['A13'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　暂不考核，2018年7月起全面考核</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A14</td>
					<td align="center" valign="middle" width="40%">6S标识标牌损坏未及时修护，每样扣１分（3分封顶）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a14"  value="${pd.a14}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a14sm" class="form-control" value="${pd.a14sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A14')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A14')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A14'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A14', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A14'].status == 1 || auditInfo['A14'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A14', ${auditInfo['A14'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A14', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A14', ${auditInfo['A14'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A15</td>
					<td align="center" valign="middle" width="40%">手机未设集中放置位置，未粘贴定位标识，实际未落实集中管理，摆放无序，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a15" value="${pd.a15}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a15sm" class="form-control" value="${pd.a15sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A15')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A15')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A15'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A15', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A15'].status == 1 || auditInfo['A15'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A15', ${auditInfo['A15'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A15', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A15', ${auditInfo['A15'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A16</td>
					<td align="center" valign="middle" width="40%">茶杯未设集中放置位置，未粘贴定位标识，实际未落实集中管理，摆放无序，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a16" value="${pd.a16}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a16sm" class="form-control"  value="${pd.a16sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A16')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A16')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A16'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A16', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A16'].status == 1 || auditInfo['A16'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A16', ${auditInfo['A16'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A16', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A16', ${auditInfo['A16'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　办公室可放置在个人物品柜里，加油现场可根据需要设置物品整理箱</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A17</td>
					<td align="center" valign="middle" width="40%">书架无分类标识牌，书籍无分类标签，或书籍摆放零乱或与分类标识牌不符，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a17"  value="${pd.a17}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a17sm" class="form-control" value="${pd.a17sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A17')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A17')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A17'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A17', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A17'].status == 1 || auditInfo['A17'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A17', ${auditInfo['A17'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A17', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A17', ${auditInfo['A17'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A18</td>
					<td align="center" valign="middle" width="40%">存档资料未放入档案盒，或档案盒未填写资料日期和目录，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a18" value="${pd.a18}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a18sm" class="form-control" value="${pd.a18sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A18')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A18')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A18'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A18', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A18'].status == 1 || auditInfo['A18'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A18', ${auditInfo['A18'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A18', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A18', ${auditInfo['A18'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　备用帐表册可叠放，不用放于档案盒</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A19</td>
					<td align="center" valign="middle" width="40%">存档小票未整理保存，保存的小票未填写日期，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a19" value="${pd.a19}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a19sm" class="form-control"  value="${pd.a19sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A19')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A19')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A19'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A19', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A19'].status == 1 || auditInfo['A19'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A19', ${auditInfo['A19'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A19', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A19', ${auditInfo['A19'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A20</td>
					<td align="center" valign="middle" width="40%">电源开关上方未粘贴“请随手关灯”提示牌，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a20"  value="${pd.a20}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a20sm" class="form-control" value="${pd.a20sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A20')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A20')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A20'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A20', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A20'].status == 1 || auditInfo['A20'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A20', ${auditInfo['A20'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A20', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A20', ${auditInfo['A20'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">一组电源开关一个　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A21</td>
					<td align="center" valign="middle" width="40%">两个或以上按键的电源开关未粘贴按键控制标识或标识不易识别，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a21" value="${pd.a21}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a21sm" class="form-control" value="${pd.a21sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A21')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A21')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A21'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A21', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A21'].status == 1 || auditInfo['A21'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A21', ${auditInfo['A21'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A21', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A21', ${auditInfo['A21'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A22</td>
					<td align="center" valign="middle" width="40%">安装空调的房间未安装遥控板插袋，或有插袋无遥控板，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a22" value="${pd.a22}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a22sm" class="form-control"  value="${pd.a22sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A22')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A22')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A22'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A22', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A22'].status == 1 || auditInfo['A22'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A22', ${auditInfo['A22'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A22', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A22', ${auditInfo['A22'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　便利店内可安装在柜门内侧</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A23</td>
					<td align="center" valign="middle" width="40%">空调遥控板插袋上方未粘贴“请随手关空调”提示牌，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a23"  value="${pd.a23}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a23sm" class="form-control" value="${pd.a23sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A23')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A23')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A23'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A23', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A23'].status == 1 || auditInfo['A23'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A23', ${auditInfo['A23'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A23', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A23', ${auditInfo['A23'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A24</td>
					<td align="center" valign="middle" width="40%">无人时未关空调，扣2分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a24" value="${pd.a24}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a24sm" class="form-control" value="${pd.a24sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A24')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A24')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A24'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A24', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A24'].status == 1 || auditInfo['A24'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A24', ${auditInfo['A24'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A24', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A24', ${auditInfo['A24'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A25</td>
					<td align="center" valign="middle" width="40%">水龙头上方未粘贴“请节约用水”提示牌，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a25" value="${pd.a25}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a25sm" class="form-control"  value="${pd.a25sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A25')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A25')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A25'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A25', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A25'].status == 1 || auditInfo['A25'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A25', ${auditInfo['A25'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A25', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A25', ${auditInfo['A25'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">卫生间洗手盆的水龙头已粘贴“请节约用水”提示的除外　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A26</td>
					<td align="center" valign="middle" width="40%">窗帘未粘贴开启线，或开启时未按标线开启，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a26"  value="${pd.a26}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a26sm" class="form-control" value="${pd.a26sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A26')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A26')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A26'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A26', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A26'].status == 1 || auditInfo['A26'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A26', ${auditInfo['A26'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A26', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A26', ${auditInfo['A26'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">左右开启的窗帘不设开启线，但开启状态应统一　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A27</td>
					<td align="center" valign="middle" width="40%">站房（室内）灭火器设置不符合要求，未粘贴定位标识，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a27" value="${pd.a27}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a27sm" class="form-control" value="${pd.a27sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A27')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A27')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A27'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A27', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A27'].status == 1 || auditInfo['A27'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A27', ${auditInfo['A27'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A27', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A27', ${auditInfo['A27'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A28</td>
					<td align="center" valign="middle" width="40%">站房内有较明显高低差或存在安全隐患的门槛、台阶，服务区与办公区需提示顾客止步或其它需要提醒的地方未粘贴安全警示线，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a28" value="${pd.a28}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a28sm" class="form-control"  value="${pd.a28sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A28')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A28')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A28'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A28', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A28'].status == 1 || auditInfo['A28'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A28', ${auditInfo['A28'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A28', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A28', ${auditInfo['A28'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">粘贴在高处，粘贴方式需优化　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A29</td>
					<td align="center" valign="middle" width="40%">设备线路零乱，接线不规范，每处扣1分（3分封顶）</td>
					<td align="left" valign="top"><input type="text" size=10 name="a29"  value="${pd.a29}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a29sm" class="form-control" value="${pd.a29sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A29')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A29')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A29'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A29', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A29'].status == 1 || auditInfo['A29'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A29', ${auditInfo['A29'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A29', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A29', ${auditInfo['A29'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　其它项有考核的除外</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A30</td>
					<td align="center" valign="middle" width="40%">设备安装后较长的电源线路未作绕圈处理，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a30" value="${pd.a30}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a30sm" class="form-control" value="${pd.a30sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A30')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A30')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A30'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A30', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A30'].status == 1 || auditInfo['A30'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A30', ${auditInfo['A30'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A30', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A30', ${auditInfo['A30'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">A31</td>
					<td align="center" valign="middle" width="40%">顾客视线范围内（含办公室）的电源线、信号线、管线等未作隐蔽处理，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a31" value="${pd.a31}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a31sm" class="form-control"  value="${pd.a31sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A31')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A31')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A31'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A31', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A31'].status == 1 || auditInfo['A31'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A31', ${auditInfo['A31'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A31', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A31', ${auditInfo['A31'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">初期室内未作隐蔽处理，但只有一个线槽的考核　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">A32</td>
					<td align="center" valign="middle" width="40%">信息设备、空调、热水器、洗衣机、电视机等设备的电源线、信号线、管道（线）未隐蔽设置的，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="a32"  value="${pd.a32}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="a32sm" class="form-control" value="${pd.a32sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'A32')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'A32')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['A32'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A32', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['A32'].status == 1 || auditInfo['A32'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'A32', ${auditInfo['A32'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'A32', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'A32', ${auditInfo['A32'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">暂不考核，适用于2017年及以后新建投运或实施站房技改的加油站　</td>
				</tr>
			</table>


		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b>B.加油现场 </b></font></td>
		</tr>
		<tr class="text-center">
			<td valign="top">　</td>
			<td><table   class="table table-bordered" border="1" width="1000">
				<tr class="text-center">
					<td width="10%" align="left" valign="top">序号</td>
					<td align="left" valign="top" width="40%">考核内容</td>
					<td width="16%" align="left" valign="top">扣分或加分</td>
					<td align="left" width="21%" valign="top">扣分或加分说明</td>
					<td align="left" width="13%" valign="top">考核说明</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">B01</td>
					<td align="center" valign="middle" width="40%">加油现场未按《加油站细节管理手册》要求摆放物品，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b01" value="${pd.b01}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b01sm" class="form-control"  value="${pd.b01sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B01')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B01')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B01'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B01', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B01'].status == 1 || auditInfo['B01'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B01', ${auditInfo['B01'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B01', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B01', ${auditInfo['B01'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">参照细节管理手册，侧重加油岛和标准物件，垃圾桶不需要每岛一个　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B02</td>
					<td align="center" valign="middle" width="40%">无站铭牌或制作不规范，扣2分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="b02"  value="${pd.b02}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b02sm" class="form-control" value="${pd.b02sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B02')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B02')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B02'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B02', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B02'].status == 1 || auditInfo['B02'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B02', ${auditInfo['B02'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B02', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B02', ${auditInfo['B02'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">暂不考核，2018年5月20日起全面考核　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B03</td>
					<td align="center" valign="middle" width="40%">新版站铭牌星级、支付方式和便民服务标识牌与实际不符或摆放位置不正确，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b03" value="${pd.b03}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b03sm" class="form-control" value="${pd.b03sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B03')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B03')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B03'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B03', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B03'].status == 1 || auditInfo['B03'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B03', ${auditInfo['B03'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B03', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B03', ${auditInfo['B03'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　暂不考核，2018年5月20日起全面考核</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">B04</td>
					<td align="center" valign="middle" width="40%">安装新版站铭牌的，未取消原报警监控和95504温馨提示牌，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b04" value="${pd.b04}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b04sm" class="form-control"  value="${pd.b04sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B04')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B04')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B04'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B04', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B04'].status == 1 || auditInfo['B04'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B04', ${auditInfo['B04'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B04', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B04', ${auditInfo['B04'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　暂不考核，2018年5月20日起全面考核</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B05</td>
					<td align="center" valign="middle" width="40%">便利店前未配置不锈钢垃圾桶，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b05"  value="${pd.b05}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b05sm" class="form-control" value="${pd.b05sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B05')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B05')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B05'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B05', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B05'].status == 1 || auditInfo['B05'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B05', ${auditInfo['B05'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B05', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B05', ${auditInfo['B05'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">直径约30cm为宜，分公司内统一型号，不具备条件的可不配置　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B06</td>
					<td align="center" valign="middle" width="40%">便利店前仍放置废旧电池回收箱，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b06" value="${pd.b06}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b06sm" class="form-control" value="${pd.b06sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B06')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B06')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B06'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B06', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B06'].status == 1 || auditInfo['B06'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B06', ${auditInfo['B06'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B06', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B06', ${auditInfo['B06'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">先期考核办公室、加油现场（含站房四周）、配发电间、厨房餐厅、员工宿舍、活动室，2018年7月起全面考核　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">B07</td>
					<td align="center" valign="middle" width="40%">便利店前物品、室外垃圾桶未按要求设置地面定位标识，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b07" value="${pd.b07}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b07sm" class="form-control"  value="${pd.b07sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B07')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B07')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B07'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B07', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B07'].status == 1 || auditInfo['B07'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B07', ${auditInfo['B07'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B07', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B07', ${auditInfo['B07'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">绿植除外　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B08</td>
					<td align="center" valign="middle" width="40%">促销展区未设置地面定位标识，扣1分（询问该标识位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="b08"  value="${pd.b08}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b08sm" class="form-control" value="${pd.b08sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B08')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B08')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B08'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B08', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B08'].status == 1 || auditInfo['B08'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B08', ${auditInfo['B08'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B08', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B08', ${auditInfo['B08'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B09</td>
					<td align="center" valign="middle" width="40%">垃圾桶未按要求粘贴限高线，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b09" value="${pd.b09}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b09sm" class="form-control" value="${pd.b09sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B09')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B09')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B09'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B09', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B09'].status == 1 || auditInfo['B09'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B09', ${auditInfo['B09'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B09', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B09', ${auditInfo['B09'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　便利店前、加油现场</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">B10</td>
					<td align="center" valign="middle" width="40%">垃圾桶内垃圾超过限高线未及时清理，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b10" value="${pd.b10}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b10sm" class="form-control"  value="${pd.b10sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B10')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B10')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B10'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B10', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B10'].status == 1 || auditInfo['B10'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B10', ${auditInfo['B10'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B10', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B10', ${auditInfo['B10'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">暂不考核　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B11</td>
					<td align="center" valign="middle" width="40%">摩托车加油处未按标准配置灭火器、加油壶、置物架、遮阳伞、提示牌，扣1分（询问摩托车加油处放置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="b11"  value="${pd.b11}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b11sm" class="form-control" value="${pd.b11sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B11')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B11')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B11'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B11', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B11'].status == 1 || auditInfo['B11'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B11', ${auditInfo['B11'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B11', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B11', ${auditInfo['B11'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">加油枪直接向摩托车加油的除外　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B12</td>
					<td align="center" valign="middle" width="40%">摩托车加油区域未按要求用黄色标线标示，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b12" value="${pd.b12}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b12sm" class="form-control" value="${pd.b12sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B12')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B12')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B12'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B12', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B12'].status == 1 || auditInfo['B12'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B12', ${auditInfo['B12'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B12', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B12', ${auditInfo['B12'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　加油枪直接向摩托车加油的除外</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">B13</td>
					<td align="center" valign="middle" width="40%">一层进入办公楼的门未设置开闭线，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b13" value="${pd.b13}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b13sm" class="form-control"  value="${pd.b13sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B13')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B13')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B13'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B13', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B13'].status == 1 || auditInfo['B13'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B13', ${auditInfo['B13'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B13', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B13', ${auditInfo['B13'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B14</td>
					<td align="center" valign="middle" width="40%">计量器具箱未放置在卸油区消防器材间，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="b14"  value="${pd.b14}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b14sm" class="form-control" value="${pd.b14sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B14')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B14')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B14'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B14', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B14'].status == 1 || auditInfo['B14'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B14', ${auditInfo['B14'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B14', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B14', ${auditInfo['B14'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B15</td>
					<td align="center" valign="middle" width="40%">绿化地、盆栽有杂物、杂草，枯枝未清理，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b15" value="${pd.b15}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b15sm" class="form-control" value="${pd.b15sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B15')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B15')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B15'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B15', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B15'].status == 1 || auditInfo['B15'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B15', ${auditInfo['B15'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B15', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B15', ${auditInfo['B15'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">B16</td>
					<td align="center" valign="middle" width="40%">站前绿化植物高度高于1米，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b16" value="${pd.b16}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b16sm" class="form-control"  value="${pd.b16sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B16')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B16')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B16'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B16', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B16'].status == 1 || auditInfo['B16'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B16', ${auditInfo['B16'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B16', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B16', ${auditInfo['B16'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　暂不考核</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B17</td>
					<td align="center" valign="middle" width="40%">在顾客可见范围内晾晒衣服，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b17"  value="${pd.b17}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b17sm" class="form-control" value="${pd.b17sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B17')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B17')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B17'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B17', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B17'].status == 1 || auditInfo['B17'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B17', ${auditInfo['B17'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B17', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B17', ${auditInfo['B17'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">结合实际情况评判是否扣分　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B18</td>
					<td align="center" valign="middle" width="40%">一楼保洁用品（具）未集中管理，每处扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="b18" value="${pd.b18}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b18sm" class="form-control" value="${pd.b18sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B18')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B18')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B18'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B18', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B18'].status == 1 || auditInfo['B18'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B18', ${auditInfo['B18'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B18', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B18', ${auditInfo['B18'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　厕所设置在便利店内的，厕所内可适量设置拖把</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">B19</td>
					<td align="center" valign="middle" width="40%">清洁用具未按要求设置标识牌，或放置地面的清洁用具无地面定位标线，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b19" value="${pd.b19}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b19sm" class="form-control"  value="${pd.b19sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B19')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B19')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B19'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B19', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B19'].status == 1 || auditInfo['B19'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B19', ${auditInfo['B19'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B19', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B19', ${auditInfo['B19'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B20</td>
					<td align="center" valign="middle" width="40%">拖把、抹布未用颜色区分或颜色不符，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b20"  value="${pd.b20}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b20sm" class="form-control" value="${pd.b20sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B20')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B20')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B20'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B20', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B20'].status == 1 || auditInfo['B20'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B20', ${auditInfo['B20'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B20', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B20', ${auditInfo['B20'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B21</td>
					<td align="center" valign="middle" width="40%">污水井、生化池、雨水井、消防井、电力、燃气管道井井盖未按要求涂刷相应颜色的油漆，或未标出介质流向，扣1分（询问该标识位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="b21" value="${pd.b21}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b21sm" class="form-control" value="${pd.b21sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B21')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B21')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B21'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B21', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B21'].status == 1 || auditInfo['B21'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B21', ${auditInfo['B21'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B21', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B21', ${auditInfo['B21'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">B22</td>
					<td align="center" valign="middle" width="40%">硬化地面下埋设的油品、电缆管道未按要求在地面上进行标示的，扣3分（询问该标识位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="b22" value="${pd.b22}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b22sm" class="form-control"  value="${pd.b22sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B22')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B22')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B22'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B22', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B22'].status == 1 || auditInfo['B22'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B22', ${auditInfo['B22'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B22', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B22', ${auditInfo['B22'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　暂不考核，适用于2017年及以后新建投运或实施管线改造的加油站</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B23</td>
					<td align="center" valign="middle" width="40%">硬化地面下埋设的油品、电缆管道在地面有标识，但变向处或无变向未按5米设置一组标识的，扣2分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b23"  value="${pd.b23}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b23sm" class="form-control" value="${pd.b23sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B23')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B23')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B23'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B23', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B23'].status == 1 || auditInfo['B23'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B23', ${auditInfo['B23'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B23', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B23', ${auditInfo['B23'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　暂不考核，适用于2017年及以后新建投运或实施管线改造的加油站</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">B24</td>
					<td align="center" valign="middle" width="40%">室外其它区域物品堆放凌乱，无地面标线，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="b24" value="${pd.b24}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="b24sm" class="form-control" value="${pd.b24sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'B24')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'B24')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['B24'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B24', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['B24'].status == 1 || auditInfo['B24'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'B24', ${auditInfo['B24'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'B24', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'B24', ${auditInfo['B24'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">尽量掩蔽，不宜多设　</td>
				</tr>
			</table>

		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b>C.办公区 </b></font></td>
		</tr>
		<tr class="text-center">
			<td valign="top">　</td>
			<td><table   class="table table-bordered" border="1" width="1000">
				<tr class="text-center">
					<td width="10%" align="left" valign="top">序号</td>
					<td align="left" valign="top" width="40%">考核内容</td>
					<td width="16%" align="left" valign="top">扣分或加分</td>
					<td align="left" width="21%" valign="top">扣分或加分说明</td>
					<td align="left" width="13%" valign="top">考核说明</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C01</td>
					<td align="center" valign="middle" width="40%">办公室整体布局不合理（一般设置机柜、办公桌、桌柜、配套座椅、文件柜、灭火器、垃圾桶），扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c01" value="${pd.c01}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c01sm" class="form-control"  value="${pd.c01sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C01')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C01')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C01'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C01', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C01'].status == 1 || auditInfo['C01'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C01', ${auditInfo['C01'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C01', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C01', ${auditInfo['C01'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">办公桌一般不超过3张；一楼设置办公室的，二楼一般不再设置　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C02</td>
					<td align="center" valign="middle" width="40%">电脑主机放置不合理，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c02"  value="${pd.c02}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c02sm" class="form-control" value="${pd.c02sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C02')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C02')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C02'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C02', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C02'].status == 1 || auditInfo['C02'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C02', ${auditInfo['C02'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C02', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C02', ${auditInfo['C02'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C03</td>
					<td align="center" valign="middle" width="40%">清洁抹布未隐蔽设置，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c03" value="${pd.c03}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c03sm" class="form-control" value="${pd.c03sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C03')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C03')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C03'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C03', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C03'].status == 1 || auditInfo['C03'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C03', ${auditInfo['C03'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C03', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C03', ${auditInfo['C03'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　一定时期后应全部清除加油站</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C04</td>
					<td align="center" valign="middle" width="40%">人离座时办公椅未按要求摆放，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c04" value="${pd.c04}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c04sm" class="form-control"  value="${pd.c04sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C04')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C04')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C04'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C04', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C04'].status == 1 || auditInfo['C04'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C04', ${auditInfo['C04'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C04', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C04', ${auditInfo['C04'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C05</td>
					<td align="center" valign="middle" width="40%">办公桌抽屉未粘贴分类标识牌或未按要求设置，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c05"  value="${pd.c05}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c05sm" class="form-control" value="${pd.c05sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C05')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C05')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C05'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C05', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C05'].status == 1 || auditInfo['C05'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C05', ${auditInfo['C05'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C05', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C05', ${auditInfo['C05'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">从上到下一般为“办公文具”“常用文件”“个人物品”，按需设置　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C06</td>
					<td align="center" valign="middle" width="40%">办公桌抽屉内物品与分类标识牌不符，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c06" value="${pd.c06}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c06sm" class="form-control" value="${pd.c06sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C06')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C06')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C06'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C06', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C06'].status == 1 || auditInfo['C06'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C06', ${auditInfo['C06'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C06', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C06', ${auditInfo['C06'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C07</td>
					<td align="center" valign="middle" width="40%">办公桌抽屉内办公文具未使用收纳格或行迹管理，或文件资料分散放置，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c07" value="${pd.c07}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c07sm" class="form-control"  value="${pd.c07sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C07')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C07')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C07'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C07', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C07'].status == 1 || auditInfo['C07'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C07', ${auditInfo['C07'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C07', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C07', ${auditInfo['C07'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C08</td>
					<td align="center" valign="middle" width="40%">文件柜（标准文件柜）分类标牌未按要求设置，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="c08"  value="${pd.c08}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c08sm" class="form-control" value="${pd.c08sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C08')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C08')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C08'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C08', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C08'].status == 1 || auditInfo['C08'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C08', ${auditInfo['C08'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C08', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C08', ${auditInfo['C08'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　上层“文件资料”，下层“办公用品”</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C09</td>
					<td align="center" valign="middle" width="40%">文件柜（标准文件柜）上层文件资料未统一装入文件盒，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c09" value="${pd.c09}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c09sm" class="form-control" value="${pd.c09sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C09')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C09')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C09'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C09', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C09'].status == 1 || auditInfo['C09'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C09', ${auditInfo['C09'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C09', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C09', ${auditInfo['C09'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">有三层的，最下面一层可设置资料篮，整齐放置待装订资料</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C10</td>
					<td align="center" valign="middle" width="40%">文件柜内存放非当年有效文件资料，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c10" value="${pd.c10}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c10sm" class="form-control"  value="${pd.c10sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C10')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C10')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C10'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C10', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C10'].status == 1 || auditInfo['C10'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C10', ${auditInfo['C10'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C10', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C10', ${auditInfo['C10'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">暂不考核，有特殊要求的除外　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C11</td>
					<td align="center" valign="middle" width="40%">文件柜（标准文件柜）下层未放置办公用品或其它地方摆放备用办公用品，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c11"  value="${pd.c11}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c11sm" class="form-control" value="${pd.c11sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C11')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C11')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C11'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C11', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C11'].status == 1 || auditInfo['C11'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C11', ${auditInfo['C11'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C11', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C11', ${auditInfo['C11'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">其它地方摆放办公用品的暂不考核，2019年1月1日起执行考核　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C12</td>
					<td align="center" valign="middle" width="40%">文件柜（标准文件柜）下层物品未分类整齐摆放，未使用收纳格或蓝色标线区分，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c12" value="${pd.c12}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c12sm" class="form-control" value="${pd.c12sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C12')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C12')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C12'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C12', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C12'].status == 1 || auditInfo['C12'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C12', ${auditInfo['C12'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C12', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C12', ${auditInfo['C12'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　多余空间可放置备用账表册</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C13</td>
					<td align="center" valign="middle" width="40%">文件柜（标准文件柜）下层物品无分类标签，或实际摆放与分类标签不符，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c13" value="${pd.c13}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c13sm" class="form-control"  value="${pd.c13sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C13')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C13')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C13'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C13', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C13'].status == 1 || auditInfo['C13'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C13', ${auditInfo['C13'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C13', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C13', ${auditInfo['C13'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　与标签不符暂不考核，需完善分类优化</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C14</td>
					<td align="center" valign="middle" width="40%">文件柜（标准文件柜）内二级清单填写不规范、粘贴不规范或与实际不符，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c14"  value="${pd.c14}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c14sm" class="form-control" value="${pd.c14sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C14')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C14')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C14'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C14', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C14'].status == 1 || auditInfo['C14'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C14', ${auditInfo['C14'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C14', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C14', ${auditInfo['C14'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">其它文件柜不设置二级清单　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C15</td>
					<td align="center" valign="middle" width="40%">文件盒内三级清单填写不规范、粘贴不规范或与实际不符，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c15" value="${pd.c15}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c15sm" class="form-control" value="${pd.c15sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C15')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C15')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C15'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C15', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C15'].status == 1 || auditInfo['C15'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C15', ${auditInfo['C15'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C15', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C15', ${auditInfo['C15'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C16</td>
					<td align="center" valign="middle" width="40%">文件盒、文件夹无标签或制作不规范，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c16" value="${pd.c16}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c16sm" class="form-control"  value="${pd.c16sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C16')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C16')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C16'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C16', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C16'].status == 1 || auditInfo['C16'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C16', ${auditInfo['C16'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C16', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C16', ${auditInfo['C16'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　文件夹可用A4纸长边制作</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C17</td>
					<td align="center" valign="middle" width="40%">桌柜内放置的常用工具、备用清洁用品或其它物品未分类整齐摆放，未使用蓝色标线区分（采用行迹管理的除外），扣1分（（询问该物品放置位置，再评判，若无桌柜询问原因，并填写在扣分说明那栏）</td>
					<td align="left" valign="top"><input type="text" size=10 name="c17"  value="${pd.c17}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c17sm" class="form-control" value="${pd.c17sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C17')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C17')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C17'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C17', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C17'].status == 1 || auditInfo['C17'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C17', ${auditInfo['C17'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C17', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C17', ${auditInfo['C17'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">备用清洁用品、常用工具不得放置在文件柜内（防爆电筒除外），不首选设置在办公室内（无条件的除外）　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C18</td>
					<td align="center" valign="middle" width="40%">桌柜内物品无分类标签，或实际摆放与分类标签不符，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c18" value="${pd.c18}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c18sm" class="form-control" value="${pd.c18sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C18')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C18')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C18'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C18', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C18'].status == 1 || auditInfo['C18'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C18', ${auditInfo['C18'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C18', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C18', ${auditInfo['C18'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　不设置二级清单</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C19</td>
					<td align="center" valign="middle" width="40%">办公室门把手上方无“推”“拉”标识牌，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c19" value="${pd.c19}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c19sm" class="form-control"  value="${pd.c19sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C19')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C19')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C19'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C19', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C19'].status == 1 || auditInfo['C19'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C19', ${auditInfo['C19'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C19', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C19', ${auditInfo['C19'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C20</td>
					<td align="center" valign="middle" width="40%">办公室的门未粘贴开闭线，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c20"  value="${pd.c20}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c20sm" class="form-control" value="${pd.c20sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C20')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C20')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C20'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C20', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C20'].status == 1 || auditInfo['C20'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C20', ${auditInfo['C20'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C20', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C20', ${auditInfo['C20'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">二楼办公室不粘贴，便利店库房不粘贴　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C21</td>
					<td align="center" valign="middle" width="40%">办公桌摆放物品定位标识不全，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c21" value="${pd.c21}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c21sm" class="form-control" value="${pd.c21sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C21')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C21')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C21'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C21', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C21'].status == 1 || auditInfo['C21'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C21', ${auditInfo['C21'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C21', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C21', ${auditInfo['C21'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">桌面物品、主机箱　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C22</td>
					<td align="center" valign="middle" width="40%">钥匙箱内分区挂放位置、颜色不正确，钥匙牌或内芯背景色不正确，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="c22" value="${pd.c22}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c22sm" class="form-control"  value="${pd.c22sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C22')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C22')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C22'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C22', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C22'].status == 1 || auditInfo['C22'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C22', ${auditInfo['C22'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C22', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C22', ${auditInfo['C22'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C23</td>
					<td align="center" valign="middle" width="40%">便民医药箱设置位置不合理，未粘贴定位标识，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="c23"  value="${pd.c23}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c23sm" class="form-control" value="${pd.c23sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C23')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C23')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C23'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C23', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C23'].status == 1 || auditInfo['C23'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C23', ${auditInfo['C23'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C23', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C23', ${auditInfo['C23'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">方便实用就可以　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C24</td>
					<td align="center" valign="middle" width="40%">加油站信息设备配置超标准，每件扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c24" value="${pd.c24}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c24sm" class="form-control" value="${pd.c24sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C24')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C24')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C24'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C24', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C24'].status == 1 || auditInfo['C24'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C24', ${auditInfo['C24'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C24', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C24', ${auditInfo['C24'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">暂不考核　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C25</td>
					<td align="center" valign="middle" width="40%">办公桌设备开孔穿线不合理或线路整理不规范，显零乱，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c25" value="${pd.c25}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c25sm" class="form-control"  value="${pd.c25sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C25')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C25')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C25'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C25', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C25'].status == 1 || auditInfo['C25'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C25', ${auditInfo['C25'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C25', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C25', ${auditInfo['C25'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C26</td>
					<td align="center" valign="middle" width="40%">办公桌设备电源线标签不全，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c26"  value="${pd.c26}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c26sm" class="form-control" value="${pd.c26sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C26')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C26')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C26'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C26', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C26'].status == 1 || auditInfo['C26'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C26', ${auditInfo['C26'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C26', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C26', ${auditInfo['C26'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C27</td>
					<td align="center" valign="middle" width="40%">零管设备与监控设备未整合摆放入机柜内，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c27" value="${pd.c27}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c27sm" class="form-control" value="${pd.c27sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C27')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C27')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C27'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C27', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C27'].status == 1 || auditInfo['C27'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C27', ${auditInfo['C27'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C27', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C27', ${auditInfo['C27'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　键盘、鼠标、显示器共用</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C28</td>
					<td align="center" valign="middle" width="40%">机柜内设备线路整理不规范，显零乱，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="c28" value="${pd.c28}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c28sm" class="form-control"  value="${pd.c28sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C28')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C28')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C28'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C28', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C28'].status == 1 || auditInfo['C28'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C28', ${auditInfo['C28'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C28', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C28', ${auditInfo['C28'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C29</td>
					<td align="center" valign="middle" width="40%">机柜内显示器、键盘、鼠标无定位标识，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c29"  value="${pd.c29}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c29sm" class="form-control" value="${pd.c29sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C29')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C29')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C29'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C29', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C29'].status == 1 || auditInfo['C29'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C29', ${auditInfo['C29'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C29', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C29', ${auditInfo['C29'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">C30</td>
					<td align="center" valign="middle" width="40%">机柜内网线标签、电源线标签、设备标签不全，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c30" value="${pd.c30}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c30sm" class="form-control" value="${pd.c30sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C30')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C30')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C30'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C30', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C30'].status == 1 || auditInfo['C30'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C30', ${auditInfo['C30'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C30', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C30', ${auditInfo['C30'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">C31</td>
					<td align="center" valign="middle" width="40%">机柜底部未铺设绝缘垫，或边沿未张贴安全警示线，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="c31" value="${pd.c31}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="c31sm" class="form-control"  value="${pd.c31sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'C31')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'C31')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['C31'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C31', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['C31'].status == 1 || auditInfo['C31'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'C31', ${auditInfo['C31'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'C31', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'C31', ${auditInfo['C31'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

			</table>


		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b>D.收银区 </b></font></td>
		</tr>
		<tr class="text-center">
			<td valign="top">　</td>
			<td><table   class="table table-bordered" border="1" width="1000">
				<tr class="text-center">
					<td width="10%" align="left" valign="top">序号</td>
					<td align="left" valign="top" width="40%">考核内容</td>
					<td width="16%" align="left" valign="top">扣分或加分</td>
					<td align="left" width="21%" valign="top">扣分或加分说明</td>
					<td align="left" width="13%" valign="top">考核说明</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">D01</td>
					<td align="center" valign="middle" width="40%">桌面设备、糖果架、桌贴广告、签字笔、资料架、公告牌、提示牌、购物袋等设置不合理，显零乱的，每处扣1分（3分封顶）</td>
					<td align="left" valign="top"><input type="text" size=10 name="d01" value="${pd.d01}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d01sm" class="form-control"  value="${pd.d01sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D01')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D01')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D01'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D01', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D01'].status == 1 || auditInfo['D01'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D01', ${auditInfo['D01'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D01', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D01', ${auditInfo['D01'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">提出优化建议　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D02</td>
					<td align="center" valign="middle" width="40%">收银设备不全，如无小票打印机、无收银钱箱等，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d02"  value="${pd.d02}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d02sm" class="form-control" value="${pd.d02sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D02')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D02')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D02'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D02', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D02'].status == 1 || auditInfo['D02'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D02', ${auditInfo['D02'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D02', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D02', ${auditInfo['D02'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　台面下不能放置收银钱箱的可用抽屉，尽量不取消</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D03</td>
					<td align="center" valign="middle" width="40%">收银区未设置打印、复印一体机，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d03" value="${pd.d03}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d03sm" class="form-control" value="${pd.d03sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D03')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D03')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D03'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D03', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D03'].status == 1 || auditInfo['D03'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D03', ${auditInfo['D03'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D03', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D03', ${auditInfo['D03'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">D04</td>
					<td align="center" valign="middle" width="40%">收银POS机客显被遮挡，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="d04" value="${pd.d04}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d04sm" class="form-control"  value="${pd.d04sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D04')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D04')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D04'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D04', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D04'].status == 1 || auditInfo['D04'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D04', ${auditInfo['D04'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D04', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D04', ${auditInfo['D04'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D05</td>
					<td align="center" valign="middle" width="40%">两个银行卡密码键盘放置在一起（不易识别），扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d05"  value="${pd.d05}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d05sm" class="form-control" value="${pd.d05sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D05')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D05')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D05'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D05', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D05'].status == 1 || auditInfo['D05'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D05', ${auditInfo['D05'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D05', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D05', ${auditInfo['D05'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D06</td>
					<td align="center" valign="middle" width="40%">宣传资料散放，资料架规格不符，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="d06" value="${pd.d06}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d06sm" class="form-control" value="${pd.d06sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D06')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D06')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D06'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D06', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D06'].status == 1 || auditInfo['D06'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D06', ${auditInfo['D06'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D06', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D06', ${auditInfo['D06'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">D07</td>
					<td align="center" valign="middle" width="40%">收银区摆放垃圾桶，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d07" value="${pd.d07}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d07sm" class="form-control"  value="${pd.d07sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D07')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D07')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D07'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D07', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D07'].status == 1 || auditInfo['D07'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D07', ${auditInfo['D07'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D07', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D07', ${auditInfo['D07'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D08</td>
					<td align="center" valign="middle" width="40%">收银区抽屉、柜门未粘贴分类标识牌，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d08"  value="${pd.d08}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d08sm" class="form-control" value="${pd.d08sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D08')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D08')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D08'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D08', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D08'].status == 1 || auditInfo['D08'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D08', ${auditInfo['D08'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D08', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D08', ${auditInfo['D08'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　提出优化建议（保险柜、非油商品、收银钱箱不粘贴？）</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D09</td>
					<td align="center" valign="middle" width="40%">收银区抽屉、柜内物品与分类标识牌不符，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d09" value="${pd.d09}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d09sm" class="form-control" value="${pd.d09sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D09')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D09')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D09'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D09', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D09'].status == 1 || auditInfo['D09'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D09', ${auditInfo['D09'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D09', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D09', ${auditInfo['D09'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">D10</td>
					<td align="center" valign="middle" width="40%">收银区抽屉、柜内物品未分类整齐摆放，每处扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d10" value="${pd.d10}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d10sm" class="form-control"  value="${pd.d10sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D10')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D10')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D10'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D10', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D10'].status == 1 || auditInfo['D10'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D10', ${auditInfo['D10'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D10', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D10', ${auditInfo['D10'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">需细化描述　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D11</td>
					<td align="center" valign="middle" width="40%">文件盒、文件夹无标签或制作不规范，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d11"  value="${pd.d11}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d11sm" class="form-control" value="${pd.d11sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D11')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D11')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D11'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D11', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D11'].status == 1 || auditInfo['D11'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D11', ${auditInfo['D11'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D11', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D11', ${auditInfo['D11'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">文件夹标签可用A4纸长边制作　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D12</td>
					<td align="center" valign="middle" width="40%">收银区台面台柜的物品定位标识不全，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d12" value="${pd.d12}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d12sm" class="form-control" value="${pd.d12sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D12')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D12')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D12'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D12', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D12'].status == 1 || auditInfo['D12'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D12', ${auditInfo['D12'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D12', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D12', ${auditInfo['D12'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">D13</td>
					<td align="center" valign="middle" width="40%">收银台背柜摆放非油商品以外的物品，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d13" value="${pd.d13}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d13sm" class="form-control"  value="${pd.d13sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D13')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D13')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D13'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D13', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D13'].status == 1 || auditInfo['D13'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D13', ${auditInfo['D13'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D13', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D13', ${auditInfo['D13'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　有必要设置的设备除外</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D14</td>
					<td align="center" valign="middle" width="40%">自助服务终端机线路未整理、零乱，或未设置规范的操作说明，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="d14"  value="${pd.d14}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d14sm" class="form-control" value="${pd.d14sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D14')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D14')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D14'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D14', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D14'].status == 1 || auditInfo['D14'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D14', ${auditInfo['D14'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D14', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D14', ${auditInfo['D14'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D15</td>
					<td align="center" valign="middle" width="40%">收银台台面设备开孔穿线不合理或线路整理不规范，显零乱，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d15" value="${pd.d15}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d15sm" class="form-control" value="${pd.d15sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D15')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D15')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D15'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D15', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D15'].status == 1 || auditInfo['D15'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D15', ${auditInfo['D15'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D15', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D15', ${auditInfo['D15'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">D16</td>
					<td align="center" valign="middle" width="40%">收银台下方可视线路未进入线槽，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d16" value="${pd.d16}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d16sm" class="form-control"  value="${pd.d16sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D16')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D16')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D16'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D16', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D16'].status == 1 || auditInfo['D16'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D16', ${auditInfo['D16'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D16', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D16', ${auditInfo['D16'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D17</td>
					<td align="center" valign="middle" width="40%">收银台下电源板后方线路未整理，显零乱，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d17"  value="${pd.d17}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d17sm" class="form-control" value="${pd.d17sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D17')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D17')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D17'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D17', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D17'].status == 1 || auditInfo['D17'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D17', ${auditInfo['D17'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D17', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D17', ${auditInfo['D17'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D18</td>
					<td align="center" valign="middle" width="40%">收银台下方电源面板背面未加装保护盖，扣2分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d18" value="${pd.d18}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d18sm" class="form-control" value="${pd.d18sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D18')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D18')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D18'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D18', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D18'].status == 1 || auditInfo['D18'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D18', ${auditInfo['D18'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D18', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D18', ${auditInfo['D18'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">D19</td>
					<td align="center" valign="middle" width="40%">放置主机的柜门未设置百叶窗通风口，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d19" value="${pd.d19}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d19sm" class="form-control"  value="${pd.d19sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D19')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D19')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D19'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D19', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D19'].status == 1 || auditInfo['D19'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D19', ${auditInfo['D19'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D19', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D19', ${auditInfo['D19'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">D20</td>
					<td align="center" valign="middle" width="40%">收银台下方面板处网线标签、电源线标签不全，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="d20"  value="${pd.d20}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="d20sm" class="form-control" value="${pd.d20sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'D20')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'D20')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['D20'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D20', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['D20'].status == 1 || auditInfo['D20'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'D20', ${auditInfo['D20'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'D20', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'D20', ${auditInfo['D20'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
			</table>

		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b>E.非油业务 </b></font></td>
		</tr>
		<tr class="text-center">
			<td valign="top">　</td>
			<td><table   class="table table-bordered" border="1" width="1000">
				<tr class="text-center">
					<td width="10%" align="left" valign="top">序号</td>
					<td align="left" valign="top" width="40%">考核内容</td>
					<td width="16%" align="left" valign="top">扣分或加分</td>
					<td align="left" width="21%" valign="top">扣分或加分说明</td>
					<td align="left" width="13%" valign="top">考核说明</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">E01</td>
					<td align="center" valign="middle" width="40%">加油站营业期间，便利店内的照明设备未按要求开启，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e01" value="${pd.e01}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e01sm" class="form-control"  value="${pd.e01sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E01')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E01')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E01'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E01', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E01'].status == 1 || auditInfo['E01'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E01', ${auditInfo['E01'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E01', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E01', ${auditInfo['E01'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">广告灯箱光源须全时段开启；8点至17点59分，光线充足的站，吊顶灯须开启50%以上；18点至第二天7点59分，吊顶灯须全部开启；有报修记录的除外　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E02</td>
					<td align="center" valign="middle" width="40%">便利店商品价签不规范的扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e02"  value="${pd.e02}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e02sm" class="form-control" value="${pd.e02sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E02')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E02')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E02'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E02', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E02'].status == 1 || auditInfo['E02'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E02', ${auditInfo['E02'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E02', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E02', ${auditInfo['E02'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">在顾客能够触及到地方，所放置的商品均应用于销售，为此，必须要明码标价（有价签或POP/爆炸卡均可），且价签须靠左陈列。　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E03</td>
					<td align="center" valign="middle" width="40%">便利店商品未正面向外的扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e03" value="${pd.e03}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e03sm" class="form-control" value="${pd.e03sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E03')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E03')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E03'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E03', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E03'].status == 1 || auditInfo['E03'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E03', ${auditInfo['E03'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E03', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E03', ${auditInfo['E03'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　商品的正面应面向顾客。</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">E04</td>
					<td align="center" valign="middle" width="40%">便利店商品与上层隔板间距过大或过小扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e04" value="${pd.e04}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e04sm" class="form-control"  value="${pd.e04sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E04')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E04')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E04'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E04', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E04'].status == 1 || auditInfo['E04'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E04', ${auditInfo['E04'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E04', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E04', ${auditInfo['E04'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">为保证商品的丰满和量感陈列，以及易于顾客取拿的原则，加油站应主动调整货架层板与商品的间距，保持不少于二指的高度和不多于三到四指的高度。</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E05</td>
					<td align="center" valign="middle" width="40%">货架陈列过期商品，扣5分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e05"  value="${pd.e05}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e05sm" class="form-control" value="${pd.e05sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E05')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E05')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E05'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E05', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E05'].status == 1 || auditInfo['E05'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E05', ${auditInfo['E05'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E05', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E05', ${auditInfo['E05'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E06</td>
					<td align="center" valign="middle" width="40%">商品严重缺货，扣3分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e06" value="${pd.e06}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e06sm" class="form-control" value="${pd.e06sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E06')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E06')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E06'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E06', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E06'].status == 1 || auditInfo['E06'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E06', ${auditInfo['E06'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E06', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E06', ${auditInfo['E06'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">普通货架每90公分货架长度，缺货超过30公分，视为严重缺货。回型货架单个层板缺货超过一半，视为严重缺货。　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">E07</td>
					<td align="center" valign="middle" width="40%">食品类非油商品直接放置地面，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e07" value="${pd.e07}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e07sm" class="form-control"  value="${pd.e07sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E07')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E07')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E07'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E07', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E07'].status == 1 || auditInfo['E07'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E07', ${auditInfo['E07'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E07', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E07', ${auditInfo['E07'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E08</td>
					<td align="center" valign="middle" width="40%">室内堆头陈列不规范，靠墙堆头首层未割箱陈列等，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e08"  value="${pd.e08}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e08sm" class="form-control" value="${pd.e08sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E08')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E08')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E08'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E08', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E08'].status == 1 || auditInfo['E08'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E08', ${auditInfo['E08'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E08', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E08', ${auditInfo['E08'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">室内堆头原则上总高度不超过0.8米，如有特殊陈列须向公司报备，有报备手续的除外。靠壁堆头首层须割箱陈列。</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E09</td>
					<td align="center" valign="middle" width="40%">便利店门口两侧地堆过高，遮挡玻窗，托盘不统一、摆放不整齐，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e09" value="${pd.e09}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e09sm" class="form-control" value="${pd.e09sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E09')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E09')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E09'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E09', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E09'].status == 1 || auditInfo['E09'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E09', ${auditInfo['E09'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E09', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E09', ${auditInfo['E09'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">原则不得遮挡橱窗玻璃，地堆高度0.8米为宜，高于1米的视为过高。</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">E10</td>
					<td align="center" valign="middle" width="40%">岛上堆头围挡不整洁，商品摆放不整齐，无相应的价签或pop、爆炸卡宣传标识，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e10" value="${pd.e10}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e10sm" class="form-control"  value="${pd.e10sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E10')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E10')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E10'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E10', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E10'].status == 1 || auditInfo['E10'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E10', ${auditInfo['E10'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E10', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E10', ${auditInfo['E10'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">针对岛上有堆头加油站进行考核　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E11</td>
					<td align="center" valign="middle" width="40%">快餐区柜内物品摆放不整齐，扣1分（询问是否有快餐区，再评判，若没有不扣分，备注在扣分说明那栏）</td>
					<td align="left" valign="top"><input type="text" size=10 name="e11"  value="${pd.e11}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e11sm" class="form-control" value="${pd.e11sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E11')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E11')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E11'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E11', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E11'].status == 1 || auditInfo['E11'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E11', ${auditInfo['E11'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E11', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E11', ${auditInfo['E11'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">针对有快餐区的加油站　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E12</td>
					<td align="center" valign="middle" width="40%">便利店内摆放与非油业务无关的物品（集中存放的员工手机、水杯除外），扣2分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e12" value="${pd.e12}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e12sm" class="form-control" value="${pd.e12sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E12')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E12')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E12'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E12', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E12'].status == 1 || auditInfo['E12'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E12', ${auditInfo['E12'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E12', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E12', ${auditInfo['E12'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　标准店及高级店纳入考核，顾客目视可及的地方均纳入考核范围，可放置促销赠品</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">E13</td>
					<td align="center" valign="middle" width="40%">店内购物篮、购物车未定置摆放，或无地面标线，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="e13" value="${pd.e13}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e13sm" class="form-control"  value="${pd.e13sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E13')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E13')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E13'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E13', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E13'].status == 1 || auditInfo['E13'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E13', ${auditInfo['E13'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E13', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E13', ${auditInfo['E13'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　针对有购物篮、购物车的加油站</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E14</td>
					<td align="center" valign="middle" width="40%">库房乱堆乱放未分区存储的，扣1分（询问库房位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="e14"  value="${pd.e14}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e14sm" class="form-control" value="${pd.e14sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E14')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E14')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E14'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E14', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E14'].status == 1 || auditInfo['E14'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E14', ${auditInfo['E14'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E14', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E14', ${auditInfo['E14'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E15</td>
					<td align="center" valign="middle" width="40%">库房食品类货品直接放置于地面的，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e15" value="${pd.e15}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e15sm" class="form-control" value="${pd.e15sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E15')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E15')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E15'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E15', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E15'].status == 1 || auditInfo['E15'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E15', ${auditInfo['E15'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E15', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E15', ${auditInfo['E15'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">E16</td>
					<td align="center" valign="middle" width="40%">库房未制作分区牌，且分区牌所指区域与实际分区不符的，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e16" value="${pd.e16}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e16sm" class="form-control"  value="${pd.e16sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E16')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E16')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E16'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E16', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E16'].status == 1 || auditInfo['E16'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E16', ${auditInfo['E16'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E16', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E16', ${auditInfo['E16'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E17</td>
					<td align="center" valign="middle" width="40%">库房货品下方无磁性拔码器标识牌，扣1分（询问是否有磁性拔码器，此题需要了解是否适用，若不适用询问比如：拨码器，在用吗？如果不合理是谁来规定的一定要使用，如果改成其他方式是不是有更好的建议，出于什么考虑？写在扣分说明那栏备注）</td>
					<td align="left" valign="top"><input type="text" size=10 name="e17"  value="${pd.e17}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e17sm" class="form-control" value="${pd.e17sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E17')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E17')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E17'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E17', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E17'].status == 1 || auditInfo['E17'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E17', ${auditInfo['E17'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E17', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E17', ${auditInfo['E17'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">磁性拨码器是用来方便库房计算进出货数量品种、盘库用的　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E18</td>
					<td align="center" valign="middle" width="40%">库房货品磁性拔码器标识牌信息不全，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e18" value="${pd.e18}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e18sm" class="form-control" value="${pd.e18sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E18')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E18')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E18'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E18', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E18'].status == 1 || auditInfo['E18'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E18', ${auditInfo['E18'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E18', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E18', ${auditInfo['E18'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">E19</td>
					<td align="center" valign="middle" width="40%">开展快餐业务的，熟食类商品无熟食管控表，粘贴不规范，扣1分（询问是否有快餐业务，再评判，若没有不扣分，备注在扣分说明那栏）</td>
					<td align="left" valign="top"><input type="text" size=10 name="e19" value="${pd.e19}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e19sm" class="form-control"  value="${pd.e19sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E19')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E19')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E19'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E19', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E19'].status == 1 || auditInfo['E19'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E19', ${auditInfo['E19'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E19', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E19', ${auditInfo['E19'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">针对开展快餐业务的加油站，应在熟食类商品存储区域张贴管控表　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E20</td>
					<td align="center" valign="middle" width="40%">库房未设置过期/损坏商品区、退/换商品区、非入库赠品区（有此类赠品须设置），每项扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="e20"  value="${pd.e20}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e20sm" class="form-control" value="${pd.e20sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E20')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E20')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E20'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E20', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E20'].status == 1 || auditInfo['E20'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E20', ${auditInfo['E20'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E20', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E20', ${auditInfo['E20'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">非入库赠品指非卖品赠品。　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E21</td>
					<td align="center" valign="middle" width="40%">库房过期/损坏商品区、退/换商品区、非入库赠品区（有此类赠品须设置），未用相应颜色区分，且未设置对应管控表，每项扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e21" value="${pd.e21}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e21sm" class="form-control" value="${pd.e21sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E21')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E21')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E21'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E21', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E21'].status == 1 || auditInfo['E21'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E21', ${auditInfo['E21'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E21', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E21', ${auditInfo['E21'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">E22</td>
					<td align="center" valign="middle" width="40%">放置库房的促销物料散乱、无“促销物料暂存区”标识，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="e22" value="${pd.e22}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e22sm" class="form-control"  value="${pd.e22sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E22')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E22')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E22'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E22', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E22'].status == 1 || auditInfo['E22'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E22', ${auditInfo['E22'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E22', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E22', ${auditInfo['E22'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E23</td>
					<td align="center" valign="middle" width="40%">未使用或过期的促销物料，任意堆放在加油现场，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e23"  value="${pd.e23}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e23sm" class="form-control" value="${pd.e23sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E23')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E23')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E23'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E23', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E23'].status == 1 || auditInfo['E23'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E23', ${auditInfo['E23'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E23', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E23', ${auditInfo['E23'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E24</td>
					<td align="center" valign="middle" width="40%">未设置非油商品现场卸货区的，扣1分（询问是否有卸油区，此题需要了解是否适用，若不使用询问比如：卸货区，合理吗，在用吗？如果不合理是谁来规定的一定放在这里，如果改在其他地方是不是有更好的建议，出于什么考虑？写在扣分说明那栏备注）</td>
					<td align="left" valign="top"><input type="text" size=10 name="e24" value="${pd.e24}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e24sm" class="form-control" value="${pd.e24sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E24')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E24')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E24'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E24', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E24'].status == 1 || auditInfo['E24'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E24', ${auditInfo['E24'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E24', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E24', ${auditInfo['E24'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">E25</td>
					<td align="center" valign="middle" width="40%">放置开水壶的台面、咖啡机、开水机未粘贴“当心高温”安全标识，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e25" value="${pd.e25}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e25sm" class="form-control"  value="${pd.e25sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E25')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E25')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E25'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E25', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E25'].status == 1 || auditInfo['E25'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E25', ${auditInfo['E25'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E25', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E25', ${auditInfo['E25'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E26</td>
					<td align="center" valign="middle" width="40%">便利店吧台台面物品摆放零乱，或无定位标识，或无地面标线，或无座椅，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="e26"  value="${pd.e26}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e26sm" class="form-control" value="${pd.e26sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E26')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E26')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E26'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E26', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E26'].status == 1 || auditInfo['E26'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E26', ${auditInfo['E26'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E26', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E26', ${auditInfo['E26'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">E27</td>
					<td align="center" valign="middle" width="40%">便民工具箱未放置在便利店内，未粘贴定位标识，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="e27" value="${pd.e27}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="e27sm" class="form-control" value="${pd.e27sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'E27')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'E27')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['E27'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E27', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['E27'].status == 1 || auditInfo['E27'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'E27', ${auditInfo['E27'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'E27', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'E27', ${auditInfo['E27'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">无便利店的放置在办公室适当位置</td>
				</tr>
			</table>


		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b>F.生活区（员工餐厅，厨房，宿舍，活动室，卫生间） </b></font></td>
		</tr>
		<tr class="text-center">
			<td valign="top">　</td>
			<td><table   class="table table-bordered" border="1" width="1000">
				<tr class="text-center">
					<td width="10%" align="left" valign="top">序号</td>
					<td align="left" valign="top" width="40%">考核内容</td>
					<td width="16%" align="left" valign="top">扣分或加分</td>
					<td align="left" width="21%" valign="top">扣分或加分说明</td>
					<td align="left" width="13%" valign="top">考核说明</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">F01</td>
					<td align="center" valign="middle" width="40%">餐厅餐椅未使用时未归位，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f01" value="${pd.f01}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f01sm" class="form-control"  value="${pd.f01sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F01')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F01')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F01'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F01', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F01'].status == 1 || auditInfo['F01'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F01', ${auditInfo['F01'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F01', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F01', ${auditInfo['F01'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F02</td>
					<td align="center" valign="middle" width="40%">消毒柜未按要求粘贴物品摆放示意图，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f02"  value="${pd.f02}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f02sm" class="form-control" value="${pd.f02sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F02')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F02')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F02'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F02', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F02'].status == 1 || auditInfo['F02'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F02', ${auditInfo['F02'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F02', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F02', ${auditInfo['F02'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F03</td>
					<td align="center" valign="middle" width="40%">厨房操作台台面物品摆放不整齐，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f03" value="${pd.f03}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f03sm" class="form-control" value="${pd.f03sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F03')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F03')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F03'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F03', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F03'].status == 1 || auditInfo['F03'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F03', ${auditInfo['F03'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F03', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F03', ${auditInfo['F03'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　不要求粘贴定位标识标线</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">F04</td>
					<td align="center" valign="middle" width="40%">调味瓶、调料盒无相应标签，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f04" value="${pd.f04}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f04sm" class="form-control"  value="${pd.f04sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F04')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F04')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F04'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F04', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F04'].status == 1 || auditInfo['F04'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F04', ${auditInfo['F04'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F04', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F04', ${auditInfo['F04'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F05</td>
					<td align="center" valign="middle" width="40%">生食、熟食用砧板未按要求分开使用，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f05"  value="${pd.f05}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f05sm" class="form-control" value="${pd.f05sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F05')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F05')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F05'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F05', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F05'].status == 1 || auditInfo['F05'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F05', ${auditInfo['F05'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F05', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F05', ${auditInfo['F05'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F06</td>
					<td align="center" valign="middle" width="40%">橱柜柜门、收纳盒未粘贴相应的分类标牌标签，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f06" value="${pd.f06}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f06sm" class="form-control" value="${pd.f06sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F06')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F06')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F06'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F06', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F06'].status == 1 || auditInfo['F06'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F06', ${auditInfo['F06'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F06', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F06', ${auditInfo['F06'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">F07</td>
					<td align="center" valign="middle" width="40%">橱柜柜内盒内摆放物品零乱或与分类标识不符，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f07" value="${pd.f07}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f07sm" class="form-control"  value="${pd.f07sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F07')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F07')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F07'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F07', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F07'].status == 1 || auditInfo['F07'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F07', ${auditInfo['F07'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F07', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F07', ${auditInfo['F07'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F08</td>
					<td align="center" valign="middle" width="40%">用餐后未及时清洗碗筷，餐后未及时清倒垃圾，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f08"  value="${pd.f08}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f08sm" class="form-control" value="${pd.f08sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F08')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F08')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F08'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F08', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F08'].status == 1 || auditInfo['F08'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F08', ${auditInfo['F08'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F08', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F08', ${auditInfo['F08'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F09</td>
					<td align="center" valign="middle" width="40%">厨师用劳保用品、保洁用品未按要求集中放置，或未粘贴相应标识牌，扣１分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="f09" value="${pd.f09}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f09sm" class="form-control" value="${pd.f09sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F09')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F09')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F09'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F09', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F09'].status == 1 || auditInfo['F09'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F09', ${auditInfo['F09'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F09', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F09', ${auditInfo['F09'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">F10</td>
					<td align="center" valign="middle" width="40%">生活区扫把、撮箕、垃圾桶未摆放在固定位置，或未粘贴物品定位图标、定位标线，扣1分（询问该物品放置位置，再评判）</td>
					<td align="left" valign="top"><input type="text" size=10 name="f10" value="${pd.f10}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f10sm" class="form-control"  value="${pd.f10sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F10')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F10')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F10'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F10', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F10'].status == 1 || auditInfo['F10'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F10', ${auditInfo['F10'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F10', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F10', ${auditInfo['F10'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F11</td>
					<td align="center" valign="middle" width="40%">橱柜、冰箱、消毒柜内部不清洁，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f11"  value="${pd.f11}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f11sm" class="form-control" value="${pd.f11sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F11')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F11')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F11'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F11', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F11'].status == 1 || auditInfo['F11'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F11', ${auditInfo['F11'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F11', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F11', ${auditInfo['F11'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F12</td>
					<td align="center" valign="middle" width="40%">换气扇、抽油烟机油污重，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f12" value="${pd.f12}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f12sm" class="form-control" value="${pd.f12sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F12')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F12')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F12'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F12', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F12'].status == 1 || auditInfo['F12'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F12', ${auditInfo['F12'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F12', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F12', ${auditInfo['F12'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">F13</td>
					<td align="center" valign="middle" width="40%">拖把挂放处未粘贴清洁用具分类标牌，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f13" value="${pd.f13}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f13sm" class="form-control"  value="${pd.f13sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F13')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F13')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F13'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F13', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F13'].status == 1 || auditInfo['F13'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F13', ${auditInfo['F13'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F13', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F13', ${auditInfo['F13'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F14</td>
					<td align="center" valign="middle" width="40%">拖把未用颜色区分或颜色不符，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f14"  value="${pd.f14}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f14sm" class="form-control" value="${pd.f14sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F14')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F14')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F14'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F14', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F14'].status == 1 || auditInfo['F14'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F14', ${auditInfo['F14'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F14', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F14', ${auditInfo['F14'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F15</td>
					<td align="center" valign="middle" width="40%">员工衣柜、鞋柜配置超标，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f15" value="${pd.f15}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f15sm" class="form-control" value="${pd.f15sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F15')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F15')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F15'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F15', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F15'].status == 1 || auditInfo['F15'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F15', ${auditInfo['F15'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F15', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F15', ${auditInfo['F15'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　暂不考核</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">F16</td>
					<td align="center" valign="middle" width="40%">床位空置，被子叠放不整齐，床上用品不统一，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f16" value="${pd.f16}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f16sm" class="form-control"  value="${pd.f16sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F16')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F16')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F16'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F16', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F16'].status == 1 || auditInfo['F16'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F16', ${auditInfo['F16'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F16', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F16', ${auditInfo['F16'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　参照细节管理手册</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F17</td>
					<td align="center" valign="middle" width="40%">员工柜内、抽屉内物品摆放不规范，显零乱，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f17"  value="${pd.f17}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f17sm" class="form-control" value="${pd.f17sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F17')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F17')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F17'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F17', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F17'].status == 1 || auditInfo['F17'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F17', ${auditInfo['F17'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F17', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F17', ${auditInfo['F17'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">随机抽查两名现场当班员工的员工柜　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F18</td>
					<td align="center" valign="middle" width="40%">鞋柜内放置的鞋摆放不整齐，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f18" value="${pd.f18}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f18sm" class="form-control" value="${pd.f18sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F18')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F18')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F18'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F18', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F18'].status == 1 || auditInfo['F18'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F18', ${auditInfo['F18'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F18', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F18', ${auditInfo['F18'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">F19</td>
					<td align="center" valign="middle" width="40%">员工衣柜、鞋柜、毛巾架、毛巾、面盆的员工编号不全，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f19" value="${pd.f19}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f19sm" class="form-control"  value="${pd.f19sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F19')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F19')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F19'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F19', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F19'].status == 1 || auditInfo['F19'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F19', ${auditInfo['F19'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F19', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F19', ${auditInfo['F19'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F20</td>
					<td align="center" valign="middle" width="40%">寝室内椅子未使用时未归位，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f20"  value="${pd.f20}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f20sm" class="form-control" value="${pd.f20sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F20')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F20')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F20'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F20', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F20'].status == 1 || auditInfo['F20'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F20', ${auditInfo['F20'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F20', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F20', ${auditInfo['F20'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F21</td>
					<td align="center" valign="middle" width="40%">桌面物品、面盆架、垃圾桶未粘贴定位标识，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f21" value="${pd.f21}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f21sm" class="form-control" value="${pd.f21sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F21')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F21')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F21'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F21', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F21'].status == 1 || auditInfo['F21'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F21', ${auditInfo['F21'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F21', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F21', ${auditInfo['F21'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">F22</td>
					<td align="center" valign="middle" width="40%">淋浴间喷淋水龙头正上方未粘贴冷热水管标识，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f22" value="${pd.f22}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f22sm" class="form-control"  value="${pd.f22sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F22')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F22')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F22'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F22', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F22'].status == 1 || auditInfo['F22'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F22', ${auditInfo['F22'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F22', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F22', ${auditInfo['F22'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">F23</td>
					<td align="center" valign="middle" width="40%">房间内物品整体摆放不整齐，每个房间扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="f23"  value="${pd.f23}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="f23sm" class="form-control" value="${pd.f23sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'F23')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'F23')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['F23'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F23', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['F23'].status == 1 || auditInfo['F23'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'F23', ${auditInfo['F23'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'F23', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'F23', ${auditInfo['F23'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　主要针对未明确考核标准的区域</td>
				</tr>
			</table>


		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b>G.卫生间 </b></font></td>
		</tr>
		<tr class="text-center">
			<td valign="top">　</td>
			<td><table   class="table table-bordered" border="1" width="1000">
				<tr class="text-center">
					<td width="10%" align="left" valign="top">序号</td>
					<td align="left" valign="top" width="40%">考核内容</td>
					<td width="16%" align="left" valign="top">扣分或加分</td>
					<td align="left" width="21%" valign="top">扣分或加分说明</td>
					<td align="left" width="13%" valign="top">考核说明</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">G01</td>
					<td align="center" valign="middle" width="40%">未按要求设置卫生间指示牌，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g01" value="${pd.g01}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g01sm" class="form-control"  value="${pd.g01sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G01')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G01')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G01'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G01', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G01'].status == 1 || auditInfo['G01'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G01', ${auditInfo['G01'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G01', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G01', ${auditInfo['G01'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　90度指示牌仅用于厕所不醒目的站</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G02</td>
					<td align="center" valign="middle" width="40%">未按要求粘贴“推”“拉”“禁止吸烟”“请节约用纸”标识牌，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g02"  value="${pd.g02}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g02sm" class="form-control" value="${pd.g02sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G02')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G02')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G02'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G02', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G02'].status == 1 || auditInfo['G02'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G02', ${auditInfo['G02'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G02', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G02', ${auditInfo['G02'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G03</td>
					<td align="center" valign="middle" width="40%">提示牌不全（5种提示牌：请节约用水，保持环境清洁作为可爱的人，向前一小步文明一大步，感谢您保持这里的卫生，随手冲一冲干净又卫生），扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g03" value="${pd.g03}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g03sm" class="form-control" value="${pd.g03sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G03')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G03')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G03'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G03', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G03'].status == 1 || auditInfo['G03'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G03', ${auditInfo['G03'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G03', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G03', ${auditInfo['G03'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　五种提示牌</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">G04</td>
					<td align="center" valign="middle" width="40%">无巡查牌（是用来记录巡查卫生间时间段的记录表），扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g04" value="${pd.g04}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g04sm" class="form-control"  value="${pd.g04sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G04')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G04')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G04'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G04', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G04'].status == 1 || auditInfo['G04'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G04', ${auditInfo['G04'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G04', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G04', ${auditInfo['G04'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G05</td>
					<td align="center" valign="middle" width="40%">巡查记录提前或延迟记录，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g05"  value="${pd.g05}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g05sm" class="form-control" value="${pd.g05sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G05')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G05')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G05'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G05', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G05'].status == 1 || auditInfo['G05'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G05', ${auditInfo['G05'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G05', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G05', ${auditInfo['G05'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G06</td>
					<td align="center" valign="middle" width="40%">自助加油站未配置洗手液或安装不规范，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g06" value="${pd.g06}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g06sm" class="form-control" value="${pd.g06sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G06')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G06')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G06'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G06', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G06'].status == 1 || auditInfo['G06'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G06', ${auditInfo['G06'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G06', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G06', ${auditInfo['G06'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">暂不考核　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">G07</td>
					<td align="center" valign="middle" width="40%">盥洗间未设置不锈钢垃圾桶，扣2分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g07" value="${pd.g07}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g07sm" class="form-control"  value="${pd.g07sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G07')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G07')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G07'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G07', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G07'].status == 1 || auditInfo['G07'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G07', ${auditInfo['G07'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G07', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G07', ${auditInfo['G07'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">直径约30cm为宜，分公司内统一型号</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G08</td>
					<td align="center" valign="middle" width="40%">盥洗间不锈钢垃圾桶未粘贴限高线、或无定位标识，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g08"  value="${pd.g08}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g08sm" class="form-control" value="${pd.g08sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G08')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G08')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G08'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G08', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G08'].status == 1 || auditInfo['G08'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G08', ${auditInfo['G08'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G08', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G08', ${auditInfo['G08'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G09</td>
					<td align="center" valign="middle" width="40%">无A字形告示牌或未清洁厕所时未摆放在洗手台下方左侧，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g09" value="${pd.g09}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g09sm" class="form-control" value="${pd.g09sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G09')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G09')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G09'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G09', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G09'].status == 1 || auditInfo['G09'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G09', ${auditInfo['G09'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G09', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G09', ${auditInfo['G09'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">G10</td>
					<td align="center" valign="middle" width="40%">小便池未放置防溅垫、除臭丸（樟脑球），扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g10" value="${pd.g10}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g10sm" class="form-control"  value="${pd.g10sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G10')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G10')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G10'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G10', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G10'].status == 1 || auditInfo['G10'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G10', ${auditInfo['G10'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G10', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G10', ${auditInfo['G10'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G11</td>
					<td align="center" valign="middle" width="40%">蹲位前台阶未粘贴“当心台阶”安全标识或粘贴不全，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g11"  value="${pd.g11}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g11sm" class="form-control" value="${pd.g11sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G11')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G11')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G11'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G11', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G11'].status == 1 || auditInfo['G11'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G11', ${auditInfo['G11'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G11', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G11', ${auditInfo['G11'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G12</td>
					<td align="center" valign="middle" width="40%">蹲位隔板上未安装衣帽钩，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g12" value="${pd.g12}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g12sm" class="form-control" value="${pd.g12sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G12')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G12')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G12'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G12', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G12'].status == 1 || auditInfo['G12'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G12', ${auditInfo['G12'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G12', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G12', ${auditInfo['G12'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top"></td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">G13</td>
					<td align="center" valign="middle" width="40%">厕所蹲位设置物品放置盒（架）的，未粘贴“请带好随身物品”标识，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g13" value="${pd.g13}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g13sm" class="form-control"  value="${pd.g13sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G13')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G13')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G13'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G13', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G13'].status == 1 || auditInfo['G13'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G13', ${auditInfo['G13'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G13', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G13', ${auditInfo['G13'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G14</td>
					<td align="center" valign="middle" width="40%">蹲位无垃圾篓，或摆放位置不一致，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g14"  value="${pd.g14}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g14sm" class="form-control" value="${pd.g14sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G14')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G14')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G14'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G14', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G14'].status == 1 || auditInfo['G14'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G14', ${auditInfo['G14'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G14', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G14', ${auditInfo['G14'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G15</td>
					<td align="center" valign="middle" width="40%">洁厕刷（马桶刷）未按要求放置，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g15" value="${pd.g15}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g15sm" class="form-control" value="${pd.g15sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G15')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G15')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G15'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G15', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G15'].status == 1 || auditInfo['G15'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G15', ${auditInfo['G15'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G15', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G15', ${auditInfo['G15'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">G16</td>
					<td align="center" valign="middle" width="40%">洗手台排水管零乱，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g16" value="${pd.g16}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g16sm" class="form-control"  value="${pd.g16sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G16')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G16')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G16'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G16', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G16'].status == 1 || auditInfo['G16'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G16', ${auditInfo['G16'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G16', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G16', ${auditInfo['G16'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　重点检查可视部分</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G17</td>
					<td align="center" valign="middle" width="40%">卫生间上锁或封闭，特殊情况未张贴告示告知开放时间，扣2分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g17"  value="${pd.g17}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g17sm" class="form-control" value="${pd.g17sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G17')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G17')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G17'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G17', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G17'].status == 1 || auditInfo['G17'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G17', ${auditInfo['G17'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G17', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G17', ${auditInfo['G17'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G18</td>
					<td align="center" valign="middle" width="40%">设施不完好，扣1分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g18" value="${pd.g18}"	 >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g18sm" class="form-control" value="${pd.g18sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G18')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G18')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G18'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G18', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G18'].status == 1 || auditInfo['G18'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G18', ${auditInfo['G18'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G18', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G18', ${auditInfo['G18'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">G19</td>
					<td align="center" valign="middle" width="40%">有异味、有污垢，扣2分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g19" value="${pd.g19}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g19sm" class="form-control"  value="${pd.g19sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G19')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G19')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G19'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G19', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G19'].status == 1 || auditInfo['G19'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G19', ${auditInfo['G19'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G19', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G19', ${auditInfo['G19'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>

				<tr class="text-center">
					<td width="10%" align="left" valign="top">G20</td>
					<td align="center" valign="middle" width="40%">有积水、有积尘、有蛛网，扣2分</td>
					<td align="left" valign="top"><input type="text" size=10 name="g20"  value="${pd.g20}">
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="g20sm" class="form-control" value="${pd.g20sm}">　</td>
					&lt;%&ndash;代码生成器生成 开始&ndash;%&gt;
					<c:if test="${pd.ID != null}"><td>
						<a class="btn btn-small btn-success" onclick="addImage('${pd.ID}', 'G20')">上传图片</a>
						<a class="btn btn-small btn-info" onclick="imageDeal('${pd.ID}', 'G20')">查看图片</a></td>
						<td>
							<c:choose>
								<c:when test="${auditInfo['G20'] == null}">
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G20', '')">申诉</a>
								</c:when>
								<c:when test="${auditInfo['G20'].status == 1 || auditInfo['G20'].status == 3}">
									<a class="btn btn-small btn-danger" onclick="audit('${pd.ID}', 'G20', ${auditInfo['G20'].id})">申诉回复</a>
								</c:when>
								<c:otherwise>
									<a class="btn btn-small btn-purple" onclick="audit('${pd.ID}', 'G20', '')">再次申诉</a>
									<a class="btn btn-small btn-warning" onclick="audit('${pd.ID}', 'G20', ${auditInfo['G20'].id})">查看申诉</a>
								</c:otherwise>
							</c:choose>
						</td>
					</c:if>
					&lt;%&ndash;代码生成器生成 结束&ndash;%&gt;
					<td align="left" valign="top">　</td>
				</tr>--%>
			</table>


<%--		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b>H.加分项 </b></font></td>
		</tr>
		<tr class="text-center">
			<td valign="top">　</td>
			<td><table   class="table table-bordered" border="1" width="1000">
				<tr class="text-center">
					<td width="10%" align="left" valign="top">序号</td>
					<td align="left" valign="top" width="40%">考核内容</td>
					<td width="16%" align="left" valign="top">加分</td>
					<td align="left" width="21%" valign="top">加分说明</td>
					<td align="left" width="13%" valign="top">考核说明</td>
				</tr>
				<tr class="text-center">
					<td width="10%" align="left" valign="top">H01</td>
					<td align="center" valign="middle" width="40%">加油站率先提出具有复制、推广价值的小创新，在当月（当月未考评的在下次）量化考评时加5分</td>
					<td align="left" valign="top"><input type="text" size=10 name="h01" value="${pd.h01}" >
					</td>
					<td align="left" valign="top"><input type="text" size=30 name="h01sm" class="form-control"  value="${pd.h01sm}">　</td>
					<td align="left" valign="top">　90度指示牌仅用于厕所不醒目的站</td>
				</tr>

			</table>--%>


		<tr>
			<td valign="top">　</td>
			<td>
				<font size="4"><b>I.员工建议 </b></font></td>
		</tr>
		<tr class="text-center">
			<td valign="top">　</td>
			<td><table   class="table table-bordered" border="1" width="1000">

				<tr class="text-center">
					<td width="10%" align="left" valign="top">员工建议（本站那些做的好，不好的有没有合理的想法，的）：</td>
					<td colspan="4" align="center" valign="middle">
						<textarea name="i01"  cols="60" rows="12" style="width:900px; height:150px">${pd.i01}</textarea>
					</td>
				</tr>

			</table>
		<div class="row">
			<div class="col-md-4">
				<button type="submit"  class="btn btn-sm btn-primary icon-check">提交</button>
			</div>
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

		});

        function addImage(id, projectName){
            debugger;
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag=true;
            diag.Title ="新增图片";
            diag.URL = '<%=basePath%>adIssue/goImageAdd.do?id=' + id + '&projectName=' + projectName;
            diag.Width = 600;
            diag.Height = 500;
            diag.CancelEvent = function(){ //关闭事件
                diag.close();
            };
            diag.show();
        }

        function imageDeal(id, projectName){
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag=true;
            diag.Title ="查看图片";
            diag.URL = '<%=basePath%>adIssue/getImageDeal.do?id=' + id + '&projectName=' + projectName;
            diag.Width = 600;
            diag.Height = 500;
            diag.CancelEvent = function(){ //关闭事件
                diag.close();
            };
            diag.show();
        }

        function audit(scpcid, projectName, id){
            debugger;
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag=true;
            diag.Title ="查看图片";
            diag.URL = '<%=basePath%>adIssue/auditAdd.do?scpcid=' + scpcid + '&projectName=' + projectName + "&id=" + id;
            diag.Width = 600;
            diag.Height = 500;
            diag.CancelEvent = function(){ //关闭事件
				debugger;
                diag.close();
                window.location.reload();
            };
            diag.show();
        }

		</script>





</body>
</html>