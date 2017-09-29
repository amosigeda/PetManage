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
<title>无标题文档</title>
</head>
<script language="javascript">
function onUpdate(){
	var stopTime=frmGo.updateTime.value;
	/*   var s2 = day2.getFullYear()+"-" + (day2.getMonth()+1) + "-" + day2.getDate();
	  alert(s2); */
	  
	    
	/*  var stopTime=frmGo.updateTime.value; */
	
	if(stopTime.trim() == ''){
		alert("日期不能为空");
		frmGo.updateTime.focus();
		return false;
	}
	
	var a = /^(\d{4})-(\d{2})-(\d{2})$/;
	if(!a.test(stopTime)){
		alert("请输入正确的日期格式!");
		frmGo.updateTime.focus();
		return false;
	}

	  var day2 = new Date();
	  day2.setTime(day2.getTime());
	  var jintian=day2.Format("yyyy-MM-dd");
	  
	  var gaide=new Date(stopTime).getTime();
	  var jintianb=new Date(jintian).getTime();
	  
	  if(gaide<=jintianb){
		  alert("请输入大于今天的日期");
			frmGo.updateTime.focus();
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
<form name="frmGo" method="post" action="doSaleInfo.do?method=updateXinXi" onsubmit="return onUpdate()">
<input name="id" type="hidden" value="<%=cancelsubInfo.getAt("id")%>" >
<input name="iccid" type="hidden" value="<%=cancelsubInfo.getAt("iccid")%>" >
<table width="100%" border="0"cellpadding="0" cellspacing="1"  class="tbl_11"> 
  <tr>
     <th colspan="13" nowrap="nowrap" align="left">
                        SIM卡到期日期修改
     </th>
   </tr>

        
  <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;ICCID</td>
    <td width="80%" align="left">
    	<%=cancelsubInfo.getAt("iccid")%>
    </td>
    </tr>
    
    
     <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;订阅日期</td>
    <td width="80%" align="left">
   <input type="text" name="date_time" name="date_time" id="date_time"  value=<%=cancelsubInfo.getAt("date_time")%> readonly style="border-style:none">
   </td>
    </tr>
    
     <tr class="tr_11">
    <td width="7%" align="left">&nbsp;&nbsp;到期日期</td>
    <td width="80%" align="left">
    	 <input type="text" name="stop_time" name="stop_time" id="stop_time"  value=<%=cancelsubInfo.getAt("stop_time")%> readonly style="border-style:none">
   
    </td>
    </tr>
     <td width="7%" align="left">&nbsp;&nbsp;改为</td>
    <td align="left" width="20%" colspan="2">
      <input name="updateTime" id="updateTime" type="text" class="txt_1"maxlength="20"/><font color="red">*（日期格式为2010-01-01）</font>
    </td>
    
  <tr  class="tr_11"> 
    <td></td>
    <td  align="left"><input type="button" name="ok" accesskey="y" tabindex="y"  value="确 定" class="but_1" onclick="onUpdate()">
      <input type="button" name="back" accesskey="b" tabindex="b" value="返 回" class="but_1" onclick="location='doSaleInfo.do?method=queryCancelSubInfo'">
       <input type="reset" name="back" accesskey="b" tabindex="b" value="重置" class="but_1" >
    </td>	     
  </tr>
</table>
</form>
</body>
</html>