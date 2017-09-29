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
    /* var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("开始时间不能大于结束时间!");
		return false;
	} */
	   frmGo.submit();
}
	function c(){
		document.all.iccid.value="";
    /* 	document.all.endTime.value="";
   		document.all.userName.value="";   
   		document.all.projectId.value="";    */
	} 
	function deletePhoneInfo(id,status,company){
		var a=status;
		if(a==1){
			if(confirm("确定暂停吗？")){
				frmGo.action="doSaleInfo.do?method=operatorSimStatus&id="+id+"&status="+status+"&company="+company+"";
				frmGo.submit();
			}
		}else if(a==0){
			if(confirm("确定激活吗？")){
				frmGo.action="doSaleInfo.do?method=operatorSimStatus&id="+id+"&status="+status+"&company="+company+"";
				frmGo.submit();
			}
		}
	}

	</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doSaleInfo.do?method=querySimInfo">						
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="14" nowrap="nowrap" align="left">
                                          sim卡信息
                </th>
                </tr>            
                 <tr class="title_3">
                       <td colspan="14">	
                                                        <%--    新增时间
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>		 --%>		
						ICCID				
						    <input id="iccid" name="iccid" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"iccid");%>" size="25">
						
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
                  
                  	<td width="10%" >ICCID</td>
                  	<td width="10%" >IMSI</td>
                  	<td width="10%" >新增时间</td>                           						 
                  	<!-- <td width="10%" >更新时间</td>   --> 
                  		<td width="5%" >状态</td> 
                  	<td width="5%" >公司</td>       
                  		<td width="5%" >操作</td>     	
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
						<td>
						<logic:empty name="element" property="iccid">无</logic:empty>
						<logic:notEmpty name="element" property="iccid">						  
						     <bean:write name="element" property="iccid"/>
						     </logic:notEmpty>
						</td>						
						<td>
							<logic:empty name="element" property="imsi">无</logic:empty>
						<logic:notEmpty name="element" property="imsi">						  
						     <bean:write name="element" property="imsi"/>
						     </logic:notEmpty>
						</td>
						
						<td>
							<logic:empty name="element" property="create_time">无</logic:empty>
						<logic:notEmpty name="element" property="create_time">						  
						     <bean:write name="element" property="create_time" format="yyyy-MM-dd HH:mm:ss"/>
						     </logic:notEmpty>
						</td>
						<%-- <td>
							<logic:empty name="element" property="update_time">无</logic:empty>
						<logic:notEmpty name="element" property="update_time">						  
						     <bean:write name="element" property="update_time" format="yyyy-MM-dd HH:mm:ss"/>
						     </logic:notEmpty>
						</td> --%>
						
						<td>
							<logic:empty name="element" property="card_status">无</logic:empty>
						<logic:notEmpty name="element" property="card_status">	
						<logic:equal name="element" property="card_status" value="0"><font color="red">未激活</font></logic:equal>
						   		<logic:equal name="element" property="card_status" value="1"><font color="green">激活</font></logic:equal>
						     </logic:notEmpty>
						</td>
						
							<td>
							<logic:empty name="element" property="belong_company">无</logic:empty>
						<logic:notEmpty name="element" property="belong_company">						  
						<logic:equal name="element" property="belong_company" value="1">爱施德</logic:equal>
						   	<logic:equal name="element" property="belong_company" value="2">树米</logic:equal>
						    <%--  <bean:write name="element" property="belong_company"/> --%>
						     </logic:notEmpty>
						</td>
						
						
							<td>
						<a href=#
						onclick="deletePhoneInfo('<bean:write name="element" property="iccid" />','0','<bean:write name="element" property="belong_company" />')"
						style="color:#0000FF">
						<logic:equal name="element" property="card_status"
							value="0">激活
							</logic:equal> 
							</a>
							
								<a href=#
						onclick="deletePhoneInfo('<bean:write name="element" property="iccid" />','1','<bean:write name="element" property="belong_company" />')"
						style="color:#0000FF">
							<logic:equal name="element"
							property="card_status" value="1">暂停</logic:equal>
							
							</a>
						</td>
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