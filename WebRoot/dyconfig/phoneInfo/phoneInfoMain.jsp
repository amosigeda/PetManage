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
    var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("开始时间不能大于结束时间!");
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
	if(confirm("确定删除吗？")){
		frmGo.action="doPhoneInfo.do?method=deletePhoneInfo&id="+id+" ";
		frmGo.submit();
	}
}
function deactivatePhoneInfo(id){
	if(confirm("确定清空吗？")){
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
                IMEI信息
                <input name="addDevice" type="button" class="but_1" accesskey="a"
							tabindex="a" value="添 加" onclick="addimei()">
                </th>
                </tr>
                 <tr class="title_3">
                       <td colspan="50">
					  更新时间
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>						
						IMEI
						 <input id="serieNo" name="serieNo" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"serieNo");%>" size="15">
					<%-- 	状态<%if(request.getAttribute("status") != null && !"".equals(request.getAttribute("status"))){%>
						<%=request.getAttribute("status")%>
						<%}else{ %>
						<select id="status" name="status">
							<option value="">全部</option>
							<option value="0">录入</option>
							<option value="1">出厂</option>
							<option value="2">绑定</option>
							<option value="3"> </option>
						</select>
						<%} %>
						
						类型<%if(request.getAttribute("type") != null && !"".equals(request.getAttribute("type"))){%>
						<%=request.getAttribute("type")%>
						<%}else{ %>
						<select id="type" name="type">
							<option value="">全部</option>
							<option value="1">测试</option>
							<option value="2">量产</option>
						</select>
						<%} %> --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="搜 索" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="清除搜索" onclick="c()">
				</tr> 
				<%int i=1; %>
                  <tr class="title_2">                 	
                  	<td width="7%" >IMEI</td>
                  	<td width="7%" >ICCID</td>
                  	<td width="5%" >PHONE</td>
                  	<td width="5%" >项目</td>
                  	<td width="5%" >状态</td>                  	                                   	                 	
                  	<td width="10%">更新时间</td>
                  	<td width="5%" >绑定次数</td>                      						 
                  	<td width="5%" >设备名称</td>                      						 
                  	<td width="5%" >品牌名称</td>                      						 
                  	<td width="5%" >防脱落</td>                      						 
                  	<td width="5%" >设备类型</td>                      						 
                  	<td width="5%" >入网类型</td>                      						 
                  	<td width="5%" >GPS开关</td>                      						 
                  	<td width="5%" >唤回声音开关</td>                      						 
                  	<td width="5%" >体温监测开关</td>                      						 
                  	<td width="5%" >环境温度监测开关</td>                      						 
                  	<td width="5%" >灯光控制开关</td>                      						 
                  	<td width="5%" >飞行模式状态</td>                      						 
                  	<td width="5%" >寻找模式状态</td>                      						 
                  	<td width="5%" >终端电池电量</td>                      						 
                  	<td width="5%" >电量是否低于30%</td>                      						 
                  	<td width="5%" >设备是否自动静音</td>                      						 
                  	<td width="5%" >设备音量大小</td>                      						 
                  	<td width="5%" >设备开关机</td>                      						 
                  	<td width="5%" >绑定次数</td>                      						 
                  	<td width="5%" >WIFI测距默认刷新间隔</td>                      						 
                  	<td width="5%" >WIFI测距开关</td>                      						 
                  	<td width="5%" >最新经度</td>                      						 
                  	<td width="5%" >最新纬度</td>                      						 
                  	<td width="5%" >心跳间隔</td>                      						 
                  	<td width="5%" >时区</td> 
                  	<td width="5%" >状态</td>                     						 
                  <!-- 	<td width="5%" >操作</td>   -->
                  		<td width="5%" >操作</td>                      						 
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >						
						<td>
						<logic:empty name="element" property="serie_no">无</logic:empty>
						<logic:notEmpty name="element" property="serie_no">
						<a style="color: #0000FF"
								href="../deviceActiveInfo/doDeviceActiveInfo.do?method=queryDeviceActiveInfo&device_imei=<bean:write name="element" property="serie_no" />">
							<bean:write name="element" property="serie_no" />
							</a>
						</logic:notEmpty>
						</td>
						
							<td>
						<logic:empty name="element" property="iccid">无</logic:empty>
						<logic:notEmpty name="element" property="iccid">
						<bean:write name="element" property="iccid" />
						</logic:notEmpty>
						</td>
						
						
							<td>
						<logic:empty name="element" property="device_phone">无</logic:empty>
						<logic:notEmpty name="element" property="device_phone">
						<bean:write name="element" property="device_phone" />
						</logic:notEmpty>
						</td>
						<td>
						<logic:empty name="element" property="project_name">无</logic:empty>
						<logic:notEmpty name="element" property="project_name">
						<bean:write name="element" property="project_name" />
						</logic:notEmpty>
						</td>
						<td>
							<logic:equal name="element" property="device_disable" value="0"><font color="red">禁用</font></logic:equal>
							<logic:equal name="element" property="device_disable" value="1"><font color="green">正常</font></logic:equal>
						</td>						
						<td><bean:write name="element" property="input_time" format="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
						  <logic:empty name="element" property="bind_count">无</logic:empty>
						   <logic:notEmpty name="element" property="bind_count">
						  <bean:write name="element" property="bind_count" />
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="device_name">无</logic:empty>
						   <logic:notEmpty name="element" property="device_name">
						  <bean:write name="element" property="device_name" />
						</logic:notEmpty>
						</td>
						<td>
						  <logic:empty name="element" property="brandname">无</logic:empty>
						   <logic:notEmpty name="element" property="brandname">
						  <bean:write name="element" property="brandname" />
						</logic:notEmpty>
						</td>
						
						<td>
						<logic:equal name="element" property="fall_on" value="0">未开</logic:equal>
						<logic:equal name="element" property="fall_on" value="1">开</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="device_type" value="0">一代</logic:equal>
						<logic:equal name="element" property="device_type" value="1">二代</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="conn_type" value="0">蓝牙</logic:equal>
						<logic:equal name="element" property="conn_type" value="1">移动网络</logic:equal>
						<logic:equal name="element" property="conn_type" value="2">脱机</logic:equal>
						<logic:equal name="element" property="conn_type" value="3">wifi</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="gps_on" value="0">关</logic:equal>
						<logic:equal name="element" property="gps_on" value="1">开</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="callback_on" value="0">关</logic:equal>
						<logic:equal name="element" property="callback_on" value="1">开</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="temperature_on" value="0">关</logic:equal>
						<logic:equal name="element" property="temperature_on" value="1">开</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="heatout_on" value="0">关</logic:equal>
						<logic:equal name="element" property="heatout_on" value="1">开</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="led_on" value="0">关</logic:equal>
						<logic:equal name="element" property="led_on" value="1">开</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="flight_mode" value="0">关</logic:equal>
						<logic:equal name="element" property="flight_mode" value="1">开</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="urgent_mode" value="0">关</logic:equal>
						<logic:equal name="element" property="urgent_mode" value="1">开</logic:equal>
						</td>
						
						<td>
						  <logic:empty name="element" property="battery">无</logic:empty>
						   <logic:notEmpty name="element" property="battery">
						  <bean:write name="element" property="battery"/>
						</logic:notEmpty>
						</td>
						
						<td>
						<logic:equal name="element" property="is_lowbat" value="0">否</logic:equal>
						<logic:equal name="element" property="is_lowbat" value="1">是</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="data_mute" value="0">否</logic:equal>
						<logic:equal name="element" property="data_mute" value="1">是</logic:equal>
						</td>
						
						<td>
						  <logic:empty name="element" property="data_volume">无</logic:empty>
						   <logic:notEmpty name="element" property="data_volume">
						  <bean:write name="element" property="data_volume"/>
						</logic:notEmpty>
						</td>
						
						<td>
						<logic:equal name="element" property="data_power" value="0">关</logic:equal>
						<logic:equal name="element" property="data_power" value="1">开</logic:equal>
						</td>
						
						<td>
						  <logic:empty name="element" property="bind_count">无</logic:empty>
						   <logic:notEmpty name="element" property="bind_count">
						  <bean:write name="element" property="bind_count"/>
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="wifir_interval">无</logic:empty>
						   <logic:notEmpty name="element" property="wifir_interval">
						  <bean:write name="element" property="wifir_interval"/>
						</logic:notEmpty>
						</td>
						
						
						<td>
						  <logic:empty name="element" property="wifir_flag">无</logic:empty>
						   <logic:notEmpty name="element" property="wifir_flag">
						  <bean:write name="element" property="wifir_flag"/>
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="longitude">无</logic:empty>
						   <logic:notEmpty name="element" property="longitude">
						  <bean:write name="element" property="longitude"/>
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="latitude">无</logic:empty>
						   <logic:notEmpty name="element" property="latitude">
						  <bean:write name="element" property="latitude"/>
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="beattim">无</logic:empty>
						   <logic:notEmpty name="element" property="beattim">
						  <bean:write name="element" property="beattim"/>
						</logic:notEmpty>
						</td>
						
						<td>
						  <logic:empty name="element" property="time_zone">无</logic:empty>
						   <logic:notEmpty name="element" property="time_zone">
						  <bean:write name="element" property="time_zone"/>
						</logic:notEmpty>
						</td>
						
						<td>
						<logic:equal name="element" property="test_status" value="0">正式</logic:equal>
						<logic:equal name="element" property="test_status" value="1">test</logic:equal>
						<td><a href=# onclick="update('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > 【配置】</a>						
						</td>
						</td>
						
					<%-- 	<td>
							<a href=# onclick="deletePhoneInfo('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > 【删除】</a> 
						</td> --%>
						<td>
							<%-- <a href=# onclick="deletePhoneInfo('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > 【删除】</a> 
						 --%>
						<%-- 	<a href=#
						onclick="deactivatePhoneInfo('<bean:write name="element" property="device_id" />')"
						style="color:#0000FF">
						<logic:equal name="element" property="test_status"
							value="1">【清空所有】
							</logic:equal>  --%>
						<%-- 	<td align="center">
							<a href=# onclick="update('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > 【配置】</a>						
						</td> --%>
						
						
					<%-- 	<td><a href=# onclick="update('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > 【配置】</a>						
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