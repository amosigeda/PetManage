<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<%@ page autoFlush="true"%>
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
	<script type="text/javascript">
		function add(){
		    /* if(frmGo.belongProject.value == ""){
			   alert("请选择项目");
			   return false;
			} */
			if(frmGo.serieNo.value.trim() == ""){
				alert("IMEI号不能为空");
				frmGo.serieNo.focus();
				return false;
			}
			
			if(frmGo.iccid.value.trim() == ""){
				alert("ICCID不能为空");
				frmGo.iccid.focus();
				return false;
			}
			if(frmGo.imsi.value.trim() == ""){
				alert("IMSI号不能为空");
				frmGo.imsi.focus();
				return false;
			}
			/* else{
				var no = frmGo.serieNo.value;
				var reg = /^\d{15}$/;
				if(!reg.test(no)){
					alert("IMEI号格式不正确");
					frmGo.serieNo.focus();
					return false;
				}
			}	 */	
			/* if(frmGo.countNum.value > 100){
			    alert("手动输入的最大值为100");
			    return false;
			}	 */
			
		/* 	if(frmGo.countNum.value.trim() == ""){
				alert("数量不能为空");
				frmGo.countNum.focus();
				return false;
			}
			if(frmGo.countNum.value <= 0){	
			    alert("手动输入的最小值为1");
			    return false;
			}		 */
				
			frmGo.submit();
		}
	</script>
	<body>
		<br><span class="title_1"></span>
<form name="frmGo" method="post" action="doPhoneInfo.do?method=singleImeiIccidImsi" onsubmit="return onAdd()">
  	<table>
  
  		<tr>
  			<td>IMEI:</td>
  			<td><input type="text" name="serieNo" id="serieNo" size="25"/></td>
  		</tr>
  			<tr>
  			<td>ICCID:</td>
  			<td><input type="text" name="iccid" id="iccid" size="25"/></td>
  		</tr>
  			<tr>
  			<td>IMSI:</td>
  			<td><input type="text" name="imsi" id="imsi" size="25"/></td>
  		</tr>
  		
  		<tr>
  			<td>项目:</td>
  			<td >
     PABY<input name="type" type="radio" value="1" checked="checked" >
	<!--     量产<input type="radio" name="type"  value="2" > -->
    </td>
  			</tr>
  			
  	<!-- 	<tr>
  			<td>数量:</td>
  			<td><input type="number" name="countNum" id="countNum"/></td>
  		</tr> -->
  		<tr></tr>
  	</table>
  	
    <input type="button" name="back"accesskey="b" tabindex="b" value="返 回" class="but_1" onclick="location='doPhoneInfo.do?method=initInsert'"  style="font-size:12;width:50px;height:21px;">
	<input type="button" name="ok"accesskey="y" tabindex="y"  value="确认" class="but_1" onclick="add()" style="font-size:12;width:50px;height:21px;" >
</form>
	</body>
</html>