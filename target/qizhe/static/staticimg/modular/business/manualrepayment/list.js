/**
 * 日志管理初始化
 */
var Manualrepayment = {
    id: "ManualrepaymentTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};
/**
 * 初始化表格的列
 */
Manualrepayment.initColumn = function () {
    return [
        {field: 'selectItem',visible:false, radio: true},
        {title: 'id',field:'id',visible:false,align: 'center', valign: 'middle'},
        {title: '债权ID', field: 'orderId', align: 'center', valign: 'middle'},
        {title: '用户姓名', field: 'customerName', align: 'center', valign: 'middle', sortable: true},
        {title: '证件号码', field: 'cardNo', align: 'center', valign: 'middle'},
        {title: '手机号', field: 'mobile', align: 'center', valign: 'middle', sortable: true},
        {title: '债权期限', field: 'cycle', align: 'center', valign: 'middle', sortable: true},
        {title: '债权额度', field: 'mindPrice', align: 'center', valign: 'middle', sortable: true},
        {title: '业务类型', field: 'contractType', align: 'center', valign: 'middle', sortable: true},
        {title: '合同编号', field: 'contractNumber', align: 'center', valign: 'middle', sortable: true},
        {title: '还款金额', field: 'repaymentAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '还款期数', field: 'term', align: 'center', valign: 'middle', sortable: true},
        {title: '记录产生时间', field: 'createTime', align: 'center', valign: 'middle', sortable: true}
    ];
};

/**
 * 查询日志列表
 */
Manualrepayment.search = function () {
    var queryData = {};

    queryData['customerName'] = $("#customerName").val();

    Manualrepayment.table.refresh({query: queryData});
};

Manualrepayment.add= function(){
    var index = layer.open({
        type: 2,
        title: '录入手工还款信息',
        area: ['800px', '500px'], //宽高
        maxmin: true,
        fix: false, //不固定
        content: Feng.ctxPath + '/manualrepayment/to_add/'
    });
    Manualrepayment.layerIndex = index;
}

$(function () {
    var defaultColunms = Manualrepayment.initColumn();
    var manualrepaymentTable = new BSTable(Manualrepayment.id, "/manualrepayment/list", defaultColunms);
    manualrepaymentTable.setPaginationType("server");
    Manualrepayment.table = manualrepaymentTable.init();
});

