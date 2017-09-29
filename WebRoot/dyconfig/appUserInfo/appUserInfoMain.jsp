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
    document.all.user.value="";   
    document.getElementById("belongProject").options[0].selected=true;
} 
function onView(download){
	if(download.length == 0){
		alert("没有头像文件，无法下载！");
		return false;
	}
	frmGo.action="doAppUserInfo.do?method=downloadApk&download="+download;
   	frmGo.submit();
}

function deleteDynamicInfo(id){
	if(confirm("确定删除吗？")){
		frmGo.action="doAppUserInfo.do?method=deleteAppUser&id="+id+" ";
		frmGo.submit();
	}
}
</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doAppUserInfo.do?method=queryAppUserInfo">						
		
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="15" nowrap="nowrap" align="left">
                    APP用户信息
                </th>
                </tr>
                <% if(request.getAttribute("user_id") == null){%>
                 <tr class="title_3">
                       <td colspan="15">
                       email查询				
						    <input id="email" name="email" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"email");%>" size="20">
					  注册时间
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>						
					<%-- 	手机号				
						    <input id="user" name="user" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"user");%>" size="9"> --%>
					<%-- 	项目
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
                  <tr class="title_2"> 
                  	<td width="5%" >email</td>
                  <!-- 	<td width="5%">用户ID</td>  --> 
                  	<td width="5%" >密码</td> 
                  	<td width="5%" >昵称</td>  
                  	<td width="5%" >性别</td>
                  	<td width="5%" >是否禁用</td>
                  	<td width="5%" >APP状态</td>
                  	<td width="5%" >当前设备</td> 
                  	<td width="8%" >注册时间</td>
                  	<td width="8%" >登录时间</td>                  	
                  	<td width="5%" >项目</td>
                  	<td width="5%" >绑定数量</td>
                    <td width="5%" >用户类型</td>
                    <td width="5%" >宠物数量</td>
                    <td width="5%" >操作</td>
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
						<td>
						<logic:empty name="element" property="email">无</logic:empty>
						<logic:notEmpty name="element" property="email">
						<bean:write name="element" property="email"/>
						</logic:notEmpty>
						</td>
                      <!-- format="yyyy-MM-dd HH:mm:ss -->		
                      				
						<td><bean:write name="element" property="passwd"/></td>
						<td>
						<logic:empty name="element" property="nickname">无</logic:empty>
						<logic:notEmpty name="element" property="nickname">
						<bean:write name="element" property="nickname"/>
					</logic:notEmpty>
						</td>
						
						<td>
						<logic:equal name="element" property="sex" value="0">男</logic:equal>
						<logic:equal name="element" property="sex" value="1">女</logic:equal>
						</td>
						<td>
						<logic:equal name="element" property="status" value="0"><font color="red">是</font></logic:equal>
						<logic:equal name="element" property="status" value="1">否</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="login_status" value="0"><font color="red">不在APP也不在后台</font></logic:equal>
						<logic:equal name="element" property="login_status" value="1"><font color="green">进入APP并在前台</font></logic:equal>
						<logic:equal name="element" property="login_status" value="2"><font color="blue">进入APP但在后台</font></logic:equal>
						</td>
						<td>
							<logic:empty name="element" property="act_device_id">无</logic:empty>
							<logic:notEmpty name="element" property="act_device_id">
								<bean:write name="element" property="act_device_id" />
							</logic:notEmpty>
						</td>
						<td>
						<bean:write name="element" property="create_time"   format="yyyy-MM-dd HH:mm:ss"/>
						</td>
							<td>
						<bean:write name="element" property="lastlogin_time"   format="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td>
							<logic:empty name="element" property="belong_project">无</logic:empty>
							<logic:notEmpty name="element" property="belong_project">
							<bean:write name="element" property="belong_project"/>
								</logic:notEmpty>							
						</td>	
						<td>
						<logic:empty name="element" property="bind_count">0</logic:empty>
						<logic:notEmpty name="element" property="bind_count">
						<bean:write name="element" property="bind_count"/>
						</logic:notEmpty></td>	

						<td>
						<logic:equal name="element" property="user_type" value="0">正常账号</logic:equal>
						<logic:equal name="element" property="user_type" value="1">测试账号</logic:equal>
						<logic:equal name="element" property="user_type" value="2">facebook账号</logic:equal>
						</td>
						
						<td>
						<logic:empty name="element" property="pet_count">无</logic:empty>
						<logic:notEmpty name="element" property="pet_count">
						<bean:write name="element" property="pet_count" />
						</logic:notEmpty></td>		
						
						<td> 
						<a href=# onclick="deleteDynamicInfo('<bean:write name="element" property="user_id" />')" style="color:#0000FF" > 【删除】</a> 
						</td>	
																							
					</tr>
				</logic:iterate> 

			  	<tr class="title_3">
					<td colspan="15" align="left" >  
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>  
			</table>
		</form>
	</body>
</html>