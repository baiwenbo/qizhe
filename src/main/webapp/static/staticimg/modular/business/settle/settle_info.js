/**
 * 债权结清对话框
 */
var SettleInfoDlg = {
    settleInfoData: {}
};

/**
 * 清除数据
 */
SettleInfoDlg.clearData = function () {
    this.roleInfoData = {};
}

/**
 * 设置对话框中的数据
 *
 * @param key 数据的名称
 * @param val 数据的具体值
 */
SettleInfoDlg.set = function (key, val) {
    this.roleInfoData[key] = (typeof value == "undefined") ? $("#" + key).val() : value;
    return this;
}

/**
 * 设置对话框中的数据
 *
 * @param key 数据的名称
 * @param val 数据的具体值
 */
SettleInfoDlg.get = function (key) {
    return $("#" + key).val();
}

/**
 * 关闭此对话框
 */
SettleInfoDlg.close = function () {
    parent.layer.close(window.parent.SettleInfo.layerIndex);
}

/**
 * 收集数据
 */
SettleInfoDlg.collectData = function () {
    this.set('id');
}


/**
 * 查询客户结清信息
 */
SettleInfoDlg.select = function(){
    var orderId = $('#orderId').val()
    if(orderId == null || orderId.length ==0){
        Feng.alert("请先填写债权id");
        return;
    }
    var ajax = new $ax(Feng.ctxPath + "/settle/select", function (data) {

        Feng.success("查询成功");
        $('#orderId').attr('disabled','true').attr('required','true')
        $('#mortgageAmount').val(data.mortgageAmount).attr('disabled','true').attr("required","true")
        $('#select').attr('disabled','true')
        $('#settlementAmount').val(data.settlementAmount).attr("required","true")

    },function (data){
        Feng.alert('未查到数据');
    });
    ajax.set("orderId",orderId);
    ajax.start();
}

