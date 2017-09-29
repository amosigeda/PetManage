package com.care.sys.devicephoneinfo.action;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.care.common.config.Config;
import com.care.common.config.ServiceBean;
import com.care.common.http.BaseAction;
import com.care.sys.deviceactiveinfo.domain.DeviceActiveInfo;
import com.care.sys.deviceactiveinfo.form.DeviceActiveInfoForm;
import com.care.sys.devicephoneinfo.domain.DevicePhoneInfo;
import com.care.sys.devicephoneinfo.domain.logic.DevicePhoneInfoFacade;
import com.care.sys.devicephoneinfo.form.DevicePhoneInfoForm;
import com.godoing.rose.http.common.HttpTools;
import com.godoing.rose.http.common.PagePys;
import com.godoing.rose.http.common.Result;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;
import com.godoing.rose.log.LogFactory;

public class DevicePhoneInfoAction extends BaseAction {
	
	Log logger = LogFactory.getLog(DevicePhoneInfoAction.class);

	
	public ActionForward queryDevicePhoneInfo(ActionMapping mapping,ActionForm actionForm,
											  HttpServletRequest request,
											  HttpServletResponse response){
		
		String href = request.getServletPath();
		List<DataMap> list = null;
		Result result = new Result();
		PagePys pys = new PagePys();
		DevicePhoneInfo vo = new DevicePhoneInfo();
		DevicePhoneInfoForm form = (DevicePhoneInfoForm)actionForm;
		DevicePhoneInfoFacade devicePhoneInfoFacade = ServiceBean.getInstance().getDevicePhoneInfoFacade();
		try {
			form.setOrderBy("id");
			form.setSort("0");
			
			BeanUtils.copyProperties(vo,form);
			
			list = devicePhoneInfoFacade.getDevicePhoneInfoListByVo(vo);
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.size());;
		} catch (Exception e) {
			
			e.printStackTrace();
			logger.error(request.getQueryString()+" "+e);
			result.setBackPage(Config.ABOUT_PAGE);
			if(e instanceof SystemException){
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			}else{
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		}finally{
			request.setAttribute("result", result);
			request.setAttribute("pageList",list);
			request.setAttribute("PagePys", pys);
		}
		
		return mapping.findForward("queryDevicePhoneInfo");	
	}
	
	public ActionForward updateXinXi(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		
		Result result = new Result();
		try {
			DeviceActiveInfoForm form = (DeviceActiveInfoForm) actionForm;			
			DeviceActiveInfo vo = new DeviceActiveInfo();
			System.err.println("设备id="+form.getId());
			vo.setCondition("device_id='" + form.getId() + "'");
		//	BeanUtils.copyProperties(vo, form);
            vo.setTestStatus(form.getTestStatus());
            
			int a=ServiceBean.getInstance().getDeviceActiveInfoFacade().updateDeviceActiveInfonull(vo);
	
			/*	if(a>0){
			vo.setAddTime(stopTime);
			vo.setDateTime(new Date());
			vo.setBelongProject("1");
			vo.setImei(form.getIccid()+"");
			vo.setAppVersion("update");
			ServiceBean.getInstance().getSaleInfoFacade().insertCancelSubLogInfo(vo);
		}*/
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			if (e instanceof SystemException) { /* 锟斤拷锟斤拷知锟届常锟斤拷锟叫斤拷锟斤拷 */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* 锟斤拷未知锟届常锟斤拷锟叫斤拷锟斤拷锟斤拷锟斤拷全锟斤拷锟斤拷锟斤拷锟轿粗拷斐?*/
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}
}
