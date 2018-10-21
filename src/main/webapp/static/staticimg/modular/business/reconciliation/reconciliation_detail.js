/**
 * 对账记录的单例
 */
var ReconciliationDetail = {
    id: "reconciliationDetailTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
ReconciliationDetail.initColumn = function () {
    var columns = [
        {field: 'selectItem', visible:false,radio: true},
        {title: '编号',field:'id',align: 'center', valign: 'middle'},
        {title: '账单日期', field: 'billTime', align: 'center', valign: 'middle'},
        {title: '对账时间',field:'reconciliationTime',align: 'center', valign: 'middle'},
        {title: '对账结果',field:'result',align: 'center', valign: 'middle'},
        {title: '操作', field: 'id', align: 'center', valign: 'middle',
            formatter:function (value,row,index) {
                return [
                    '<button id="btn_transaction_detail" type="button" class="btn btn-success" onclick="ReconciliationDetail.financialtransactionsInfo('+value+')">详情</button>',
                ].join('')

        }},
        ]
    return columns;
};


$(function () {
    var reconciliationDetailColunms = ReconciliationDetail.initColumn();
    var reconciliationDetailTable = new BSTable(ReconciliationDetail.id, "/reconciliation/list/", reconciliationDetailColunms);
    reconciliationDetailTable.height = 637;
    ReconciliationDetail.table = reconciliationDetailTable.init();
});