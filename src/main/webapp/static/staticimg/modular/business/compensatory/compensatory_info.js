$(function () {	
	$("#contractType option[value='"+contractTypeId+"']").attr("selected","selected");
	$("#cycle option[value='"+cycle+"']").attr("selected","selected");
	$("#relationships option[value='"+relationshipId+"']").attr("selected","selected");
	$("#relationshipsTwo option[value='"+relationshipTwoId+"']").attr("selected","selected");
	$("#relationshipsThree option[value='"+relationshipThreeId+"']").attr("selected","selected");
	$("#rightName option[value='"+rightName+"']").attr("selected","selected");
});


//===========禁用按钮============
$('input').prop('disabled',true)
$('textarea').prop('disabled',true)
$('select').prop('disabled',true)
$('[type="submit"]').prop('disabled',true)
setTimeout(function(){
	$('.kv-file-remove').hide()
	$('.kv-file-zoom').prop('disabled',false)
	$('#myModal textarea').prop('disabled',false)
},1000)


function download(url,orderNo){
	if (url == null || url == ''){
		Feng.alert('很抱歉！没有下载链接！');
		return false;
	}
	
	var substr = '.pdf';
	
	if (url.indexOf(substr) < 0){
        Feng.alert('很抱歉！无效的链接！');
		return false;
	}
	
	window.location.href = "pdf/download.do?urlPdf="+url+'&orderNo='+orderNo;
 }
function show(reportUrl){
	window.open(reportUrl);
}

 		
localStorage.clear() //清除图片数组缓存

//中文化
$.datepicker.regional['zh-CN'] = {
clearText: '清除',
clearStatus: '清除已选日期',
closeText: '关闭',
closeStatus: '不改变当前选择',
prevText: '<上月',
prevStatus: '显示上月',
prevBigText: '<<',
prevBigStatus: '显示上一年',
nextText: '下月>',
nextStatus: '显示下月',
nextBigText: '>>',
nextBigStatus: '显示下一年',
currentText: '今天',
currentStatus: '显示本月',
monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
monthNamesShort: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
monthStatus: '选择月份',
yearStatus: '选择年份',
weekHeader: '周',
weekStatus: '年内周次',
dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
dayNamesShort: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
dayNamesMin: ['日', '一', '二', '三', '四', '五', '六'],
dayStatus: '设置 DD 为一周起始',
dateStatus: '选择 m月 d日, DD',
dateFormat: 'yy-mm-dd',
firstDay: 1,
initStatus: '请选择日期',
isRTL: false
};
$.datepicker.setDefaults($.datepicker.regional['zh-CN']);

//选择时间
$(".starttime").datepicker({
showOtherMonths: true,
selectOtherMonths: false,
changeMonth: true,
changeYear: true,
onClose: function (selectedDate) {
$(".endtime").datepicker("option", "minDate", selectedDate);
}
});
$(".endtime").datepicker({
showOtherMonths: true,
selectOtherMonths: false,
changeMonth: true,
changeYear: true,
numberOfMonths: 1,
onClose: function (selectedDate) {
$(".starttime").datepicker("option", "maxDate", selectedDate);
}
});
$("#starttime").datepicker({
showOtherMonths: true,
selectOtherMonths: false,
changeMonth: true,
changeYear: true,
onClose: function (selectedDate) {
$("#endtime").datepicker("option", "minDate", selectedDate);
}
});
$("#endtime").datepicker({
showOtherMonths: true,
selectOtherMonths: false,
changeMonth: true,
changeYear: true,
numberOfMonths: 1,
onClose: function (selectedDate) {
$("#starttime").datepicker("option", "maxDate", selectedDate);
}
});




//评估-是否违章——是否显示
$('#radio-rule label').click(function(){
var rad=$('#radio-rule').find(':checked').val()
if (rad == 1) {
$('#display1,#display2').removeClass('hide')
} 
else {
$('#display1,#display2').addClass('hide')
}
})


