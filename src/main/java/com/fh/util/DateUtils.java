package com.fh.util;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import org.springframework.format.datetime.DateFormatter;

public class DateUtils extends org.apache.commons.lang3.time.DateUtils {
    /**
     * 日期格式化字符串 yyyy/MM/dd
     */
    public static final String DATEFORMATTER_YYYYMMDD_1 = "yyyy/MM/dd";

    /**
     * 日期格式化字符串 yyyy-MM-dd
     */
    public static final String DATEFORMATTER_YYYYMMDD_2 = "yyyy-MM-dd";

    /**
     * 字符串转化为日期类型
     * 
     * @param value
     *            字符串数据
     * @param dateFormatter
     *            字符串格式
     * 
     * @return 日期数据
     */
    public static Date toDate(String str, String dateFormatter) {
        if (str == null || "".equals(str)) {
            return null;
        } else {
            DateFormatter format = new DateFormatter(dateFormatter);
            try {
                return format.parse(str, Locale.getDefault());
            } catch (ParseException e) {
                e.printStackTrace();
                System.out.println("has Error");
                return null;
            }
        }
    }

    /**
     * 日期类型转化为字符串类型
     * 
     * @param date
     *            日期类型
     * @param dateFormatter
     *            字符串格式
     * 
     * @return 字符串结果
     */
    public static String toString(Date date, String dateFormatter) {
        if (date == null) {
            return null;
        } else {
            DateFormatter format = new DateFormatter(dateFormatter);
            return format.print(date, Locale.getDefault());
        }
    }

    /**
     * 计算两个日期之差（按天计算）
     * 
     * @param from
     *            起始日
     * @param to
     *            终止日
     * 
     * @return 日期间距
     */
    public static int getIntervalByDay(Date from, Date to) {
        Date actualFrom = toDate(toString(from, DATEFORMATTER_YYYYMMDD_1), DATEFORMATTER_YYYYMMDD_1);
        Date actualTo = toDate(toString(to, DATEFORMATTER_YYYYMMDD_1), DATEFORMATTER_YYYYMMDD_1);
        if (actualFrom == null) {
            actualFrom = new Date();
        }
        long timeFrom = actualFrom.getTime();
        if (actualTo == null) {
            actualTo = new Date();
        }
        long timeTo = actualTo.getTime();
        return Integer.parseInt((timeTo - timeFrom) / 1000 / 60 / 60 / 24 + "");
    }

    public static long getIntervalByDayNew(Date from, Date to) {
        Date actualFrom = toDate(toString(from, DATEFORMATTER_YYYYMMDD_1), DATEFORMATTER_YYYYMMDD_1);
        Date actualTo = toDate(toString(to, DATEFORMATTER_YYYYMMDD_1), DATEFORMATTER_YYYYMMDD_1);
        if (actualFrom == null) {
            actualFrom = new Date();
        }
        long timeFrom = actualFrom.getTime();
        if (actualTo == null) {
            actualTo = new Date();
        }
        long timeTo = actualTo.getTime();
        return (timeTo - timeFrom) / 1000 / 60 / 60 / 24;
    }

    /**
     * 计算日期（按月计算）
     * 
     * @param from
     *            起始日
     * @param months
     *            经过月数
     * 
     * @return 日期
     */
    public static Date getToDay(Date from, Integer months) {
        Date actualFrom = toDate(toString(from, DATEFORMATTER_YYYYMMDD_1), DATEFORMATTER_YYYYMMDD_1);
        Calendar calender = Calendar.getInstance();
        calender.setTime(actualFrom);
        calender.add(Calendar.MONTH, months);
        return calender.getTime();
    }

    /**
     * 功能：得到当前月份月底 格式为：xxxx-yy-zz (eg: 2007-12-31)
     * 
     * @return String
     * @author pure
     **/
    public static Date thisMonthEnd(String date) {
        Date thisMonth = toDate(date, DATEFORMATTER_YYYYMMDD_2);
        Calendar calender = Calendar.getInstance();
        calender.setTime(thisMonth);
        String strY = null;
        String strZ = null;
        boolean leap = false;
        int x = calender.get(Calendar.YEAR);
        int y = calender.get(Calendar.MONTH) + 1;
        if (y == 1 || y == 3 || y == 5 || y == 7 || y == 8 || y == 10 || y == 12) {
            strZ = "31";
        }
        if (y == 4 || y == 6 || y == 9 || y == 11) {
            strZ = "30";
        }
        if (y == 2) {
            leap = leapYear(x);
            if (leap) {
                strZ = "29";
            } else {
                strZ = "28";
            }
        }
        strY = y >= 10 ? String.valueOf(y) : ("0" + y);
        return toDate(x + "-" + strY + "-" + strZ, DATEFORMATTER_YYYYMMDD_2);
    }

    /**
     * 功能：判断输入年份是否为闰年<br>
     * 
     * @param year
     * @return 是：true 否：false
     * @author pure
     */
    public static boolean leapYear(int year) {
        boolean leap;
        if (year % 4 == 0) {
            if (year % 100 == 0) {
                if (year % 400 == 0)
                    leap = true;
                else
                    leap = false;
            } else
                leap = true;
        } else
            leap = false;
        return leap;
    }

}
