<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<%@ page autoFlush="true"%>
<%
	/*ҳ������*/
	PagePys pys = (PagePys) request.getAttribute("PagePys");
	LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER); 
%>

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
	<script language="javascript">
	function finds(){
   /*  var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
		return false;
	} */
	   frmGo.submit();
}
	function c(){
		document.all.youhuijuan.value="";
    	/* document.all.endTime.value="";
   		document.all.userName.value="";   
   		document.all.projectId.value="";  */  
	} 
	function insert(){
		frmGo.action = "doSaleInfo.do?method=initInsertPromotion";
		frmGo.submit();
	}

	//�޸��˻�				
	function update(id)
	{
		frmGo.action="doSaleInfo.do?method=initUpdatePromotion&id="+id;
		frmGo.submit();
	}
	
	</script>
	<body>
		<span class="title_1"></span>
		<form name="frmGo" method="post" action="doSaleInfo.do?method=queryPromotionInfo">						
			<table width="100%" class="table" border=0 cellpadding="0" cellspacing="1">
               <tr>
                <th colspan="14" nowrap="nowrap" align="left">
                                         �Ż�ȯ��Ϣ
                                           <input name="inset" type="button" class="but_1" accesskey="a"
							tabindex="a" value="�� ��" onclick="insert()">
                </th>
                </tr>            
                 <tr class="title_3">
                       <td colspan="14">	
                                         <%--                   ����ʱ��
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>	 --%>			
						�Ż�ȯ				
						    <input id="youhuijuan" name="youhuijuan" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"youhuijuan");%>" size="20">
						
				<%-- 	��Ŀ��		
						<%String projectId = (String)request.getAttribute("projectId"); %>			
							<select id="projectId" name="projectId" >
								<option value="">ȫ��</option>
								<logic:iterate id="pro" name="project">
									<bean:define id="project" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=project %>' <%=String.valueOf(project).equals(projectId)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select>		 --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="�� ��" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="�������" onclick="c()">
				</tr> 
                  <tr class="title_2">     
                  	<td width="10%">�Ż�ȯ</td> 
                  	<td width="10%" >�Ƿ����ʹ��</td>
                  	<td width="10%" >����</td>
                  	<td width="10%" >������</td>
                  	<td width=10%" >�ۿ���</td>
                  	<td width="10%" >��ʹ�ô���(0��ʾ���޴�)</td>
                  	<td width="10%" >����ʱ��</td>
                  	<td width="10%" >�����</td>
                  	<td width="10%" >��ע</td>
                  	<td width="10%" >����</td>
                  	           	
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
						
							<td>
						<logic:empty name="element" property="promotion_code">��</logic:empty>
						<logic:notEmpty name="element" property="promotion_code">						  
						     <bean:write name="element" property="promotion_code"/>
						     </logic:notEmpty>
						</td>	
						
							
						<td>
							<logic:equal name="element" property="card_status" value="0"><font color="red">��</font></logic:equal>							
							<logic:equal name="element" property="card_status" value="1"><font color="green">��</font></logic:equal>
						</td>
					
						<td>
							<logic:equal name="element" property="type" value="1">�Żݿ�</logic:equal>							
							<logic:equal name="element" property="type" value="2">����ȯ</logic:equal>
						</td>
						
						<td>
							<logic:equal name="element" property="card_type" value="1">12����</logic:equal>							
							<logic:equal name="element" property="card_type" value="2">6����</logic:equal>
							<logic:equal name="element" property="card_type" value="3">3����</logic:equal>
						</td>
						
							<td>
						<logic:empty name="element" property="discount_rate">��</logic:empty>
						<logic:notEmpty name="element" property="discount_rate">						  
						     <bean:write name="element" property="discount_rate"/>
						     </logic:notEmpty>
						</td>	
						
							<td>
						<logic:empty name="element" property="use_count">��</logic:empty>
						<logic:notEmpty name="element" property="use_count">						  
						     <bean:write name="element" property="use_count"/>
						     </logic:notEmpty>
						</td>	
						
						
						<td>
							<logic:empty name="element" property="create_date">��</logic:empty>
						<logic:notEmpty name="element" property="create_date">						  
						     <bean:write name="element" property="create_date" format="yyyy-MM-dd HH:mm:ss"/>
						     </logic:notEmpty>
						</td>
						
							<td>
						<logic:empty name="element" property="add_user">��</logic:empty>
						<logic:notEmpty name="element" property="add_user">						  
						     <bean:write name="element" property="add_user"/>
						     </logic:notEmpty>
						</td>	
						
						
							<td>
						<logic:empty name="element" property="remark">��</logic:empty>
						<logic:notEmpty name="element" property="remark">						  
						     <bean:write name="element" property="remark"/>
						     </logic:notEmpty>
						</td>	
											
						
							
							<td align="center">
							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > �����á�</a>						
						</td>
						
					
					</tr>
				</logic:iterate> 


			  	<tr class="title_3">
					<td colspan="14" align="left" >  
						<%
							pys.printGoPage(response, "frmGo");
						%>
					</td>
				</tr>  
			</table>
		</form>
	</body>
</html>