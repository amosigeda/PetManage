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
    var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
		return false;
	}
	   frmGo.submit();
}
function c(){
    document.all.startTime.value="";
    document.all.endTime.value="";
    document.all.serieNo.value="";
    document.getElementById("status").options[0].selected=true;
     document.getElementById("type").options[0].selected=true;
} 
function addimei(){
	frmGo.action="doPhoneInfo.do?method=initInsert";
	frmGo.submit();
}

function deletePhoneInfo(id){
	if(confirm("ȷ��ɾ����")){
		frmGo.action="doPhoneInfo.do?method=deletePhoneInfo&id="+id+" ";
		frmGo.submit();
	}
}
function deactivatePhoneInfo(id){
	if(confirm("ȷ�������")){
		frmGo.action="doPhoneInfo.do?method=deactivatePhoneInfo&id="+id+" ";
		frmGo.submit();
	}
}

				
function update(id)
{
	frmGo.action="doPhoneInfo.do?method=initUpdate&id="+id;
	frmGo.submit();
}
</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post"
			action="doPhoneInfo.do?method=queryPhoneInfo">
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="50" nowrap="nowrap" align="left">
                IMEI��Ϣ
                <input name="addDevice" type="button" class="but_1" accesskey="a"
							tabindex="a" value="�� ��" onclick="addimei()">
                </th>
                </tr>
                 <tr class="title_3">
                       <td colspan="50">
					  ����ʱ��
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>						
						IMEI
						 <input id="serieNo" name="serieNo" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"serieNo");%>" size="15">
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
						<%} %> --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="�� ��" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="�������" onclick="c()">
				</tr> 
				<%int i=1; %>
                  <tr class="title_2">                 	
                  	<td width="7%" >IMEI</td>
                  	<td width="7%" >ICCID</td>
                  	<td width="5%" >PHONE</td>
                  	<td width="5%" >��Ŀ</td>
                  	<td width="5%" >״̬</td>                  	                                   	                 	
                  	<td width="10%">����ʱ��</td>
                  	<td width="5%" >�󶨴���</td>                      						 
                  	<td width="5%" >�豸����</td>                      						 
                  	<td width="5%" >Ʒ������</td>                      						 
                  	<td width="5%" >������</td>                      						 
                  	<td width="5%" >�豸����</td>                      						 
                  	<td width="5%" >��������</td>                      						 
                  	<td width="5%" >GPS����</td>                      						 
                  	<td width="5%" >������������</td>                      						 
                  	<td width="5%" >���¼�⿪��</td>                      						 
                  	<td width="5%" >�����¶ȼ�⿪��</td>                      						 
                  	<td width="5%" >�ƹ���ƿ���</td>                      						 
                  	<td width="5%" >����ģʽ״̬</td>                      						 
                  	<td width="5%" >Ѱ��ģʽ״̬</td>                      						 
                  	<td width="5%" >�ն˵�ص���</td>                      						 
                  	<td width="5%" >�����Ƿ����30%</td>                      						 
                  	<td width="5%" >�豸�Ƿ��Զ�����</td>                      						 
                  	<td width="5%" >�豸������С</td>                      						 
                  	<td width="5%" >�豸���ػ�</td>                      						 
                  	<td width="5%" >�󶨴���</td>                      						 
                  	<td width="5%" >WIFI���Ĭ��ˢ�¼��</td>                      						 
                  	<td width="5%" >WIFI��࿪��</td>                      						 
                  	<td width="5%" >���¾���</td>                      						 
                  	<td width="5%" >����γ��</td>                      						 
                  	<td width="5%" >�������</td>                      						 
                  	<td width="5%" >ʱ��</td> 
                  	<td width="5%" >״̬</td>                     						 
                  <!-- 	<td width="5%" >����</td>   -->
                  		<td width="5%" >����</td>                      						 
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >						
						<td>
						<logic:empty name="element" property="serie_no">��</logic:empty>
						<logic:notEmpty name="element" property="serie_no">
						<a style="color: #0000FF"
								href="../deviceActiveInfo/doDeviceActiveInfo.do?method=queryDeviceActiveInfo&device_imei=<bean:write name="element" property="serie_no" />">
							<bean:write name="element" property="serie_no" />
							</a>
						</logic:notEmpty>
						</td>
						
							<td>
						<logic:empty name="element" property="iccid">��</logic:empty>
						<logic:notEmpty name="element" property="iccid">
						<bean:write name="element" property="iccid" />
						</logic:notEmpty>
						</td>
						
						
							<td>
						<logic:empty name="element" property="device_phone">��</logic:empty>
						<logic:notEmpty name="element" property="device_phone">
						<bean:write name="element" property="device_phone" />
						</logic:notEmpty>
						</td>
						<td>
						<logic:empty name="element" property="project_name">��</logic:empty>
						<logic:notEmpty name="element" property="project_name">
						<bean:write name="element" property="project_name" />
						</logic:notEmpty>
						</td>
						<td>
							<logic:equal name="element" property="device_disable" value="0"><font color="red">����</font></logic:equal>
							<logic:equal name="element" property="device_disable" value="1"><font color="green">����</font></logic:equal>
						</td>						
						<td><bean:write name="element" property="input_time" format="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
						  <logic:empty name="element" property="bind_count">��</logic:empty>
						   <logic:notEmpty name="element" property="bind_count">
						  <bean:write name="element" property="bind_count" />
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="device_name">��</logic:empty>
						   <logic:notEmpty name="element" property="device_name">
						  <bean:write name="element" property="device_name" />
						</logic:notEmpty>
						</td>
						<td>
						  <logic:empty name="element" property="brandname">��</logic:empty>
						   <logic:notEmpty name="element" property="brandname">
						  <bean:write name="element" property="brandname" />
						</logic:notEmpty>
						</td>
						
						<td>
						<logic:equal name="element" property="fall_on" value="0">δ��</logic:equal>
						<logic:equal name="element" property="fall_on" value="1">��</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="device_type" value="0">һ��</logic:equal>
						<logic:equal name="element" property="device_type" value="1">����</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="conn_type" value="0">����</logic:equal>
						<logic:equal name="element" property="conn_type" value="1">�ƶ�����</logic:equal>
						<logic:equal name="element" property="conn_type" value="2">�ѻ�</logic:equal>
						<logic:equal name="element" property="conn_type" value="3">wifi</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="gps_on" value="0">��</logic:equal>
						<logic:equal name="element" property="gps_on" value="1">��</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="callback_on" value="0">��</logic:equal>
						<logic:equal name="element" property="callback_on" value="1">��</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="temperature_on" value="0">��</logic:equal>
						<logic:equal name="element" property="temperature_on" value="1">��</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="heatout_on" value="0">��</logic:equal>
						<logic:equal name="element" property="heatout_on" value="1">��</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="led_on" value="0">��</logic:equal>
						<logic:equal name="element" property="led_on" value="1">��</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="flight_mode" value="0">��</logic:equal>
						<logic:equal name="element" property="flight_mode" value="1">��</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="urgent_mode" value="0">��</logic:equal>
						<logic:equal name="element" property="urgent_mode" value="1">��</logic:equal>
						</td>
						
						<td>
						  <logic:empty name="element" property="battery">��</logic:empty>
						   <logic:notEmpty name="element" property="battery">
						  <bean:write name="element" property="battery"/>
						</logic:notEmpty>
						</td>
						
						<td>
						<logic:equal name="element" property="is_lowbat" value="0">��</logic:equal>
						<logic:equal name="element" property="is_lowbat" value="1">��</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="data_mute" value="0">��</logic:equal>
						<logic:equal name="element" property="data_mute" value="1">��</logic:equal>
						</td>
						
						<td>
						  <logic:empty name="element" property="data_volume">��</logic:empty>
						   <logic:notEmpty name="element" property="data_volume">
						  <bean:write name="element" property="data_volume"/>
						</logic:notEmpty>
						</td>
						
						<td>
						<logic:equal name="element" property="data_power" value="0">��</logic:equal>
						<logic:equal name="element" property="data_power" value="1">��</logic:equal>
						</td>
						
						<td>
						  <logic:empty name="element" property="bind_count">��</logic:empty>
						   <logic:notEmpty name="element" property="bind_count">
						  <bean:write name="element" property="bind_count"/>
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="wifir_interval">��</logic:empty>
						   <logic:notEmpty name="element" property="wifir_interval">
						  <bean:write name="element" property="wifir_interval"/>
						</logic:notEmpty>
						</td>
						
						
						<td>
						  <logic:empty name="element" property="wifir_flag">��</logic:empty>
						   <logic:notEmpty name="element" property="wifir_flag">
						  <bean:write name="element" property="wifir_flag"/>
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="longitude">��</logic:empty>
						   <logic:notEmpty name="element" property="longitude">
						  <bean:write name="element" property="longitude"/>
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="latitude">��</logic:empty>
						   <logic:notEmpty name="element" property="latitude">
						  <bean:write name="element" property="latitude"/>
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="beattim">��</logic:empty>
						   <logic:notEmpty name="element" property="beattim">
						  <bean:write name="element" property="beattim"/>
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="time_zone">��</logic:empty>
						   <logic:notEmpty name="element" property="time_zone">
						  <bean:write name="element" property="time_zone"/>
						</logic:notEmpty>
						</td>
						
						<td>
						<logic:equal name="element" property="test_status" value="0">��ʽ</logic:equal>
						<logic:equal name="element" property="test_status" value="1">test</logic:equal>
						<td><a href=# onclick="update('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > �����á�</a>						
						</td>
						</td>
						
					<%-- 	<td>
							<a href=# onclick="deletePhoneInfo('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > ��ɾ����</a> 
						</td> --%>
						<td>
							<%-- <a href=# onclick="deletePhoneInfo('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > ��ɾ����</a> 
						 --%>
						<%-- 	<a href=#
						onclick="deactivatePhoneInfo('<bean:write name="element" property="device_id" />')"
						style="color:#0000FF">
						<logic:equal name="element" property="test_status"
							value="1">��������С�
							</logic:equal>  --%>
						<%-- 	<td align="center">
							<a href=# onclick="update('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > �����á�</a>						
						</td> --%>
						
						
					<%-- 	<td><a href=# onclick="update('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > �����á�</a>						
						</td>
						 --%>
						
					</tr>
				</logic:iterate> 

			  	<tr class="title_3">
					<td colspan="50" align="left" >  
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>  
			</table>
		</form>
	</body>
</html>