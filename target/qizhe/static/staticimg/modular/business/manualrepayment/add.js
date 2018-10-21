/**
 * 债权结清对话框
 */
var ManualrepaymentDlg = {
    manualrepaymentData: {},
    validateFields: {
        orderId: {
            validators: {
                notEmpty: {
                    message: '债权id不能为空'
                }
            }
        },
        repaymentAmount: {
            validators: {
                notEmpty: {
                    message: '还款额不能为空'
                }
            }
        },
        term: {
            validators: {
                notEmpty: {
                    message: '还款期数不能为空'
                }
            }
        }
    }
};

/**
 * 清除数据
 */
ManualrepaymentDlg.clearData = function () {
    this.roleInfoData = {};
}

/**
 * 设置对话框中的数据
 *
 * @param key 数据的名称
 * @param val 数据的具体值
 */
ManualrepaymentDlg.set = function (key, val) {
    this.roleInfoData[key] = (typeof value == "undefined") ? $("#" + key).val() : value;
    return this;
}

/**
 * 设置对话框中的数据
 *
 * @param key 数据的名称
 * @param val 数据的具体值
 */
ManualrepaymentDlg.get = function (key) {
    return $("#" + key).val();
}

/**
 * 关闭此对话框
 */
ManualrepaymentDlg.close = function () {
    parent.layer.close(window.parent.Manualrepayment.layerIndex);
}

/**
 * 收集数据
 */
ManualrepaymentDlg.collectData = function () {
    this.set('id');
}

/**
 * 验证数据是否为空
 */
ManualrepaymentDlg.validate = function () {
    $('#manualrepaymentForm').data("bootstrapValidator").resetForm();
    $('#manualrepaymentForm').bootstrapValidator('validate');
    return $("#manualrepaymentForm").data('bootstrapValidator').isValid();
}

/**
 * 查询客户结清信息
 */
ManualrepaymentDlg.select = function(){
    var orderId = $('#orderId').val()
    if(orderId == null || orderId.length ==0){
        Feng.alert("请先填写债权id");
        return;
    }
    var ajax = new $ax(Feng.ctxPath + "/manualrepayment/select", function (data) {

        Feng.success("查询成功");
        $('#orderId').attr('disabled','true')
        $('#repaymentAmount').val(data.lesseeRepay).attr('disabled','true')
        $('#select').attr('disabled','true')
        $('#term').val(data.term).attr('disabled','true')
      
    },function (data){
        Feng.alert('未查到数据');
    });
    ajax.set("orderId",orderId);
    ajax.start();
}


$(function () {
    Feng.initValidator("manualrepaymentForm", ManualrepaymentDlg.validateFields);
});
