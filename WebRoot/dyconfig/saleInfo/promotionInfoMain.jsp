<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="com.godoing.rose.http.common.*"%>
<%@ page import="com.care.common.lang.*"%>
<%@ page import="com.care.common.config.Config"%>
<%@ page import="com.care.app.LoginUser"%>
<%@ taglib uri="/WEB-INF/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic"%>
<%@ page autoFlush="true"%>
<%
	/*页面属性*/
	PagePys pys = (PagePys) request.getAttribute("PagePys");
	LoginUser loginUser = (LoginUser)request.getSession().getAttribute(Config.SystemConfig.LOGINUSER); 
%>

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
	<script language="javascript">
	function finds(){
   /*  var st = new Date(frmGo.startTime.value.replace(/-/g,'/'));
	var et = new Date(frmGo.endTime.value.replace(/-/g,'/'));
	if(Date.parse(st) - Date.parse(et)>0){
		alert("开始时间不能大于结束时间!");
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

	//修改账户				
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
                                         优惠券信息
                                           <input name="inset" type="button" class="but_1" accesskey="a"
							tabindex="a" value="添 加" onclick="insert()">
                </th>
                </tr>            
                 <tr class="title_3">
                       <td colspan="14">	
                                         <%--                   新增时间
                     <input name="startTime" type="text" class="txt_1"  id="startTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"fNow_date");%>" onclick="WdatePicker()"
								size="9" readonly> -
							<input name="endTime" type="text" class="txt_1" id="endTime" style="cursor:text"
								value="<%CommUtils.printReqByAtt(request,response,"now_date");%>" onclick="WdatePicker()"
								size="9" readonly>	 --%>			
						优惠券				
						    <input id="youhuijuan" name="youhuijuan" type="text" class="txt_1" 
						    value="<%CommUtils.printReqByAtt(request,response,"youhuijuan");%>" size="20">
						
				<%-- 	项目名		
						<%String projectId = (String)request.getAttribute("projectId"); %>			
							<select id="projectId" name="projectId" >
								<option value="">全部</option>
								<logic:iterate id="pro" name="project">
									<bean:define id="project" name="pro" property="id" type="java.lang.Integer" />																	
									<option value='<%=project %>' <%=String.valueOf(project).equals(projectId)? "selected" : "" %>><bean:write name="pro" property="project_name"/></option>
								</logic:iterate>
							</select>		 --%>
						<input name="find1" type="button" class="but_1" accesskey="f"
							tabindex="f" value="搜 索" onclick="javascript:finds()">
					     <input name="clear" type="button" class="but_1" accesskey="c"
						    tabindex="c"  value="清除搜索" onclick="c()">
				</tr> 
                  <tr class="title_2">     
                  	<td width="10%">优惠券</td> 
                  	<td width="10%" >是否可以使用</td>
                  	<td width="10%" >类型</td>
                  	<td width="10%" >卡类型</td>
                  	<td width=10%" >折扣率</td>
                  	<td width="10%" >可使用次数(0表示无限次)</td>
                  	<td width="10%" >创建时间</td>
                  	<td width="10%" >添加人</td>
                  	<td width="10%" >备注</td>
                  	<td width="10%" >操作</td>
                  	           	
				</tr>
 
				<logic:iterate id="element" name="pageList">
					<tr class="tr_5" onmouseover='this.className="tr_4"' onmouseout='this.className="tr_5"' >
						
							<td>
						<logic:empty name="element" property="promotion_code">无</logic:empty>
						<logic:notEmpty name="element" property="promotion_code">						  
						     <bean:write name="element" property="promotion_code"/>
						     </logic:notEmpty>
						</td>	
						
							
						<td>
							<logic:equal name="element" property="card_status" value="0"><font color="red">否</font></logic:equal>							
							<logic:equal name="element" property="card_status" value="1"><font color="green">是</font></logic:equal>
						</td>
					
						<td>
							<logic:equal name="element" property="type" value="1">优惠卡</logic:equal>							
							<logic:equal name="element" property="type" value="2">代金券</logic:equal>
						</td>
						
						<td>
							<logic:equal name="element" property="card_type" value="1">12个月</logic:equal>							
							<logic:equal name="element" property="card_type" value="2">6个月</logic:equal>
							<logic:equal name="element" property="card_type" value="3">3个月</logic:equal>
						</td>
						
							<td>
						<logic:empty name="element" property="discount_rate">无</logic:empty>
						<logic:notEmpty name="element" property="discount_rate">						  
						     <bean:write name="element" property="discount_rate"/>
						     </logic:notEmpty>
						</td>	
						
							<td>
						<logic:empty name="element" property="use_count">无</logic:empty>
						<logic:notEmpty name="element" property="use_count">						  
						     <bean:write name="element" property="use_count"/>
						     </logic:notEmpty>
						</td>	
						
						
						<td>
							<logic:empty name="element" property="create_date">无</logic:empty>
						<logic:notEmpty name="element" property="create_date">						  
						     <bean:write name="element" property="create_date" format="yyyy-MM-dd HH:mm:ss"/>
						     </logic:notEmpty>
						</td>
						
							<td>
						<logic:empty name="element" property="add_user">无</logic:empty>
						<logic:notEmpty name="element" property="add_user">						  
						     <bean:write name="element" property="add_user"/>
						     </logic:notEmpty>
						</td>	
						
						
							<td>
						<logic:empty name="element" property="remark">无</logic:empty>
						<logic:notEmpty name="element" property="remark">						  
						     <bean:write name="element" property="remark"/>
						     </logic:notEmpty>
						</td>	
											
						
							
							<td align="center">
							<a href=# onclick="update('<bean:write name="element" property="id" />')" style="color:#0000FF" > 【配置】</a>						
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