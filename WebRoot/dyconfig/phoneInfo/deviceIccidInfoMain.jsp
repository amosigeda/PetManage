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
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet"
	type="text/css">
<script language="JavaScript"
	src="<%=request.getContextPath()%>/public/public.js"></script>
<!-- ���ô˷��� -->
<script language="JavaScript"
	src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
</head>
<script language="javascript">
function finds(){
  /*   var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
		return false;
	} */
	   frmGo.submit();
}
function c(){
    document.all.serieNo.value="";
    document.all.iccid.value="";
   
} 
function addimei(){
	frmGo.action="doPhoneInfo.do?method=initInsert";
	frmGo.submit();
}

function deletePhoneInfo(id,status,company){
	var a=status;
	if(a==1){
		if(confirm("ȷ����ͣ��")){
			frmGo.action="doPhoneInfo.do?method=operatorSimStatus&id="+id+"&status="+status+"&company="+company+"";
			frmGo.submit();
		}
	}else if(a==0){
		if(confirm("ȷ��������")){
			frmGo.action="doPhoneInfo.do?method=operatorSimStatus&id="+id+"&status="+status+"&company="+company+"";
			frmGo.submit();
		}
	}
}


function unbindIccid(imei){
		if(confirm("��ȷ�������")){
			frmGo.action="doPhoneInfo.do?method=unbindIccid&imei="+imei+" ";
			frmGo.submit();
		}
	
}
</script>
<body>
	<span class="title_1"></span>
	<form name="frmGo" method="post"
		action="doPhoneInfo.do?method=queryDeviceIccid">
		<table width="100%" class="table" border=0 cellpadding="0"
			cellspacing="1">
			<tr>
				<th colspan="50" nowrap="nowrap" align="left">ICCID��IMEI����Ϣ <!-- <input
					name="addDevice" type="button" class="but_1" accesskey="a"
					tabindex="a" value="�� ��" onclick="addimei()"> -->
				</th>
			</tr>
			<tr class="title_3">
				<td colspan="50">
					<%-- 	  ����ʱ��
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>			 --%>
								 IMEI <input id="serieNo"
					name="serieNo" type="text" class="txt_1"
					value="<%CommUtils.printReqByAtt(request,response,"serieNo");%>"
					size="20"> 
					
						 ICCID <input id="iccid"
					name="iccid" type="text" class="txt_1"
					value="<%CommUtils.printReqByAtt(request,response,"iccid");%>"
					size="20">
					
					<%-- 	״̬<%if(request.getAttribute("status") != null && !"".equals(request.getAttribute("status"))){%>
						<%=request.getAttribute("status")%>
						<%}else{ %>
						<select id="status" name="status">
							<option value="">ȫ��</option>
							<option value="0">¼��</option>
							<option value="1">����</option>
							<option value="2">��</option>
							<option value="3"> </option>
						</select>
						<%} %>
						
						����<%if(request.getAttribute("type") != null && !"".equals(request.getAttribute("type"))){%>
						<%=request.getAttribute("type")%>
						<%}else{ %>
						<select id="type" name="type">
							<option value="">ȫ��</option>
							<option value="1">����</option>
							<option value="2">����</option>
						</select>
						<%} %> --%> <input name="find1" type="button" class="but_1"
					accesskey="f" tabindex="f" value="�� ��" onclick="javascript:finds()">
					<input name="clear" type="button" class="but_1" accesskey="c"
					tabindex="c" value="�������" onclick="c()">
			</tr>
			<%int i=1; %>
			<tr class="title_2">
				<td width="7%">IMEI</td>
				<td width="5%">ICCID</td>
				<!-- <td width="5%">FriendLyName</td>
				<td width="5%">sid</td>
				<td width="5%">RATE_PLAN</td> -->
				<td width="7%">�Ƿ񼤻�</td>
				<td width="7%">��˾</td>
				<!-- <td width="5%">����ʱ��</td>
				<td width="5%">����ʱ��</td> -->
				<td width="5%">����</td>
			</tr>

			<logic:iterate id="element" name="pageList">
				<tr class="tr_5" onmouseover='this.className="tr_4"'
					onmouseout='this.className="tr_5"'>
					<td><logic:empty name="element" property="device_imei">��</logic:empty>
						<logic:notEmpty name="element" property="device_imei">
							<%-- <a style="color: #0000FF"
								href="../deviceActiveInfo/doDeviceActiveInfo.do?method=queryDeviceActiveInfo&device_imei=<bean:write name="element" property="device_imei" />">
								 --%><bean:write name="element" property="device_imei" />
						<!-- 	</a> -->
						</logic:notEmpty></td>

					<td><logic:empty name="element" property="iccid">��</logic:empty>
						<logic:notEmpty name="element" property="iccid">
							<bean:write name="element" property="iccid" />
						</logic:notEmpty></td>
