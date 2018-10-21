/**
 * 租赁债权结清管理的单例
 */
var FinancialtransactionsInfo = {
    id: "financialtransactionsInfoTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
FinancialtransactionsInfo.initColumn = function () {
    var columns = [
        {field: 'selectItem', radio: true},
        {title: 'id', field: 'id',visible:false,  align: 'center', valign: 'middle', sortable: true},
        {title: '债权id', field: 'orderId', align: 'center', valign: 'middle', sortable: true},
        {title: '用户姓名', field: 'customerName', align: 'center', valign: 'middle', sortable: true},
        {title: '证件号码', field: 'cardNo', align: 'center', valign: 'middle'},
        {title: '手机号', field: 'mobile', align: 'center', valign: 'middle', sortable: true},
        {title: '债权期限', field: 'cycle', align: 'center', valign: 'middle', sortable: true},
        {title: '债权额度', field: 'mindPrice', align: 'center', valign: 'middle', sortable: true},
        {title: '交易金额', field: 'transactionAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '业务类型', field: 'ftType', align: 'center', valign: 'middle', sortable: true},
        {title: '记录时间', field: 'recordingTime', align: 'center', valign: 'middle', sortable: true},
        {title: '操作人', field: 'operator', align: 'center', valign: 'middle', sortable: true}
        ]
    return columns;
};


/**
 * 检查是否选中
 */
FinancialtransactionsInfo.check = function () {
    var selected = $('#' + FinancialtransactionsInfo.id).bootstrapTable('getSelections');
    if (selected.length == 0) {
        Feng.info("请先选中保证金信息表中的某一记录！");
        return false;
    } else {
        FinancialtransactionsInfo.seItem = selected[0];
        return true;
    }
};


/**
 * 查看客户信息详情
 */
FinancialtransactionsInfo.addBond = function () {
    if (FinancialtransactionsInfo.check()) {
    	  var index = layer.open({
              type: 2,
              title: '增加保证金',
              area: ['400px', '200px'], //宽高
              fix: false, //不固定

              content: Feng.ctxPath + '/bond/to_add/' + FinancialtransactionsInfo.seItem.id
          });
        FinancialtransactionsInfo.layerIndex = index;
    }
};


$(function () {
    var financialtransactionsInfoColunms = FinancialtransactionsInfo.initColumn();
    var financialtransactionsInfoTable = new BSTable(FinancialtransactionsInfo.id, "/financialtransactionsInfo/list", financialtransactionsInfoColunms);
    FinancialtransactionsInfo.table = financialtransactionsInfoTable.init();
});