/**
 * 角色管理的单例
 */
var Customer = {
    id: "customerTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
Customer.initColumn = function () {
    var columns = [  
        {field: 'selectItem', radio: true},
        {title: '债权ID', field: 'orderId', align: 'center', valign: 'middle', sortable: true},
        {title: '用户姓名', field: 'customerName', align: 'center', valign: 'middle', sortable: true},
        {title: '身份证号', field: 'cardNo', align: 'center', valign: 'middle', sortable: true},
        {title: '手机号', field: 'mobile', align: 'center', valign: 'middle', sortable: true},
        {title: '城市', field: 'city', align: 'center', valign: 'middle', sortable: true},
        {title: '渠道名称', field: 'channelName', align: 'center', valign: 'middle', sortable: true},
        {title: '联系地址', field: 'address', align: 'center', valign: 'middle', sortable: true},
        {title: '开户银行', field: 'openBank', align: 'center', valign: 'middle', sortable: true},
        {title: '开户姓名', field: 'openName', align: 'center', valign: 'middle', sortable: true},
        {title: '开户银行账户', field: 'openBankNo', align: 'center', valign: 'middle', sortable: true},
        {title: '单位名称', field: 'companyName', align: 'center', valign: 'middle', sortable: true},
        {title: '单位地址', field: 'companyAddress', align: 'center', valign: 'middle', sortable: true},             
        {title: '进件时间', field: 'pushTime', align: 'center', valign: 'middle', sortable: true}
        ]
    return columns;
};


/**
 * 检查是否选中
 */
Customer.check = function () {
    var selected = $('#' + this.id).bootstrapTable('getSelections'); 
    if (selected.length == 0) {
        Feng.info("请先选中表格中的某一记录！");
        return false;
    } else {
        Customer.seItem = selected[0];
        return true;
    }
};


/**
 * 查看客户信息详情
 */
Customer.detail = function () {
    if (this.check()) {
    	  var index = layer.open({
              type: 2,
              title: '查看客户详情信息',
              area: ['800px', '450px'], //宽高
              fix: false, //不固定
              maxmin: true,
              content: Feng.ctxPath + '/customer/detail/' + Customer.seItem.orderId
          });
    	  layer.full(index);
          this.layerIndex = index;
    }
};

/**
 * 导出Excel
 */
Customer.excel = function () {	  
    	  var customerName =  $('#customerName').val();
    	  window.location.href='/customer/excel?customerName='+customerName
    	
};

/**
 * 搜索
 */
Customer.search = function () {
    var queryData = {};
    queryData['customerName'] = $("#customerName").val();
    Customer.table.refresh({query: queryData});      
}

$(function () {	
    var defaultColunms = Customer.initColumn();
    var table = new BSTable(Customer.id, "/customer/list", defaultColunms);  
    table.setPaginationType("server"); 
    Customer.table = table.init();
});