/*
*产品编辑数据插入
*======================================================
*/

 $.when( 		
 		$.getJSON('/customer/findEvaluationPictures?orderId='+orderId,function (data) {
			 	console.log('findEvaluationPictures::'+Feng.ctxPath)
				 vehiclePictureUrlArray = $.map(data.vehiclePictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				 vehiclePictureUrlArray2 = $.map(data.picName, function (val,key) {
						return  {caption:val}
				});
				// JSON.stringify(vehiclePictureUrlArray2)
				carLicensePictureUrlArray = $.map(data.carLicensePictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				carLicensePictureUrlArray2 = $.map(data.carLicensePictureUrl, function (val,key) {
					return  {url:val}
				});				

	})
	 
 ).then(function(){

		//车辆图片
		var upload51=[]
		$('#upload51').fileinput({
			language: 'zh', //设置语言
			uploadUrl: '${ctxPath}pictures/save?imgurl=vehiclePictureUrl', //上传的地址
			allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
			showUpload: true, //是否显示上传按钮
			showCaption: true,//是否显示标题
			browseClass: "btn btn-primary", //按钮样式
			maxFileSize: 5000,//单位为kb，如果为0表示不限制文件大小
			maxFileCount: 10, //表示允许同时上传的最大文件个数
			validateInitialCount:true,
			msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
			overwriteInitial: false,
			initialPreview: vehiclePictureUrlArray,
			initialPreviewConfig: vehiclePictureUrlArray2 ,		
		}).on("fileuploaded", function (event, data, previewId, index) {
				var json= data.response
				JSON.stringify(json)
				upload51.push(json.url)
				localStorage.setItem('vehiclePictureUrl', upload51)
		}).on("filepredelete", function(jqXHR) {
			var abort = true;
			if (confirm("确定删除图片?")) {
				abort = false;
			}
			return abort;  
		});
		
		//车证图片
		var upload52=[]
		$('#upload52').fileinput({
			language: 'zh', //设置语言
			uploadUrl: '${ctxPath}pictures/save?imgurl=carLicensePictureUrl', //上传的地址
			allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
			showUpload: true, //是否显示上传按钮
			showCaption: true,//是否显示标题
			browseClass: "btn btn-primary", //按钮样式
			maxFileSize: 5000,//单位为kb，如果为0表示不限制文件大小
			maxFileCount: 10, //表示允许同时上传的最大文件个数
			validateInitialCount:true,
			msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
			overwriteInitial: false,
			initialPreview: carLicensePictureUrlArray,
			initialPreviewConfig: carLicensePictureUrlArray2 ,		
		}).on("fileuploaded", function (event, data, previewId, index) {
				var json= data.response
				JSON.stringify(json)
				upload52.push(json.url)
				localStorage.setItem('carLicensePictureUrl', upload52)
		}).on("filepredelete", function(jqXHR) {
			var abort = true;
			if (confirm("确定删除图片?")) {
				abort = false;
			}
			return abort;  
		});

 })
$.when( 
 		$.getJSON('/customer/findCustomerPictures?orderId='+orderId,function (data) {	
 			 console.log('findCustomerPictures::'+Feng.ctxPath)
			customerid=data.customer.id
				//upload80
				customerPictureUrlArray = $.map(data.customer.customerPictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				customerPictureUrlArray2 = $.map(data.customer.customerPictureUrl, function (val,key) {
					return  {url:val}
				});	
			    //upload81
				identityCardPictureUrlArray = $.map(data.customer.identityCardPictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				identityCardPictureUrlArray2 = $.map(data.customer.identityCardPictureUrl, function (val,key) {
					return  {url:val}
				});
			    //upload82
				applicationPictureUrlArray = $.map(data.customer.applicationPictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				applicationPictureUrlArray2 = $.map(data.customer.applicationPictureUrl, function (val,key) {
					return  {url:val}
				});
			    //upload83
				registrationPictureUrlArray = $.map(data.customer.registrationPictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				registrationPictureUrlArray2 = $.map(data.customer.registrationPictureUrl, function (val,key) {
					return  {url:val}
				});
			    //upload84
				drivingLicensePictureUrlArray = $.map(data.customer.drivingLicensePictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				drivingLicensePictureUrlArray2 = $.map(data.customer.drivingLicensePictureUrl, function (val,key) {
					return  {url:val}
				});
			    //upload85
				vehiclePolicyPictureUrlArray = $.map(data.customer.vehiclePolicyPictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				vehiclePolicyPictureUrlArray2 = $.map(data.customer.vehiclePolicyPictureUrl, function (val,key) {
					return  {url:val}
				});
			    //upload86
				creditInquiryPictureUrlArray = $.map(data.customer.creditInquiryPictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				creditInquiryPictureUrlArray2 = $.map(data.customer.creditInquiryPictureUrl, function (val,key) {
					return  {url:val}
				});
			    //upload87
				workCertificatePictureUrlArray = $.map(data.customer.workCertificatePictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				workCertificatePictureUrlArray2 = $.map(data.customer.workCertificatePictureUrl, function (val,key) {
					return  {url:val}
				});
			    //upload88
				otherInformationPictureUrlArray = $.map(data.customer.otherInformationPictureUrl, function (val,key) {
					return  '<img  src='+val+' data-img='+val+'>'
				});
				otherInformationPictureUrlArray2 = $.map(data.customer.otherInformationPictureUrl, function (val,key) {
					return  {url:val}
				});
		 	
	})

 ).then(function(){
			
				//customerPictureUrl   客户照片
				var upload80=[]
				$('#upload80').fileinput({
					theme: "explorer",
					language: 'zh', //设置语言
					uploadUrl: '${ctxPath}pictures/save?imgurl=customerPictureUrl', //上传的地址
					allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
					showUpload: true, //是否显示上传按钮
					showCaption: true,//是否显示标题
					browseClass: "btn btn-primary", //按钮样式
					maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
					maxFileCount: 10, //表示允许同时上传的最大文件个数
					validateInitialCount:true,
					overwriteInitial: false,
					layoutTemplates: {
						actionUpload: '',    //设置为空可去掉上传按钮
						// actionDelete:''  //设置为空可去掉删除按钮
					},				
					initialPreview: customerPictureUrlArray,
					initialPreviewConfig: customerPictureUrlArray2 ,
				}).on("fileuploaded", function (event, data, previewId, index) {
						var json= data.response
						JSON.stringify(json)
						upload80.push(json.url)
						localStorage.setItem('customerPictureUrl', upload80)
						$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
				}).on("filepredelete", function(jqXHR) {
					var abort = true;
					if (confirm("确定删除图片?")) {
						abort = false;
					}
					return abort;  
				});	  


				//identityCardPictureUrl   身份证图片或暂住证图片
				var upload81=[]
				$('#upload81').fileinput({
					theme: "explorer",
					language: 'zh', //设置语言
					uploadUrl: '${ctxPath}pictures/save?imgurl=identityCardPictureUrl', //上传的地址
					allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
					showUpload: true, //是否显示上传按钮
					showCaption: true,//是否显示标题
					browseClass: "btn btn-primary", //按钮样式
					maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
					maxFileCount: 10, //表示允许同时上传的最大文件个数
					validateInitialCount:true,
					overwriteInitial: false,
					layoutTemplates: {
						actionUpload: '',    //设置为空可去掉上传按钮
						// actionDelete:''  //设置为空可去掉删除按钮
					},				
					initialPreview: identityCardPictureUrlArray,
					initialPreviewConfig: identityCardPictureUrlArray2 ,
				}).on("fileuploaded", function (event, data, previewId, index) {
						var json= data.response
						JSON.stringify(json)
						upload81.push(json.url)
						localStorage.setItem('identityCardPictureUrl', upload81)
						$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
				}).on("filepredelete", function(jqXHR) {
					var abort = true;
					if (confirm("确定删除图片?")) {
						abort = false;
					}
					return abort;  
				});	  
					//applicationPictureUrl    申请表图片
				var upload82=[]
				$('#upload82').fileinput({
					theme: "explorer",
					language: 'zh', //设置语言
					uploadUrl: '${ctxPath}pictures/save?imgurl=applicationPictureUrl', //上传的地址
					allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
					showUpload: true, //是否显示上传按钮
					showCaption: true,//是否显示标题
					browseClass: "btn btn-primary", //按钮样式
					maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
					maxFileCount: 10, //表示允许同时上传的最大文件个数
					validateInitialCount:true,
					overwriteInitial: false,
					layoutTemplates: {
						actionUpload: '',    //设置为空可去掉上传按钮
						// actionDelete:''  //设置为空可去掉删除按钮
					},				
					initialPreview: applicationPictureUrlArray,
					initialPreviewConfig: applicationPictureUrlArray2 ,
				}).on("fileuploaded", function (event, data, previewId, index) {
						var json= data.response
						JSON.stringify(json)
						upload82.push(json.url)
						localStorage.setItem('applicationPictureUrl', upload82)
						$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
				}).on("filepredelete", function(jqXHR) {
					var abort = true;
					if (confirm("确定删除图片?")) {
						abort = false;
					}
					return abort;  
				});	  
					//registrationPictureUrl   登记证图片
				var upload83=[]
				$('#upload83').fileinput({
					theme: "explorer",
					language: 'zh', //设置语言
					uploadUrl: '${ctxPath}pictures/save?imgurl=registrationPictureUrl', //上传的地址
					allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
					showUpload: true, //是否显示上传按钮
					showCaption: true,//是否显示标题
					browseClass: "btn btn-primary", //按钮样式
					maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
					maxFileCount: 10, //表示允许同时上传的最大文件个数
					validateInitialCount:true,
					overwriteInitial: false,
					layoutTemplates: {
						actionUpload: '',    //设置为空可去掉上传按钮
						// actionDelete:''  //设置为空可去掉删除按钮
					},				
					initialPreview: registrationPictureUrlArray,
					initialPreviewConfig: registrationPictureUrlArray2 ,
				}).on("fileuploaded", function (event, data, previewId, index) {
						var json= data.response
						JSON.stringify(json)
						upload83.push(json.url)
						localStorage.setItem('registrationPictureUrl', upload83)
						$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
				}).on("filepredelete", function(jqXHR) {
					var abort = true;
					if (confirm("确定删除图片?")) {
						abort = false;
					}
					return abort;  
				});	  
					//drivingLicensePictureUrl 行驶证图片
				var upload84=[]
				$('#upload84').fileinput({
					theme: "explorer",
					language: 'zh', //设置语言
					uploadUrl: '${ctxPath}pictures/save?imgurl=drivingLicensePictureUrl', //上传的地址
					allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
					showUpload: true, //是否显示上传按钮
					showCaption: true,//是否显示标题
					browseClass: "btn btn-primary", //按钮样式
					maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
					maxFileCount: 10, //表示允许同时上传的最大文件个数
					validateInitialCount:true,
					overwriteInitial: false,
					layoutTemplates: {
						actionUpload: '',    //设置为空可去掉上传按钮
						// actionDelete:''  //设置为空可去掉删除按钮
					},				
					initialPreview: drivingLicensePictureUrlArray,
					initialPreviewConfig: drivingLicensePictureUrlArray2 ,
				}).on("fileuploaded", function (event, data, previewId, index) {
						var json= data.response
						JSON.stringify(json)
						upload84.push(json.url)
						localStorage.setItem('drivingLicensePictureUrl', upload84)
						$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
				}).on("filepredelete", function(jqXHR) {
					var abort = true;
					if (confirm("确定删除图片?")) {
						abort = false;
					}
					return abort;  
				});	  
					//vehiclePolicyPictureUrl  车辆保单图片
				var upload85=[]
				$('#upload85').fileinput({
					theme: "explorer",
					language: 'zh', //设置语言
					uploadUrl: '${ctxPath}pictures/save?imgurl=vehiclePolicyPictureUrl', //上传的地址
					allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
					showUpload: true, //是否显示上传按钮
					showCaption: true,//是否显示标题
					browseClass: "btn btn-primary", //按钮样式
					maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
					maxFileCount: 10, //表示允许同时上传的最大文件个数
					validateInitialCount:true,
					overwriteInitial: false,
					layoutTemplates: {
						actionUpload: '',    //设置为空可去掉上传按钮
						// actionDelete:''  //设置为空可去掉删除按钮
					},				
					initialPreview: vehiclePolicyPictureUrlArray,
					initialPreviewConfig: vehiclePolicyPictureUrlArray2 ,
				}).on("fileuploaded", function (event, data, previewId, index) {
						var json= data.response
						JSON.stringify(json)
						upload85.push(json.url)
						localStorage.setItem('vehiclePolicyPictureUrl', upload85)
						$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
				}).on("filepredelete", function(jqXHR) {
					var abort = true;
					if (confirm("确定删除图片?")) {
						abort = false;
					}
					return abort;  
				});	  
					//creditInquiryPictureUrl  征信查询相关图片
				var upload86=[]
				$('#upload86').fileinput({
					theme: "explorer",
					language: 'zh', //设置语言
					uploadUrl: '${ctxPath}pictures/save?imgurl=creditInquiryPictureUrl', //上传的地址
					allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
					showUpload: true, //是否显示上传按钮
					showCaption: true,//是否显示标题
					browseClass: "btn btn-primary", //按钮样式
					maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
					maxFileCount: 10, //表示允许同时上传的最大文件个数
					validateInitialCount:true,
					overwriteInitial: false,
					layoutTemplates: {
						actionUpload: '',    //设置为空可去掉上传按钮
						// actionDelete:''  //设置为空可去掉删除按钮
					},				
					initialPreview: creditInquiryPictureUrlArray,
					initialPreviewConfig: creditInquiryPictureUrlArray2 ,
				}).on("fileuploaded", function (event, data, previewId, index) {
						var json= data.response
						JSON.stringify(json)
						upload86.push(json.url)
						localStorage.setItem('creditInquiryPictureUrl', upload86)
						$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
				}).on("filepredelete", function(jqXHR) {
					var abort = true;
					if (confirm("确定删除图片?")) {
						abort = false;
					}
					return abort;  
				});	  
					//workCertificatePictureUrl  工作证明相关图片
				var upload87=[]
				$('#upload87').fileinput({
					theme: "explorer",
					language: 'zh', //设置语言
					uploadUrl: '${ctxPath}pictures/save?imgurl=workCertificatePictureUrl', //上传的地址
					allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
					showUpload: true, //是否显示上传按钮
					showCaption: true,//是否显示标题
					browseClass: "btn btn-primary", //按钮样式
					maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
					maxFileCount: 10, //表示允许同时上传的最大文件个数
					validateInitialCount:true,
					overwriteInitial: false,
					layoutTemplates: {
						actionUpload: '',    //设置为空可去掉上传按钮
						// actionDelete:''  //设置为空可去掉删除按钮
					},				
					initialPreview: workCertificatePictureUrlArray,
					initialPreviewConfig: workCertificatePictureUrlArray2 ,
				}).on("fileuploaded", function (event, data, previewId, index) {
						var json= data.response
						JSON.stringify(json)
						upload87.push(json.url)
						localStorage.setItem('workCertificatePictureUrl', upload87)
						$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
				}).on("filepredelete", function(jqXHR) {
					var abort = true;
					if (confirm("确定删除图片?")) {
						abort = false;
					}
					return abort;  
				});	  
					//otherInformationPictureUrl  其他资料图片
				var upload88=[]
				$('#upload88').fileinput({
					theme: "explorer",
					language: 'zh', //设置语言
					uploadUrl: '${ctxPath}pictures/save?imgurl=otherInformationPictureUrl', //上传的地址
					allowedFileExtensions: ['jpg','jpeg', 'gif', 'png'],//接收的文件后缀
					showUpload: true, //是否显示上传按钮
					showCaption: true,//是否显示标题
					browseClass: "btn btn-primary", //按钮样式
					maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
					maxFileCount: 10, //表示允许同时上传的最大文件个数
					validateInitialCount:true,
					overwriteInitial: false,
					layoutTemplates: {
						actionUpload: '',    //设置为空可去掉上传按钮
						// actionDelete:''  //设置为空可去掉删除按钮
					},				
					initialPreview: otherInformationPictureUrlArray,
					initialPreviewConfig: otherInformationPictureUrlArray2 ,
				}).on("fileuploaded", function (event, data, previewId, index) {
						var json= data.response
						JSON.stringify(json)
						upload88.push(json.url)
						localStorage.setItem('otherInformationPictureUrl', upload88)
						$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
				}).on("filepredelete", function(jqXHR) {
					var abort = true;
					if (confirm("确定删除图片?")) {
						abort = false;
					}
					return abort;  
				});	  
})





	
 $.when( 
		 $.getJSON('/customer/findContractPictures?orderId='+orderId,function (data) {
			// console.log(JSON.stringify(data, null, 4)) 
			contractid=data.contract.id

			  //upload40
		    contractPictureUrlArray = $.map(data.contract.contractPictureUrl, function (val,key) {
				if  ( val.indexOf("pdf") > -1 ){
					return  '<embed  src='+val+' data-img='+val+'>'
				}
				else {
					return  '<img  src='+val+' data-img='+val+'>'
				}
			});
		   contractPictureUrlArray2 = $.map(data.contract.contractPictureUrl, function (val,key) {
				return  {url:val}
			});
			 
			//upload41
			creditPictureUrlArray = $.map(data.contract.creditPictureUrl, function (val,key) {
				if  ( val.indexOf("pdf") > -1 ){
					return  '<embed  src='+val+' data-img='+val+'>'
				}
				else {
					return  '<img  src='+val+' data-img='+val+'>'
				}
			});
			creditPictureUrlArray2 = $.map(data.contract.creditPictureUrl, function (val,key) {
				return  {url:val}
			});
		  //upload42
			gpsPictureUrlArray = $.map(data.contract.gpsPictureUrl, function (val,key) {
				if  ( val.indexOf("pdf") > -1 ){
					return  '<embed  src='+val+' data-img='+val+'>'
				}
				else {
					return  '<img  src='+val+' data-img='+val+'>'
				}
			});
			gpsPictureUrlArray2 = $.map(data.contract.gpsPictureUrl, function (val,key) {
				return  {url:val}
			});
		  //upload43
			carKeysPictureUrlArray = $.map(data.contract.carKeysPictureUrl, function (val,key) {
				if  ( val.indexOf("pdf") > -1 ){
					return  '<embed  src='+val+' data-img='+val+'>'
				}
				else {
					return  '<img  src='+val+' data-img='+val+'>'
				}
			});
			carKeysPictureUrlArray2 = $.map(data.contract.carKeysPictureUrl, function (val,key) {
				return  {url:val}
			});
		  //upload44
			mortgagePictureUrlArray = $.map(data.contract.mortgagePictureUrl, function (val,key) {
				if  ( val.indexOf("pdf") > -1 ){
					return  '<embed  src='+val+' data-img='+val+'>'
				}
				else {
					return  '<img  src='+val+' data-img='+val+'>'
				}
			});
			mortgagePictureUrlArray2 = $.map(data.contract.mortgagePictureUrl, function (val,key) {
				return  {url:val}
			});
		  //upload45
		  visaInterviewPictureUrlArray = $.map(data.contract.visaInterviewPictureUrl, function (val,key) {
				if  ( val.indexOf("pdf") > -1 ){
					return  '<embed  src='+val+' data-img='+val+'>'
				}
				else {
					return  '<img  src='+val+' data-img='+val+'>'
				}
			});
			visaInterviewPictureUrlArray2 = $.map(data.contract.visaInterviewPictureUrl, function (val,key) {
				return  {url:val}
			});
		  //upload46
			spLoanStreamPictureUrlArray = $.map(data.contract.spLoanStreamPictureUrl, function (val,key) {
				if  ( val.indexOf("pdf") > -1 ){
					return  '<embed  src='+val+' data-img='+val+'>'
				}
				else {
					return  '<img  src='+val+' data-img='+val+'>'
				}
			});
			spLoanStreamPictureUrlArray2 = $.map(data.contract.spLoanStreamPictureUrl, function (val,key) {
				return  {url:val}
			})
	})
 ).then(function(){
		//合同照片
		var upload40=[]
		$('#upload40').fileinput({
			theme: "explorer",
			language: 'zh', //设置语言
			uploadUrl: '${ctxPath}pictures/save?imgurl=contractPictureUrl', //上传的地址
			allowedFileExtensions: ['jpg','jpeg', 'gif', 'png','pdf'],//接收的文件后缀
			showUpload: true, //是否显示上传按钮
			showCaption: true,//是否显示标题
			maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
			maxFileCount: 10, //表示允许同时上传的最大文件个数
			validateInitialCount:true,
			overwriteInitial: false,
			layoutTemplates: {
				actionUpload: '',    //设置为空可去掉上传按钮
				// actionDelete:''  //设置为空可去掉删除按钮
			},						
			initialPreview: contractPictureUrlArray,
			initialPreviewConfig: contractPictureUrlArray2 ,
		}).on("fileuploaded", function (event, data, previewId, index) {
				var json= data.response
				JSON.stringify(json)
				upload40.push(json.url)
				localStorage.setItem('contractPictureUrl', upload40)
				$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
		}).on("filepredelete", function(jqXHR) {
			var abort = true;
			if (confirm("确定删除图片?")) {
				abort = false;
			}
			return abort;  
		});
			//征信照片
		var upload41=[]
		$('#upload41').fileinput({
			theme: "explorer",
			language: 'zh', //设置语言
			uploadUrl: '${ctxPath}pictures/save?imgurl=creditPictureUrl', //上传的地址
			allowedFileExtensions: ['jpg','jpeg', 'gif', 'png','pdf'],//接收的文件后缀
			showUpload: true, //是否显示上传按钮
			showCaption: true,//是否显示标题
			maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
			maxFileCount: 10, //表示允许同时上传的最大文件个数
			validateInitialCount:true,
			overwriteInitial: false,
			layoutTemplates: {
				actionUpload: '',    //设置为空可去掉上传按钮
				// actionDelete:''  //设置为空可去掉删除按钮
			},						
			initialPreview: creditPictureUrlArray,
			initialPreviewConfig: creditPictureUrlArray2 ,
		}).on("fileuploaded", function (event, data, previewId, index) {
				var json= data.response
				JSON.stringify(json)
				upload41.push(json.url)
				localStorage.setItem('creditPictureUrl', upload41)
				$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
		}).on("filepredelete", function(jqXHR) {
			var abort = true;
			if (confirm("确定删除图片?")) {
				abort = false;
			}
			return abort;  
		});
		//gps图片
		var upload42=[]
		$('#upload42').fileinput({
			theme: "explorer",
			language: 'zh', //设置语言
			uploadUrl: '${ctxPath}pictures/save?imgurl=gpsPictureUrl', //上传的地址
			allowedFileExtensions: ['jpg','jpeg', 'gif', 'png','pdf'],//接收的文件后缀
			showUpload: true, //是否显示上传按钮
			showCaption: true,//是否显示标题
			maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
			maxFileCount: 10, //表示允许同时上传的最大文件个数
			validateInitialCount:true,
			overwriteInitial: false,
			layoutTemplates: {
				actionUpload: '',    //设置为空可去掉上传按钮
				// actionDelete:''  //设置为空可去掉删除按钮
			},						
			initialPreview: gpsPictureUrlArray,
			initialPreviewConfig: gpsPictureUrlArray2 ,
		}).on("fileuploaded", function (event, data, previewId, index) {
				var json= data.response
				JSON.stringify(json)
				upload42.push(json.url)
				localStorage.setItem('gpsPictureUrl', upload42)
				$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
		}).on("filepredelete", function(jqXHR) {
			var abort = true;
			if (confirm("确定删除图片?")) {
				abort = false;
			}
			return abort;  
		});
		//车钥匙图片
		var upload43=[]
		$('#upload43').fileinput({
			theme: "explorer",
			language: 'zh', //设置语言
			uploadUrl: '${ctxPath}pictures/save?imgurl=carKeysPictureUrl', //上传的地址
			allowedFileExtensions: ['jpg','jpeg', 'gif', 'png','pdf'],//接收的文件后缀
			showUpload: true, //是否显示上传按钮
			showCaption: true,//是否显示标题
			maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
			maxFileCount: 10, //表示允许同时上传的最大文件个数
			validateInitialCount:true,
			overwriteInitial: false,
			layoutTemplates: {
				actionUpload: '',    //设置为空可去掉上传按钮
				// actionDelete:''  //设置为空可去掉删除按钮
			},						
			initialPreview: carKeysPictureUrlArray,
			initialPreviewConfig: carKeysPictureUrlArray2 ,
		}).on("fileuploaded", function (event, data, previewId, index) {
				var json= data.response
				JSON.stringify(json)
				upload43.push(json.url)
				localStorage.setItem('carKeysPictureUrl', upload43)
				$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
		}).on("filepredelete", function(jqXHR) {
			var abort = true;
			if (confirm("确定删除图片?")) {
				abort = false;
			}
			return abort;  
		});
		//抵押权图片
		var upload44=[]
		$('#upload44').fileinput({
			theme: "explorer",
			language: 'zh', //设置语言
			uploadUrl: '${ctxPath}pictures/save?imgurl=mortgagePictureUrl', //上传的地址
			allowedFileExtensions: ['jpg','jpeg', 'gif', 'png','pdf'],//接收的文件后缀
			showUpload: true, //是否显示上传按钮
			showCaption: true,//是否显示标题
			maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
			maxFileCount: 10, //表示允许同时上传的最大文件个数
			validateInitialCount:true,
			overwriteInitial: false,
			layoutTemplates: {
				actionUpload: '',    //设置为空可去掉上传按钮
				// actionDelete:''  //设置为空可去掉删除按钮
			},						
			initialPreview: mortgagePictureUrlArray,
			initialPreviewConfig: mortgagePictureUrlArray2 ,
		}).on("fileuploaded", function (event, data, previewId, index) {
				var json= data.response
				JSON.stringify(json)
				upload44.push(json.url)
				localStorage.setItem('mortgagePictureUrl', upload44)
				$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
		}).on("filepredelete", function(jqXHR) {
			var abort = true;
			if (confirm("确定删除图片?")) {
				abort = false;
			}
			return abort;  
		});
		//面签照图片
		var upload45=[]
		$('#upload45').fileinput({
			theme: "explorer",
			language: 'zh', //设置语言
			uploadUrl: '${ctxPath}pictures/save?imgurl=visaInterviewPictureUrl', //上传的地址
			allowedFileExtensions: ['jpg','jpeg', 'gif', 'png','pdf'],//接收的文件后缀
			showUpload: true, //是否显示上传按钮
			showCaption: true,//是否显示标题
			maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
			maxFileCount: 10, //表示允许同时上传的最大文件个数
			validateInitialCount:true,
			overwriteInitial: false,
			layoutTemplates: {
				actionUpload: '',    //设置为空可去掉上传按钮
				// actionDelete:''  //设置为空可去掉删除按钮
			},						
			initialPreview: visaInterviewPictureUrlArray,
			initialPreviewConfig: visaInterviewPictureUrlArray2 ,
		}).on("fileuploaded", function (event, data, previewId, index) {
				var json= data.response
				JSON.stringify(json)
				upload45.push(json.url)
				localStorage.setItem('visaInterviewPictureUrl', upload45)
				$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
		}).on("filepredelete", function(jqXHR) {
			var abort = true;
			if (confirm("确定删除图片?")) {
				abort = false;
			}
			return abort;  
		});
		//放款流水图片
		var upload46=[]
		$('#upload46').fileinput({
			theme: "explorer",
			language: 'zh', //设置语言
			uploadUrl: '${ctxPath}pictures/save?imgurl=spLoanStreamPictureUrl', //上传的地址
			allowedFileExtensions: ['jpg','jpeg', 'gif', 'png','pdf'],//接收的文件后缀
			showUpload: true, //是否显示上传按钮
			showCaption: true,//是否显示标题
			maxFileSize: 10000,//单位为kb，如果为0表示不限制文件大小
			maxFileCount: 10, //表示允许同时上传的最大文件个数
			validateInitialCount:true,
			overwriteInitial: false,
			layoutTemplates: {
				actionUpload: '',    //设置为空可去掉上传按钮
				// actionDelete:''  //设置为空可去掉删除按钮
			},						
			initialPreview: spLoanStreamPictureUrlArray,
			initialPreviewConfig: spLoanStreamPictureUrlArray2 ,
		}).on("fileuploaded", function (event, data, previewId, index) {
				var json= data.response
				JSON.stringify(json)
				upload46.push(json.url)
				localStorage.setItem('spLoanStreamPictureUrl', upload46)
				$(this).closest('.file-input').find('.file-preview-success .kv-file-remove').hide()
		}).on("filepredelete", function(jqXHR) {
			var abort = true;
			if (confirm("确定删除图片?")) {
				abort = false;
			}
			return abort;  
		});

 })
 
 
 	
	function download(urlPdf,orderNo) {
	    window.location.href='/compensatoryQuery/download?urlPdf='+urlPdf+"&orderNo="+orderNo
	}
