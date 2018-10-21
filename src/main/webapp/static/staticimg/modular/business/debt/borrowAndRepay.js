/**
 * 角色管理的单例
 */
var BorrowAndRepay = {
    id: "borrowAndRepayTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
BorrowAndRepay.initColumn = function () {
    var columns = [  
        {field: 'selectItem', checkBox: true},
        {title: '租赁债权ID', field: 'orderId', align: 'center', valign: 'middle', sortable: true},
        {title: '渠道供应商名称', field: 'channelName', align: 'center', valign: 'middle', sortable: true},
        {title: '客户姓名', field: 'customerName', align: 'center', valign: 'middle', sortable: true},
        {title: '放款账户', field: 'openBankNo', align: 'center', valign: 'middle', sortable: true},
        {title: '债权额', field: 'mortgageAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '审核时间', field: 'auditTime', align: 'center', valign: 'middle', sortable: true},
        {title: '审核人', field: 'auditName', align: 'center', valign: 'middle', sortable: true},
        {title: '操作人', field: 'operator', align: 'center', valign: 'middle', sortable: true},
        {title: '操作时间', field: 'operatingTime', align: 'center', valign: 'middle', sortable: true},
        {title: '借款申请书信息', field: 'loanApply', align: 'center', valign: 'middle', sortable: true},
        {title: '状态', field: 'stauts', align: 'center', valign: 'middle', sortable: true,formatter:function(value){
        	  if(value=='5'){
        		  return '已受理';
        	}else if(value=='4'){
        		return '待确认';
        	}else if(value=='3'){
                return '放款失败';
            }else if(value=='2'){
                return '放款成功';
            }else if(value=='1'){
                return '未发起';
            }
        }}]
    return columns;
};


/**
 * 检查是否选中
 */
BorrowAndRepay.check = function () {

    var selected = $('#' + this.id).bootstrapTable('getSelections'); 
    if (selected.length == 0) {
        Feng.info("请先选中表格中的某一记录！");
        return false;
    } else {
        BorrowAndRepay.seItem = selected[0];
        return true;
    }
};

var orderIdStr
BorrowAndRepay.check2 = function () {	
    var selected = $('#' + this.id).bootstrapTable('getSelections'); 
    var arr = [],len = selected.length 
    for(var i=0;i<len;i++){
    	if(selected[i].stauts=='1'){
    		arr.push(selected[i].orderId)
    	}
    }
    orderIdStr = arr.join(',')
    if (arr.length == 0) {
        Feng.info("请至少选择一个状态为未发起的订单！");
        return false;
    }  
    else {
    	BorrowAndRepay.seItem = arr;
        return true;
    }

};


/**
 * 去放款
 */
BorrowAndRepay.toLoan= function () {
    if (this.check2()) {
    	  var index = layer.open({
              type: 2,
              title: '去放款',
              area: ['800px', '450px'], //宽高
              fix: false, //不固定
              maxmin: true,
              content: '/borrowAndRepay/toLoan?orderIdStr='+ orderIdStr
          });
    	  layer.full(index);
          this.layerIndex = index;
    }
};

BorrowAndRepay.search = function () {
    var queryData = {};
    queryData['customerName'] = $("#customerName").val();
    BorrowAndRepay.table.refresh({query: queryData});      
}

$(function () {	
    var defaultColunms = BorrowAndRepay.initColumn();
    var table = new BSTable(BorrowAndRepay.id, "/borrowAndRepay/list", defaultColunms);  
    table.setPaginationType("server"); 
    BorrowAndRepay.table = table.init();
});