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
                       IMEI				
						    <input id="device_imei" name="device_imei" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"device_imei");%>" size="20">
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
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="�� ��" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="�������" onclick="c()">
				</tr> 
                  <tr class="title_2">     
                  	<td width="10%">�豸IMEI</td>  
                  <!-- 	<td width="10%">��Ŀ����</td>  -->        	
                  	<td width="8%" >����Χ���ܿ���</td>                  	                  	
                  	<td width="8%" >�����ǰ�����ĵ���Χ��id</td>
                  	<td width="8%" >��ǰ��������Χ��id</td>
                  	<td width="8%" >��Ӧprev_eid��ʱ��ڵ�</td>
                  	<td width="8%" >���һ��app���ߵ�ʱ��</td> 
                  	<td width="8%">���豸��ص������û�APP״̬�Ļ���״̬</td>                 	 
                  	<td width="8%" >��Ӧ���һ���豸���ߵ�ʱ��</td>
                  	<td width="5%" >�豸״̬</td>                 	                	               	                  	          						 
                  	<td width="5%" >�豸���״̬</td>                 	                	               	                  	          						 
                  	<td width="5%" >�豸�ź�ǿ��</td>                 	                	               	                  	          						 
                  	<td width="5%" >���һ�ζ�λ�ľ���</td>                 	                	               	                  	          						 
                  	<td width="5%" >��λ����</td>                 	                	               	                  	          						 
                  	<td width="5%" >ʡ��ģʽ</td>                 	                	               	                  	          						 
                  	<td width="5%" >�豸����ģʽ</td>                 	                	               	                  	          						 
                  	<td width="5%" >WIFI����Χ���ܿ���</td>                 	                	               	                  	          						 
                  	<td width="5%" >WIFI SSID</td>                 	                	               	                  	          						 
                  	<td width="5%" >WIFI BSSID</td>                 	                	               	                  	          						 
                  	<td width="5%" >WIFI����Χ������״̬</td>                 	                	               	                  	          						 
                  	<td width="5%" >˯��ʱ��00:00-07:00 ��־</td>                 	                	               	                  	          						 
                  	<td width="5%" >�豸����ģʽ�Ƿ����õƿ���</td>                 	                	               	                  	          						 
                  	<td width="5%" >�豸����״̬</td>                 	                	               	                  	          						 
				</tr>

				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
						<td>
								<a style="color: #0000FF"
								href="../deviceActiveInfo/doDeviceActiveInfo.do?method=queryDeviceActiveInfo&device_imei=<bean:write name="element" property="device_imei" />">
							<bean:write name="element" property="device_imei" />
							</a>		
						</td>						
						<td>
						<logic:equal name="element" property="esafe_on" value="1"><font color="green">��</font></logic:equal>
							<logic:equal name="element" property="esafe_on" value="0"><font color="red">��</font></logic:equal>
						</td>
						<td>
						<a style="color: #0000FF"
								href="../safeArea/doSafeArea.do?method=queryWeiLanInfo&id=<bean:write name="element" property="prev_eid" />">
								<bean:write name="element" property="prev_eid"/>
</a>
						</td>
						<td>
							<a style="color: #0000FF"
								href="../safeArea/doSafeArea.do?method=queryWeiLanInfo&id=<bean:write name="element" property="cur_eid" />">
								<bean:write name="element" property="cur_eid"/></a>
						</td>
						<td>
								<bean:write name="element" property="prev_time"/>
						</td>
						<td>
								<bean:write name="element" property="app_timestamp"/>
						</td>
						<td>
						<logic:equal name="element" property="app_status" value="0">���û�����APP</logic:equal>
							<logic:equal name="element" property="app_status" value="1">���û�����APP������ǰ̨</logic:equal>
							<logic:equal name="element" property="app_status" value="2">���û�����APp�����ں�̨</logic:equal>
						</td>
						<td>
								<bean:write name="element" property="dev_timestamp"/>
						</td>
						<td>
						<logic:equal name="element" property="dev_status" value="0"><font color="red">������</font></logic:equal>
						<logic:equal name="element" property="dev_status" value="1"><font color="green">����</font></logic:equal>
						</td>
						<td>
						<logic:equal name="element" property="charging_status" value="0">û�г��</logic:equal>
						<logic:equal name="element" property="charging_status" value="1"><font color="green">�����</font></logic:equal>
						</td>
						<td>
								<bean:write name="element" property="sig_level"/>
						</td>
						<td>
								<bean:write name="element" property="acc"/>
						</td>
						<td>
						<logic:equal name="element" property="lct_type" value="1">GPS�ߵµ�ͼ</logic:equal>
						<logic:equal name="element" property="lct_type" value="2">��վ��λ�ߵµ�ͼ</logic:equal>
						<logic:equal name="element" property="lct_type" value="3">�ߵµ�ͼwifi��λ</logic:equal>
						<logic:equal name="element" property="lct_type" value="4">Google Map GPS</logic:equal>
						<logic:equal name="element" property="lct_type" value="5">Google Map Geolocation</logic:equal>
						</td>
						<td>
								<bean:write name="element" property="eco_mode"/>
						</td>
						<td>
								<bean:write name="element" property="debug_mode"/>
						</td>
						
						<td>
						<logic:equal name="element" property="esafe_wifi" value="0">��</logic:equal>
						<logic:equal name="element" property="esafe_wifi" value="1">��</logic:equal>
						</td>
						
						<td>
								<bean:write name="element" property="ssid_wifi"/>
						</td>
						<td>
								<bean:write name="element" property="bssid_wifi"/>
						</td>
						<td>
							<logic:equal name="element" property="estat_wifi" value="0">������</logic:equal>
						<logic:equal name="element" property="estat_wifi" value="1"><font color="red">����</font></logic:equal>
						</td>
						<td>
						<logic:equal name="element" property="sleep_status" value="0">�ر�</logic:equal>
						<logic:equal name="element" property="sleep_status" value="1"><font color="green">����</font></logic:equal>
						</td>
						<td>
						<logic:equal name="element" property="sos_led_on" value="0"><font color="red">��</font></logic:equal>
						<logic:equal name="element" property="sos_led_on" value="1">��</logic:equal>
						</td>
							<td>
								<logic:equal name="element" property="ufirm_stat" value="0">������</logic:equal>
						<logic:equal name="element" property="ufirm_stat" value="1"><font color="green">����</font></logic:equal>
						</td>
								 						
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