<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import = "com.godoing.rose.http.common.*" %>
<%@ page import = "com.godoing.rose.lang.*" %>
<jsp:useBean id = "roleInfo" scope = "request" class = "com.godoing.rose.lang.DataMap"/>
<%@ page autoFlush="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/public/public.js"></script>
<title>�ޱ����ĵ�</title>
</head>
<script language="javascript">
function onUpdate(){
	if(frm.roleDesc.value.trim() == ''){
		alert("��������Ϊ��");
		frm.roleDesc.focus();
		return false;
	}else if(frm.roleDesc.value.trim().length > 30){
		alert("�������ܳ���30��");
		frm.roleDesc.focus();
		return false;
	}
}
</script>
<body>
<span class="title_1"> </span>
<form name="frm" method="post" action="doRoleInfo.do?method=permissionUpdate" onsubmit="return onUpdate()">
 <input name="roleCode" type="hidden" value="<%=roleInfo.getAt("role")%>" >
<%--<input name="roleName" type="hidden" value="<%=roleInfo.getAt("roleName")%>" >
 <input name="roleType" type="hidden" value="<%=roleInfo.getAt("roleType") %>" /> --%>
<table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11">
  <tr>
     <th colspan="3" nowrap="nowrap" align="left">
                           Ȩ��ѡ��
     </th>
   </tr>
 <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;ϵͳ����</td>
    <td width="20%" align="left">
    	<input name="systemFunction" type="radio" class="txt_1" value="1" <%=roleInfo.getAt("system_function").equals("1")? "checked":"" %> >��
    	<input name="systemFunction" type="radio" class="txt_1" value="0" <%=roleInfo.getAt("system_function").equals("0")? "checked":"" %>>��
    </td>
    <td align="left"></td>
  </tr>
  
   <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;ע���</td>
    <td width="20%" align="left">
    	<input name="registBind" type="radio" class="txt_1" value="1" <%=roleInfo.getAt("regist_bind").equals("1")? "checked":"" %> >��
    	<input name="registBind" type="radio" class="txt_1" value="0" <%=roleInfo.getAt("regist_bind").equals("0")? "checked":"" %>>��
    </td>
    <td align="left"></td>
  </tr>
  
   <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;APP����</td>
    <td width="20%" align="left">
    	<input name="appInteraction" type="radio" class="txt_1" value="1" <%=roleInfo.getAt("app_interaction").equals("1")? "checked":"" %> >��
    	<input name="appInteraction" type="radio" class="txt_1" value="0" <%=roleInfo.getAt("app_interaction").equals("0")? "checked":"" %>>��
    </td>
    <td align="left"></td>
  </tr>
   <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;�豸����</td>
    <td width="20%" align="left">
    	<input name="deviceData" type="radio" class="txt_1" value="1" <%=roleInfo.getAt("device_data").equals("1")? "checked":"" %> >��
    	<input name="deviceData" type="radio" class="txt_1" value="0" <%=roleInfo.getAt("device_data").equals("0")? "checked":"" %>>��
    </td>
    <td align="left"></td>
  </tr>
   <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;SIM����Ϣ</td>
    <td width="20%" align="left">
    	<input name="simInfo" type="radio" class="txt_1" value="1" <%=roleInfo.getAt("sim_info").equals("1")? "checked":"" %> >��
    	<input name="simInfo" type="radio" class="txt_1" value="0" <%=roleInfo.getAt("sim_info").equals("0")? "checked":"" %>>��
    </td>
    <td align="left"></td>
  </tr>
  
  
  <tr><td>&nbsp;</td></tr>
  <tr class="tr_11" align="center">
  	<td></td>
    <td align="left">
    	&nbsp;&nbsp;<input type="submit" name="ok" accesskey="y" tabindex="y"  value="ȷ��" class="but_1" style="font-size:11;width:40px;height:21px;" onclick="onUpdate()">
      	<input type="button" name="back" accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doRoleInfo.do?method=queryRoleInfo'" style="font-size:11;width:40px;height:21px;">  
    </td>
  </tr>
</table>
</form>
</body>
</html>
