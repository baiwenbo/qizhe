/**
 * 角色管理的单例
 */
var Compensatory = {
    id: "compensatoryTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
Compensatory.initColumn = function () {
    var columns = [  //visible: false,
        {field: 'selectItem', checkBox: true},
        {title: '债权ID', field: 'orderId', align: 'center', valign: 'middle', sortable: true},
        {title: '用户姓名', field: 'customerName', align: 'center', valign: 'middle', sortable: true},
        {title: '证件号码', field: 'cardNo', align: 'center', valign: 'middle', sortable: true},
        {title: '手机号', field: 'mobile', align: 'center', valign: 'middle', sortable: true},
        {title: '债权期限', field: 'mortgageCycle', align: 'center', valign: 'middle', sortable: true},
        {title: '债权周期', field: 'term', align: 'center', valign: 'middle', sortable: true},
        {title: '债权额度', field: 'mortgageAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '业务类型', field: 'contractType', align: 'center', valign: 'middle', sortable: true},
        {title: '合同编号', field: 'contractNumber', align: 'center', valign: 'middle', sortable: true},
        {title: '代偿金额', field: 'repaymentAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '实际还款时间', field: 'repaymentTime', align: 'center', valign: 'middle', sortable: true},
        {title: '债权还款日期', field: 'rTime', align: 'center', valign: 'middle', sortable: true}
        ]
    return columns;
};


/**
 * 检查是否选中
 */
Compensatory.check = function () {
    var selected = $('#' + this.id).bootstrapTable('getSelections'); 
    if (selected.length == 0) {
        Feng.info("请先选中表格中的某一记录！");
        return false;
    } 
    else if (selected.length > 1) {
        Feng.info("只能选中一条记录！");
        return false;
    }   
    else {
    	Compensatory.seItem = selected[0];
        return true;
    }
};

var orderIdStr
Compensatory.check2 = function () {
    var selected = $('#' + this.id).bootstrapTable('getSelections'); 
    var arr = [],len = selected.length 
    for(var i=0;i<len;i++){
    	arr.push(selected[i].orderId)
    }
    orderIdStr = arr.join(',')
    
    if (selected.length == 0) {
        Feng.info("请先选中表格中的某一记录！");
        return false;
    }  
    else {
    	Compensatory.seItem = selected[0];
        return true;
    }

};

/**
 * 查看客户信息详情
 */
Compensatory.detail = function () {
	
    if (this.check()) {
    	  var index = layer.open({
              type: 2,
              title: '查看客户详情信息',
              area: ['800px', '450px'], //宽高
              fix: false, //不固定
              maxmin: true,
              content: Feng.ctxPath + '/compensatoryQuery/detail/' + Compensatory.seItem.orderId
          });
    	  layer.full(index);
          this.layerIndex = index;
    }
};
/**
 * 放款
 */
Compensatory.cutPayment= function () {
    if (this.check2()) {
  	  var index = layer.open({
            type: 2,
            title: '去放款',
            area: ['600px', '300px'], //宽高
            fix: false, //不固定
            maxmin: true,
            content: '/compensatoryQuery/cutpayment?orderIdStr='+ orderIdStr
        });
        this.layerIndex = index;
  }
};


Compensatory.edit = function () {
	
    if (this.check2()) {
    	  
    	$('#myModal').modal('show')
    	
    	$('#datetimepicker').val('')
    	$('#refuseRemark').val('')
    	
    	$("#refuseSubmit").off('click').on('click',function () {
		var datetimepicker = $('#datetimepicker').val()
		var refuseRemark = $('#refuseRemark').val()
		
		
		if (datetimepicker == '' || datetimepicker == undefined) {
			alert('时间不能为空')
			return false
		}		
		if (refuseRemark == '' || refuseRemark == undefined) {
			alert('提交信息不能为空')
			return false
		}
		else {
			$.ajax({
				type: 'post',
				url: '../compensatoryQuery/edit',
				cache: false,
				async: false,
				data: {
					orderIdStr: orderIdStr,
					datetimepicker: datetimepicker,
					refuseRemark: refuseRemark
				},
				success: function (data, textStatus, jqXHR) {
					if (data.code == 200) {
                        Feng.success("提交成功")
						$('#myModal').modal('hide')
						window.location.href='../compensatoryQuery/list?date='+new Date()
							
					}
					else if (data.code == 202) {
						Feng.error("不能重复提交")
					}
				},
				error: function (data) {
                    Feng.error('提交失败，请重试')
				},
			})
		}
	})
    	
    	
    	
    }
};

/**
 * 导出Excel
 */
/*Compensatory.excel = function () {	  
    	  var customerName =  $('#customerName').val();
    	  window.location.href='/customer/excel?customerName='+customerName
    	
};*/


/**
 * 搜索
 */
Compensatory.search = function () {
    var queryData = {};
    queryData['customerName'] = $("#customerName").val();
    Compensatory.table.refresh({query: queryData});      
}

$(function () {	
    var defaultColunms = Compensatory.initColumn();
    var table = new BSTable(Compensatory.id, "/compensatoryQuery/sel", defaultColunms);  
    table.setPaginationType("client"); 
    Compensatory.table = table.init();
});
