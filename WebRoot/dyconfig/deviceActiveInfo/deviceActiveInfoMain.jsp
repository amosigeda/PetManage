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
	function onView1(download){
		if(download.length == 0){
			alert("没有头像文件，无法下载！");
			return false;
		}
		frmGo.action="doDeviceActiveInfo.do?method=downloadImg&download="+download;
	   	frmGo.submit();
	}
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
    document.all.device_imei.value="";
    document.all.startTime.value="";
    document.all.endTime.value="";
    document.all.serieNo.value="";
    document.all.userName.value="";
    document.getElementById("belongProject").options[0].selected=true;
} 

function updateUpUser(id){
	frmGo.action="doDeviceActiveInfo.do?method=initUpdateUpDevice&id="+id;
	frmGo.submit();
}

function deleteDeviceActive(obj){
	if(confirm("若解绑该设备,该设备的相关数据也不删除,解绑后不可恢复,确认解绑?")){
		var msg = obj.split(",");
		if(msg.length == 3){
			frmGo.action = "doDeviceActiveInfo.do?method=deleteDeviceActive&user_id="+msg[0]+"&device_imei="+msg[1]+"&belong_project="+msg[2];
			frmGo.submit();
		}		
	}
}
</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post"
			action="doDeviceActiveInfo.do?method=queryDeviceActiveInfo">
			<% if(request.getAttribute("deviceImei") != null && !request.getAttribute("deviceImei").equals("")){%>
			<table class="table_1" style="font-size:14px;margin-bottom:5px;">
			   <tr>  
			     <td>
			                      当前IMEI:
			              <font color="#FFA500">
			               <strong ><%=request.getAttribute("deviceImei") %></strong>
			               <input type="hidden" name="deviceImei" value="<%=request.getAttribute("deviceImei") %>"/>
			            </font>
			     </td>
			   </tr>
			</table>
		 <%} %>		 
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="16" nowrap="nowrap" align="left">
                                           宠物信息
                </th>
                </tr>
                <% if(request.getAttribute("deviceImei") == null){%>
                 <tr class="title_3">
                       <td colspan="16">
                       IMEI
						 <input id="device_imei" name="device_imei" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"device_imei");%>" size="15">
					出生日期
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>						
					
				        <!--   设备号码
						 <input id="phoneNumber" name="phoneNumber" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"phoneNumber");%>" size="9"> -->
					<%--   主亲情号码
						 <input id="userName" name="userName" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"userName");%>" size="9">
				 --%>	<%-- 项目
							<%String belongProject = (String)request.getAttribute("belongProject"); %>
							<select id="belongProject" name="belongProject">
								<option value="">全部</option>
								<logic:iterate id="pro" name="project">
									<bean:define id="projectId" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=projectId %>' <%=String.valueOf(projectId).equals(belongProject)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select> --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="搜 索" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="清除搜索" onclick="c()">
				</tr> 
				<%} %>
				<%int i=1; %>
                  <tr class="title_2">
                  	<td width="8%" >IMEI</td>
                  	<td width="9%" >昵称</td>
                  	<td width="10%" >出生日期</td>
                  	<td width="6%" >性别</td>
                  	<td width="6%" >体重(KG)</td> 
                  	<td width="6%" >好动程度</td>
                  	<td width="5%" >肥胖程度</td> 
                  	<td width="7%" >宠物类型</td>
                  	<td width="6%" >肩高</td>
                  	<td width="6%" >计步器Sensor灵敏度</td>
                  	<td width="6%" >健康程度</td>
                  	<td width="8%" >时区</td> 
                  	<td width="6%" >是否接入系统</td> 
                  	<td width="6%">用户选择体重操作的方式</td>                	
                  	<td width="5%">步数</td>                	
                  	<td width="5%">操作</td>                	
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >						
						<%-- <td><bean:write name="element" property="first" format="yyyy-MM-dd HH:mm:ss"/></td> --%>
						<td><bean:write name="element" property="device_imei" /></td>
						<td><bean:write name="element" property="nickname" /></td>
						<td><bean:write name="element" property="born_date" /></td>
						<td>
						<logic:equal name="element" property="sex" value="0">male</logic:equal>
								<logic:equal name="element" property="sex" value="1">female</logic:equal>
						</td>
						<td><bean:write name="element" property="weight" /></td>
						<td>
						<logic:equal name="element" property="sport_level" value="0">lazzy</logic:equal> 
							<logic:equal name="element" property="sport_level" value="1">normal</logic:equal>
							<logic:equal name="element" property="sport_level" value="2">active</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="fat_level" value="0">消瘦</logic:equal>
						<logic:equal name="element" property="fat_level" value="1">偏瘦</logic:equal>
						<logic:equal name="element" property="fat_level" value="2">正常</logic:equal>
						<logic:equal name="element" property="fat_level" value="3">偏旁</logic:equal>
						<logic:equal name="element" property="fat_level" value="4">肥胖</logic:equal>
						</td>

						<td>
						<logic:equal name="element" property="pet_type" value="0">dog</logic:equal>
						<logic:equal name="element" property="pet_type" value="1">cat</logic:equal>
						</td>
						
						<td><bean:write name="element" property="sheight" /></td>
						<td><bean:write name="element" property="sensitivity" /></td>
						<td>
						<logic:equal name="element" property="is_healthy" value="0">abnormal</logic:equal>
						<logic:equal name="element" property="is_healthy" value="1">normal</logic:equal>
						</td>
						<td><bean:write name="element" property="time_zone" /></td>
						<td>
						<logic:equal name="element" property="is_online" value="0">脱机</logic:equal>
						<logic:equal name="element" property="is_online" value="1">在线</logic:equal>
					</td>
						<td><bean:write name="element" property="weight_type" /></td>
							<td><bean:write name="element" property="ulfq" /></td>
								<td>
								<a href=# onclick="updateUpUser('<bean:write name="element" property="device_id" />')" style="color:#0000FF" > 【配置】</a>
								</td>
						
						
						
						<%-- <td>
							<a style="color:#00f" href="../projectInfo/doProjectInfo.do?method=queryProjectInfo&projectId=<bean:write name="element" property="belong_project"/>">
						<bean:write name="element" property="project" />
						</a>
						</td>
						<td>
						<logic:empty name="element" property="device_phone">无</logic:empty>
							<logic:notEmpty name="element" property="device_phone">
								<bean:write name="element" property="device_phone" />
							</logic:notEmpty>
						</td>
						<td><bean:write name="element" property="count"/></td>
						<td><bean:write name="element" property="user_name"/></td>						
						<td>
							<a style="color: #0000FF"
								href="../appUserInfo/doAppUserInfo.do?method=queryAppUserInfo&user_id=<bean:write name="element" property="user_id" />">
								<bean:write name="element" property="user_name"/>
							</a>
						</td>
						<td><bean:write name="element" property="id" /></td>					
						<td><bean:write name="element" property="device_name" /></td>
						<td>
							<logic:equal name="element" property="device_sex" value="0">男</logic:equal> 
							<logic:equal name="element" property="device_sex" value="1">女</logic:equal>
						</td>
						<td><bean:write name="element" property="device_age" /></td>	
						<td><bean:write name="element" property="device_height" /></td>
						<td><bean:write name="element" property="device_weight" /></td>
						<td>
							<logic:equal name="element" property="device_head" value="0">无</logic:equal>
							<logic:notEqual name="element" property="device_head" value="0">
								<a href=# onclick="onView1('<bean:write name="element" property="device_head"/>')" style="color:#0000FF">下载</a>
							</logic:notEqual>							
						</td>	
						<td>
						<logic:notEmpty name="element" property="firm"><bean:write name="element" property="firm"/></logic:notEmpty>
						<logic:empty name="element" property="firm">无</logic:empty>
						<bean:write name="element" property="firm"/>
						</td>							
						<td><bean:write name="element" property="device_update_time" format="yyyy-MM-dd HH:mm:ss"/></td>								 						
						<td>
							<a href=# onclick="deleteDeviceActive('<bean:write name="element" property="user_id" />,<bean:write name="element" property="device_imei" />,<bean:write name="element" property="belong_project" />')" style="color:#0000FF" > 【解绑】</a>
							
						</td> --%>
					</tr>
				</logic:iterate> 

			  	<tr class="title_3">
					<td colspan="16" align="left" >  
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>  
			</table>
		</form>
	</body>
</html>