<%-- 
					<td><logic:empty name="element" property="friendly_name">��</logic:empty>
						<logic:notEmpty name="element" property="friendly_name">
							<bean:write name="element" property="friendly_name" />
						</logic:notEmpty></td>


					<td><logic:empty name="element" property="sid">��</logic:empty>
						<logic:notEmpty name="element" property="sid">
							<bean:write name="element" property="sid" />
						</logic:notEmpty></td>

					<td><logic:empty name="element" property="rate_plan">��</logic:empty>
						<logic:notEmpty name="element" property="rate_plan">
							<bean:write name="element" property="rate_plan" />
						</logic:notEmpty></td> --%>

					<td><logic:equal name="element" property="card_status"
							value="0"><font color="red">��</font></logic:equal> 
							<logic:equal name="element"
							property="card_status" value="1"><font color="green">��</font></logic:equal>
							<logic:equal name="element"
							property="card_status" value="">��</logic:equal>
							</td>
							
							
								<td><logic:equal name="element" property="belong_company"
							value="0">twilio</logic:equal> 
							<logic:equal name="element"
							property="belong_company" value="1">��ʩ��</logic:equal>
								<logic:equal name="element"
							property="belong_company" value="2">����</logic:equal>
								<logic:equal name="element"
							property="belong_company" value="">��</logic:equal>
							</td>

				<%-- 	<td><logic:empty name="element" property="create_time">��</logic:empty>
						<logic:notEmpty name="element" property="create_time">
							<bean:write name="element" property="create_time" />
						</logic:notEmpty></td>
					<td><logic:empty name="element" property="update_time">��</logic:empty>
						<logic:notEmpty name="element" property="update_time">
							<bean:write name="element" property="update_time" />
						</logic:notEmpty></td> --%>

				<%-- 	<td><a href=#
						onclick="deletePhoneInfo('<bean:write name="element" property="device_id" />')"
						style="color:#0000FF"> ��ɾ����</a></td> --%>
						
						<td>
						<a href=#
						onclick="deletePhoneInfo('<bean:write name="element" property="iccid" />','0','<bean:write name="element" property="belong_company" />')"
						style="color:#0000FF">
						<logic:equal name="element" property="card_status"
							value="0">�����
							</logic:equal> 
							</a>
							
								<a href=#
						onclick="deletePhoneInfo('<bean:write name="element" property="iccid" />','1','<bean:write name="element" property="belong_company" />')"
						style="color:#0000FF">
							<logic:equal name="element"
							property="card_status" value="1">����ͣ��</logic:equal>
							</a>
							<logic:equal name="element"
							property="card_status" value="">���ޡ�</logic:equal>
							
							<a href=#
						onclick="unbindIccid('<bean:write name="element" property="device_imei" />')"
						style="color:#0000FF">
					����� 
							</a>
							
						</td>

				</tr>
			</logic:iterate>

			<tr class="title_3">
				<td colspan="50" align="left">
					<%
							pys.printGoPage(response, "frmGo");
						%>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>