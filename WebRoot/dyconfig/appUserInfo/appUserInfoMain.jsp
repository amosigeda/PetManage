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
    document.all.email.value="";
    document.all.startTime.value="";
    document.all.endTime.value="";
    document.all.user.value="";   
    document.getElementById("belongProject").options[0].selected=true;
} 
function onView(download){
	if(download.length == 0){
		alert("û��ͷ���ļ����޷����أ�");
		return false;
	}
	frmGo.action="doAppUserInfo.do?method=downloadApk&download="+download;
   	frmGo.submit();
}

function deleteDynamicInfo(id){
	if(confirm("ȷ��ɾ����")){
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
                    APP�û���Ϣ
                </th>
                </tr>
                <% if(request.getAttribute("user_id") == null){%>
                 <tr class="title_3">
                       <td colspan="15">
                       email��ѯ				
						    <input id="email" name="email" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"email");%>" size="20">
					  ע��ʱ��
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>						
					<%-- 	�ֻ���				
						    <input id="user" name="user" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"user");%>" size="9"> --%>
					<%-- 	��Ŀ
							<%String belongProject = (String)request.getAttribute("belongProject"); %>
							<select id="belongProject" name="belongProject">
								<option value="">ȫ��</option>
								<logic:iterate id="pro" name="project">
									<bean:define id="projectId" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=projectId %>' <%=String.valueOf(projectId).equals(belongProject)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select> --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="�� ��" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="�������" onclick="c()">
				</tr> 
				<%} %>
                  <tr class="title_2"> 
                  	<td width="5%" >email</td>
                  <!-- 	<td width="5%">�û�ID</td>  --> 
                  	<td width="5%" >����</td> 
                  	<td width="5%" >�ǳ�</td>  
                  	<td width="5%" >�Ա�</td>
                  	<td width="5%" >�Ƿ����</td>
                  	<td width="5%" >APP״̬</td>
                  	<td width="5%" >��ǰ�豸</td> 
                  	<td width="8%" >ע��ʱ��</td>
                  	<td width="8%" >��¼ʱ��</td>                  	
                  	<td width="5%" >��Ŀ</td>
                  	<td width="5%" >������</td>
                    <td width="5%" >�û�����</td>
                    <td width="5%" >��������</td>
                    <td width="5%" >����</td>
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
						<td>
						<logic:empty name="element" property="email">��</logic:empty>
						<logic:notEmpty name="element" property="email">
						<bean:write name="element" property="email"/>
						</logic:notEmpty>
						</td>
                      <!-- format="yyyy-MM-dd HH:mm:ss -->		
                      				
						<td><bean:write name="element" property="passwd"/></td>
						<td>
						<logic:empty name="element" property="nickname">��</logic:empty>
						<logic:notEmpty name="element" property="nickname">
						<bean:write name="element" property="nickname"/>
					</logic:notEmpty>
						</td>
						
						<td>
						<logic:equal name="element" property="sex" value="0">��</logic:equal>
						<logic:equal name="element" property="sex" value="1">Ů</logic:equal>
						</td>
						<td>
						<logic:equal name="element" property="status" value="0"><font color="red">��</font></logic:equal>
						<logic:equal name="element" property="status" value="1">��</logic:equal>
						</td>
						
						<td>
						<logic:equal name="element" property="login_status" value="0"><font color="red">����APPҲ���ں�̨</font></logic:equal>
						<logic:equal name="element" property="login_status" value="1"><font color="green">����APP����ǰ̨</font></logic:equal>
						<logic:equal name="element" property="login_status" value="2"><font color="blue">����APP���ں�̨</font></logic:equal>
						</td>
						<td>
							<logic:empty name="element" property="act_device_id">��</logic:empty>
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
							<logic:empty name="element" property="belong_project">��</logic:empty>
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
						<logic:equal name="element" property="user_type" value="0">�����˺�</logic:equal>
						<logic:equal name="element" property="user_type" value="1">�����˺�</logic:equal>
						<logic:equal name="element" property="user_type" value="2">facebook�˺�</logic:equal>
						</td>
						
						<td>
						<logic:empty name="element" property="pet_count">��</logic:empty>
						<logic:notEmpty name="element" property="pet_count">
						<bean:write name="element" property="pet_count" />
						</logic:notEmpty></td>		
						
						<td> 
						<a href=# onclick="deleteDynamicInfo('<bean:write name="element" property="user_id" />')" style="color:#0000FF" > ��ɾ����</a> 
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