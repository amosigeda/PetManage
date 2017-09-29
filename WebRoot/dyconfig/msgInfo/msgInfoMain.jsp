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
  /*   var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("开始时间不能大于结束时间!");
		return false;
	} */
	   frmGo.submit();
}
function c(){
    document.all.device_imei.value="";
   /*  document.all.startTime.value="";
    document.all.endTime.value="";
    document.all.startTime1.value="";
    document.all.endTime1.value="";
    document.all.toUserName.value="";
    document.all.content.value="";
    document.all.fromUserName.value="";
    document.all.serieNo.value="";
    document.all.belongProject.value="";
    document.getElementById("statusSelect").options[0].selected = true; */
} 

</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doMsgInfo.do?method=queryMsgInfo">
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="20" nowrap="nowrap" align="left">
                MSG信息
                </th>
                </tr>
                 <tr class="title_3">
                 
                      <td colspan="14">
					<%--   处理时间
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>	
					产生时间
					<input name="startTime1" type="text" class="txt_1"  id="startTime1" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date1");%>" onclick="WdatePicker()"
								size="15" readonly> -
							<input name="endTime1" type="text" class="txt_1" id="endTime1" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date1");%>" onclick="WdatePicker()"
								size="15" readonly>					
						用户手机号
						 <input id="fromUserName" name="fromUserName" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"fromUserName");%>" size="9">
						发送用户手机号
						 <input id="toUserName" name="toUserName" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"toUserName");%>" size="9"><br> --%>
						<!-- 
						内容
						 <input id="content" name="content" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"content");%>" size="14"><br/>
						 -->
						IMEI
						<input id="device_imei" name="device_imei" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"device_imei");%>" size="15">
						 <%--  项目
						 <%String belongProject = (String)request.getAttribute("belongProject"); %>			
							<select id="belongProject" name="belongProject" >
								<option value="">全部</option>
								<logic:iterate id="pro" name="project_name">
									<bean:define id="projectId" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=projectId %>' <%=String.valueOf(projectId).equals(belongProject)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select>
						是否处理
						<%if(request.getAttribute("statusSelect") != null && !"".equals(request.getAttribute("statusSelect"))){ %>
						<%=request.getAttribute("statusSelect") %>
						<%}else{ %>
						<select id="statusSelect" name="statusSelect">
						<option value="">全部</option>
						<option value="1">√</option>
						<option value="0">×</option>
						</select>
						<%} %> --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="搜 索" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="清除搜索" onclick="c()">
				</tr>  
				<%int i=1; %>
                  <tr class="title_2">                 	
                  	<td width="6%">设备imei</td>
                  	<td width="6%" >消息类型</td>
                  	<td width="6%" >消息身份</td>
                  	<td width="6%">消息时间</td>
                  	<td width="10%">消息内容</td>
                  	<td width="5%">消息发送者</td>
                  	<td width="5%">消息接受者</td>
                  	<td width="5%">电子围栏id</td>
                  	<td width="5%">消息状态</td>
                  	<td width="5%">share_id</td>
                  	<td width="5%">pet_id</td>
                  	<td width="5%">推送状态</td>
                  	<td width="5%">是否显示给APP用户</td>
                  	<td width="10%">通知内容</td>
                  </tr>	
                  
                  <logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >						
						<td>
							<bean:write name="element" property="device_imei"/>
						</td>
						<td>
							<bean:write name="element" property="msg_type"/>
						</td>
						<td>
							<logic:equal name="element" property="msg_ind_id" value="-1">其他</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="0">正常消息</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="1">离开电子围栏</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="2">进入电子围栏</logic:equal>
							<%-- <logic:equal name="element" property="msg_ind_id" value="3">未读</logic:equal> --%>
							<logic:equal name="element" property="msg_ind_id" value="4">低电报警</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="5">设备分享请求</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="6">同意设备分享</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="7">拒绝设备分享</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="8">设备断网</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="9">设备连网</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="10">app用户断网</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="11">app用户连网</logic:equal>
							<logic:equal name="element" property="msg_ind_id" value="12">脱落</logic:equal>
						</td>
						<td>
							<bean:write name="element" property="msg_date"/>
						</td>
						<td>
							<bean:write name="element" property="msg_content"/>
						</td>
						<td>
							<bean:write name="element" property="from_usrid"/>
						</td>
						<td>
							<bean:write name="element" property="to_usrid"/>
						</td>
						<td>
							<bean:write name="element" property="fence_id"/>
						</td>
						<td>
						<logic:equal name="element" property="status" value="0">未读</logic:equal>
						<logic:equal name="element" property="status" value="1"><font color="green">已读</font></logic:equal>
						</td>
						<td>
							<bean:write name="element" property="share_id"/>
						</td>
						<td>
							<bean:write name="element" property="pet_id"/>
						</td>
							<td>
							<logic:equal name="element" property="push_status" value="0">未推</logic:equal>
						<logic:equal name="element" property="push_status" value="1"><font color="green">已推</font></logic:equal>
						</td>
							<td>
							<logic:equal name="element" property="hide_flag" value="0">不隐藏</logic:equal>
							<logic:equal name="element" property="hide_flag" value="1">隐藏</logic:equal>
						</td>
						<td>
							<bean:write name="element" property="summary"/>
						</td>
							
						<%-- 	<td>
							<a style="color: #0000FF"  
								href="../../dyconfig/projectInfo/doProjectInfo.do?method=queryProjectInfo&projectId=<bean:write name="element" property="belong_project" />">
									<bean:write name="element" property="project"/>
									 </a>
						</td>
						<td>
							<a style="color:#00f" href="../appUserInfo/doAppUserInfo.do?method=queryAppUserInfo&user_id=<bean:write name="element" property="user_id"/>">
								<bean:write name="element" property="from_user_name"/>
							</a>	
						</td>
						<td>
							<a style="color:#00f" href="../appUserInfo/doAppUserInfo.do?method=queryAppUserInfo&user_id=<bean:write name="element" property="user_id"/>">
								<bean:write name="element" property="to_user_name"/>
							</a>							
						</td>
							<td>
							<a style="color:#00f" href="../deviceActiveInfo/doDeviceActiveInfo.do?method=queryDeviceActiveInfo&deviceImei=<bean:write name="element" property="msgImei"/>">
								<bean:write name="element" property="msgImei"/>
							</a>
						</td>
						<td><logic:equal name="element" property="msgContent" value="0">绑定</logic:equal>
							<logic:equal name="element" property="msgContent" value="1">解绑</logic:equal>
							<logic:equal name="element" property="msgContent" value="2">进入围栏</logic:equal>
							<logic:equal name="element" property="msgContent" value="3">出围栏</logic:equal>
							<logic:equal name="element" property="msgContent" value="4">低电</logic:equal>
							<logic:equal name="element" property="msgContent" value="5">戴上</logic:equal>
							<logic:equal name="element" property="msgContent" value="6">脱落</logic:equal>
							<logic:equal name="element" property="msgContent" value="7">SOS</logic:equal>
							<logic:equal name="element" property="msgContent" value="8">远程关机</logic:equal>
							<logic:equal name="element" property="msgContent" value="9">驱蚊</logic:equal>
							<logic:equal name="element" property="msgContent" value="10">爱心</logic:equal>
							<logic:equal name="element" property="msgContent" value="13">定位模式</logic:equal>
							<logic:equal name="element" property="msgContent" value="14">离线状态</logic:equal>
							</td>
						<td>
							<logic:equal name="element" property="is_handler" value="1">
								<font style="color:green;font-size: 20px;">√</font>
							</logic:equal>
							<logic:equal name="element" property="is_handler" value="0">
								<font style="color:red;font-size: 20px;">×</font>
							</logic:equal>
						</td>
						<td>
							<bean:write name="element" property="msg_occur_date" format="yyyy-MM-dd HH:mm:ss"/>
							<logic:empty name="element" property="msg_occur_date">无</logic:empty>
						</td>
						<td>
							<bean:write name="element" property="msg_handler_date" format="yyyy-MM-dd HH:mm:ss"/>
							<logic:empty name="element" property="msg_handler_date">无</logic:empty>
						</td> --%>
					</tr>
				</logic:iterate>
				
				<tr class="title_3">
					<td colspan="20" align="left" >  
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr> 
			</table>
		</form>
	</body>
</html>