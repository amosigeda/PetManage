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

	<body>
		<span class="title_1"></span>
<form name="frm" method="post" action="doPhoneInfo.do?method=addImei" onsubmit="return onAdd()">
  <p>��ѡ��¼������:</p>
  	<!-- <input type="radio" name="addType" value="0" checked="checked"/>�ֶ�¼�� -->
  	1.<input type="radio" name="addType" value="1" />Excel-IMEI-ICCID¼��</br>
  	  <!-- 	<input type="radio" name="addType" value="2"/>�ı�¼��  -->
  	2.<input type="radio" name="addType" value="3" />Excel-IMEI-¼��</br>
  		3.<input type="radio" name="addType" value="4" />Excel-ICCID-IMSI-¼��</br>
  		4.<input type="radio" name="addType" value="5" />����IMEI-¼��</br>
  		5.<input type="radio" name="addType" value="6" />����IMEI-ICCID-IMSI--¼��</br>
  		6.<input type="radio" name="addType" value="7" />����ICCID-IMSI--¼��</br>
  		7.<input type="radio" name="addType" value="8" />����IMEI-ICCID--¼��</br>
  		8.<input type="radio" name="addType" value="9" />EXCEL-IMEI-ICCID-IMSI-¼��</br>
  			9.<input type="radio" name="addType" value="10" />IMEI-SN-¼��</br>
  			10.<input type="radio" name="addType" value="11" />�Ż�ȯ����ȯ-¼��</br>
  	<br/>
    <input type="button" name="back"accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doPhoneInfo.do?method=queryPhoneInfo'"  style="font-size:12;width:50px;height:21px;">
	<input type="submit" name="ok"accesskey="y" tabindex="y"  value="��һ��" class="but_1" style="font-size:12;width:50px;height:21px;" >
</form>
	</body>
</html>