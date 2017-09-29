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
    document.all.email.value="";
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

function deleteBindDevice(device_id,user_id){
	if(confirm("确定解绑嘛吗？")){
		frmGo.action="doPhoneInfo.do?method=deleteBindDevice&device_id="+device_id+"&user_id="+user_id+" ";
		frmGo.submit();
	}
}
</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post"
			action="doPhoneInfo.do?method=imeiControl">
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="12" nowrap="nowrap" align="left">
                IMEI管理
              <!--   <input name="addDevice" type="button" class="but_1" accesskey="a"
							tabindex="a" value="添 加" onclick="addimei()"> -->
                </th>
                </tr>
                 <tr class="title_3">
                       <td colspan="13">
                        email查询				
						    <input id="email" name="email" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"email");%>" size="20">
					  时间
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
                  	<td width="7%" >用户email</td>
                  	<td width="5%" >用户昵称</td>
                  	<td width="5%" >被分享用户id</td>
                  	<td width="7%" >设备IMEI</td>                  	                                   	                 	
                  	<td width="5%">是否为主设备</td>
                  	<td width="10%">分享时间</td>                      						 
                  	<td width="5%">是否同意分享</td>                      						 
                  	<td width="5%">操作</td>                      						 
                                  						 
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
						<logic:empty name="element" property="email">无</logic:empty>
						<logic:notEmpty name="element" property="email">
						<a style="color: #0000FF"
								href="../appUserInfo/doAppUserInfo.do?method=queryAppUserInfo&email=<bean:write name="element" property="email" />">
							<bean:write name="element" property="email" />
							</a>
						</logic:notEmpty>
						</td>
						
						<td>
						<logic:empty name="element" property="nickname">无</logic:empty>
						<logic:notEmpty name="element" property="nickname">
						<bean:write name="element" property="nickname"/>
						</logic:notEmpty>
						</td>
						
						<td>
						<logic:empty name="element" property="to_user_id">无</logic:empty>
						<logic:notEmpty name="element" property="to_user_id">
						<bean:write name="element" property="to_user_id" />
						</logic:notEmpty>
						</td>
						
						<%-- <td>
						<logic:empty name="element" property="device_id">无</logic:empty>
						<logic:notEmpty name="element" property="device_id">
						<bean:write name="element" property="device_id" />
						</logic:notEmpty>
						</td> --%>
						
						<td>
						<logic:empty name="element" property="device_imei">无</logic:empty>
						<logic:notEmpty name="element" property="device_imei">
						<a style="color: #0000FF"
								href="../deviceActiveInfo/doDeviceActiveInfo.do?method=queryDeviceActiveInfo&device_imei=<bean:write name="element" property="device_imei" />">
							<bean:write name="element" property="device_imei" />
							</a>
						</logic:notEmpty>
						</td>
						
						<td>
							<logic:equal name="element" property="is_priority" value="1"><font color="green">是</font></logic:equal>
							<logic:equal name="element" property="is_priority" value="0"><font color="red">否</font></logic:equal>
						</td>	
							
						<td>
						<logic:empty name="element" property="share_date">无</logic:empty>
						<logic:notEmpty name="element" property="share_date">
						<bean:write name="element" property="share_date" />
						</logic:notEmpty>
						</td>
						
						<td>
							<logic:equal name="element" property="status" value="0">等待</logic:equal>
							<logic:equal name="element" property="status" value="1"><font color="green">有效</font></logic:equal>
							<logic:equal name="element" property="status" value="2">同意</logic:equal>
							<logic:equal name="element" property="status" value="3"><font color="red">拒绝</font></logic:equal>
						</td>	
						
						<td>
							<logic:equal name="element" property="status" value="1">
							<a href=# onclick="deleteBindDevice('<bean:write name="element" property="device_id" />','<bean:write name="element" property="user_id" />')" style="color:#0000FF" > 【解绑】</a> 
							</logic:equal>
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