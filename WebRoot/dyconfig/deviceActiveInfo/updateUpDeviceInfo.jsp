<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import = "com.godoing.rose.http.common.*" %>
<%@ page import = "com.godoing.rose.lang.*" %>

<jsp:useBean id = "deviceInfo" scope = "request"  class = "com.godoing.rose.lang.DataMap"/>
<%@ page autoFlush="true" %>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/public/public.js"></script>
<title>无标题文档</title>
</head>
<script language="javascript">
function onUpdate(){
	
	var phoneNo = document.getElementById("ulfq").value;
	if(isNaN(phoneNo)){
		alert("步数必须为数字！");
		//document.getElementById("ulfq").focus();
		return false;
	}
	
	/* if(frmGo.companyName.value.trim() == ''){
		alert("公司名称不能为空");
		frmGo.ProjectName.focus();
		return false;
	}
	if(frmGo.companyName.value.trim().length > 10){
		alert("字数不能超过10字");
		frmGo.remark.focus();
		return false;
	}
	if(frmGo.remark.value.trim().length > 30){
		alert("字数不能超过30字");
		frmGo.remark.focus();
		return false;
	} */
	frmGo.submit();
}


</script>
<body>
<span class="title_1"></span>
<form name="frmGo" method="post" action="doDeviceActiveInfo.do?method=updateUpDeviceInfo" onsubmit="return onUpdate()">
<input name="device_id" type="hidden" value="<%=deviceInfo.getAt("device_id")%>" >
<table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11"> 
  <tr>
     <th colspan="13" nowrap="nowrap" align="left">
                          设备步数配置
     </th>
   </tr>
  <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;imei</td>
  
    <td width="20%" align="left">
    	<input name="device_imei" id="device_imei" type="text" class="txt_1" maxlength="20" value="<%=deviceInfo.getAt("device_imei")==null?" ":deviceInfo.getAt("device_imei")%>" readonly></font>
    </td>
  </tr>
  
   <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;步数</td>
      <td width="20%" align="left">
    	<input  name="ulfq" id="ulfq" type="text" class="txt_1" maxlength="20" value="<%=deviceInfo.getAt("ulfq")==null?" ":deviceInfo.getAt("ulfq")%>" ></font>
    </td>
   
   
  </tr>
 
  <tr  class="tr_11"> 
    <td></td>
    <td  align="left">&nbsp;&nbsp;&nbsp;<input type="button" name="ok" accesskey="y" tabindex="y"  value="确 定" class="but_1" onclick="onUpdate()">
	
      <input type="button" name="back" accesskey="b" tabindex="b" value="返 回" class="but_1" onclick="location='doDeviceActiveInfo.do?method=queryDeviceActiveInfo'">
       <input type="reset" name="back" accesskey="b" tabindex="b" value="重置" class="but_1" >
    </td>	     
    </td>
    <td></td>
  </tr>
</table>
</form>
</body>
</html>