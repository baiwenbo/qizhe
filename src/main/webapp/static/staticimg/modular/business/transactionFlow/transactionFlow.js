/**
 * 租赁债权结清管理的单例
 */
var TransactionFlow = {
    id: "transactionFlowTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
TransactionFlow.initColumn = function () {
    var columns = [
        {field: 'selectItem', visible:false,radio: true},
        {title: '交易流水号',field:'transactionFlowId',align: 'center', valign: 'middle'},
        {title: '业务类型',field:'ftType',align: 'center', valign: 'middle',width:'99px'},
        {title: '支付类型', field: 'tradeCode', align: 'center', valign: 'middle',width :'99px',
            formatter: function (value) {
                if(value == "100014"){
                    return "代付"
                }else if(value == "100011"){
                    return "代收"
                }else{
                    return "-";
                }
            }
        },
        {title: '开户银行',field:'bankName',align: 'center', valign: 'middle',width:'99px'},
        {title: '客户姓名', field: 'openName', align: 'center', valign: 'middle', sortable: true,width:'97px'},
        {title: '银行卡号', field: 'openBankNo', align: 'center', valign: 'middle', sortable: true,width:'169px'},
        {title: '账户属性', field: 'accountProperty', align: 'center', valign: 'middle', sortable: true,width:'97px',
            formatter: function (value) {
                if(value == "0"){
                    return "个人";
                }else if(value == "1"){
                    return "公司";
                }else{
                    return "-";
                }
            }},
        {title: '交易金额', field: 'amount', align: 'center', valign: 'middle', sortable: true,width:'107px'},
        {title: '提交时间',field:'createTime',align: 'center', valign: 'middle',width:'173px'},
        {title: '完成时间',field:'completeTime',align: 'center', valign: 'middle',width:'173px'},
        {title: '交易结果', field: 'status', align: 'center', valign: 'middle', sortable: true,width:'96px',
            formatter:function (value) {
                if(value == '2'){
                    return '交易成功';
                }else if(value == '4'){
                    return '正在处理';
                }else{
                    return '交易失败';
                }
            }
        },
        {title: '失败原因',field:'remark',align: 'center', valign: 'middle',width:'173px'},
        {title: '操作员', field: 'operator', align: 'center', valign: 'middle', sortable: true,width:'97px'},
        {title: '操作', field: 'id', align: 'center', valign: 'middle', sortable: true,width:'455px',
            formatter:function (value,row,index) {
            // debugger;
                var ftTypeId = row.ftTypeId
                var transactionFlowId = row.transactionFlowId
                if (row.status == '3') {
                    return [
                            '<button id="btn_transaction_detail" type="button" class="btn btn-success" onclick="TransactionFlow.financialtransactionsInfo('+'\''+transactionFlowId+'\''+')">金融交易详情</button>',
                        ].join('')
                        + '&nbsp;&nbsp;&nbsp;' +
                        [
                            '<button id="btn_flow_detail" type="button" class="btn btn-primary" onclick="TransactionFlow.collectionRepaymentSignInfo('+'\''+transactionFlowId+'\''+')">支付流水详情</button>',
                        ].join('')
                        + '&nbsp;&nbsp;&nbsp;' +
                        [
                            '<button id="btn_repayment_detail" type="button" class="btn btn-danger" onclick="TransactionFlow.pay('+'\''+transactionFlowId+'\''+','+ftTypeId+')">支付</button>',
                        ].join('');
                }else{
                    return [
                            '<button id="btn_transaction_detail" type="button" class="btn btn-success" onclick="TransactionFlow.financialtransactionsInfo('+'\''+transactionFlowId+'\''+')">金融交易详情</button>',
                        ].join('')
                        + '&nbsp;&nbsp;&nbsp;' +
                        [
                            '<button id="btn_flow_detail" type="button" class="btn btn-primary" onclick="TransactionFlow.collectionRepaymentSignInfo('+'\''+transactionFlowId+'\''+')">支付流水详情</button>',
                        ].join('')
                }
        }},
        ]
    return columns;
};

/**
 * 查询
 */
TransactionFlow.search = function () {
    var queryData = {};
    queryData['openName'] = $("#openName").val();
    TransactionFlow.table.refresh({query: queryData});
};

/**
 * 查询交易记录详情
 * @param value
 */
TransactionFlow.financialtransactionsInfo = function (value) {
    var index = layer.open({
        type: 2,
        title: '金融交易详情',
        area: ['800px', '500px'], //宽高
        maxmin: true,
        fix: false, //不固定
        content: Feng.ctxPath + '/transactionFlow/to_financialtransactionsInfo/'+value
    });
    layer.full(index);    
    TransactionFlow.layerIndex = index;
}

/**
 * 查询支付记录详情
 * @param value
 */
TransactionFlow.collectionRepaymentSignInfo = function (value) {
    var index = layer.open({
        type: 2,
        title: '支付流水详情',
        area: ['800px', '500px'], //宽高
        maxmin: true,
        fix: false, //不固定
        content: Feng.ctxPath + '/transactionFlow/to_collectionRepaymentSignInfo/'+value
    });
    layer.full(index);
    
    
    TransactionFlow.layerIndex = index;
    
}
/**
 * 支付
 * @param value
 */
TransactionFlow.pay = function (transactionFlowId,ftTypeId) {
    var ajax = new $ax(Feng.ctxPath + "/transactionFlow/pay", function (data) {
        TransactionFlow.table.refresh();
        Feng.success("支付成功");
    },function (data){
        Feng.alert('支付失败');
    });
    ajax.set("transactionFlowId",transactionFlowId);
    ajax.set("ftTypeId",ftTypeId);
    ajax.start();
}

$(function () {
    var transactionFlowColunms = TransactionFlow.initColumn();
    var transactionFlowTable = new BSTable(TransactionFlow.id, "/transactionFlow/list/", transactionFlowColunms);
    transactionFlowTable.height = 637;
    TransactionFlow.table = transactionFlowTable.init();
});