
package com.fh.util;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

/**
 * 常量工具类
 * 
 * @author M2
 */
public class ConstantUtils {

    /* ================ enum categories begin =================== */
    /**
     * 车辆类型
     */
    public static final String ENUM_CAT_VEHICLETYPE = "VehicleType";

    /**
     * 附件用途类型
     */
    public static final String ENUM_CAT_ATTACHUSETYPE = "AttachUseType";

    /**
     * 变速箱类型
     */
    public static final String ENUM_CAT_TRANSMISSIONTYPE = "TransmissionType";

    /**
     * 车辆资料交接状态
     */
    public static final String ENUM_CAT_VEHICLEMATERIALSTATUS = "TransferStatus";

    /**
     * 质抵押车辆状态
     */
    public static final String ENUMS_CAT_MORT_VE_STATUS = "MortVeStatus";

    /**
     * 审核类型
     */
    public static final String ENUMS_CAT_APRV_TYPE = "AprvType";

    /**
     * 车辆性质
     */
    public static final String ENUMS_CAT_MORT_VE_PROP = "MortVeProp";

    /**
     * 附件用途类型
     */
    public static final String ENUMS_CAT_MORT_ATTACH_USE_TYPE = "MortAttachUseType";

    /**
     * 过户状态
     */
    public static final String ENUM_CAT_TRANSFERSTATUS = "VehicleMaterialStatus";
    /* ================ enum categories begin =================== */

    /* ================ business constant begin =================== */
    /**
     * 默认车牌号
     */
    public static final String BIZ_DEFAULT_LICENSEPLATENO = "";
    /* ================ business constant end =================== */

    /* ================ front end server begin ================== */
    /**
     * 前端服务器地址
     */
    public static final String FRONT_END_SERVER_ADDR = "http://121.40.89.253:9001";
    // public static final String FRONT_END_SERVER_ADDR =
    // "http://121.40.95.85:9001";
    // public static final String FRONT_END_SERVER_ADDR =
    // "http://121.40.89.253:9009";

    public static final String UNHANDLED_TASK_ADDR = "/#/dashboard/workflow/taskInst";
    /* ================ front end server end ================== */

    /* ================ Dock begin ============== */
    /**
     * 保证金比例
     */
    public static final Double DEFAULT_DEPOSIT_RATIO = 0.2;

    /**
     * 全年天数
     */
    public static final Integer DEFAULT_FULL_YEAR_DAY = 360;
    /* ================ Dock end ============== */

    /* ================ BizInfo type begin ============== */
    // 信息类型
    /**
     * 信息类型: 资金对接业务
     */
    public static final String BIZINFO_TYPE_RAISEINFO = "raiseInfo";

    /**
     * 信息类型: 车商信息
     */
    public static final String BIZINFO_TYPE_DEALERINFO = "dealerInfo";

    /**
     * 信息类型: 合同前缀
     */
    public static final String BIZINFO_TYPE_CONTRACTPREFIX = "contract-prefix";

    // 信息关键字
    /**
     * 信息关键字： 车商缩写
     */
    public static final String BIZINFO_KEY_DEALERABBR = "dealer-abbr";

    /**
     * 信息关键字： 地区
     */
    public static final String BIZINFO_KEY_AREA = "area";

    /**
     * 信息关键字： 签单
     */
    public static final String BIZINFO_KEY_SIGNING = "signing";

    /* ================ BizInfo type end ============== */
    // 常量表_业务类型
    public static final String BUSINESS_TYPE = "BUSINESS_TYPE";

    // 常量表_渠道类型
    public static final String CAPITAL_TYPE = "CAPITAL_TYPE";

    // 常量表_质抵押业务类型
    public static final String MORTGAGE_TYPE = "MORTGAGE_TYPE";

    // 常量表_性质
    public static final String NATURE = "NATURE";

    // 常量表_查封状况
    public static final String SEALED_CONDITION = "SEALED_CONDITION";

