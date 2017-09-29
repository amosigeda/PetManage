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
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet"
	type="text/css">
<script language="JavaScript"
	src="<%=request.getContextPath()%>/public/public.js"></script>
<!-- 调用此方法 -->
<script language="JavaScript"
	src="<%=request.getContextPath()%>/public/My97DatePicker/WdatePicker.js"></script>
</head>
<script language="javascript">
function finds(){
  /*   var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("开始时间不能大于结束时间!");
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
		if(confirm("确定暂停吗？")){
			frmGo.action="doPhoneInfo.do?method=operatorSimStatus&id="+id+"&status="+status+"&company="+company+"";
			frmGo.submit();
		}
	}else if(a==0){
		if(confirm("确定激活吗？")){
			frmGo.action="doPhoneInfo.do?method=operatorSimStatus&id="+id+"&status="+status+"&company="+company+"";
			frmGo.submit();
		}
	}
}


function unbindIccid(imei){
		if(confirm("您确定解绑吗？")){
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
				<th colspan="50" nowrap="nowrap" align="left">ICCID和IMEI绑定信息 <!-- <input
					name="addDevice" type="button" class="but_1" accesskey="a"
					tabindex="a" value="添 加" onclick="addimei()"> -->
				</th>
			</tr>
			<tr class="title_3">
				<td colspan="50">
					<%-- 	  更新时间
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
						<%} %> --%> <input name="find1" type="button" class="but_1"
					accesskey="f" tabindex="f" value="搜 索" onclick="javascript:finds()">
					<input name="clear" type="button" class="but_1" accesskey="c"
					tabindex="c" value="清除搜索" onclick="c()">
			</tr>
			<%int i=1; %>
			<tr class="title_2">
				<td width="7%">IMEI</td>
				<td width="5%">ICCID</td>
				<!-- <td width="5%">FriendLyName</td>
				<td width="5%">sid</td>
				<td width="5%">RATE_PLAN</td> -->
				<td width="7%">是否激活</td>
				<td width="7%">公司</td>
				<!-- <td width="5%">创建时间</td>
				<td width="5%">更新时间</td> -->
				<td width="5%">操作</td>
			</tr>

			<logic:iterate id="element" name="pageList">
				<tr class="tr_5" onmouseover='this.className="tr_4"'
					onmouseout='this.className="tr_5"'>
					<td><logic:empty name="element" property="device_imei">无</logic:empty>
						<logic:notEmpty name="element" property="device_imei">
							<%-- <a style="color: #0000FF"
								href="../deviceActiveInfo/doDeviceActiveInfo.do?method=queryDeviceActiveInfo&device_imei=<bean:write name="element" property="device_imei" />">
								 --%><bean:write name="element" property="device_imei" />
						<!-- 	</a> -->
						</logic:notEmpty></td>

					<td><logic:empty name="element" property="iccid">无</logic:empty>
						<logic:notEmpty name="element" property="iccid">
							<bean:write name="element" property="iccid" />
						</logic:notEmpty></td>
<%-- 
					<td><logic:empty name="element" property="friendly_name">无</logic:empty>
						<logic:notEmpty name="element" property="friendly_name">
							<bean:write name="element" property="friendly_name" />
						</logic:notEmpty></td>


					<td><logic:empty name="element" property="sid">无</logic:empty>
						<logic:notEmpty name="element" property="sid">
							<bean:write name="element" property="sid" />
						</logic:notEmpty></td>

					<td><logic:empty name="element" property="rate_plan">无</logic:empty>
						<logic:notEmpty name="element" property="rate_plan">
							<bean:write name="element" property="rate_plan" />
						</logic:notEmpty></td> --%>

					<td><logic:equal name="element" property="card_status"
							value="0"><font color="red">否</font></logic:equal> 
							<logic:equal name="element"
							property="card_status" value="1"><font color="green">是</font></logic:equal>
							<logic:equal name="element"
							property="card_status" value="">无</logic:equal>
							</td>
							
							
								<td><logic:equal name="element" property="belong_company"
							value="0">twilio</logic:equal> 
							<logic:equal name="element"
							property="belong_company" value="1">爱施德</logic:equal>
								<logic:equal name="element"
							property="belong_company" value="2">树米</logic:equal>
								<logic:equal name="element"
							property="belong_company" value="">无</logic:equal>
							</td>

				<%-- 	<td><logic:empty name="element" property="create_time">无</logic:empty>
						<logic:notEmpty name="element" property="create_time">
							<bean:write name="element" property="create_time" />
						</logic:notEmpty></td>
					<td><logic:empty name="element" property="update_time">无</logic:empty>
						<logic:notEmpty name="element" property="update_time">
							<bean:write name="element" property="update_time" />
						</logic:notEmpty></td> --%>

				<%-- 	<td><a href=#
						onclick="deletePhoneInfo('<bean:write name="element" property="device_id" />')"
						style="color:#0000FF"> 【删除】</a></td> --%>
						
						<td>
						<a href=#
						onclick="deletePhoneInfo('<bean:write name="element" property="iccid" />','0','<bean:write name="element" property="belong_company" />')"
						style="color:#0000FF">
						<logic:equal name="element" property="card_status"
							value="0">【激活】
							</logic:equal> 
							</a>
							
								<a href=#
						onclick="deletePhoneInfo('<bean:write name="element" property="iccid" />','1','<bean:write name="element" property="belong_company" />')"
						style="color:#0000FF">
							<logic:equal name="element"
							property="card_status" value="1">【暂停】</logic:equal>
							</a>
							<logic:equal name="element"
							property="card_status" value="">【无】</logic:equal>
							
							<a href=#
						onclick="unbindIccid('<bean:write name="element" property="device_imei" />')"
						style="color:#0000FF">
					【解绑】 
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