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
  /*   var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
		return false;
	} */
	   frmGo.submit();
}
function c(){
     document.all.device_imei.value="";
   /*  document.all.email.value="";
    document.all.startTime.value="";
    document.all.endTime.value="";
    document.all.serieNo.value="";
    document.getElementById("status").options[0].selected=true;
     document.getElementById("type").options[0].selected=true; */
} 
function addimei(){
	frmGo.action="doPhoneInfo.do?method=initInsert";
	frmGo.submit();
}

function deleteBindDevice(id){
	if(confirm("ȷ���������")){
		frmGo.action="doPhoneInfo.do?method=deleteBindDevice&id="+id+" ";
		frmGo.submit();
	}
}
</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post"
			action="doPhoneInfo.do?method=queryDeviceWifi">
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="12" nowrap="nowrap" align="left">
               ����WIFI
              <!--   <input name="addDevice" type="button" class="but_1" accesskey="a"
							tabindex="a" value="�� ��" onclick="addimei()"> -->
                </th>
                </tr>
                 <tr class="title_3">
                       <td colspan="13">
                       IMEI				
						    <input id="device_imei" name="device_imei" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"device_imei");%>" size="20">
					
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
                  	<td width="7%" >�豸IMEI</td>                  	                                   	                 	
                  	<td width="7%" >�����ʶ��</td>
                  	<td width="5%" >�����ǳ�</td>
                  	<td width="5%" >WIFI�ź�ǿ��(��)</td>
                  	<td width="5%" >����wifi�ȵ��SSID</td>
                  	<td width="5%">�����ϴ�ʱ��</td>
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >						
						<%-- <td>
							<logic:equal name="element" property="status" value="2"><a style="color: #0000FF"
								href="../deviceActiveInfo/doDeviceActiveInfo.do?method=queryDeviceActiveInfo&deviceImei=<bean:write name="element" property="serie_no" />">
							<bean:write name="element" property="serie_no" />
							</a>
							</logic:equal>
							<logic:notEqual name="element" property="status" value="2">
								<bean:write name="element" property="serie_no" />
							</logic:notEqual>
						</td> --%>
						
						<td>
						<logic:empty name="element" property="device_imei">��</logic:empty>
						<logic:notEmpty name="element" property="device_imei">
						<a style="color: #0000FF"
								href="../deviceActiveInfo/doDeviceActiveInfo.do?method=queryDeviceActiveInfo&device_imei=<bean:write name="element" property="device_imei" />">
							<bean:write name="element" property="device_imei" />
							</a>
						</logic:notEmpty>
						</td>
						
						<td>
						<bean:write name="element" property="pet_id" />
							</td>	
								<td>
						<bean:write name="element" property="nickname" />
							</td>	
							<td>
						<bean:write name="element" property="wifi_radius" />
							</td>	
							<td>
						<bean:write name="element" property="host_ssid" />
							</td>	
							
							
						<td>
						<logic:empty name="element" property="up_time">��</logic:empty>
						<logic:notEmpty name="element" property="up_time">
						<bean:write name="element" property="up_time" />
						</logic:notEmpty>
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