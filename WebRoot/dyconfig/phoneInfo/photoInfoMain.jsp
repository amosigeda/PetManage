<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ page import="com.godoing.rose.lang.*"%>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<%@ page autoFlush="true"%>
<%
	/*页面属性*/
	PagePys pys = (PagePys) request.getAttribute("PagePys");
	int count = 1;	
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>无标题文档</title>
		<link href="<%=request.getContextPath()%>/css/tbls.css"
			rel="stylesheet" type="text/css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/public.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" 
           src="<%=request.getContextPath()%>/js/jquery-3.1.1.min.js" ></script>
<script type="text/javascript" 
            src="<%=request.getContextPath()%>/js/layer.js" ></script>
	</head>
	<script language="javascript">
	
	
	
function finds(){
	   frmGo.submit();
}

function c(){
    document.all.imei.value="";
    document.all.nick_name.value="";
}
function update(id){
	frmGo.action="doFeedBackInfo.do?method=initFeedBackInfoUpdate&id="+id;
	frmGo.submit();
}
function del(id){
		if(confirm("确定删除吗?"))
		{
			frmGo.action = "doFeedBackInfo.do?method=deleteFeedBackInfo&id="+id+" ";
			frmGo.submit();
		}
}




</script>
	<body>
		<form name="frmGo" method="post" action="doPhoneInfo.do?method=queryDevicePhoto">
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="13" nowrap="nowrap" align="left">
                                                            宠物照片
                </th>
                </tr>
                   <tr class="title_3">			
				    <td colspan="13">
				    	
						imei
						    <input id="imei" name="imei" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"imei");%>" size="20">
						    昵称
						    <input id="nick_name" name="nick_name" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"nick_name");%>" size="20">
					
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="搜 索" onclick="javascript:finds()">
							 <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="清除搜索" onclick="c()">
						</td>					
				</tr>
                 <tr class="title_2">                 	
                    <td width="4%">设备IMEI</td>
					<td width="10%">设备昵称</td>	
					<td width="8%"> 图片</td>	
					<td width="8%">上传时间</td>	
																	
				</tr>
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >					 							
						<td>
							<bean:write name="element" property="device_imei" />
						</td>
					
						<td>
							<bean:write name="element" property="device_name" />
						</td>
						
						<td>
						<img src="<%=request.getContextPath()%>/ccd.png"></img>
						</td>
						
						<td>
							<bean:write name="element" property="up_time" format="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
				</logic:iterate>
				
				<tr class="title_3">			
					<td colspan="8" align="left">
					  <% 
					  pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>
				
			</table>
		</form>
	</body>
</html>
