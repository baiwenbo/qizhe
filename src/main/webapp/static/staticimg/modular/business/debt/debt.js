/**
 * 角色管理的单例
 */
var Debt = {
    id: "debtTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
Debt.initColumn = function () {
    var columns = [  
        {field: 'selectItem', radio: true},
        {title: '债权ID', field: 'orderId', align: 'center', valign: 'middle', sortable: true},
        {title: '用户姓名', field: 'customerName', align: 'center', valign: 'middle', sortable: true},
        {title: '身份证号', field: 'cardNo', align: 'center', valign: 'middle', sortable: true},
        {title: '城市', field: 'city', align: 'center', valign: 'middle', sortable: true},
        {title: '渠道名称', field: 'channelName', align: 'center', valign: 'middle', sortable: true},
        {title: '债权期限', field: 'cycle', align: 'center', valign: 'middle', sortable: true},
        {title: '放款金额', field: 'mortgageAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '放款时间', field: 'loanTime', align: 'center', valign: 'middle', sortable: true},
        {title: '结清日期', field: 'endDate', align: 'center', valign: 'middle', sortable: true},             
        {title: '状态', field: 'stauts', align: 'center', valign: 'middle', sortable: true}]
    return columns;
};


/**
 * 检查是否选中
 */
Debt.check = function () {
    var selected = $('#' + this.id).bootstrapTable('getSelections'); 
    if (selected.length == 0) {
        Feng.info("请先选中表格中的某一记录！");
        return false;
    } else {
        Debt.seItem = selected[0];
        return true;
    }
};


/**
 * 查看债权查询详情页面
 */
Debt.detail = function () {
    if (this.check()) {
    	  var index = layer.open({
              type: 2,
              title: '查看债权查询详情页面',
              area: ['800px', '450px'], //宽高
              fix: false, //不固定
              maxmin: true,
              content: Feng.ctxPath + '/debt/detail/' + Debt.seItem.orderId
          });
    	  layer.full(index);
          this.layerIndex = index;
    }
};

/**
 * 搜索
 */
Debt.search = function () {
    var queryData = {};
    queryData['customerName'] = $("#customerName").val();
    queryData['cardNo'] = $("#cardNo").val();
    queryData['channelName'] = $("#channelName").val();
    queryData['loanTime'] = $("#loanTime").val();
    queryData['stauts'] = $("#stauts").val();
    Debt.table.refresh({query: queryData});      
}

$(function () {	
    var defaultColunms = Debt.initColumn();
    var table = new BSTable(Debt.id, "/debt/list", defaultColunms);  
    table.setPaginationType("server"); 
    Debt.table = table.init();
});
