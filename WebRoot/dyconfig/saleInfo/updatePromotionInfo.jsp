<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import = "com.godoing.rose.http.common.*" %>
<%@ page import = "com.godoing.rose.lang.*" %>

<jsp:useBean id = "cancelsubInfo" scope = "request"  class = "com.godoing.rose.lang.DataMap"/>
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
	/*   var s2 = day2.getFullYear()+"-" + (day2.getMonth()+1) + "-" + day2.getDate();
	  alert(s2); */
	  
	    
	/*  var stopTime=frmGo.updateTime.value; */
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
<form name="frmGo" method="post" action="doSaleInfo.do?method=updatePromotionInfo" onsubmit="return onUpdate()">
<input name="id" type="hidden" value="<%=cancelsubInfo.getAt("id")%>" >
<input name="promotionCode" type="hidden" value="<%=cancelsubInfo.getAt("promotion_code")%>" >
<table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11"> 
  <tr>
     <th colspan="13" nowrap="nowrap" align="left">
                        �Ż�ȯ�޸�
     </th>
   </tr>

        
  <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;�Ż�ȯ</td>
    <td width="80%" align="left">
    	<%=cancelsubInfo.getAt("promotion_code")%>
    </td>
    </tr>
    
     <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;�Ƿ����ʹ��</td>
    <td width="20%" align="left">
    	<input name="cardStatus" type="radio" class="txt_1" value="0" <%=cancelsubInfo.getAt("card_status").equals("0")? "checked":"" %>>����
    	<input name="cardStatus" type="radio" class="txt_1" value="1" <%=cancelsubInfo.getAt("card_status").equals("1")? "checked":"" %> >����
    </td>
    <td align="left"></td>
  </tr>
  
  <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;�Ż�ȯ������</td>
    <td width="20%" align="left">
    	<input name="type" type="radio" class="txt_1" value="1" <%=cancelsubInfo.getAt("type").equals("1")? "checked":"" %>>�Żݿ�
    	<input name="type" type="radio" class="txt_1" value="2" <%=cancelsubInfo.getAt("type").equals("2")? "checked":"" %> >����ȯ
    </td>
    <td align="left"></td>
  </tr>
  
    <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;������</td>
    <td width="20%" align="left">
    	<input name="cardType" type="radio" class="txt_1" value="1" <%=cancelsubInfo.getAt("card_type").equals("1")? "checked":"" %>>1��
    	<input name="cardType" type="radio" class="txt_1" value="2" <%=cancelsubInfo.getAt("card_type").equals("2")? "checked":"" %> >����
    	<input name="cardType" type="radio" class="txt_1" value="3" <%=cancelsubInfo.getAt("card_type").equals("2")? "checked":"" %> >3����
    </td>
    <td align="left"></td>
  </tr>
    
      <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;�ۿ���</td>
    <td width="20%" align="left">
    	<input name="discountRate" id="discountRate" type="text" class="txt_1" maxlength="20" value="<%=cancelsubInfo.getAt("discount_rate")==null?" ":cancelsubInfo.getAt("discount_rate")%>"><font color="red">*</font>
    </td>
    <td align="left"><font></font></td>
  </tr>
  
      <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;ʹ�ô���</td>
    <td width="20%" align="left">
    	<input name="useCount" id="useCount" type="text" class="txt_1" maxlength="20" value="<%=cancelsubInfo.getAt("use_count")==null?" ":cancelsubInfo.getAt("use_count")%>"><font color="red">*</font>
    </td>
    <td align="left"><font></font></td>
  </tr>
  
       <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;��ע</td>
    <td width="20%" align="left">
    	<input name="remark" id="remark" type="text" class="txt_1" maxlength="20" value="<%=cancelsubInfo.getAt("remark")==null?" ":cancelsubInfo.getAt("remark")%>"><font color="red">*</font>
    </td>
    <td align="left"><font></font></td>
  </tr>
    
   <tr class="tr_11">
  	<td></td><td></td>
  </tr>
  <tr class="tr_11">
  <td width="7%"></td>
    <td align="left" colspan="2">&nbsp;&nbsp;&nbsp;<input type="button" name="ok"accesskey="y" tabindex="y"  value="ȷ ��" class="but_1" onclick="onUpdate()" style="font-size:12;width:40px;height:21px;">
      <input type="button" name="back"accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doSaleInfo.do?method=queryPromotionInfo'" style="font-size:12;width:40px;height:21px;">
  
    </td>
  </tr>
</table>
</form>
</body>
</html>