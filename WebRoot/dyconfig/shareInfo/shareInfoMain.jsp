<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<%@ page autoFlush="true"%>
<%
	/*ҳ������*/
	PagePys pys = (PagePys) request.getAttribute("PagePys");
	LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER); 
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<title>�ޱ����ĵ�</title>
		<link href="<%=request.getContextPath()%>/css/tbls.css"
			rel="stylesheet" type="text/css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/public.js"></script>   <!-- ���ô˷��� -->
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
	</head>
	<script language="javascript">
function finds(){
   /*  var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
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
                ������Ϣ
                </th>
                </tr>
                 <tr class="title_3">
                       <td colspan="13">
					 <%--  ����ʱ��
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>	 --%>					
						IMEI
						 <input id="device_imei" name="device_imei" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"device_imei");%>" size="15">
					<%-- 	�û��ֻ���
						 <input id="userName" name="userName" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"userName");%>" size="9">
						�����û��ֻ���
						 <input id="toUserName" name="toUserName" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"toUserName");%>" size="9">
                                                    ��Ŀ��
						<%String projectId = (String)request.getAttribute("projectId"); %>			
							<select id="projectId" name="projectId" >
								<option value="">ȫ��</option>
								<logic:iterate id="pro" name="project">
									<bean:define id="project" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=project %>' <%=String.valueOf(project).equals(projectId)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select> --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="�� ��" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="�������" onclick="c()">
				</tr> 
				<%int i=1; %>
                  <tr class="title_2">                 	
                  	<td width="12%" >�豸IMEI</td>
                  	<td width="8%" >������</td>
                  	<td width="8%" >�������û�</td>                                 	                 	
                  	<td width="8%" >�Ƿ������豸</td>                                 	                 	
                  	<td width="12%" >����ʱ��</td>   						 
                  	<td width="12%" >�����Ƿ�ͬ��</td>   						 
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >						
						<td><bean:write name="element" property="device_imei"/></td>
						<td><bean:write name="element" property="email"/></td>
						<td><bean:write name="element" property="emaill"/></td>
						<td>
							<logic:equal name="element" property="is_priority" value="0">��</logic:equal>
							<logic:equal name="element" property="is_priority" value="1"><font color="green">��</font></logic:equal>
						</td>
						<td><bean:write name="element" property="share_date" format="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
						<logic:equal name="element" property="status" value="0">�ȴ�</logic:equal>
						<logic:equal name="element" property="status" value="1"><font color="green">��Ч</font></logic:equal>
						<logic:equal name="element" property="status" value="2">����</logic:equal>
						<logic:equal name="element" property="status" value="3"><font color="red">�ܾ�</font></logic:equal>
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