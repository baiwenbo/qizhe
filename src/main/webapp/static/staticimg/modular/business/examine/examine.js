/**
 * 角色管理的单例
 */
var Examine = {
    id: "examineTable",	//表格id
    seItem: null,		//选中的条目
    table: null,
    layerIndex: -1
};

/**
 * 初始化表格的列
 */
Examine.initColumn = function () {
    var columns = [  
        {field: 'selectItem', radio: true},
        {title: '债权ID', field: 'orderId', align: 'center', valign: 'middle', sortable: true},
        {title: '用户姓名', field: 'customerName', align: 'center', valign: 'middle', sortable: true},
        {title: '身份证号', field: 'cardNo', align: 'center', valign: 'middle', sortable: true},
        {title: '手机号', field: 'mobile', align: 'center', valign: 'middle', sortable: true},
        {title: '城市', field: 'city', align: 'center', valign: 'middle', sortable: true},
        {title: '渠道代理商', field: 'channelName', align: 'center', valign: 'middle', sortable: true},
        {title: '联系地址', field: 'address', align: 'center', valign: 'middle', sortable: true},
        {title: '开户(放款)银行', field: 'openBank', align: 'center', valign: 'middle', sortable: true},
        {title: '开户(放款)姓名', field: 'openName', align: 'center', valign: 'middle', sortable: true},
        {title: '开户(放款)银行账户', field: 'openBankNo', align: 'center', valign: 'middle', sortable: true},
        {title: '申请的期限', field: 'cycle', align: 'center', valign: 'middle', sortable: true},
        {title: '申请额度', field: 'mortgageAmount', align: 'center', valign: 'middle', sortable: true},
        {title: '业务类型', field: 'contractType', align: 'center', valign: 'middle', sortable: true},
        {title: '进件时间', field: 'pushTime', align: 'center', valign: 'middle', sortable: true},
        {title: '审核时间', field: 'examineTime', align: 'center', valign: 'middle', sortable: true},
        {title: '状态', field: 'examineStatus', align: 'center', valign: 'middle', sortable: true,formatter:function(value){
        	 if(value=='1'){
                 return '未审核';
             }else if(value=='2'){
                 return '审核通过';
             }else{            	 
            	 return '审核拒绝'; 
             }
         }} ,
        {title: '单位名称', field: 'companyName', align: 'center', valign: 'middle', sortable: true},
        {title: '单位地址', field: 'companyAddress', align: 'center', valign: 'middle', sortable: true}       
        ]
        
        
    return columns;
};

/**
 * 检查是否选中
 */
Examine.check = function () {
    var selected = $('#' + this.id).bootstrapTable('getSelections'); 
    if (selected.length == 0) {
        Feng.info("请先选中表格中的某一记录！");
        return false;
    } else {
        Examine.seItem = selected[0];
        return true;
    }
};
/**
 * 条件筛选
 */
Examine.check1 = function () {
    var selected = $('#' + this.id).bootstrapTable('getSelections'); 
    if (selected.length == 0) {
        Feng.info("请先选中表格中的某一记录！");
        return false;
    } else if(selected[0].examineStatus=="1"){
        Examine.seItem = selected[0];
        return true;
    }else{
    	 Feng.info("请先选中表格中的一条未审核的记录！");
    	 return false;
    }
};

/**
 * 查看客户信息详情
 */
Examine.detail = function () {
    if (this.check()) {
    	  var index = layer.open({
              type: 2,
              title: '租赁债权详细信息',
              area: ['800px', '450px'], //宽高
              fix: false, //不固定
              maxmin: true,
              content: Feng.ctxPath + '/examine/detail/' + Examine.seItem.orderId
          });
    	  layer.full(index);
          this.layerIndex = index;
    }
};




/**
 * 审核管理
 */
Examine.checks = function () {


  if (this.check1()) {
    //询问框
    layer.confirm('是否通过审核？', {
        btn: ['通过','拒绝'] //按钮
    }, function(){

        $.ajax({
			type: 'post',
			url: '/examine/adopt',
			cache: false,
			async: false,
			data: {
				'orderId':Examine.seItem.orderId
			},
			success: function (data, textStatus, jqXHR) {
				if (data.code == 200) {
					layer.msg('已经通过', {icon: 1});
					window.location.reload()
				}
				else if (data.code == 202) {
					layer.msg('不能重复提交', {icon: 0});
					window.location.reload()
				}
			},
			error: function (data) {
				layer.msg('提交失败，请重试', {icon: 2});
			}
        })

    }, function(){
    	 $(document).on('click','.layui-layer-btn1',function () {
             $('#refuseRemark').val('')
             $('#refuse').modal('show')
             $("#refuseSubmit").click(function () {
                 var refuseRemark = $('#refuseRemark').val()
                 if (refuseRemark == '' || refuseRemark == undefined) {
                     layer.msg('不能为空', {
                         time: 2000,
                     });
                     return false
                 }
                 else {
                     $.ajax({
                         type: 'post',
                         url: '/examine/refuse',
                         cache: false,
                         async: false,
                         data: {
                             'orderId': Examine.seItem.orderId,
                             refuseRemark: refuseRemark
                         },
                         success: function (data, textStatus, jqXHR) {
                             if (data.code == 200) {
                                 layer.msg('提交成功', {
                                     time: 2000,
                                 });
                                 $('#refuse').modal('hide')
                                 window.location.reload()
                             }
                             else if (data.code == 202) {
                                 layer.msg('不能重复提交', {
                                     time: 2000,
                                 });
                                 window.location.reload()
                             }
                         },
                         error: function (data) {
                             layer.msg('提交失败，请重试', {
                                 time: 2000,
                             });

                         }
                     })
                 }
             })
         })


    });

}





};

/**
 * 搜索
 */
Examine.search = function () {
    var queryData = {};
    queryData['customerName'] = $("#customerName").val();
    queryData['channelName'] = $("#channelName").val();
    queryData['examineStatus'] = $("#examineStatus").val();    
    queryData['startTime'] = $("#startTime").val();    
    queryData['endTime'] = $("#endTime").val();    
    Examine.table.refresh({query: queryData});      
}

$(function () {
	// debugger;	
    var defaultColunms = Examine.initColumn();
    var table = new BSTable(Examine.id, "/examine/list", defaultColunms);  
    table.setPaginationType("server"); 
    Examine.table = table.init();
});