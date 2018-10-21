var BondInfoDlg = {
    bondInfoData: {},
    validateFields: {
        naAmount: {
            validators: {
                notEmpty: {
                    message: '金额不能为空'
                }, regexp: {
                    regexp: /^[0-9]*$/,
                    message: '请输入正确的金额'
                }
            }
        }
}
};
// 清除数据
BondInfoDlg.clearData = function () {
    this.bondInfoData = {};
};
/**
 * 收集数据
 */
BondInfoDlg.collectData = function () {
    this.set('bondId').set('naAmount');
}
BondInfoDlg.validate = function () {
    $('#bondInfoForm').data("bootstrapValidator").resetForm();
    $('#bondInfoForm').bootstrapValidator('validate');
    return $("#bondInfoForm").data('bootstrapValidator').isValid();
};
// 关闭
BondInfoDlg.close = function () {
    parent.layer.close(window.parent.BondInfo.layerIndex);
};
/**
* 设置对话框中的数据
*
* @param key 数据的名称
* @param val 数据的具体值
*/
BondInfoDlg.set = function (key, val) {
    this.bondInfoData[key] = (typeof value == "undefined") ? $("#" + key).val() : value;
    return this;
}
/**
 * 新增提交
 */
BondInfoDlg.addSubmit = function () {
        this.clearData();
        this.collectData();
        if (!this.validate()) {
            return;
        }
        //提交信息
        var ajax = new $ax(Feng.ctxPath + "/bond/add", function (data) {
            Feng.success("新增成功!");
            window.parent.BondInfo.table.refresh();
            window.parent.BondRecordInfo.table.refresh();
            BondInfoDlg.close();
        }, function (data) {
            Feng.error("新增失败!" + data.responseJSON.message + "!");
        });
        ajax.set(this.bondInfoData);
        ajax.start();
    };
$(function () {
    Feng.initValidator("bondInfoForm", BondInfoDlg.validateFields);
});