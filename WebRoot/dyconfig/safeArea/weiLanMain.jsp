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
	}
	var safeRange1 = document.getElementById("safeRange1").value;
	var safeRange2 = document.getElementById("safeRange2").value;
	if(safeRange1 > safeRange2){
		alert("��ʼ��Χ���ܴ��ڽ�����Χ");
		return false;
	} */
	   frmGo.submit();
}
function c(){
    document.all.device_imei.value="";
  /*   document.all.startTime.value="";
    document.all.endTime.value="";
    document.all.safeRange1.value="";
    document.all.safeRange2.value="";
    document.all.userName.value="";
    document.all.belongProject.value=""; */
} 

</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doSafeArea.do?method=querySafeArea">			
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="25" nowrap="nowrap" align="left">
                                           ��ȫ������Ϣ
                </th>
                </tr>            		
                 <tr class="title_3">
                       <td colspan="25">
                    <%--    IMEI				
						    <input id="device_imei" name="device_imei" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"device_imei");%>" size="20"> --%>
					<%--   ����ʱ��
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>
						
						��Χ				
						    <input id="safeRange1" name="safeRange1" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"safeRange1");%>" size="7">
						-				
						    <input id="safeRange2" name="safeRange2" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"safeRange2");%>" size="7">m
						 ��Ŀ
						 <%String belongProject = (String)request.getAttribute("belongProject"); %>			
							<select id="belongProject" name="belongProject" >
								<option value="">ȫ��</option>
								<logic:iterate id="pro" name="project_name">
									<bean:define id="projectId" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=projectId %>' <%=String.valueOf(projectId).equals(belongProject)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select>
						 �û��ֻ���
						  <input id="userName" name="userName" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"userName");%>" size="9"> --%>
						<!-- <input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="�� ��" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="�������" onclick="c()"> -->
				</tr> 
                  <tr class="title_2">     
                  	<td width="5%">id</td>  
                  	<td width="5%">Χ������</td>  
                  	<td width="5%">Χ��γ��</td>  
                  	<td width="5%">�뾶(��)</td>  
                  	<td width="5%">��ȫ��������</td>  
                  	<td width="5%">��Чʱ��</td>  
                  	<td width="5%">�Ƿ񼤻�</td>  
                  	<td width="5%">�Ƿ���Ҫ���û�����</td>  
                  	<td width="5%">�豸id</td>  
                  	<td width="5%">Χ�����ĵ�ַ����</td>  
                  	<td width="5%">����Χ������</td>  
                  	<td width="5%">flag</td>  
				</tr>

				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
						<td>
								<bean:write name="element" property="id" />
						</td>
						<td>
								<bean:write name="element" property="center_gps_lo" />
						</td>
						<td>
								<bean:write name="element" property="center_gps_la" />
						</td>
						<td>
								<bean:write name="element" property="round_distance" />
						</td>
						<td>
								<bean:write name="element" property="device_safe_namee" />
						</td>
						<td>
								<bean:write name="element" property="device_safe_effect_time" />
						</td>
						<td>
								<bean:write name="element" property="if_active" />
						</td>
						
						<td>
								<bean:write name="element" property="if_prompt_user" />
						</td>
						
						<td>
								<bean:write name="element" property="device_id" />
						</td>
						<td>
								<bean:write name="element" property="center_addr" />
						</td>
						
						<td>
						<logic:equal name="element" property="safe_type" value="0">��ȫ����</logic:equal>
						<logic:equal name="element" property="safe_type" value="1"><font color="red">Σ������</font></logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="flag" value="0">��ʼ״̬</logic:equal>
						<logic:equal name="element" property="flag" value="1">�ڴ�����</logic:equal>
						<logic:equal name="element" property="flag" value="2">���ڴ�����</logic:equal>
						</td>
												
				
							<%-- <td>
								<logic:equal name="element" property="ufirm_stat" value="0">������</logic:equal>
						<logic:equal name="element" property="ufirm_stat" value="1"><font color="green">����</font></logic:equal>
						</td> --%>
								 						
					</tr>
				</logic:iterate> 

			  	<tr class="title_3">
					<td colspan="25" align="left" >  
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>  
			</table>
		</form>
	</body>
</html>