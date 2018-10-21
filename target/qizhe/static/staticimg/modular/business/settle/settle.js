/**
 * 租赁债权结清管理的单例
 */
var SettleInfo = {
    id: "settleInfoTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
SettleInfo.initColumn = function () {
    var columns = [
        {field: 'selectItem', radio: true},
        {title: 'id',field:'id',visible:false,align: 'center', valign: 'middle'},
        {title: '债权ID', field: 'orderId', align: 'center', valign: 'middle'},
        {title: '用户姓名', field: 'customerName', align: 'center', valign: 'middle', sortable: true},
        {title: '证件号码', field: 'cardNo', align: 'center', valign: 'middle'},
        {title: '手机号', field: 'mobile', align: 'center', valign: 'middle', sortable: true},
        {title: '债权期限', field: 'cycle', align: 'center', valign: 'middle', sortable: true},
        {title: '债权额度', field: 'mindPrice', align: 'center', valign: 'middle', sortable: true},
        {title: '业务类型', field: 'contractType', align: 'center', valign: 'middle', sortable: true},
        {title: '合同编号', field: 'contractNumber', align: 'center', valign: 'middle', sortable: true},
        {title: '结清总额', field: 'settlementAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '主债权结清额', field: 'companyAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '子债权结清额', field: 'rebateAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '结清类型', field: 'settleType', align: 'center', valign: 'middle', sortable: true},
        {title: '操作人', field: 'operator', align: 'center', valign: 'middle', sortable: true},
        {title: '记录产生时间', field: 'createTime', align: 'center', valign: 'middle', sortable: true},
        {title: '是否结清', field: 'isSettle', align: 'center', valign: 'middle', sortable: true,formatter:function(value){
            if(value=='1'){
                return '是';
            }else{
                return '否';
            }
        }}
        ]
    return columns;
};


/**
 * 检查是否选中
 */
SettleInfo.check = function () {
    var selected = $('#' + SettleInfo.id).bootstrapTable('getSelections');
    if (selected.length == 0) {
        Feng.info("请选择表中类型为强制结清且尚未结清的某一记录！");
        return false;
    } else {
        if(selected[0].isSettle=='1' || selected[0].settleType=='客户结清'){
            Feng.info("请选择表中类型为强制结清且尚未结清的某一记录")
            return false;
        }
        SettleInfo.seItem = selected[0];
        return true;
    }
};


/**
 * 客户结清
 */
SettleInfo.customerSettle = function () {
      var index = layer.open({
          type: 2,
          title: '客户结清',
          area: ['800px', '500px'], //宽高
          maxmin: true,
          fix: false, //不固定
          content: Feng.ctxPath + '/settle/to_customerSettle/'
      });
    SettleInfo.layerIndex = index;
};
/**
 * 强制结清
 */
SettleInfo.settle = function () {
    if (SettleInfo.check()) {
    	  var index = layer.open({
              type: 2,
              title: '强制结清',
              area: ['800px', '500px'], //宽高
              maxmin: true,
              fix: false, //不固定

              content: Feng.ctxPath + '/settle/to_settle/' + SettleInfo.seItem.id
          });
        SettleInfo.layerIndex = index;
    }
};
SettleInfo.search = function () {
    var queryData = {};
    queryData['customerName'] = $("#customerName").val();
    queryData['isSettle'] = $("#isSettle").val();
    SettleInfo.table.refresh({query: queryData});
};


$(function () {
    var settleInfoColunms = SettleInfo.initColumn();
    var settleInfoTable = new BSTable(SettleInfo.id, "/settle/list/"+$("#settleTypeId").val(), settleInfoColunms);
    settleInfoTable.height = 637;
    SettleInfo.table = settleInfoTable.init();
});