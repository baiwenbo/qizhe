/**
 * 日志管理初始化
 */
var LoginLog = {
    id: "list",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};
console.log(9999)
/**
 * 初始化表格的列
 */
LoginLog.initColumn = function () {
    return [
        {field: 'selectItem', radio: true},
        {title: '债权ID', field: 'id', visible: false, align: 'center', valign: 'middle'},
        {title: '用户姓名', field: 'logname', align: 'center', valign: 'middle', sortable: true},
        {title: '证件号码', field: 'userName', align: 'center', valign: 'middle'},
        {title: '手机号', field: 'createtime', align: 'center', valign: 'middle', sortable: true},
        {title: '债权期限', field: 'message', align: 'center', valign: 'middle', sortable: true},
        {title: '债权额度', field: 'ip1', align: 'center', valign: 'middle', sortable: true},
        {title: '业务类型', field: 'ip2', align: 'center', valign: 'middle', sortable: true},
        {title: '债权额度', field: 'ip3', align: 'center', valign: 'middle', sortable: true},
        {title: '合同编号', field: 'ip4', align: 'center', valign: 'middle', sortable: true},
        {title: '结清金额', field: 'ip4', align: 'center', valign: 'middle', sortable: true},
        {title: '记录产生时间', field: 'ip6', align: 'center', valign: 'middle', sortable: true}
    ];
};

/**
 * 检查是否选中
 */
LoginLog.check = function () {
    var selected = $('#' + this.id).bootstrapTable('getSelections');
    if (selected.length == 0) {
        Feng.info("请先选中表格中的某一记录！");
        return false;
    } else {
        LoginLog.seItem = selected[0];
        return true;
    }
};


/**
 * 清空日志
 */
LoginLog.delLog = function () {
    Feng.confirm("是否清空所有日志?", function () {
        var ajax = Feng.baseAjax("/loginLog/delLoginLog", "清空日志");
        ajax.start();
        LoginLog.table.refresh();
    });
}

/**
 * 查询日志列表
 */
LoginLog.search = function () {
    var queryData = {};

    queryData['logName'] = $("#logName").val();
    queryData['beginTime'] = $("#beginTime").val();
    queryData['endTime'] = $("#endTime").val();

    LoginLog.table.refresh({query: queryData});
};

$(function () {

    init();

    var defaultColunms = LoginLog.initColumn();
    var table = new BSTable(LoginLog.id, "/loginLog/list", defaultColunms);
    table.setPaginationType("server");
    LoginLog.table = table.init();
});

function init() {

    var BootstrapTable = $.fn.bootstrapTable.Constructor;
    BootstrapTable.prototype.onSort = function (event) {
        var $this = event.type === "keypress" ? $(event.currentTarget) : $(event.currentTarget).parent(),
            $this_ = this.$header.find('th').eq($this.index()),
            sortName = this.header.sortNames[$this.index()];

        this.$header.add(this.$header_).find('span.order').remove();

        if (this.options.sortName === $this.data('field')) {
            this.options.sortOrder = this.options.sortOrder === 'asc' ? 'desc' : 'asc';
        } else {
            this.options.sortName = sortName || $this.data('field');
            this.options.sortOrder = $this.data('order') === 'asc' ? 'desc' : 'asc';
        }
        this.trigger('sort', this.options.sortName, this.options.sortOrder);

        $this.add($this_).data('order', this.options.sortOrder);

        // Assign the correct sortable arrow
        this.getCaret();

        if (this.options.sidePagination === 'server') {
            this.initServer(this.options.silentSort);
            return;
        }

        this.initSort();
        this.initBody();
    };
    BootstrapTable.prototype.getCaret = function () {
        var that = this;

        $.each(this.$header.find('th'), function (i, th) {
            var sortName = that.header.sortNames[i];
            $(th).find('.sortable').removeClass('desc asc').addClass((sortName || $(th).data('field')) === that.options.sortName ? that.options.sortOrder : 'both');
        });
    };
}
