<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<%@ page autoFlush="true"%>
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
	<script type="text/javascript">
		function add(){
		    /* if(frmGo.belongProject.value == ""){
			   alert("��ѡ����Ŀ");
			   return false;
			} */
			if(frmGo.serieNo.value.trim() == ""){
				alert("IMEI�Ų���Ϊ��");
				frmGo.serieNo.focus();
				return false;
			}
			
			if(frmGo.iccid.value.trim() == ""){
				alert("ICCID����Ϊ��");
				frmGo.iccid.focus();
				return false;
			}
			if(frmGo.imsi.value.trim() == ""){
				alert("IMSI�Ų���Ϊ��");
				frmGo.imsi.focus();
				return false;
			}
			/* else{
				var no = frmGo.serieNo.value;
				var reg = /^\d{15}$/;
				if(!reg.test(no)){
					alert("IMEI�Ÿ�ʽ����ȷ");
					frmGo.serieNo.focus();
					return false;
				}
			}	 */	
			/* if(frmGo.countNum.value > 100){
			    alert("�ֶ���������ֵΪ100");
			    return false;
			}	 */
			
		/* 	if(frmGo.countNum.value.trim() == ""){
				alert("��������Ϊ��");
				frmGo.countNum.focus();
				return false;
			}
			if(frmGo.countNum.value <= 0){	
			    alert("�ֶ��������СֵΪ1");
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
  			<td>��Ŀ:</td>
  			<td >
     PABY<input name="type" type="radio" value="1" checked="checked" >
	<!--     ����<input type="radio" name="type"  value="2" > -->
    </td>
  			</tr>
  			
  	<!-- 	<tr>
  			<td>����:</td>
  			<td><input type="number" name="countNum" id="countNum"/></td>
  		</tr> -->
  		<tr></tr>
  	</table>
  	
    <input type="button" name="back"accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doPhoneInfo.do?method=initInsert'"  style="font-size:12;width:50px;height:21px;">
	<input type="button" name="ok"accesskey="y" tabindex="y"  value="ȷ��" class="but_1" onclick="add()" style="font-size:12;width:50px;height:21px;" >
</form>
	</body>
</html>