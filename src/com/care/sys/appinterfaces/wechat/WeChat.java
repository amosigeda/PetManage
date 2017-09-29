package com.care.sys.appinterfaces.wechat;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.mina.core.session.IoSession;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.care.app.MessageManager;
import com.care.common.config.ServiceBean;
import com.care.common.http.BaseAction;
import com.care.common.lang.Constant;
import com.godoing.rose.log.LogFactory;

public class WeChat extends BaseAction{
	
	Log logger = LogFactory.getLog(WeChat.class);
	  // 自定义 token
  //  private String TOKEN = "weitechao321";
    
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("UTF-8");
		String href= request.getServletPath();
		Date start = new Date();
		JSONObject json = new JSONObject();
	
		  // 微信加密签名，signature结合了开发者填写的token参数和请求中的timestamp参数、nonce参数。  
        String signature = request.getParameter("signature");  
        // 时间戳  
        String timestamp = request.getParameter("timestamp");  
        // 随机数  
        String nonce = request.getParameter("nonce");  
        // 随机字符串  
        String echostr = request.getParameter("echostr");  
  
        PrintWriter out = null;  
		
		try{
			
			  out = response.getWriter();  
	            // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，否则接入失败  
	            if (SignUtil.checkSignature(signature, timestamp, nonce)) {  
	                out.print(echostr);  
	            } 
	            
	        json.put("sianature", signature);
	        json.put("echostr", echostr);
	        json.put("timestamp", timestamp);
	        json.put("nonce", nonce);
			
	        // SHA1加密
	    //    String digest = new SHA1().getDigestOfString(bigStr.getBytes()).toLowerCase();
	       /* if (digest.equals(signature)) {
	            response.getWriter().print(echostr);
	        }*/
	        
		}catch(Exception e){
			e.printStackTrace();	
			StringBuffer sb = new StringBuffer();
			Writer writer = new StringWriter();
			PrintWriter printWriter = new PrintWriter(writer);
			Throwable cause = e.getCause();		
			while (cause != null) {
				cause.printStackTrace(printWriter);
				cause = cause.getCause();
			}
			printWriter.close();
			String resultSb = writer.toString();
			sb.append(resultSb);
			
			logger.error(e);
			result = Constant.EXCEPTION_CODE;
			json.put(Constant.EXCEPTION, sb.toString());
		}finally{
			 out.close();  
	            out = null;  
		}
		/*json.put(Constant.RESULTCODE, result);
		response.setCharacterEncoding("UTF-8");	
		response.getWriter().write(json.toString());*/	
		return null;		
	}

}
