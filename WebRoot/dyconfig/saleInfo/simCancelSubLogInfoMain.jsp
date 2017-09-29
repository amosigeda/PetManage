<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<%@ page autoFlush="true"%>
<%
	/*页面属性*/
	PagePys pys = (PagePys) request.getAttribute("PagePys");
	LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER); 
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>无标题文档</title>
		<link href="<%=request.getContextPath()%>/css/tbls.css"
			rel="stylesheet" type="text/css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/public.js"></script>   <!-- 调用此方法 -->
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
	</head>
	<script language="javascript">
	function finds(){
   /*  var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("开始时间不能大于结束时间!");
		return false;
	} */
	   frmGo.submit();
}
	function c(){
		document.all.imei.value="";
    	/* document.all.endTime.value="";
   		document.all.userName.value="";   
   		document.all.projectId.value="";  */  
	} 

	//修改账户				
	function update(id)
	{
		frmGo.action="doSaleInfo.do?method=initUpdate&id="+id;
		frmGo.submit();
	}
	
	</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doSaleInfo.do?method=queryCancelSubLogInfo">						
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="14" nowrap="nowrap" align="left">
                                          sim卡订阅信息
                </th>
                </tr>            
                 <tr class="title_3">
                       <td colspan="14">	
                                         <%--                   新增时间
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>	 --%>			
						imei				
						    <input id="imei" name="imei" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"imei");%>" size="20">
						
				<%-- 	项目名		
						<%String projectId = (String)request.getAttribute("projectId"); %>			
							<select id="projectId" name="projectId" >
								<option value="">全部</option>
								<logic:iterate id="pro" name="project">
									<bean:define id="project" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=project %>' <%=String.valueOf(project).equals(projectId)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select>		 --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="搜 索" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="清除搜索" onclick="c()">
				</tr> 
                  <tr class="title_2">     
                  	<td width="10%">IMEI</td> 
                  	<td width="10%" >操作时间</td>
                  	<td width="10%" >到期时间</td>
                  	<td width="10%" >acvtive</td>
                  	           	
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
						<td>
						<logic:empty name="element" property="imei">无</logic:empty>
						<logic:notEmpty name="element" property="imei">						  
						     <bean:write name="element" property="imei"/>
						     </logic:notEmpty>
						</td>	
						
						<%-- 	<td>
						<logic:empty name="element" property="iccid">无</logic:empty>
						<logic:notEmpty name="element" property="iccid">						  
						     <bean:write name="element" property="iccid"/>
						     </logic:notEmpty>
						</td>	 --%>
						
						<td>
							<logic:empty name="element" property="date_time">无</logic:empty>
						<logic:notEmpty name="element" property="date_time">						  
						     <bean:write name="element" property="date_time" format="yyyy-MM-dd HH:mm:ss"/>
						     </logic:notEmpty>
						</td>
											
						<%-- <td>
							<logic:empty name="element" property="card_status">无</logic:empty>
						<logic:notEmpty name="element" property="card_status">						  
						     <bean:write name="element" property="card_status"/>
						     </logic:notEmpty>
						</td>
						
							<td>
							<logic:empty name="element" property="customer_id">无</logic:empty>
						<logic:notEmpty name="element" property="customer_id">						  
						     <bean:write name="element" property="customer_id"/>
						     </logic:notEmpty>
						</td>
						
						<td>
							<logic:empty name="element" property="subscription_id">无</logic:empty>
						<logic:notEmpty name="element" property="subscription_id">						  
						     <bean:write name="element" property="subscription_id"/>
						     </logic:notEmpty>
						</td>
						 --%>
						<td>
							<logic:empty name="element" property="stop_time">无</logic:empty>
						<logic:notEmpty name="element" property="stop_time">						  
						     <bean:write name="element" property="stop_time" format="yyyy-MM-dd"/>
						     </logic:notEmpty>
					 </td>
					 
					 	<td>
							<logic:empty name="element" property="message">无</logic:empty>
						<logic:notEmpty name="element" property="message">						  
						     <bean:write name="element" property="message"/>
						     </logic:notEmpty>
					 </td>
							
							
							
							<%--	<td align="center">
							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > 【配置】</a>						
						</td> --%>
						
					
					</tr>
				</logic:iterate> 


			  	<tr class="title_3">
					<td colspan="14" align="left" >  
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>  
			</table>
		</form>
	</body>
</html>