    // 常量表_车辆类型
    public static final String VEH_TYPE = "VEH_TYPE";

    // 常量表_换挡
    public static final String SHIFT = "SHIFT";

    // 常量表_空调
    public static final String AIR_CON = "AIR_CON";

    // 常量表_燃料
    public static final String FUEL = "FUEL";

    // 常量表_区域
    public static final String AREA = "AREA";

    // 常量表_NG理由
    public static final String NG_REASON = "NG_REASON";

    // 常量表_放款用途
    public static final String RELEASE_USE = "RELEASE_USE";

    // 常量表_附件类型
    public static final String ATTACH_TYPE = "ATTACH_TYPE";

    // 常量表_客户来源
    public static final String CUST_SOURCE = "CUST_SOURCE";

    // 常量表_产品类型
    public static final String PRO_TYPE = "PRO_TYPE";

    // 常量表_来源类型
    public static final String SOURCE_TYPE = "SOURCE_TYPE";

    // 常量表_流程删除原因
    public static final String PROC_DEL_REASON = "PROC_DEL_REASON";

    // 常量表_还款方式
    public static final String RPM_MET = "RPM_MET";

    // 常量表_紧急联系人关系
    public static final String EC_RLAT = "EC_RLAT";

    // 常量表_是否全部放款
    public static final String IS_ALL_RLSE = "IS_ALL_RLSE";

    // 业务状态
    public static final String BIZ_CATG = "BIZ_CATG";

    // 常量表_流水用途
    public static final String BF_USE_TYPE = "BF_USE_TYPE";

    public static final String Salesman = "Salesman";

    public static final String Veh_Detect = "Veh_Detect";

    public static final String GPS = "GPS";

    public static final String In_Store = "In_Store";

    public static final String Fin_Rlse = "Fin_Rlse";

    /**
     * 数字枚举
     * 
     * @author Abner
     */
    public static class NUMCNST {
        // 整型形式
        public final static Integer INT_ZERO = 0;
        public final static Integer INT_ONE = 1;
        public final static Integer INT_TWO = 2;
        public final static Integer INT_THREE = 3;
        public final static Integer INT_FOUR = 4;
        public final static Integer INT_FIVE = 5;
        public final static Integer INT_SIX = 6;
        public final static Integer INT_SERVEN = 7;
        public final static Integer INT_EIGNT = 8;
        public final static Integer INT_NINE = 9;
        public final static Integer INT_TEN = 10;

        // 字符串形式
        public final static String STR_ZERO = "0";
        public final static String STR_ONE = "1";
        public final static String STR_TWO = "2";
        public final static String STR_THREE = "3";
        public final static String STR_FOUR = "4";
        public final static String STR_FIVE = "5";
        public final static String STR_SIX = "6";
        public final static String STR_SEVEN = "7";
        public final static String STR_EIGHT = "8";
        public final static String STR_NINE = "9";
        public final static String STR_TEN = "10";
    }

    /**
     * 布尔枚举
     * 
     * @author Abner
     */
    public static class BOOLCNST {
        public final static Boolean TRUE = true;
        public final static Boolean FALSE = false;
    }

    public static class CHARSET_CNST {
        public final static String UTF8 = "UTF-8";
    }

    public static class PROP_TEXT_CNST {
        public final static Map<String, String> MAP = new HashMap<String, String>();

