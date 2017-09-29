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
	}
	var safeRange1 = document.getElementById("safeRange1").value;
	var safeRange2 = document.getElementById("safeRange2").value;
	if(safeRange1 > safeRange2){
		alert("开始范围不能大于结束范围");
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
                                           安全区域信息
                </th>
                </tr>            		
                 <tr class="title_3">
                       <td colspan="25">
                       IMEI				
						    <input id="device_imei" name="device_imei" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"device_imei");%>" size="20">
					<%--   创建时间
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>
						
						范围				
						    <input id="safeRange1" name="safeRange1" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"safeRange1");%>" size="7">
						-				
						    <input id="safeRange2" name="safeRange2" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"safeRange2");%>" size="7">m
						 项目
						 <%String belongProject = (String)request.getAttribute("belongProject"); %>			
							<select id="belongProject" name="belongProject" >
								<option value="">全部</option>
								<logic:iterate id="pro" name="project_name">
									<bean:define id="projectId" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=projectId %>' <%=String.valueOf(projectId).equals(belongProject)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select>
						 用户手机号
						  <input id="userName" name="userName" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"userName");%>" size="9"> --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="搜 索" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="清除搜索" onclick="c()">
				</tr> 
                  <tr class="title_2">     
                  	<td width="10%">设备IMEI</td>  
                  <!-- 	<td width="10%">项目名称</td>  -->        	
                  	<td width="8%" >电子围栏总开关</td>                  	                  	
                  	<td width="8%" >五分钟前所属的电子围栏id</td>
                  	<td width="8%" >当前所属电子围栏id</td>
                  	<td width="8%" >对应prev_eid的时间节点</td>
                  	<td width="8%" >最后一次app在线的时间</td> 
                  	<td width="8%">与设备相关的所有用户APP状态的汇总状态</td>                 	 
                  	<td width="8%" >对应最后一次设备在线的时间</td>
                  	<td width="5%" >设备状态</td>                 	                	               	                  	          						 
                  	<td width="5%" >设备充电状态</td>                 	                	               	                  	          						 
                  	<td width="5%" >设备信号强度</td>                 	                	               	                  	          						 
                  	<td width="5%" >最后一次定位的精度</td>                 	                	               	                  	          						 
                  	<td width="5%" >定位类型</td>                 	                	               	                  	          						 
                  	<td width="5%" >省电模式</td>                 	                	               	                  	          						 
                  	<td width="5%" >设备调试模式</td>                 	                	               	                  	          						 
                  	<td width="5%" >WIFI电子围栏总开关</td>                 	                	               	                  	          						 
                  	<td width="5%" >WIFI SSID</td>                 	                	               	                  	          						 
                  	<td width="5%" >WIFI BSSID</td>                 	                	               	                  	          						 
                  	<td width="5%" >WIFI电子围栏报警状态</td>                 	                	               	                  	          						 
                  	<td width="5%" >睡眠时段00:00-07:00 标志</td>                 	                	               	                  	          						 
                  	<td width="5%" >设备紧急模式是否启用灯开关</td>                 	                	               	                  	          						 
                  	<td width="5%" >设备升级状态</td>                 	                	               	                  	          						 
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
						<logic:equal name="element" property="esafe_on" value="1"><font color="green">开</font></logic:equal>
							<logic:equal name="element" property="esafe_on" value="0"><font color="red">关</font></logic:equal>
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
						<logic:equal name="element" property="app_status" value="0">无用户进入APP</logic:equal>
							<logic:equal name="element" property="app_status" value="1">有用户进入APP并且在前台</logic:equal>
							<logic:equal name="element" property="app_status" value="2">有用户进入APp并且在后台</logic:equal>
						</td>
						<td>
								<bean:write name="element" property="dev_timestamp"/>
						</td>
						<td>
						<logic:equal name="element" property="dev_status" value="0"><font color="red">不在线</font></logic:equal>
						<logic:equal name="element" property="dev_status" value="1"><font color="green">在线</font></logic:equal>
						</td>
						<td>
						<logic:equal name="element" property="charging_status" value="0">没有充电</logic:equal>
						<logic:equal name="element" property="charging_status" value="1"><font color="green">充电中</font></logic:equal>
						</td>
						<td>
								<bean:write name="element" property="sig_level"/>
						</td>
						<td>
								<bean:write name="element" property="acc"/>
						</td>
						<td>
						<logic:equal name="element" property="lct_type" value="1">GPS高德地图</logic:equal>
						<logic:equal name="element" property="lct_type" value="2">基站定位高德地图</logic:equal>
						<logic:equal name="element" property="lct_type" value="3">高德地图wifi定位</logic:equal>
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
						<logic:equal name="element" property="esafe_wifi" value="0">关</logic:equal>
						<logic:equal name="element" property="esafe_wifi" value="1">开</logic:equal>
						</td>
						
						<td>
								<bean:write name="element" property="ssid_wifi"/>
						</td>
						<td>
								<bean:write name="element" property="bssid_wifi"/>
						</td>
						<td>
							<logic:equal name="element" property="estat_wifi" value="0">不报警</logic:equal>
						<logic:equal name="element" property="estat_wifi" value="1"><font color="red">报警</font></logic:equal>
						</td>
						<td>
						<logic:equal name="element" property="sleep_status" value="0">关闭</logic:equal>
						<logic:equal name="element" property="sleep_status" value="1"><font color="green">开启</font></logic:equal>
						</td>
						<td>
						<logic:equal name="element" property="sos_led_on" value="0"><font color="red">关</font></logic:equal>
						<logic:equal name="element" property="sos_led_on" value="1">开</logic:equal>
						</td>
							<td>
								<logic:equal name="element" property="ufirm_stat" value="0">非升级</logic:equal>
						<logic:equal name="element" property="ufirm_stat" value="1"><font color="green">升级</font></logic:equal>
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