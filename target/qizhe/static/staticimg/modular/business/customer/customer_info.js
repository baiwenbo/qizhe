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
		alert('很抱歉！没有下载链接！');
		return false;
	}
	
	var substr = '.pdf';
	
	if (url.indexOf(substr) < 0){
		alert('很抱歉！无效的链接！');
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


