

(function () {
    var NewBSTable = function (bstableId, url, columns) {
        this.btInstance = null;					//jquery和BootStrapTable绑定的对象
        this.bstableId = bstableId;
        this.url = Feng.ctxPath + url;
        this.method = "post";
        this.paginationType = "server";			//默认分页方式是服务器分页,可选项"client"
        this.toolbarId = bstableId + "Toolbar";
        this.columns = columns;
        this.height = 665,						//默认表格高度665
        this.data = {};
    };

    NewBSTable.prototype = {
        /**
         * 初始化bootstrap table
         */
        init: function () {
            var tableId = this.bstableId;
            this.btInstance =
                $('#' + tableId).bootstrapTable({
                    contentType: "application/x-www-form-urlencoded",
                    url: this.url,				//请求地址
                    method: this.method,		//ajax方式,post还是get
                    data: {"transactionFlowId":$("#transactionFlowId").val()},
                    pageNumber: 1,      			//初始化加载第一页，默认第一页
                    pageSize: 10,      			//每页的记录行数（*）
                    pageList: [10, 50, 100],  	//可供选择的每页的行数（*）
                    toolbar: "#" + this.toolbarId,//顶部工具条
                    striped: true,     			//是否显示行间隔色
                    cache: false,      			//是否使用缓存,默认为true
                    pagination: true,     		//是否显示分页（*）
                    sortable: false,      		//是否启用排序
                    queryParamsType: '', 	//默认值为 'limit' ,在默认情况下 传给服务端的参数为：offset,limit,sort
                    sidePagination: this.paginationType,   //分页方式：client客户端分页，server服务端分页（*）
                    search: false,      		//是否显示表格搜索，此搜索是客户端搜索，不会进服务端
                    strictSearch: true,			//设置为 true启用 全匹配搜索，否则为模糊搜索
                    showColumns: false,     		//是否显示所有的列
                    minimumCountColumns: 2,    	//最少允许的列数
                    clickToSelect: true,    	//是否启用点击选中行
                    searchOnEnterKey: true,		//设置为 true时，按回车触发搜索方法，否则自动触发搜索方法
                    columns: this.columns,		//列数组
                    pagination: true,			//是否显示分页条
                    height: this.height,
                    icons: {
                        refresh: 'glyphicon-repeat',
                        toggle: 'glyphicon-list-alt',
                        columns: 'glyphicon-list'
                    },
                    iconSize: 'outline'
                });
            return this;
        },

        /**
         * 设置分页方式：server 或者 client
         */
        setPaginationType: function (type) {
            this.paginationType = type;
        },

        /**
         * 设置ajax post请求时候附带的参数
         */
        set: function (key, value) {
            if (typeof key == "object") {
                for (var i in key) {
                    if (typeof i == "function")
                        continue;
                    this.data[i] = key[i];
                }
            } else {
                this.data[key] = (typeof value == "undefined") ? $("#" + key).val() : value;
            }
            return this;
        },

        /**
         * 设置ajax post请求时候附带的参数
         */
        setData: function (data) {
            this.data = data;
            return this;
        },

        /**
         * 清空ajax post请求参数
         */
        clear: function () {
            this.data = {};
            return this;
        },

        /**
         * 刷新 bootstrap 表格
         * Refresh the remote server data,
         * you can set {silent: true} to refresh the data silently,
         * and set {url: newUrl} to change the url.
         * To supply query params specific to this request, set {query: {foo: 'bar'}}
         */
        refresh: function (parms) {
            if (typeof parms != "undefined") {
                this.btInstance.bootstrapTable('refreshOptions',{pageNumber:1});
                this.btInstance.bootstrapTable('refresh', parms);
            } else {
                this.btInstance.bootstrapTable('refresh');
            }
        }
    };

    window.NewBSTable = NewBSTable;

}());
var financialtransactionsInfo = {
    id: "financialtransactions_info",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1,
};

/**
 * 初始化表格的列
 */
financialtransactionsInfo.initColumn = function () {
    var columns = [
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

$(function () {
    var defaultColunms = financialtransactionsInfo.initColumn();
    var table = new NewBSTable(financialtransactionsInfo.id 

, "/transactionFlow/financialtransactionsInfoList?transactionFlowId="+$("#transactionFlowId").val(), defaultColunms);

    table.setPaginationType("client")
    table.height = 510;
    financialtransactionsInfo.table = table.init();
});


