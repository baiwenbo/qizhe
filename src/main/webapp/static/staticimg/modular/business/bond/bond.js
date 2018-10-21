/**
 * 保证金管理的单例
 */
var BondInfo = {
    id: "bondInfoTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
BondInfo.initColumn = function () {
    var columns = [
        [{title:'保证金信息',
            colspan:'15',
            align:'center',
            valign: 'middle',
        }],
        [{field: 'selectItem', radio: true},
        {title: 'id', field: 'id',  align: 'center', valign: 'middle', sortable: true},
        {title: '保证金总额', field: 'bondAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '债权总额', field: 'mortgageAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '当前保证金比例', field: 'currentBondProportion', align: 'center', valign: 'middle', sortable: true},
        {title: '保证金预警比例', field: 'bondProportion', align: 'center', valign: 'middle', sortable: true,formatter:function (value) {
            var newValue = value + "%";
            return newValue;
        }},
        {title: '创建时间', field: 'createTime', align: 'center', valign: 'middle', sortable: true}]
        ]
    return columns;
};


/**
 * 检查是否选中
 */
BondInfo.check = function () {
    var selected = $('#' + BondInfo.id).bootstrapTable('getSelections');
    if (selected.length == 0) {
        Feng.info("请先选中保证金信息表中的某一记录！");
        return false;
    } else {
        BondInfo.seItem = selected[0];
        return true;
    }
};


/**
 * 查看客户信息详情
 */
BondInfo.addBond = function () {
    if (BondInfo.check()) {
    	  var index = layer.open({
              type: 2,
              title: '增加保证金',
              area: ['400px', '200px'], //宽高
              fix: false, //不固定

              content: Feng.ctxPath + '/bond/to_add/' + BondInfo.seItem.id
          });
        BondInfo.layerIndex = index;
    }
};



/**
 * 保证金操作记录的单例
 */
var BondRecordInfo = {
    id: "bondRecordInfoTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
BondRecordInfo.initColumn = function () {
    var columns = [
        [{
            title:'保证金操作记录',
            colspan:'15',
            align:'center',
            valign: 'middle',
        }],
        [
        {title: 'id', field: 'id',visible:false, align: 'center', valign: 'middle', sortable: true},
        {title: '保证金id', field: 'bondId', align: 'center', valign: 'middle', sortable: true},
        {title: '新增额度', field: 'naAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '操作人', field: 'operator', align: 'center', valign: 'middle', sortable: true},
        {title: '操作时间', field: 'operatingTime', align: 'center', valign: 'middle', sortable: true}
        ]
    ]
    return columns;
};


$(function () {
    var bondInfoColunms = BondInfo.initColumn();
    var bondInfoTable = new BSTable(BondInfo.id, "/bond/listBondInfo", bondInfoColunms);
    bondInfoTable.height=300;
    BondInfo.table = bondInfoTable.init();
    var bondRecordInfoColunms = BondRecordInfo.initColumn();
    var bondRecordInfoTable = new BSTable(BondRecordInfo.id, "/bond/listBondRecordInfo", bondRecordInfoColunms);
    bondRecordInfoTable.height=553;
    BondRecordInfo.table = bondRecordInfoTable.init();
});
