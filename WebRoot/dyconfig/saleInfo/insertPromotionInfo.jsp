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
	if(frmGo.promotionCode.value.trim() == ""){
		alert("�Ż�ȯ����Ϊ��!");
		frmGo.promotionCode.focus();
		return false;
	}
		var phoneNo = document.getElementById("discountRate").value;
	if(frmGo.discountRate.value.trim() == ""){
		alert("�ۿ��ʲ���Ϊ��!");
		frmGo.discountRate.focus();
		return false;
	}else{
		if(isNaN(phoneNo)){
			alert("�ۿ��ʱ���Ϊ���֣�");
			//document.getElementById("ulfq").focus();
			return false;
		}else{
			if(phoneNo>100){
				alert("�ۿ��ʱ���С��100��");
				//document.getElementById("ulfq").focus();
				return false;
			}
		}
	}
	
	
	var useCount = document.getElementById("useCount").value;
	if(frmGo.useCount.value.trim() == ""){
		alert("ʹ�ô�������Ϊ��!");
		frmGo.useCount.focus();
		return false;
	}else{
		if(isNaN(useCount)){
			alert("ʹ�ô�������Ϊ���֣�");
			//document.getElementById("ulfq").focus();
			return false;
		}
	}
	
	
	if(frmGo.user.value.trim() == ""){
		alert("����˲���Ϊ��!");
		frmGo.user.focus();
		return false;
	}
	
	if(frmGo.remark.value.trim() == ""){
		alert("��ע����Ϊ��!");
		frmGo.remark.focus();
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
<form name="frmGo" method="post" action="doSaleInfo.do?method=insertPromotionInfo" onsubmit="return onAdd()">
<% LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER);
	String loginUserCode = loginUser.getUserCode();
%>
<!-- <input type="hidden" name="addUser" value="<%=loginUserCode %>"> -->
<table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11">
  <tr>
        <th colspan="3" nowrap="nowrap" align="left">
                                    ����Ż�ȯ
        </th>
       </tr>
  <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;�Ż�ȯ</td>
    <td align="left" width="20%" colspan="2">
      <input name="promotionCode" id="promotionCode" type="text" class="txt_1"maxlength="20"/>
<font color="red">�����Ż��벻����ӳɹ�</font>
    </td>
      <td><</font></td>
    </tr>
    
      <tr class="tr_11">
    <td align="left" width="12%">&nbsp;&nbsp;����
 	</td>
    <td align="left" width="20%" colspan="2">
      <div style="margin-left: 10px;">�Żݿ�<input name="type" type="radio" class="radio_1" value="1" checked="checked" >
	    ����ȯ<input type="radio" name="type" class="radio_1" value="2" >
      </div>
    </td>
    <td></td>
  </tr>
  
      <tr class="tr_11">
    <td align="left" width="12%">&nbsp;&nbsp;�Ƿ�ʹ��
 	</td>
    <td align="left" width="20%" colspan="2">
      <div style="margin-left: 10px;">
          �� <input name="cardStatus" type="radio" class="radio_1" value="1" checked="checked" >
	    ��<input name="cardStatus" type="radio"  class="radio_1" value="0" >
      </div>
    </td>
    <td></td>
  </tr>
  
  <tr class="tr_11">
    <td align="left" width="12%">&nbsp;&nbsp;ȯ����
 	</td>
    <td align="left" width="20%" colspan="2">
      <div style="margin-left: 10px;">
          1�� <input name="cardType" type="radio" class="radio_1" value="1" checked="checked" >
	    ����<input name="cardType" type="radio"  class="radio_1" value="2" >
	    3����<input name="cardType" type="radio"  class="radio_1" value="3" >
      </div>
    </td>
    <td></td>
  </tr>
  
   <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;�ۿ���</td>
    <td align="left" width="20%" colspan="2">
      <input name="discountRate" id="discountRate" type="text" class="txt_1"maxlength="20"/>
      <font color="red">����д1��100������</font>
    </td>
    </tr>
    
      <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;ʹ�ô���</td>
    <td align="left" width="20%" colspan="2">
      <input name="useCount" id="useCount" type="text" class="txt_1"maxlength="20"/>
      <font color="red">����д����(0��ʾ����ʹ��)</font>
    </td>
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
      <input type="button" name="back"accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doSaleInfo.do?method=queryPromotionInfo'" style="font-size:12;width:40px;height:21px;">
  
    </td>
  </tr>
</table>
</form>
</body>
</html>