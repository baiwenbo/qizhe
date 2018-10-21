package com.fh.util;

/**
 * Title: 银行卡校验工具类<br/>
 * Description: 通过Luhn算法来验证通过。<br/>
 * <ol>
 * 该校验的过程：
 * <li>从卡号最后一位数字开始，逆向将奇数位(1、3、5等等)相加。</li>
 * <li>从卡号最后一位数字开始，逆向将偶数位数字，先乘以2（如果乘积为两位数，则将其减去9），再求和。</li>
 * <li>将奇数位总和加上偶数位总和，结果应该可以被10整除。</li>
 * </ol>
 * Copyrignt: Copyright(c) 2015 by www.motor2.cn<br/>
 * Company: 上海安美途金融信息服务有限公司
 * 
 * @author M2
 * @version V1.0.0
 * @since 2016-01-14 14:31:19
 */
public class CheckBankCard {
    /**
     * 校验银行卡卡号
     * 
     * @param cardId
     * @return
     */
    public static boolean checkBankCard(String cardId) {
        char bit = getBankCardCheckCode(cardId.substring(0, cardId.length() - 1));
        if (bit == 'N') {
            return false;
        }
        return cardId.charAt(cardId.length() - 1) == bit;
    }

    /**
     * 从不含校验位的银行卡卡号采用 Luhm 校验算法获得校验位
     * 
     * @param nonCheckCodeCardId
     * @return
     */
    public static char getBankCardCheckCode(String nonCheckCodeCardId) {
        if (nonCheckCodeCardId == null || nonCheckCodeCardId.trim().length() == 0
                || !nonCheckCodeCardId.matches("\\d+")) {
            // 如果传的不是数据返回N
            return 'N';
        }
        char[] chs = nonCheckCodeCardId.trim().toCharArray();
        int luhmSum = 0;
        for (int i = chs.length - 1, j = 0; i >= 0; i--, j++) {
            int k = chs[i] - '0';
            if (j % 2 == 0) {
                k *= 2;
                k = k / 10 + k % 10;
            }
            luhmSum += k;
        }
        return (luhmSum % 10 == 0) ? '0' : (char) ((10 - luhmSum % 10) + '0');
    }
}
