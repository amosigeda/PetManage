<%@ page language="java" contentType="text/html;charset=GB2312"%>
<%@ page autoFlush="true" %>
<%@ page import="com.care.app.LoginUser"%>
<%@ page import="com.care.common.config.Config"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=request.getContextPath()%>/css/tbls.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="<%=request.getContextPath()%>/public/public.js"></script>
<title>�ޱ����ĵ�</title>
</head>
<script language="javascript">
function onAdd(){
	if(frmGo.iccid.value.trim() == ""){
		alert("ICCID����Ϊ��!");
		frmGo.iccid.focus();
		return false;
	}

	var stopTime=frmGo.updateTime.value;
	/*   var s2 = day2.getFullYear()+"-" + (day2.getMonth()+1) + "-" + day2.getDate();
	  alert(s2); */
	  
	    
	/*  var stopTime=frmGo.updateTime.value; */
	
	if(stopTime.trim() == ''){
		alert("���ڲ���Ϊ��");
		frmGo.updateTime.focus();
		return false;
	}
	
	var a = /^(\d{4})-(\d{2})-(\d{2})$/;
	if(!a.test(stopTime)){
		alert("��������ȷ�����ڸ�ʽ!");
		frmGo.updateTime.focus();
		return false;
	}

	  var day2 = new Date();
	  day2.setTime(day2.getTime());
	  var jintian=day2.Format("yyyy-MM-dd");
	  
	  var gaide=new Date(stopTime).getTime();
	  var jintianb=new Date(jintian).getTime();
	  
	  if(gaide<=jintianb){
		  alert("��������ڽ��������");
			frmGo.updateTime.focus();
			return false;
	  }
	frmGo.submit();
}
Date.prototype.Format = function (fmt) {/*  author: meizz  */
    var o = {
        "M+": this.getMonth() + 1, //�·� 
        "d+": this.getDate(), //�� 
        "h+": this.getHours(), //Сʱ 
        "m+": this.getMinutes(), //�� 
        "s+": this.getSeconds(), //�� 
        "q+": Math.floor((this.getMonth() + 3) / 3), //���� 
        "S": this.getMilliseconds() //���� 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
</script>
<body>
<span class="title_1"></span>
<form name="frmGo" method="post" action="doSaleInfo.do?method=insertCancelSubInfo" onsubmit="return onAdd()">
<% LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
	String loginUserCode = loginUser.getUserCode();
%>
<!-- <input type="hidden" name="addUser" value="<%=loginUserCode %>"> -->
<table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11">
  <tr>
        <th colspan="3" nowrap="nowrap" align="left">
                                    ���sim��������Ϣ
        </th>
       </tr>
  <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;ICCID</td>
    <td align="left" width="20%" colspan="2">
      <input name="iccid" id="iccid" type="text" class="txt_1"maxlength="20"/>
    </td>
    </tr>
      <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;����ʱ��</td>
    <td align="left" width="20%" colspan="2">
     <input name="updateTime" id="updateTime" type="text" class="txt_1"maxlength="20"/><font color="red">*�����ڸ�ʽΪ2010-01-01��</font>
    </td>
    </tr>
    
     <tr class="tr_11">
    <td align="left" width="12%">&nbsp;&nbsp;sim����˾
 	</td>
    <td align="left" width="20%" colspan="2">
      <div style="margin-left: 10px;">��ʩ�� <input name="radio" type="radio" class="radio_1" value="1" checked="checked" >
	    twilio<input type="radio" name="radio" class="radio_1" value="2" >
      </div>
    </td>
    <td></td>
  </tr>
  
     <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;�����</td>
    <td align="left" width="20%" colspan="2">
      <input name="user" id="user" type="text" class="txt_1"maxlength="20"/>
    </td>
    </tr>
     
  <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;��ע</td>
    <td align="left" width="20%">
      <textarea name="remark" id="remark" rows="5" cols="50" class="txt_1"></textarea>
    </td>
    <td><font color="red">���������ܳ���30�֣�</font></td>
  </tr>
  <tr class="tr_11">
  	<td></td><td></td>
  </tr>
  <tr class="tr_11">
  <td width="7%"></td>
    <td align="left" colspan="2">&nbsp;&nbsp;&nbsp;<input type="button" name="ok"accesskey="y" tabindex="y"  value="ȷ ��" class="but_1" onclick="onAdd()" style="font-size:12;width:40px;height:21px;">
      <input type="button" name="back"accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doSaleInfo.do?method=queryCancelSubInfo'" style="font-size:12;width:40px;height:21px;">
  
    </td>
  </tr>
</table>
</form>
</body>
</html>