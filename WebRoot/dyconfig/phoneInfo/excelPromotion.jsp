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
<!-- 	<style type="text/css">
    table{
        border:1px solid;
        width:50px;
        height:30px;

}

</style> -->

	<script type="text/javascript">
		function add(){
			frmGo.submit();	
		}
	</script>
	<body>
		<br><span class="title_1"></span>
<form name="frmGo" method="post" action="doPhoneInfo.do?method=excelPromotion" encType="multipart/form-data" onsubmit="return onAdd()">
  		<p>	����ȯ�Żݿ�¼��:</p>
  <br/>
  	<logic:iterate name="list" id="element">
  		<input type="radio" name="belongProject" value="<bean:write name="element" property="id"/>"/>
  		<bean:write name="element" property="project_name"/>
  	</logic:iterate>
  
  	<input name="file1" type="file"/><br/>
  		<tr>
  			<td>����:</td>
  			<td >
   �Żݿ�  <input name="type" type="radio" value="1" checked="checked" >
       ����ȯ <input name="type" type="radio" value="2"  >
	<!--     ����<input type="radio" name="type"  value="2" > -->
    </td>
  			</tr><br/>
  			
  				
  			
  				<tr>
  			<td>ʹ�ô���:</td>
  			<td >
   һ�� <input name="usecount" type="radio" value="1" checked="checked" >
     ���޴�  <input name="usecount" type="radio" value="0"  >
	<!--     ����<input type="radio" name="type"  value="2" > -->
    </td>
  			</tr><br/>
  			
  				<tr>
  			<td>�ۿ���(����ȯ�ۿ���ѡʲô���ǰٷְ�)����λ:%��:</td>
  			<td >
   10<input name="zhekou" type="radio" value="10" checked="checked" >
     100  <input name="zhekou" type="radio" value="100"  >
	<!--     ����<input type="radio" name="type"  value="2" > -->
    </td>
  			</tr><br/>
  			
  		
  			<br/>
  			
  			ʾ��:(���һ��Ϊ�Ż�ȯ���ߴ���ȯ)<br/>
  			  <table border="1" width="400">

            <tr>                    <!--һ��-->

                <td>111</td>        <!--һ��-->

                <td></td>
                <td></td>
 <td></td>
            </tr>
             <tr>                    <!--һ��-->

                <td>222</td>        <!--һ��-->

                <td></td>
 <td></td>
  <td></td>
            </tr>
             <tr>                    <!--һ��-->

                <td>333</td>        <!--һ��-->

                <td></td>
 <td></td>
  <td></td>
            </tr>
             <tr>                    <!--һ��-->

                <td>444</td>        <!--һ��-->

                <td></td>
 <td></td>
  <td></td>
            </tr>
             <tr>                    <!--һ��-->

                <td>555</td>        <!--һ��-->

                <td></td>
 <td></td>
  <td></td>
            </tr>
            </table>
   
    <input type="button" name="back"accesskey="b" tabindex="b" value="�� ��" class="but_1" onclick="location='doPhoneInfo.do?method=initInsert'"  style="font-size:12;width:50px;height:21px;">
	<input type="button" name="ok"accesskey="y" tabindex="y"  value="ȷ��" class="but_1" onclick="add()" style="font-size:12;width:50px;height:21px;" >
</form>
	</body>
</html>