        static {
            MAP.put("M2AssetBusiness", "业务信息");
            MAP.put("M2AssetCredit", "客户征信");
            MAP.put("M2AssetCustomerAccount", "客户信息");
            MAP.put("M2AssetCustomerBasic", "客户信息");
            MAP.put("M2AssetCustomerNeeds", "客户需求");
            MAP.put("M2AssetEntryMat", "入档材料");
            MAP.put("M2AssetEvaluation", "评估");
            MAP.put("DicVehModel", "车辆模型");
            MAP.put("M2AssetFee", "费用");
            MAP.put("M2AssetFeeOther", "其他费用");
            MAP.put("M2AssetGps", "GPS");
            MAP.put("M2AssetMortgage", "合同信息");
            MAP.put("M2AssetReview", "审核信息");
            MAP.put("M2AssetVehicle", "车辆信息");
            MAP.put("M2AssetStore", "库存信息");
            MAP.put("M2fRelease", "放款信息");
            MAP.put("M2AssetTempRecv", "暂收款信息");
            MAP.put("M2fRepayment", "还款信息");
            MAP.put("M2fBusinessFlowAndId", "放款信息");

            // M2AssetBusiness
            MAP.put("M2AssetBusiness.id", "业务-编号");
            MAP.put("M2AssetBusiness.bizCatg", "业务-区分");
            MAP.put("M2AssetBusiness.businessType", "业务-类型");
            MAP.put("M2AssetBusiness.salesman", "业务-业务员");
            MAP.put("M2AssetBusiness.custServId", "业务-400客服编号");
            MAP.put("M2AssetBusiness.cusNeedsId", "业务-客户需求编号");
            MAP.put("M2AssetBusiness.custAcctId", "业务-客户账号编号");
            MAP.put("M2AssetBusiness.crId", "业务-征信编号");
            MAP.put("M2AssetBusiness.vehId", "业务-车辆编号");
            MAP.put("M2AssetBusiness.evalId", "业务-评估编号");
            MAP.put("M2AssetBusiness.mortId", "业务-合同信息编号");
            MAP.put("M2AssetBusiness.feeId", "业务-费用编号");
            MAP.put("M2AssetBusiness.entryMatId", "业务-入党编号");
            MAP.put("M2AssetBusiness.storeId", "业务-库存编号");
            MAP.put("M2AssetBusiness.area", "业务-地区");
            MAP.put("M2AssetBusiness.rlatBizId", "业务-关联业务编号");
            MAP.put("M2AssetBusiness.isExpired", "业务-是否超期");
            MAP.put("M2AssetBusiness.remark", "业务-备注");
            MAP.put("M2AssetBusiness.bizSt", "业务-业务状态");
            MAP.put("M2AssetBusiness.status", "业务-删除标记");

            // M2AssetCredit
            MAP.put("M2AssetCredit.id", "征信-编号");
            MAP.put("M2AssetCredit.isConPass", "征信-是否有效");
            MAP.put("M2AssetCredit.remark", "征信-备注");
            MAP.put("M2AssetCredit.status", "征信-删除标记");

            // M2AssetCustomerAccount
            MAP.put("M2AssetCustomerAccount.id", "客户-账户编号");
            MAP.put("M2AssetCustomerAccount.custBasicId", "客户-基本编号");
            MAP.put("M2AssetCustomerAccount.channelId", "客户-渠道编号");
            MAP.put("M2AssetCustomerAccount.mobileNo", "客户-手机号");
            MAP.put("M2AssetCustomerAccount.addr", "客户-联系地址");
            MAP.put("M2AssetCustomerAccount.coName", "客户-单位名称");
            MAP.put("M2AssetCustomerAccount.coAddr", "客户-单位地址");
            MAP.put("M2AssetCustomerAccount.bankUserName", "客户-收款账户姓名");
            MAP.put("M2AssetCustomerAccount.bank", "客户-借款收款银行");
            MAP.put("M2AssetCustomerAccount.bankAccount", "客户-借款收款银行账户");
            MAP.put("M2AssetCustomerAccount.ecPersName", "客户-紧急联系人姓名");
            MAP.put("M2AssetCustomerAccount.ecTel", "客户-紧急联系人电话");
            MAP.put("M2AssetCustomerAccount.ecRlat", "客户-紧急联系人与客户关系");
            MAP.put("M2AssetCustomerAccount.area", "客户-地区");
            MAP.put("M2AssetCustomerAccount.status", "客户-删除标记");

            // M2AssetCustomerBasic
            MAP.put("M2AssetCustomerBasic.id", "客户-编号");
            MAP.put("M2AssetCustomerBasic.name", "客户-姓名");
            MAP.put("M2AssetCustomerBasic.idcardNo", "客户-身份证号");
            MAP.put("M2AssetCustomerBasic.status", "客户-删除标记");

            // M2AssetCustomerNeeds
            MAP.put("M2AssetCustomerNeeds.id", "客户需求-编号");
            MAP.put("M2AssetCustomerNeeds.cusAcctId", "客户需求-客户账户编号");
            MAP.put("M2AssetCustomerNeeds.proId", "客户需求-客户需求产品编号");
            MAP.put("M2AssetCustomerNeeds.psyPrice", "客户需求-心理价位");
            MAP.put("M2AssetCustomerNeeds.remark", "客户需求-备注");
            MAP.put("M2AssetCustomerNeeds.status", "客户需求-删除标记");

            // M2AssetEntryMat
            MAP.put("M2AssetEntryMat.id", "入档材料-入档材料编号");
            MAP.put("M2AssetEntryMat.idCard", "入档材料-身份证");
            MAP.put("M2AssetEntryMat.temResPer", "入档材料-上海暂住证");
            MAP.put("M2AssetEntryMat.autoVehReg", "入档材料-机动车登记证");
            MAP.put("M2AssetEntryMat.autoVehDri", "入档材料-机动车行驶证");
            MAP.put("M2AssetEntryMat.keyNum", "入档材料-钥匙");
            MAP.put("M2AssetEntryMat.addTax", "入档材料-车辆购置附加税证");
            MAP.put("M2AssetEntryMat.realEstate", "入档材料-房产证");
            MAP.put("M2AssetEntryMat.purInv", "入档材料-购车发票");
            MAP.put("M2AssetEntryMat.icCard", "入档材料-机构代码证、IC卡");
            MAP.put("M2AssetEntryMat.loanCntr", "入档材料-借款合同");
            MAP.put("M2AssetEntryMat.loanAdv", "入档材料-借款咨询及管理服务协议");
            MAP.put("M2AssetEntryMat.repMan", "入档材料-还款管理服务说明书");
            MAP.put("M2AssetEntryMat.proxy", "入档材料-委托书");
            MAP.put("M2AssetEntryMat.secCarPurCon", "入档材料-二手车购买合同");
            MAP.put("M2AssetEntryMat.evalTbl", "入档材料-评估表");
            MAP.put("M2AssetEntryMat.credit", "入档材料-征信");
            MAP.put("M2AssetEntryMat.riskCtrlCfm", "入档材料-风控确认单");
            MAP.put("M2AssetEntryMat.inquiry", "入档材料-征信查询单");
            MAP.put("M2AssetEntryMat.cerRec", "入档材料-委托收款证明");
            MAP.put("M2AssetEntryMat.gpsTab", "入档材料-GPS表");
            MAP.put("M2AssetEntryMat.houCor", "入档材料-房调");
            MAP.put("M2AssetEntryMat.justice", "入档材料-公证");
            MAP.put("M2AssetEntryMat.mortCer", "入档材料-抵押凭证");
            MAP.put("M2AssetEntryMat.pleAut", "入档材料-质押凭证");
            MAP.put("M2AssetEntryMat.status", "入档材料-删除标记");

            // M2AssetEvaluation
            MAP.put("M2AssetEvaluation.id", "评估-编号");
            MAP.put("M2AssetEvaluation.vehId", "评估-车辆编号");
            MAP.put("M2AssetEvaluation.evalDate", "评估-评估时间");
            MAP.put("M2AssetEvaluation.evalPrice", "评估-评估价");
            MAP.put("M2AssetEvaluation.evalPerson", "评估-评估人员");
            MAP.put("M2AssetEvaluation.licPlaNo", "评估-牌照号");
            MAP.put("M2AssetEvaluation.colorOut", "评估-车外颜色");
            MAP.put("M2AssetEvaluation.colorIn", "评估-车内颜色");
            MAP.put("M2AssetEvaluation.annualChecked", "评估-年检到期");
            MAP.put("M2AssetEvaluation.annualValid", "评估-年检有效期");
            MAP.put("M2AssetEvaluation.accidentHistory", "评估-事故历史");
            MAP.put("M2AssetEvaluation.sealedCondition", "评估-查封状况");
            MAP.put("M2AssetEvaluation.vehSealNote", "评估-查封备注");
            MAP.put("M2AssetEvaluation.peccancyCheck", "评估-是否违章");
            MAP.put("M2AssetEvaluation.peccancyPrice", "评估-违章总罚款");
            MAP.put("M2AssetEvaluation.peccancyDeduction", "评估-违章总扣分");
            MAP.put("M2AssetEvaluation.vehPecNote", "评估-违章备注");
            MAP.put("M2AssetEvaluation.pledgeRegister", "评估-有无抵押登记");
            MAP.put("M2AssetEvaluation.nature", "评估-抵押性质");
            MAP.put("M2AssetEvaluation.registrationId", "评估-登记证书编号");
            MAP.put("M2AssetEvaluation.perIns", "评估-保险有效期");
            MAP.put("M2AssetEvaluation.validDriLic", "评估-行驶证有效期");
            MAP.put("M2AssetEvaluation.vehNature", "评估-车辆性质");
            MAP.put("M2AssetEvaluation.vehMaterial", "评估-车辆材料真伪");
            MAP.put("M2AssetEvaluation.newVehPri", "评估-新车指导价");
            MAP.put("M2AssetEvaluation.haveDlw", "评估-是否投保车损险");
            MAP.put("M2AssetEvaluation.haveCla", "评估-是否投保交强险");
            MAP.put("M2AssetEvaluation.haveCpli", "评估-是否投保车上人员责任险");
            MAP.put("M2AssetEvaluation.vehFlaw", "评估-车辆瑕疵情况");
            MAP.put("M2AssetEvaluation.autoProCer", "评估-有无产证");
            MAP.put("M2AssetEvaluation.driLic", "评估-有无行驶证");
            MAP.put("M2AssetEvaluation.airCon", "评估-空调");
            MAP.put("M2AssetEvaluation.fuel", "评估-燃料");
            MAP.put("M2AssetEvaluation.oriConPs", "评估-原装配置_方向助力");
            MAP.put("M2AssetEvaluation.oriConPw", "评估-原装配置_电动门窗");
            MAP.put("M2AssetEvaluation.oriConSr", "评估-原装配置_天窗");
            MAP.put("M2AssetEvaluation.oriConLs", "评估-原装配置_真皮座椅");
            MAP.put("M2AssetEvaluation.oriConGps", "评估-原装配置_GPS");
            MAP.put("M2AssetEvaluation.oriConTel", "评估-原装配置_电话");
            MAP.put("M2AssetEvaluation.oriConCd", "评估-原装配置_CD机");
            MAP.put("M2AssetEvaluation.oriConCdch", "评估-原装配置_多碟机");
            MAP.put("M2AssetEvaluation.oriConDvd", "评估-原装配置_DVD机");
            MAP.put("M2AssetEvaluation.oriConRke", "评估-原装配置_遥控钥匙");
            MAP.put("M2AssetEvaluation.oriConAirbag", "评估-原装配置_气囊");
            MAP.put("M2AssetEvaluation.oriConAbs", "评估-原装配置_ABS防抱死");
            MAP.put("M2AssetEvaluation.oriConAw", "评估-原装配置_铝合金轮毂");
            MAP.put("M2AssetEvaluation.oriConCcs", "评估-原装配置_定速巡航");
            MAP.put("M2AssetEvaluation.oriConEs", "评估-原装配置_电动座椅");
            MAP.put("M2AssetEvaluation.oriConHas", "评估-原装配置_电加热座椅");
            MAP.put("M2AssetEvaluation.oriConMs", "评估-原装配置_记忆座椅");
            MAP.put("M2AssetEvaluation.oriConPr", "评估-原装配置_倒车雷达");
            MAP.put("M2AssetEvaluation.oriConErm", "评估-原装配置_电动后视镜");
            MAP.put("M2AssetEvaluation.oriConCsvvs", "评估-原装配置_可视倒车影像");
            MAP.put("M2AssetEvaluation.oriConEtc", "评估-其他原装配置");
            MAP.put("M2AssetEvaluation.oriConAdd", "评估-加装配置");
            MAP.put("M2AssetEvaluation.mileage", "评估-表显里程");
            MAP.put("M2AssetEvaluation.scoOut", "评估-评分_车体外部");
            MAP.put("M2AssetEvaluation.scoIn", "评估-评分_车体内部");
            MAP.put("M2AssetEvaluation.scoFrame", "评估-评分_车骨架");
            MAP.put("M2AssetEvaluation.scoDev", "评估-评分_装置");
            MAP.put("M2AssetEvaluation.flawInundate", "评估-重大瑕疵_浸水");
            MAP.put("M2AssetEvaluation.flawHail", "评估-重大瑕疵_雹害");
            MAP.put("M2AssetEvaluation.flawCorr", "评估-重大瑕疵_距离涂改");
            MAP.put("M2AssetEvaluation.flawStoRes", "评估-重大瑕疵_失盗履历");
            MAP.put("M2AssetEvaluation.flawCom", "评估-重大瑕疵_结合");
            MAP.put("M2AssetEvaluation.vehIma", "评估-车辆印象");
            MAP.put("M2AssetEvaluation.note", "评估-备注");
            MAP.put("M2AssetEvaluation.status", "评估-删除标记");

            // DicVehModel
            MAP.put("DicVehModel.id", "车辆模型-编号");
            MAP.put("DicVehModel.parentId", "车辆模型-父级编号");
            MAP.put("DicVehModel.factory", "车辆-车辆品牌");
            MAP.put("DicVehModel.family", "车辆模型-车系");
            MAP.put("DicVehModel.remark", "车辆模型-备注");
            MAP.put("DicVehModel.status", "车辆模型-删除标记");

            // M2AssetFee
            MAP.put("M2AssetFee.id", "费用-编号");
            MAP.put("M2AssetFee.stop", "费用-停车费");
            MAP.put("M2AssetFee.peccancy", "费用-违章");
            MAP.put("M2AssetFee.gps", "费用-GPS");
            MAP.put("M2AssetFee.gpsInstall", "费用-GPS 安装费");
            MAP.put("M2AssetFee.gpsUse", "费用-GPS 使用");
            MAP.put("M2AssetFee.insPldg", "费用-保险押金");
            MAP.put("M2AssetFee.servAgcy", "费用-服务费-中介");
            MAP.put("M2AssetFee.servCo", "费用-服务费-公司");
            MAP.put("M2AssetFee.creditInvest", "费用-征信费");
            MAP.put("M2AssetFee.brokerage", "费用-佣金");
            MAP.put("M2AssetFee.brokerageCo", "费用-公司佣金");
            MAP.put("M2AssetFee.factorage", "费用-手续费");
            MAP.put("M2AssetFee.valuation", "费用-评估费");
            MAP.put("M2AssetFee.spot", "费用-实地费");
            MAP.put("M2AssetFee.mort", "费用-抵押费");
            MAP.put("M2AssetFee.other", "费用-其他");
            MAP.put("M2AssetFee.isSettle", "费用-是否付清");
            MAP.put("M2AssetFee.status", "费用-删除标记");

            // M2AssetMortgage
            MAP.put("M2AssetMortgage.id", "合同-编号");
            MAP.put("M2AssetMortgage.contractCode", "合同-合同编号");
            MAP.put("M2AssetMortgage.mortType", "合同-抵押类型");
            MAP.put("M2AssetMortgage.proId", "合同-产品编号");
            MAP.put("M2AssetMortgage.riskPrice", "合同-风控定价");
            MAP.put("M2AssetMortgage.mortAmount", "合同-抵押金额");
            MAP.put("M2AssetMortgage.provision", "合同-拨备金");
            MAP.put("M2AssetMortgage.rmngCpl", "合同-剩余本金");
            MAP.put("M2AssetMortgage.trRmngAmt", "合同-暂收款余额");
            MAP.put("M2AssetMortgage.rate", "合同-利率");
            MAP.put("M2AssetMortgage.isSettle", "合同-是否结清");
            MAP.put("M2AssetMortgage.profitLoss", "合同-盈亏状况");
            MAP.put("M2AssetMortgage.coPayment", "合同-合作付款");
            MAP.put("M2AssetMortgage.dateFrom", "合同-开始年月日");
            MAP.put("M2AssetMortgage.dateTo", "合同-结束年月日");
            MAP.put("M2AssetMortgage.monthsDays", "合同-周期");
            MAP.put("M2AssetMortgage.stoStatus", "合同-车辆入库状态");
            MAP.put("M2AssetMortgage.gpsStatus", "合同-GPS配置状态");
            MAP.put("M2AssetMortgage.remark", "合同-备注");
            MAP.put("M2AssetMortgage.status", "合同-删除标记");

            MAP.put("M2AssetMortgage.firstProvision", "合同-店长拨备金(头息使用)");
            MAP.put("M2AssetMortgage.provision", "合同-店长拨备金(非头息使用)");
            MAP.put("M2AssetMortgage.signFlag", "合同-客户签名");
            MAP.put("M2AssetMortgage.nextMonthReduceCapital", "合同-次月降本金额");

            // M2AssetVehicle
            // MAP.put("M2AssetVehicle.id", "车辆-车辆编号");
            MAP.put("M2AssetVehicle.vehModelId", "车辆-车型编号");
            MAP.put("M2AssetVehicle.vehVinCode", "车辆-车架号");
            MAP.put("M2AssetVehicle.vehEngNo", "车辆-发动机号码");
            MAP.put("M2AssetVehicle.factoryTime", "车辆-出厂时间");
            MAP.put("M2AssetVehicle.regDate", "车辆-初登日期");
            MAP.put("M2AssetVehicle.vehType", "车辆-车型");
            MAP.put("M2AssetVehicle.compressor", "车辆-排气量");
            MAP.put("M2AssetVehicle.pessagerNum", "车辆-乘车定员");
            MAP.put("M2AssetVehicle.doorNum", "车辆-车门数");
            MAP.put("M2AssetVehicle.style", "车辆-款式");
            MAP.put("M2AssetVehicle.shift", "车辆-换挡");
            MAP.put("M2AssetVehicle.status", "车辆-删除标记");

            // M2AssetStore
            MAP.put("M2AssetStore.id", "库存-库存编号");
            MAP.put("M2AssetStore.vehId", "库存-车辆编号");
            MAP.put("M2AssetStore.garageId", "库存-车库");
            MAP.put("M2AssetStore.inStoreTime", "库存-入库时间");
            MAP.put("M2AssetStore.inStoreOper", "库存-入库操作人员");
            MAP.put("M2AssetStore.outStoreTime", "库存-出库时间");
            MAP.put("M2AssetStore.outStoreOper", "库存-出库操作人员");
            MAP.put("M2AssetStore.remark", "库存-备注");
            MAP.put("M2AssetStore.status", "库存-删除标记");

            // M2fRelease
            MAP.put("M2fRelease.id", "放款-编号");
            MAP.put("M2fRelease.bizId", "放款-业务编号");
            MAP.put("M2fRelease.rlseAmt", "放款-应放金额");
            MAP.put("M2fRelease.rlseTime", "放款-放款时间");
            MAP.put("M2fRelease.isAllRlse", "放款-是否全部放完");
            MAP.put("M2fRelease.finOper", "放款-财务操作人员");
            MAP.put("M2fRelease.note", "放款-备注");
            MAP.put("M2fRelease.status", "放款-删除标记");

            // M2AssetTempRecv
            MAP.put("M2AssetTempRecv.id", "暂收款-编号");
            MAP.put("M2AssetTempRecv.bizId", "暂收款-业务编号");
            MAP.put("M2AssetTempRecv.trHandleObj", "暂收款-处理对象");
            MAP.put("M2AssetTempRecv.trType", "暂收款-暂收款类型");
            MAP.put("M2AssetTempRecv.trAmount", "暂收款-暂收款金额");
            MAP.put("M2AssetTempRecv.trTime", "暂收款-暂收时间");
            MAP.put("M2AssetTempRecv.trStatus", "暂收款-暂收款状态");
            MAP.put("M2AssetTempRecv.note", "暂收款-备注");
            MAP.put("M2AssetTempRecv.status", "暂收款-删除标记");

            // M2fRepayment
            MAP.put("M2fRepayment.id", "还款-编号");
            MAP.put("M2fRepayment.bizId", "还款-业务编号");
            MAP.put("M2fRepayment.rpyPd", "还款-期数");
            MAP.put("M2fRepayment.rpyAmt", "还款-应还金额");
            MAP.put("M2fRepayment.rpyTime", "还款-应还时间");
            MAP.put("M2fRepayment.pdCpl", "还款-当期本金");
            MAP.put("M2fRepayment.pdInt", "还款-当期利息");
            MAP.put("M2fRepayment.coInt", "还款-公司利息");
            MAP.put("M2fRepayment.intInner", "还款-息内利息");
            MAP.put("M2fRepayment.intOuter", "还款-息外利息");
            MAP.put("M2fRepayment.rpyStop", "还款-停车费");
            MAP.put("M2fRepayment.rpyGps", "还款-GPS");
            MAP.put("M2fRepayment.rpyServAgcy", "还款-服务费-中介");
            MAP.put("M2fRepayment.rpyServCo", "还款-服务费-公司");
            MAP.put("M2fRepayment.rpyOther", "还款-其他费用");
            MAP.put("M2fRepayment.isSettle", "还款-是否结清");
            MAP.put("M2fRepayment.note", "还款-备注");
            MAP.put("M2fRepayment.status", "还款-删除标记");

            // M2fBusinessFlowAndId
            MAP.put("M2fBusinessFlowAndId.id", "流水对应-编号");
            MAP.put("M2fBusinessFlowAndId.bizId", "流水对应-业务编号");
            MAP.put("M2fBusinessFlowAndId.flowId", "流水对应-流水编号");
            MAP.put("M2fBusinessFlowAndId.bfUseType", "流水对应-用途");
            MAP.put("M2fBusinessFlowAndId.bfRlatId", "流水对应-关联编号");
            MAP.put("M2fBusinessFlowAndId.bfAmt", "流水对应-对应金额");
            MAP.put("M2fBusinessFlowAndId.note", "流水对应-备注");
            MAP.put("M2fBusinessFlowAndId.status", "流水对应-删除标记");
            MAP.put("M2fBusinessFlowAndId.coAcctId", "放款-放款账户");
        }

    }

    // 拨备金id
    public static final Integer PROVISION = 0;

    // 赎回时每天停车费
    public static final BigDecimal PARKINGPERDAY = new BigDecimal(20);

    // 赎回时每天gps费
    public static final BigDecimal GPSPERDAY = new BigDecimal(20);

    // 盛大
    public static final String[] SD_ARRAY = { "SDZY", "SDSHZY", "SDXZZY" };

}
