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
    document.all.device_imei.value="";
   /*  document.all.startTime.value="";
    document.all.endTime.value="";
    document.all.userName.value="";
    document.all.toUserName.value="";
    document.all.projectId.value=""; */
} 

</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doShareInfo.do?method=queryShareInfo">
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="12" nowrap="nowrap" align="left">
                分享信息
                </th>
                </tr>
                 <tr class="title_3">
                       <td colspan="13">
					 <%--  分享时间
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>	 --%>					
						IMEI
						 <input id="device_imei" name="device_imei" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"device_imei");%>" size="15">
					<%-- 	用户手机号
						 <input id="userName" name="userName" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"userName");%>" size="9">
						分享用户手机号
						 <input id="toUserName" name="toUserName" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"toUserName");%>" size="9">
                                                    项目名
						<%String projectId = (String)request.getAttribute("projectId"); %>			
							<select id="projectId" name="projectId" >
								<option value="">全部</option>
								<logic:iterate id="pro" name="project">
									<bean:define id="project" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=project %>' <%=String.valueOf(project).equals(projectId)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select> --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="搜 索" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="清除搜索" onclick="c()">
				</tr> 
				<%int i=1; %>
                  <tr class="title_2">                 	
                  	<td width="12%" >设备IMEI</td>
                  	<td width="8%" >分享人</td>
                  	<td width="8%" >被分享用户</td>                                 	                 	
                  	<td width="8%" >是否是主设备</td>                                 	                 	
                  	<td width="12%" >分享时间</td>   						 
                  	<td width="12%" >主人是否同意</td>   						 
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >						
						<td><bean:write name="element" property="device_imei"/></td>
						<td><bean:write name="element" property="email"/></td>
						<td><bean:write name="element" property="emaill"/></td>
						<td>
							<logic:equal name="element" property="is_priority" value="0">否</logic:equal>
							<logic:equal name="element" property="is_priority" value="1"><font color="green">是</font></logic:equal>
						</td>
						<td><bean:write name="element" property="share_date" format="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
						<logic:equal name="element" property="status" value="0">等待</logic:equal>
						<logic:equal name="element" property="status" value="1"><font color="green">有效</font></logic:equal>
						<logic:equal name="element" property="status" value="2">脱落</logic:equal>
						<logic:equal name="element" property="status" value="3"><font color="red">拒绝</font></logic:equal>
						</td>
					</tr>
				</logic:iterate> 

			  	<tr class="title_3">
					<td colspan="12" align="left" >  
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>  
			</table>
		</form>
	</body>
</html>