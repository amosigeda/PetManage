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
  		<p>	代金券优惠卡录入:</p>
  <br/>
  	<logic:iterate name="list" id="element">
  		<input type="radio" name="belongProject" value="<bean:write name="element" property="id"/>"/>
  		<bean:write name="element" property="project_name"/>
  	</logic:iterate>
  
  	<input name="file1" type="file"/><br/>
  		<tr>
  			<td>类型:</td>
  			<td >
   优惠卡  <input name="type" type="radio" value="1" checked="checked" >
       代金券 <input name="type" type="radio" value="2"  >
	<!--     量产<input type="radio" name="type"  value="2" > -->
    </td>
  			</tr><br/>
  			
  				
  			
  				<tr>
  			<td>使用次数:</td>
  			<td >
   一次 <input name="usecount" type="radio" value="1" checked="checked" >
     无限次  <input name="usecount" type="radio" value="0"  >
	<!--     量产<input type="radio" name="type"  value="2" > -->
    </td>
  			</tr><br/>
  			
  				<tr>
  			<td>折扣率(代金券折扣率选什么都是百分百)（单位:%）:</td>
  			<td >
   10<input name="zhekou" type="radio" value="10" checked="checked" >
     100  <input name="zhekou" type="radio" value="100"  >
	<!--     量产<input type="radio" name="type"  value="2" > -->
    </td>
  			</tr><br/>
  			
  		
  			<br/>
  			
  			示例:(左边一侧为优惠券或者代金券)<br/>
  			  <table border="1" width="400">

            <tr>                    <!--一行-->

                <td>111</td>        <!--一列-->

                <td></td>
                <td></td>
 <td></td>
            </tr>
             <tr>                    <!--一行-->

                <td>222</td>        <!--一列-->

                <td></td>
 <td></td>
  <td></td>
            </tr>
             <tr>                    <!--一行-->

                <td>333</td>        <!--一列-->

                <td></td>
 <td></td>
  <td></td>
            </tr>
             <tr>                    <!--一行-->

                <td>444</td>        <!--一列-->

                <td></td>
 <td></td>
  <td></td>
            </tr>
             <tr>                    <!--一行-->

                <td>555</td>        <!--一列-->

                <td></td>
 <td></td>
  <td></td>
            </tr>
            </table>
   
    <input type="button" name="back"accesskey="b" tabindex="b" value="返 回" class="but_1" onclick="location='doPhoneInfo.do?method=initInsert'"  style="font-size:12;width:50px;height:21px;">
	<input type="button" name="ok"accesskey="y" tabindex="y"  value="确认" class="but_1" onclick="add()" style="font-size:12;width:50px;height:21px;" >
</form>
	</body>
</html>