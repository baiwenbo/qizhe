package com.fh.util.redis;
import org.apache.log4j.Logger;

import java.util.Date;

/**
 * Created by Administrator on 2015/12/10 0010.
 */
public class LogUtil {

	/**
	 * debug日志
	 */
    private static Logger debugLogger = null ;
    /**
	 * info日志
	 */
    private static Logger infoLogger = null ;
    /**
	 * warn日志
	 */
    private static Logger warnLogger = null ;
    /**
	 * error日志
	 */
    private static Logger errorLogger = null ;
    /**
	 * 还款日志
	 */
    private static Logger repaymentDebugLog = null;
    /**
	 * 代偿日志
	 */
    private static Logger compensatoryDebugLog = null;
    /**
	 * 通联接口日志
	 */
    private static Logger tongLianDebugLog = null;
    /**
	 * 追偿日志
	 */
    private static Logger recoveryDebugLog = null;

    static{
        debugLogger = Logger.getLogger("debugLog");
        infoLogger = Logger.getLogger("infoLog");
        warnLogger = Logger.getLogger("warnLog");
        errorLogger = Logger.getLogger("errorLog");
        repaymentDebugLog = Logger.getLogger("repaymentDebug");
        compensatoryDebugLog = Logger.getLogger("compensatoryDebug");
        tongLianDebugLog = Logger.getLogger("tongLianDebug");
        recoveryDebugLog = Logger.getLogger("recoveryDebug");
    }

    public static void debug(Object message){
        StackTraceElement stack[] = Thread.currentThread().getStackTrace();
        debugLogger.debug(stack[2].getClassName()+"."+stack[2].getMethodName()+"() --- Line:"+stack[2].getLineNumber()+" --- Message:"+message);
    }

    public static void info(Object message){
        StackTraceElement stack[] = Thread.currentThread().getStackTrace();
        infoLogger.info(stack[2].getClassName()+"."+stack[2].getMethodName()+"() --- Line:"+stack[2].getLineNumber()+" --- Message:"+message);
    }

    public static void warn(Object message){
        StackTraceElement stack[] = Thread.currentThread().getStackTrace();
        warnLogger.warn(stack[2].getClassName()+"."+stack[2].getMethodName()+"() --- Line:"+stack[2].getLineNumber()+" --- Message:"+message);
    }

    public static void error(Object message){
        StackTraceElement stack[] = Thread.currentThread().getStackTrace();
        errorLogger.error(stack[2].getClassName()+"."+stack[2].getMethodName()+"() --- Line:"+stack[2].getLineNumber()+" --- Message:"+message);
    }

    public static void repaymentDebugLog(Object message) {
    	StackTraceElement stack[] = Thread.currentThread().getStackTrace();
    	repaymentDebugLog.debug(stack[2].getClassName()+"."+stack[2].getMethodName()+"() --- Line:"+stack[2].getLineNumber()+" --- Message:"+message);
    }
    
    public static void compensatoryDebugLog(Object message) {
    	StackTraceElement stack[] = Thread.currentThread().getStackTrace();
    	compensatoryDebugLog.debug(stack[2].getClassName()+"."+stack[2].getMethodName()+"() --- Line:"+stack[2].getLineNumber()+" --- Message:"+message);
    }
    
    public static void tongLianDebugLog(Object message) {
    	StackTraceElement stack[] = Thread.currentThread().getStackTrace();
    	tongLianDebugLog.debug(stack[2].getClassName()+"."+stack[2].getMethodName()+"() --- Line:"+stack[2].getLineNumber()+" --- Message:"+message);
    }
    
    public static void recoveryDebugLog(Object message) {
    	StackTraceElement stack[] = Thread.currentThread().getStackTrace();
    	recoveryDebugLog.debug(stack[2].getClassName()+"."+stack[2].getMethodName()+"() --- Line:"+stack[2].getLineNumber()+" --- Message:"+message);
    }
}
