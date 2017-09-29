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
<title>无标题文档</title>
</head>
<script language="javascript">
function onAdd(){
	if(frmGo.promotionCode.value.trim() == ""){
		alert("优惠券不能为空!");
		frmGo.promotionCode.focus();
		return false;
	}
		var phoneNo = document.getElementById("discountRate").value;
	if(frmGo.discountRate.value.trim() == ""){
		alert("折扣率不能为空!");
		frmGo.discountRate.focus();
		return false;
	}else{
		if(isNaN(phoneNo)){
			alert("折扣率必须为数字！");
			//document.getElementById("ulfq").focus();
			return false;
		}else{
			if(phoneNo>100){
				alert("折扣率必须小于100！");
				//document.getElementById("ulfq").focus();
				return false;
			}
		}
	}
	
	
	var useCount = document.getElementById("useCount").value;
	if(frmGo.useCount.value.trim() == ""){
		alert("使用次数不能为空!");
		frmGo.useCount.focus();
		return false;
	}else{
		if(isNaN(useCount)){
			alert("使用次数必须为数字！");
			//document.getElementById("ulfq").focus();
			return false;
		}
	}
	
	
	if(frmGo.user.value.trim() == ""){
		alert("添加人不能为空!");
		frmGo.user.focus();
		return false;
	}
	
	if(frmGo.remark.value.trim() == ""){
		alert("备注不能为空!");
		frmGo.remark.focus();
		return false;
	}

	frmGo.submit();
}
Date.prototype.Format = function (fmt) {/*  author: meizz  */
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
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
                                    添加优惠券
        </th>
       </tr>
  <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;优惠券</td>
    <td align="left" width="20%" colspan="2">
      <input name="promotionCode" id="promotionCode" type="text" class="txt_1"maxlength="20"/>
<font color="red">已有优惠码不会添加成功</font>
    </td>
      <td><</font></td>
    </tr>
    
      <tr class="tr_11">
    <td align="left" width="12%">&nbsp;&nbsp;类型
 	</td>
    <td align="left" width="20%" colspan="2">
      <div style="margin-left: 10px;">优惠卡<input name="type" type="radio" class="radio_1" value="1" checked="checked" >
	    代金券<input type="radio" name="type" class="radio_1" value="2" >
      </div>
    </td>
    <td></td>
  </tr>
  
      <tr class="tr_11">
    <td align="left" width="12%">&nbsp;&nbsp;是否使用
 	</td>
    <td align="left" width="20%" colspan="2">
      <div style="margin-left: 10px;">
          是 <input name="cardStatus" type="radio" class="radio_1" value="1" checked="checked" >
	    否<input name="cardStatus" type="radio"  class="radio_1" value="0" >
      </div>
    </td>
    <td></td>
  </tr>
  
  <tr class="tr_11">
    <td align="left" width="12%">&nbsp;&nbsp;券类型
 	</td>
    <td align="left" width="20%" colspan="2">
      <div style="margin-left: 10px;">
          1年 <input name="cardType" type="radio" class="radio_1" value="1" checked="checked" >
	    半年<input name="cardType" type="radio"  class="radio_1" value="2" >
	    3个月<input name="cardType" type="radio"  class="radio_1" value="3" >
      </div>
    </td>
    <td></td>
  </tr>
  
   <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;折扣率</td>
    <td align="left" width="20%" colspan="2">
      <input name="discountRate" id="discountRate" type="text" class="txt_1"maxlength="20"/>
      <font color="red">请填写1到100的整数</font>
    </td>
    </tr>
    
      <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;使用次数</td>
    <td align="left" width="20%" colspan="2">
      <input name="useCount" id="useCount" type="text" class="txt_1"maxlength="20"/>
      <font color="red">请填写整数(0表示无限使用)</font>
    </td>
    </tr>
    
  
     <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;添加人</td>
    <td align="left" width="20%" colspan="2">
      <input name="user" id="user" type="text" class="txt_1"maxlength="20"/>
    </td>
    </tr>
     
  <tr class="tr_11">
    <td align="left" width="7%">&nbsp;&nbsp;备注</td>
    <td align="left" width="20%">
      <textarea name="remark" id="remark" rows="5" cols="50" class="txt_1"></textarea>
    </td>
    <td><font color="red">（字数不能超过30字）</font></td>
  </tr>
  <tr class="tr_11">
  	<td></td><td></td>
  </tr>
  <tr class="tr_11">
  <td width="7%"></td>
    <td align="left" colspan="2">&nbsp;&nbsp;&nbsp;<input type="button" name="ok"accesskey="y" tabindex="y"  value="确 定" class="but_1" onclick="onAdd()" style="font-size:12;width:40px;height:21px;">
      <input type="button" name="back"accesskey="b" tabindex="b" value="返 回" class="but_1" onclick="location='doSaleInfo.do?method=queryPromotionInfo'" style="font-size:12;width:40px;height:21px;">
  
    </td>
  </tr>
</table>
</form>
</body>
</html>