/**
 * 对账记录的单例
 */
var Reconciliation = {
    id: "reconciliationTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
Reconciliation.initColumn = function () {
    var columns = [
        {field: 'selectItem', visible:false,radio: true},
        {title: '编号',field:'id',align: 'center', valign: 'middle'},
        {title: '账单日期', field: 'billTime', align: 'center', valign: 'middle'},
        {title: '对账时间',field:'reconciliationTime',align: 'center', valign: 'middle'},
        {title: '对账结果',field:'result',align: 'center', valign: 'middle'},
        {title: '操作', field: 'id', align: 'center', valign: 'middle',
            formatter:function (value,row,index) {
                return [
                    '<button id="btn_transaction_detail" type="button" class="btn btn-success" onclick="Reconciliation.financialtransactionsInfo('+value+')">详情</button>',
                ].join('')

        }},
        ]
    return columns;
};

/**
 * 查询
 */
Reconciliation.search = function () {
    var queryData = {};
    queryData['openName'] = $("#openName").val();
    Reconciliation.table.refresh({query: queryData});
};

/**
 * 查询支付记录详情
 * @param value
 */
Reconciliation.collectionRepaymentSignInfo = function (value) {
    var index = layer.open({
        type: 2,
        title: '支付流水详情',
        area: ['800px', '500px'], //宽高
        maxmin: true,
        fix: false, //不固定
        content: Feng.ctxPath + '/reconciliation/to_reconciliationDetail/'+value
    });
    layer.full(index);
    
    
    Reconciliation.layerIndex = index;
    
}

$(function () {
    var reconciliationColunms = Reconciliation.initColumn();
    var reconciliationTable = new BSTable(Reconciliation.id, "/reconciliation/list/", reconciliationColunms);
    reconciliationTable.height = 637;
    Reconciliation.table = reconciliationTable.init();
});