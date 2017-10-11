package com.care.sys.phoneinfo.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Scanner;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

import com.care.app.LoginUser;
import com.care.common.config.Config;
import com.care.common.config.ServiceBean;
import com.care.common.http.BaseAction;
import com.care.common.lang.CommUtils;
import com.care.common.lang.ReadExcelTest;
import com.care.sys.companyinfo.domain.CompanyInfo;
import com.care.sys.deviceactiveinfo.domain.DeviceActiveInfo;
import com.care.sys.deviceactiveinfo.form.DeviceActiveInfoForm;
import com.care.sys.devicephoneinfo.domain.DevicePhoneInfo;
import com.care.sys.devicephoneinfo.form.DevicePhoneInfoForm;
import com.care.sys.dynamicInfo.domain.DynamicInfo;
import com.care.sys.phoneinfo.domain.PhoneInfo;
import com.care.sys.phoneinfo.domain.logic.PhoneInfoFacade;
import com.care.sys.phoneinfo.form.PhoneInfoForm;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.care.sys.saleinfo.domain.SaleInfo;
import com.care.sys.saleinfo.domain.logic.SaleInfoFacade;
import com.care.sys.saleinfo.form.SaleInfoForm;
import com.care.wei.AiShiDeIccidApi;
import com.godoing.rose.http.common.HttpTools;
import com.godoing.rose.http.common.PagePys;
import com.godoing.rose.http.common.Result;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;
import com.godoing.rose.log.LogFactory;
import com.twilio.Twilio;
import com.twilio.rest.preview.wireless.Sim;

public class PhoneInfoAction extends BaseAction {

	Log logger = LogFactory.getLog(PhoneInfoAction.class);

	public ActionForward queryPhoneInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		PhoneInfoFacade info = ServiceBean.getInstance().getPhoneInfoFacade();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}
			
			PhoneInfoForm form = (PhoneInfoForm) actionForm;
			PhoneInfo vo = new PhoneInfo();
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String serieNo = request.getParameter("serieNo");
			

			form.setOrderBy("p.device_id");
			form.setSort("1");

			if (startTime != null && !"".equals(startTime)) {
				sb.append("substring(p.device_update_time,1,10) >= '"
						+ startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(p.device_update_time,1,10) <= '" + endTime
						+ "'");
			}
			if (serieNo != null && !"".equals(serieNo)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("p.device_imei like '%" + serieNo + "%'");
			}
			/*
			 * if(phoneManageId != null && !"".equals(phoneManageId)){
			 * if(sb.length() > 0){ sb.append(" and "); }
			 * sb.append("p.phone_manage_id='" + phoneManageId + "'"); }
			 * if(status != null && !"".equals(status)){ if(sb.length() > 0){
			 * sb.append(" and "); } sb.append("p.status ='"+status+"'");
			 * request.setAttribute("status", CommUtils.getStatusSelect(
			 * "status", Integer.parseInt(status))); } if(type != null &&
			 * !"".equals(type)){ if(sb.length() > 0){ sb.append(" and "); }
			 * sb.append("m.type ='"+type+"'"); request.setAttribute("type",
			 * CommUtils.getTypeSelect( "type", Integer.parseInt(type))); }
			 */
			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("serieNo", serieNo);

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			// list = info.getPhoneInfoListByVo(vo);
			list = info.getWdeviceActiveInfoListByVo(vo);// 录入信息表为wdevice_active_info
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryPhoneInfo");
	}

	public ActionForward imeiControl(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		PhoneInfoFacade info = ServiceBean.getInstance().getPhoneInfoFacade();
		try {
			/*
			 * LoginUser loginUser =
			 * (LoginUser)request.getSession().getAttribute
			 * (Config.SystemConfig.LOGINUSER); if (loginUser == null) { return
			 * null; }
			 */
			// String companyInfoId = loginUser.getCompanyId();
			// String projectInfoId = loginUser.getProjectId();
			PhoneInfoForm form = (PhoneInfoForm) actionForm;
			PhoneInfo vo = new PhoneInfo();
			String email = request.getParameter("email");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String serieNo = request.getParameter("serieNo");
			/*
			 * String status = request.getParameter("status"); String
			 * type=request.getParameter("type"); String phoneManageId =
			 * request.getParameter("phoneManageId");
			 */

			form.setOrderBy("s.share_date");
			form.setSort("1");

			/*
			 * if(!projectInfoId.equals("0")){ sb.append("p.belong_project in("
			 * + projectInfoId + ")"); }else{ if(!companyInfoId.equals("0")){
			 * ProjectInfo pro = new ProjectInfo();
			 * pro.setCondition("company_id in(" + companyInfoId + ")");
			 * List<DataMap> proList =
			 * ServiceBean.getInstance().getProjectInfoFacade
			 * ().getProjectInfo(pro); if(proList.size() > 0){ int num =
			 * proList.size(); String str = ""; for(int i=0; i<num; i++){
			 * Integer id = (Integer)proList.get(i).getAt("id"); str +=
			 * String.valueOf(id); if(i != num-1){ str += ","; } }
			 * sb.append("p.belong_project in(" + str + ")"); } } }
			 */
			if (email != null && !"".equals(email)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.email like '%" + email + "%'");
			}
			if (startTime != null && !"".equals(startTime)) {
				sb.append("substring(s.share_date,1,10) >= '" + startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(s.share_date,1,10) <= '" + endTime + "'");
			}
			if (serieNo != null && !"".equals(serieNo)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("device_imei like '%" + serieNo + "%'");
			}
			/*
			 * if(phoneManageId != null && !"".equals(phoneManageId)){
			 * if(sb.length() > 0){ sb.append(" and "); }
			 * sb.append("p.phone_manage_id='" + phoneManageId + "'"); }
			 * if(status != null && !"".equals(status)){ if(sb.length() > 0){
			 * sb.append(" and "); } sb.append("p.status ='"+status+"'");
			 * request.setAttribute("status", CommUtils.getStatusSelect(
			 * "status", Integer.parseInt(status))); } if(type != null &&
			 * !"".equals(type)){ if(sb.length() > 0){ sb.append(" and "); }
			 * sb.append("m.type ='"+type+"'"); request.setAttribute("type",
			 * CommUtils.getTypeSelect( "type", Integer.parseInt(type))); }
			 */
			request.setAttribute("email", email);
			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("serieNo", serieNo);

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			// list = info.getPhoneInfoListByVo(vo);
			list = info.getWshareInfoListByVo(vo);// 录入信息表为wdevice_active_info
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("imeiControl");
	}

	public ActionForward queryPhoneIMEIInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		PhoneInfoFacade info = ServiceBean.getInstance().getPhoneInfoFacade();
		ProjectInfo pro = new ProjectInfo();
		try {
			/*
			 * LoginUser loginUser =
			 * (LoginUser)request.getSession().getAttribute
			 * (Config.SystemConfig.LOGINUSER); String companyInfoId =
			 * loginUser.getCompanyId(); String projectInfoId =
			 * loginUser.getProjectId();
			 */
			PhoneInfoForm form = (PhoneInfoForm) actionForm;
			PhoneInfo vo = new PhoneInfo();
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String projectId = request.getParameter("projectId");// ��Ŀ��
			String companyId = request.getParameter("companyId");
			String type = request.getParameter("type");

			form.setOrderBy("input_time");
			form.setSort("1");
			/*
			 * if(!projectInfoId.equals("0")){ sb.append("m.project_id in(" +
			 * projectInfoId + ")"); }else{ if(!companyInfoId.equals("0")){
			 * 
			 * pro.setCondition("company_id in(" + companyInfoId + ")");
			 * List<DataMap> proList =
			 * ServiceBean.getInstance().getProjectInfoFacade
			 * ().getProjectInfo(pro); if(proList.size() > 0){ int num =
			 * proList.size(); String str = ""; for(int i=0; i<num; i++){
			 * Integer id = (Integer)proList.get(i).getAt("id"); str +=
			 * String.valueOf(id); if(i != num-1){ str += ","; } }
			 * sb.append("m.project_id in(" + str + ")"); } } }
			 */
			if (startTime != null && !"".equals(startTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(input_time,1,10) >= '" + startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(input_time,1,10) <= '" + endTime + "'");
			}
			if (projectId != null && !"".equals(projectId)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("m.project_id = '" + projectId + "'");
			}
			if (companyId != null && !"".equals(companyId)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("m.company_id = '" + companyId + "'");
				pro.setCondition("company_id = '" + companyId + "'");
			}

			if (type != null && !"".equals(type)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("m.type ='" + type + "'");
				request.setAttribute("type",
						CommUtils.getTypeSelect("type", Integer.parseInt(type)));
			}

			// List<DataMap> pros =
			// ServiceBean.getInstance().getProjectInfoFacade().getProjectInfo(pro);
			List<DataMap> pros = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(pro);
			request.setAttribute("project", pros);

			/*
			 * CompanyInfo ci = new CompanyInfo(); List<DataMap> coms =
			 * ServiceBean
			 * .getInstance().getCompanyInfoFacade().getCompanyInfo(ci);
			 * request.setAttribute("company", coms);
			 */

			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("companyId", companyId);
			request.setAttribute("projectId", projectId);

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			List<DataMap> listTemp = info.getPhoneManagerInfo(vo);
			int length = listTemp.size();
			for (int i = 0; i < length; i++) {
				DataMap temp = listTemp.get(i);
				String managerId = "" + temp.getAt("id");
				vo.setCondition("phone_manage_id = '" + managerId
						+ "' and status != 0 and status !=1 ");
				int active = info.getPhoneInfoCount(vo);
				temp.put("active", active);
				listTemp.set(i, temp);
			}

			list = new DataList(listTemp);
			list.setTotalSize(listTemp.size());
			// list = info.getPhoneManageListByVo(vo);

			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryPhoneIMEIInfo");
	}

	public ActionForward initInsert(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		return mapping.findForward("addimei");
	}

	public ActionForward addImei(ActionMapping mapping, ActionForm actionForm,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String forward = "";
		String type = request.getParameter("addType");

		/*
		 * <input type="radio" name="addType" value="0" checked="checked"/>手动录入
		 * <!-- <input type="radio" name="addType" value="1" hidden="hidden"
		 * title="excel录入"/> --> <input type="radio" name="addType" value="1"
		 * />Excel-IMEI-ICCID录入 <input type="radio" name="addType"
		 * value="2"/>文本录入 <input type="radio" name="addType" value="3"
		 * />Excel-IMEI录入
		 */
		System.err.println("type=" + type);
		if (type.equals("0")) {
			// 0手动录入
			forward = "manualInput";
		} else if (type.equals("1")) {
			// Excel-IMEI-ICCID录入
			forward = "excelInput";
		} else if (type.equals("2")) {
			// 文本录入
			forward = "textInput";
		} else if (type.equals("3")) {
			// Excel-IMEI录入
			forward = "excelInputImei";
		} else if (type.equals("4")) {
			forward = "excelIccidIsmi";
		} else if (type.equals("5")) {
			forward = "singleImei";
		} else if (type.equals("6")) {
			forward = "singleImeiIccidImsi";
		} else if (type.equals("7")) {
			forward = "singleIccidImsi";
		} else if (type.equals("8")) {
			forward = "singleImeiIccid";
		}else if(type.equals("9")){
			forward = "excelImeiIccidImsi";
		}else if(type.equals("10")){
			forward="excelImeiSn";
		}else if(type.equals("11")){
			forward="excelPromotion";
		}

		/*
		 * <input type="radio" name="addType" value="5" />单个IMEI-录入</br> <input
		 * type="radio" name="addType" value="6" />单个IMEI带ICCID-IMSI-爱施德-录入</br>
		 * <input type="radio" name="addType" value="7"
		 * />单个ICCID-IMSI-爱施德-录入</br>
		 */

		/*
		 * else{ //0手动录入 forward="manualInput"; }
		 */
		ProjectInfo vo = new ProjectInfo();
		List<DataMap> list = ServiceBean.getInstance().getProjectInfoFacade()
				.getProjectInfo(vo);
		request.setAttribute("list", list);
		return mapping.findForward(forward);
	}

	public ActionForward manualInput(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		Result result = new Result();
		try {
			String imei = form.getSerieNo();

			PhoneInfo vo = new PhoneInfo();
			int countNum = Integer.parseInt(form.getCountNum());
			System.err.println("需要录入的数量为=" + countNum);

			// vo.setFrom(0);
			// vo.setTo(0);
			// vo.setPageSize(1);
			if (countNum == 1) {
				vo.setCondition("p.device_imei='" + imei
						+ "'and p.belong_project='1' limit 0,1");
				List<DataMap> list = ServiceBean.getInstance()
						.getPhoneInfoFacade().getWdeviceActiveInfoList(vo);
				if (list.size() <= 0) {
					vo.setSerieNo(imei);
					vo.setBelongProject("1");
					vo.setUploadTime(new Date());
					ServiceBean.getInstance().getPhoneInfoFacade()
							.insertWdeviceActiveInfo(vo);
				}

			} else if (countNum != 0 && countNum != 1) {
				for (int i = 0; i <= countNum; i++) {
					vo.setSerieNo(imei + i);
					vo.setBelongProject("1");
					vo.setUploadTime(new Date());
					ServiceBean.getInstance().getPhoneInfoFacade()
							.insertWdeviceActiveInfo(vo);
				}
			}

			// String belongProject = form.getBelongProject();
			/*
			 * int countNum = Integer.parseInt(form.getCountNum()); Long miniNum
			 * = Long.parseLong(form.getSerieNo()); Long maxNum = miniNum +
			 * (countNum - 1); Date inputTime = new Date(); PhoneInfoFacade df =
			 * ServiceBean.getInstance().getPhoneInfoFacade(); PhoneInfo vo =
			 * new PhoneInfo(); Integer maxPhoneManage =
			 * df.getPhoneManageMaxId(vo); if(maxPhoneManage == null){
			 * maxPhoneManage = 0; }
			 * vo.setPhoneManageId(String.valueOf(maxPhoneManage + 1));
			 * vo.setInputTime(inputTime); vo.setBelongProject("1"); for(int
			 * i=0;i<countNum; i++){ vo.setSerieNo(String.valueOf(miniNum));
			 * df.insertPhoneInfo(vo); miniNum ++; }
			 */

			// String companyId = this.getCompanyId(belongProject);

			// this.insertPhoneManage(maxPhoneManage + 1, inputTime, companyId,
			// belongProject, String.valueOf(countNum), form.getSerieNo(),
			// String.valueOf(maxNum), "1");

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	/*
	 * public ActionForward excelInput(ActionMapping mapping, ActionForm
	 * actionForm, HttpServletRequest request, HttpServletResponse response)
	 * throws Exception{ PhoneInfoForm form = (PhoneInfoForm)actionForm;
	 * FormFile file = form.getFile1(); Result result = new Result(); String dir
	 * = request.getSession(true).getServletContext().getRealPath("/upload");
	 * try{ String path = dir + "/" + file.getFileName();
	 * 
	 * OutputStream os = new FileOutputStream(path);
	 * os.write(file.getFileData(), 0, file.getFileSize()); os.flush();
	 * os.close(); ReadExcelTest read = new ReadExcelTest(); ArrayList<String>
	 * list = read.readExcel(path); PhoneInfoFacade df =
	 * ServiceBean.getInstance().getPhoneInfoFacade(); PhoneInfo vo = new
	 * PhoneInfo(); String belongProject = form.getBelongProject(); Integer
	 * maxPhoneManage = df.getPhoneManageMaxId(vo); if(maxPhoneManage == null){
	 * maxPhoneManage = 0; } Date inputTime = new Date(); //
	 * vo.setPhoneManageId(String.valueOf(maxPhoneManage + 1));
	 * vo.setInputTime(inputTime); vo.setBelongProject(belongProject);
	 * 
	 * int countNum = 0; Long miniNum = 0L; Long maxNum = 0L; for(String str:
	 * list){ countNum ++; Long s = Long.parseLong(str); if(miniNum > s){
	 * miniNum = s; } if(maxNum < s){ maxNum = s; } vo.setSerieNo(str);
	 * df.insertPhoneInfo(vo); }
	 * 
	 * // String companyId = this.getCompanyId(belongProject);
	 * 
	 * // this.insertPhoneManage(maxPhoneManage + 1, inputTime, companyId,
	 * belongProject, String.valueOf(countNum), String.valueOf(miniNum),
	 * String.valueOf(maxNum), "2");
	 * 
	 * result.setBackPage(HttpTools.httpServletPath(request,
	 * "queryPhoneIMEIInfo")); result.setResultCode("inserts");
	 * result.setResultType("success"); }catch (Exception e) {
	 * e.printStackTrace(); logger.error(request.getQueryString() + "  " + e);
	 * result.setBackPage(Config.ABOUT_PAGE); if (e instanceof SystemException)
	 * { result.setResultCode(((SystemException) e).getErrCode());
	 * result.setResultType(((SystemException) e).getErrType()); } else {
	 * result.setResultCode("noKnownException");
	 * result.setResultType("sysRunException"); } }finally{
	 * request.setAttribute("result", result); } return
	 * mapping.findForward("result"); }
	 */

	public ActionForward excelInputImei(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		FormFile file = form.getFile1();
		Result result = new Result();
		String dir = request.getSession(true).getServletContext()
				.getRealPath("/upload");
		try {
			String path = dir + "/" + file.getFileName();

			OutputStream os = new FileOutputStream(path);
			os.write(file.getFileData(), 0, file.getFileSize());
			os.flush();
			os.close();
			ReadExcelTest read = new ReadExcelTest();
			ArrayList<String> list = read.readExcel(path);
			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();
			PhoneInfo vo = new PhoneInfo();
			String belongProject = form.getBelongProject();
			Integer maxPhoneManage = df.getPhoneManageMaxId(vo);
			if (maxPhoneManage == null) {
				maxPhoneManage = 0;
			}
			Date inputTime = new Date();
			// vo.setPhoneManageId(String.valueOf(maxPhoneManage + 1));
			vo.setInputTime(inputTime);
			vo.setBelongProject(belongProject);

			int countNum = 0;
			Long miniNum = 0L;
			Long maxNum = 0L;
			for (String str : list) {
				countNum++;
				Long s = Long.parseLong(str);
				if (miniNum > s) {
					miniNum = s;
				}
				if (maxNum < s) {
					maxNum = s;
				}
				vo.setCondition("device_imei='" + str + "'");

				List<DataMap> listHave = df.getWdeviceActiveInfoList(vo);
				if (listHave.size() <= 0) {
					vo.setSerieNo(str);
					vo.setIccid("");
					vo.setUploadTime(new Date());
					vo.setBelongProject("1");
					df.insertWdeviceActiveInfo(vo);
				}
			}

			// String companyId = this.getCompanyId(belongProject);

			// this.insertPhoneManage(maxPhoneManage + 1, inputTime, companyId,
			// belongProject, String.valueOf(countNum), String.valueOf(miniNum),
			// String.valueOf(maxNum), "2");

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	// EXCEL-IMEI-ICCID 表格录入
	public ActionForward excelInput(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		FormFile file = form.getFile1();
		Result result = new Result();
		String dir = request.getSession(true).getServletContext()
				.getRealPath("/upload");
		try {
			System.err.println("EXCEL-IMEI-ICCID 表格录入");
			String path = dir + "/" + file.getFileName();

			OutputStream os = new FileOutputStream(path);
			os.write(file.getFileData(), 0, file.getFileSize());
			os.flush();
			os.close();
			ReadExcelTest read = new ReadExcelTest();
			ArrayList<String> list = read.readExcel(path);
			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();
			PhoneInfo vo = new PhoneInfo();
			String belongProject = "1";
			String belongCompany=request.getParameter("type");
			Integer maxPhoneManage = df.getPhoneManageMaxId(vo);
			if (maxPhoneManage == null) {
				maxPhoneManage = 0;
			}
			Date inputTime = new Date();
			vo.setPhoneManageId(String.valueOf(maxPhoneManage + 1));
			vo.setInputTime(inputTime);
			vo.setBelongProject(belongProject);

			int countNum = 0;
			Long miniNum = 0L;
			Long maxNum = 0L;
			for (String str : list) {
				countNum++;

				if (countNum % 2 == 1) {
					Long s = Long.parseLong(str);
					if (miniNum > s) {
						miniNum = s;
					}
					if (maxNum < s) {
						maxNum = s;
					}
					vo.setCondition("device_imei='" + str + "' limit 1");

					List<DataMap> listHave = df.getWdeviceActiveInfoList(vo);
					SaleInfo sao = new SaleInfo();
					@SuppressWarnings("static-access")
					SaleInfoFacade sf = ServiceBean.getInstance()
							.getSaleInfoFacade();
					if (listHave.size() <= 0) {
						vo.setSerieNo(str);
						vo.setIccid("");
						vo.setUploadTime(new Date());
						vo.setBelongProject(belongProject);
						vo.setCompanyId("");
						df.insertWdeviceActiveInfo(vo);

						sao.setCondition("iccid='" + list.get(countNum)
								+ "'and belong_company='"+belongCompany+"' limit 1");
						List<DataMap> simlist = sf.getSimInfoList(sao);
						if (simlist.size() <= 0) {
							sao.setImei(list.get(countNum));
							sao.setDateTime(new Date());
							sao.setBelongProject(belongCompany);
							sf.insertSimInfo(sao);
							
							vo.setCondition("iccid='" + list.get(countNum) + "' limit 1");

							List<DataMap> listHavee = df.getWdeviceActiveInfoList(vo);
							if(listHavee.size()<=0){
								DeviceActiveInfo ddo = new DeviceActiveInfo();
								ddo.setCondition("device_imei='" + str + "'");
								ddo.setIccid(list.get(countNum));
								ddo.setBelongCompany(belongCompany);
								ServiceBean.getInstance().getDeviceActiveInfoFacade()
										.updateDeviceActiveInfonull(ddo);
							}
						}
					} else {
						
						sao.setCondition("iccid='" + list.get(countNum)
								+ "'and belong_company='"+belongCompany+"' limit 1");
						List<DataMap> simlist = sf.getSimInfoList(sao);
						if (simlist.size() <= 0) {
							sao.setImei(list.get(countNum));
							sao.setDateTime(new Date());
							sao.setBelongProject(belongCompany);
							sf.insertSimInfo(sao);
						}
						
						vo.setCondition("iccid='" + list.get(countNum)
								+ "'and belong_company='"+belongCompany+"' limit 1");

						List<DataMap> listHavee = df.getWdeviceActiveInfoList(vo);
						if(listHavee.size()<=0){
							DeviceActiveInfo ddo = new DeviceActiveInfo();
							ddo.setCondition("device_imei='" + str + "'");
							ddo.setIccid(list.get(countNum));
							ddo.setBelongCompany(belongCompany);
							ServiceBean.getInstance().getDeviceActiveInfoFacade()
									.updateDeviceActiveInfonull(ddo);
						}
					}
				}
			}


			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward excelIccidIsmi(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		FormFile file = form.getFile1();
		Result result = new Result();
		String dir = request.getSession(true).getServletContext()
				.getRealPath("/upload");
		try {
			System.err.println("EXCEI-ICCID-IMSI 表格录入");
			String path = dir + "/" + file.getFileName();

			OutputStream os = new FileOutputStream(path);
			os.write(file.getFileData(), 0, file.getFileSize());
			os.flush();
			os.close();
			ReadExcelTest read = new ReadExcelTest();
			ArrayList<String> list = read.readExcel(path);
			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();
			PhoneInfo vo = new PhoneInfo();
			String belongCompany =request.getParameter("type");
			Integer maxPhoneManage = df.getPhoneManageMaxId(vo);
			if (maxPhoneManage == null) {
				maxPhoneManage = 0;
			}
			Date inputTime = new Date();
			vo.setPhoneManageId(String.valueOf(maxPhoneManage + 1));
			vo.setInputTime(inputTime);
			vo.setBelongProject(belongCompany);

			int countNum = 0;
			Long miniNum = 0L;
			Long maxNum = 0L;
			for (String str : list) {
				System.out.println("长度为=" + list.size());
				countNum++;
				System.out.println("countNum=" + countNum);

				if (countNum % 2 == 1) {
					Long s = Long.parseLong(str);
					System.out.println("s=" + s);
					System.out.println("list=" + list.get(countNum));
					if (miniNum > s) {
						miniNum = s;
					}
					if (maxNum < s) {
						maxNum = s;
					}
					// vo.setCondition("device_imei='" + str + "'");

					// List<DataMap> listHave = df.getWdeviceActiveInfoList(vo);
					// if (listHave.size() <= 0) {
					/*
					 * vo.setSerieNo(str); vo.setIccid(list.get(countNum));
					 * vo.setUploadTime(new Date()); vo.setCompanyId("1");
					 * df.insertWdeviceActiveInfo(vo);
					 */

					@SuppressWarnings("static-access")
					SaleInfoFacade sf = ServiceBean.getInstance()
							.getSaleInfoFacade();

					SaleInfo sao = new SaleInfo();
					sao.setCondition("iccid='" + str
							+ "' and belong_company='"+belongCompany+"'");
					List<DataMap> listSal = sf.getSimInfoList(sao);
					if (listSal.size() > 0) {
						String id = listSal.get(0).get("id") + "";
						sao.setImsi(list.get(countNum));
						sao.setCondition("id='" + id + "'");
						sao.setDateTime(new Date());
						sf.updateSimInfo(sao);
					} else {
						sao.setImei(str);
						sao.setDateTime(new Date());
						sao.setBelongProject(belongCompany);
						sao.setImsi(list.get(countNum));
						sf.insertSimInfo(sao);
					}
				}
			}

			// String companyId = this.getCompanyId(belongProject);

			// this.insertPhoneManage(maxPhoneManage + 1, inputTime, companyId,
			// belongProject, String.valueOf(countNum), String.valueOf(miniNum),
			// String.valueOf(maxNum), "2");

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryDeviceIccid"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	/*
	 * public ActionForward textInput(ActionMapping mapping, ActionForm
	 * actionForm, HttpServletRequest request, HttpServletResponse response)
	 * throws Exception{ PhoneInfoForm form = (PhoneInfoForm)actionForm;
	 * FormFile file = form.getFile1(); Result result = new Result(); String dir
	 * = request.getSession(true).getServletContext().getRealPath("/upload");
	 * try{ String path = dir + file.getFileName();
	 * 
	 * OutputStream os = new FileOutputStream(path);
	 * os.write(file.getFileData(), 0, file.getFileSize()); os.flush();
	 * os.close(); File f = new File(path); Scanner in = new Scanner(f); String
	 * str = ""; PhoneInfoFacade df =
	 * ServiceBean.getInstance().getPhoneInfoFacade(); PhoneInfo vo = new
	 * PhoneInfo(); String belongProject = form.getBelongProject(); Integer
	 * maxPhoneManage = df.getPhoneManageMaxId(vo); if(maxPhoneManage == null){
	 * maxPhoneManage = 0; } Date inputTime = new Date();
	 * vo.setPhoneManageId(String.valueOf(maxPhoneManage + 1));
	 * vo.setInputTime(inputTime); vo.setBelongProject(belongProject); int
	 * countNum = 0; Long miniNum = 0L; Long maxNum = 0L; while(in.hasNext()){
	 * str = in.nextLine(); if(str != null && !"".equals(str)){ countNum ++;
	 * Long s = Long.parseLong(str); if(miniNum > s){ miniNum = s; } if(maxNum <
	 * s){ maxNum = s; } vo.setSerieNo(str); df.insertPhoneInfo(vo); } }
	 * 
	 * f.delete();
	 * 
	 * String companyId = this.getCompanyId(belongProject);
	 * 
	 * this.insertPhoneManage(maxPhoneManage + 1, inputTime, companyId,
	 * belongProject, String.valueOf(countNum), String.valueOf(miniNum),
	 * String.valueOf(maxNum), "2");
	 * 
	 * result.setBackPage(HttpTools.httpServletPath(request,
	 * "queryPhoneIMEIInfo")); result.setResultCode("inserts");
	 * result.setResultType("success"); }catch (Exception e) {
	 * e.printStackTrace(); logger.error(request.getQueryString() + "  " + e);
	 * result.setBackPage(Config.ABOUT_PAGE); if (e instanceof SystemException)
	 * { result.setResultCode(((SystemException) e).getErrCode());
	 * result.setResultType(((SystemException) e).getErrType()); } else {
	 * result.setResultCode("noKnownException");
	 * result.setResultType("sysRunException"); } }finally{
	 * request.setAttribute("result", result); } return
	 * mapping.findForward("result"); }
	 */

	public ActionForward textInput(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		FormFile file = form.getFile1();
		Result result = new Result();
		String dir = request.getSession(true).getServletContext()
				.getRealPath("/upload");
		try {
			String path = dir + file.getFileName();

			OutputStream os = new FileOutputStream(path);
			os.write(file.getFileData(), 0, file.getFileSize());
			os.flush();
			os.close();
			File f = new File(path);
			Scanner in = new Scanner(f);
			String str = "";
			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();
			PhoneInfo vo = new PhoneInfo();
			String belongProject = "1";
			Integer maxPhoneManage = df.getPhoneManageMaxId(vo);
			if (maxPhoneManage == null) {
				maxPhoneManage = 0;
			}
			Date inputTime = new Date();
			vo.setPhoneManageId(String.valueOf(maxPhoneManage + 1));
			vo.setInputTime(inputTime);
			vo.setBelongProject(belongProject);
			int countNum = 0;
			Long miniNum = 0L;
			Long maxNum = 0L;
			while (in.hasNext()) {
				str = in.nextLine();
				if (str != null && !"".equals(str)) {
					countNum++;
					Long s = Long.parseLong(str);
					if (miniNum > s) {
						miniNum = s;
					}
					if (maxNum < s) {
						maxNum = s;
					}
					vo.setSerieNo(str);
					vo.setUploadTime(new Date());
					df.insertWdeviceActiveInfo(vo);
				}
			}

			f.delete();

			// String companyId = this.getCompanyId(belongProject);

			// this.insertPhoneManage(maxPhoneManage + 1, inputTime, companyId,
			// belongProject, String.valueOf(countNum), String.valueOf(miniNum),
			// String.valueOf(maxNum), "2");

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	private void insertPhoneManage(int id, Date inputTime, String companyId,
			String projectId, String countNum, String miniNum, String maxNum,
			String status) {

		try {
			PhoneInfo vo = new PhoneInfo();
			vo.setId(id);
			vo.setInputTime(inputTime);
			vo.setCompanyId(companyId);
			vo.setBelongProject(projectId);
			vo.setCountNum(countNum);
			vo.setMiniNum(miniNum);
			vo.setMaxNum(maxNum);
			vo.setStatus(status);

			ServiceBean.getInstance().getPhoneInfoFacade()
					.insertPhoneManage(vo);
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private String getCompanyId(String projectId) {

		Integer companyId = 0;
		ProjectInfo projectInfo = new ProjectInfo();
		projectInfo.setCondition("id = '" + projectId + "'");
		List<DataMap> projectList;
		try {
			projectList = ServiceBean.getInstance().getProjectInfoFacade()
					.getProjectInfo(projectInfo);

			if (projectList.size() > 0) {
				companyId = (Integer) projectList.get(0).getAt("company_id");
			}
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return String.valueOf(companyId);
	}

	public ActionForward getProjectByCompanyId(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		String companyId = request.getParameter("companyId");

		try {
			ProjectInfo vo = new ProjectInfo();
			if (companyId != null && !"".equals(companyId)) {
				vo.setCondition("company_id = '" + companyId + "'");
			}

			List<DataMap> list = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(vo);
			StringBuffer sb = new StringBuffer();
			if (list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					sb.append(list.get(i).getAt("id"));
					sb.append(",");
					sb.append(list.get(i).getAt("project_name"));
					sb.append("&");
				}
			}
			response.getWriter().write(sb.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public ActionForward deletePhoneInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		Result result = new Result();
		try {
			String id = request.getParameter("id");
			PhoneInfo vo = new PhoneInfo();
			vo.setCondition("device_id ='" + id + "'"); // 设置用户账户
			ServiceBean.getInstance().getPhoneInfoFacade().deletePhoneInfo(vo);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			if (e instanceof SystemException) { /* 对已知异常进行解析 */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* 对未知异常进行解析，并全部定义成未知异常 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward deleteBindDevice(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		Result result = new Result();
		try {
			String id = request.getParameter("device_id");
			String userId = request.getParameter("user_id");
			System.err.println("device_id=" + id + "--userId=" + userId);
			PhoneInfo vo = new PhoneInfo();
			// vo.setCondition("id ='" + id + "'"); // 设置用户账户
			/*
			 * ServiceBean.getInstance().getPhoneInfoFacade()
			 * .deleteBindDeviceInfo(vo);
			 */
			vo.setCondition("device_id ='" + id + "' AND user_id = '" + userId
					+ "' AND status = 1 limit 1");
			List<DataMap> lsit = ServiceBean.getInstance().getPhoneInfoFacade()
					.getDeviceInfoIsPriority(vo);
			if (lsit.size() > 0) {
				String isPriority = lsit.get(0).getAt("is_priority") + "";
				if ("1".equals(isPriority)) {
					vo.setCondition(" device_id = '" + id + "'");
					int a = ServiceBean.getInstance().getPhoneInfoFacade()
							.updateIsPriority(vo);
					if (a > 0) {
						vo.setCondition("device_id ='" + id + "'");
						int b = ServiceBean.getInstance().getPhoneInfoFacade()
								.deleteBindDeviceInfo(vo);
						if (b > 0) {
							System.out.println("解绑成功");
						}
					}
				} else {
					vo.setCondition("device_id ='" + id + "' AND user_id = '"
							+ userId + "' AND status = 1");
					int b = ServiceBean.getInstance().getPhoneInfoFacade()
							.deleteBindDeviceInfo(vo);
					if (b > 0) {
						System.out.println("解绑成功");
					}
				}
			}
			result.setBackPage(HttpTools
					.httpServletPath(request, "imeiControl"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools
					.httpServletPath(request, "imeiControl"));
			if (e instanceof SystemException) { /* 对已知异常进行解析 */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* 对未知异常进行解析，并全部定义成未知异常 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward queryDeviceWifi(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		PhoneInfoFacade info = ServiceBean.getInstance().getPhoneInfoFacade();
		try {
			/*
			 * LoginUser loginUser =
			 * (LoginUser)request.getSession().getAttribute
			 * (Config.SystemConfig.LOGINUSER); if (loginUser == null) { return
			 * null; }
			 */
			// String companyInfoId = loginUser.getCompanyId();
			// String projectInfoId = loginUser.getProjectId();
			PhoneInfoForm form = (PhoneInfoForm) actionForm;
			PhoneInfo vo = new PhoneInfo();

			String deviceImei = request.getParameter("device_imei");
			String email = request.getParameter("email");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String serieNo = request.getParameter("serieNo");
			/*
			 * String status = request.getParameter("status"); String
			 * type=request.getParameter("type"); String phoneManageId =
			 * request.getParameter("phoneManageId");
			 */

			form.setOrderBy("w.pet_id");
			form.setSort("1");

			/*
			 * if(!projectInfoId.equals("0")){ sb.append("p.belong_project in("
			 * + projectInfoId + ")"); }else{ if(!companyInfoId.equals("0")){
			 * ProjectInfo pro = new ProjectInfo();
			 * pro.setCondition("company_id in(" + companyInfoId + ")");
			 * List<DataMap> proList =
			 * ServiceBean.getInstance().getProjectInfoFacade
			 * ().getProjectInfo(pro); if(proList.size() > 0){ int num =
			 * proList.size(); String str = ""; for(int i=0; i<num; i++){
			 * Integer id = (Integer)proList.get(i).getAt("id"); str +=
			 * String.valueOf(id); if(i != num-1){ str += ","; } }
			 * sb.append("p.belong_project in(" + str + ")"); } } }
			 */
			if (deviceImei != null && !"".equals(deviceImei)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.device_imei like '%" + deviceImei + "%'");
			}
			if (email != null && !"".equals(email)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.email like '%" + email + "%'");
			}
			if (startTime != null && !"".equals(startTime)) {
				sb.append("substring(s.share_date,1,10) >= '" + startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(s.share_date,1,10) <= '" + endTime + "'");
			}
			if (serieNo != null && !"".equals(serieNo)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("device_imei like '%" + serieNo + "%'");
			}
			/*
			 * if(phoneManageId != null && !"".equals(phoneManageId)){
			 * if(sb.length() > 0){ sb.append(" and "); }
			 * sb.append("p.phone_manage_id='" + phoneManageId + "'"); }
			 * if(status != null && !"".equals(status)){ if(sb.length() > 0){
			 * sb.append(" and "); } sb.append("p.status ='"+status+"'");
			 * request.setAttribute("status", CommUtils.getStatusSelect(
			 * "status", Integer.parseInt(status))); } if(type != null &&
			 * !"".equals(type)){ if(sb.length() > 0){ sb.append(" and "); }
			 * sb.append("m.type ='"+type+"'"); request.setAttribute("type",
			 * CommUtils.getTypeSelect( "type", Integer.parseInt(type))); }
			 */
			request.setAttribute("email", email);
			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("device_imei", deviceImei);

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			// list = info.getPhoneInfoListByVo(vo);
			list = info.getDeviceWifiInfoListByVo(vo);
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryDeviceWifiInfo");
	}

	public ActionForward queryDevicePhoto(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		PhoneInfoFacade info = ServiceBean.getInstance().getPhoneInfoFacade();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}
			PhoneInfoForm form = (PhoneInfoForm) actionForm;
			PhoneInfo vo = new PhoneInfo();

			String imei = request.getParameter("imei");
			String nickName = request.getParameter("nick_name");

			form.setOrderBy("l.id");
			form.setSort("1");

			if (imei != null && !"".equals(imei)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.device_imei like '%" + imei + "%'");
			}
			if (nickName != null && !"".equals(nickName)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.device_name like '%" + nickName + "%'");
			}

			request.setAttribute("imei", imei);
			request.setAttribute("nick_name", nickName);

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			list = info.getWdevicePhotoInfoListByVo(vo);// 录入信息表为wdevice_active_info
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryDevicePhoto");
	}

	public ActionForward queryDeviceIccid(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		PhoneInfoFacade info = ServiceBean.getInstance().getPhoneInfoFacade();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}
			// String companyInfoId = loginUser.getCompanyId();
			// String projectInfoId = loginUser.getProjectId();
			PhoneInfoForm form = (PhoneInfoForm) actionForm;
			PhoneInfo vo = new PhoneInfo();
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String serieNo = request.getParameter("serieNo");
			String iccid = request.getParameter("iccid");
			/*
			 * String status = request.getParameter("status"); String
			 * type=request.getParameter("type"); String phoneManageId =
			 * request.getParameter("phoneManageId");
			 */

			form.setOrderBy("p.device_id");
			form.setSort("1");
			if (startTime != null && !"".equals(startTime)) {
				sb.append("substring(p.device_update_time,1,10) >= '"
						+ startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(p.device_update_time,1,10) <= '" + endTime
						+ "'");
			}
			if (serieNo != null && !"".equals(serieNo)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("p.device_imei like '%" + serieNo + "%'");
			}

			if (iccid != null && !"".equals(iccid)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("s.iccid like '%" + iccid + "%'");
			}

			/*
			 * if(phoneManageId != null && !"".equals(phoneManageId)){
			 * if(sb.length() > 0){ sb.append(" and "); }
			 * sb.append("p.phone_manage_id='" + phoneManageId + "'"); }
			 * if(status != null && !"".equals(status)){ if(sb.length() > 0){
			 * sb.append(" and "); } sb.append("p.status ='"+status+"'");
			 * request.setAttribute("status", CommUtils.getStatusSelect(
			 * "status", Integer.parseInt(status))); } if(type != null &&
			 * !"".equals(type)){ if(sb.length() > 0){ sb.append(" and "); }
			 * sb.append("m.type ='"+type+"'"); request.setAttribute("type",
			 * CommUtils.getTypeSelect( "type", Integer.parseInt(type))); }
			 */
			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("serieNo", serieNo);
			request.setAttribute("iccid", iccid);

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			// list = info.getPhoneInfoListByVo(vo);
			// list =
			// info.getWdeviceActiveInfoListByVo(vo);//录入信息表为wdevice_active_info
			list = info.getDeviceIccIdByVo(vo);// 录入信息表为wdevice_active_info
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryDeviceIccid");
	}

	// 操作状态
	public ActionForward operatorSimStatus(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		Result result = new Result();

		final String ACCOUNT_SID = "AC08d153f6d0fb9a2135f0edd5614229f6";
		final String AUTH_TOKEN = "5fc4e38b694dfd9a530871996a4a038e";

		try {
			String sid = request.getParameter("id");
			String status = request.getParameter("status");
			String company = request.getParameter("company");
			System.out.println("id=" + sid + "--status=" + status
					+ "--company=" + company);
			// 激活的时候 status传了个0，注销传1
			// 空不管 1 爱施德 2 数米
			PhoneInfo vo = new PhoneInfo();
			if ("0".equals(company)) {
				Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
				if ("0".equals(status)) {
					// status是0就是去激活
					Sim updatedSim = Sim.updater(sid).setRatePlan("data100")
							.setStatus("active").update();

					vo.setCondition("sid ='" + sid + "'");
					vo.setCardStatus("1");
					ServiceBean.getInstance().getPhoneInfoFacade()
							.updateDeviceStatus(vo);
					// active 是设备活跃 inactive 使设备不活跃
					System.out.println("Status: " + updatedSim.getStatus()
							+ "--链接：" + updatedSim.getUrl());
				} else if ("1".equals(status)) {
					System.out.println("sid=" + sid);
					Sim updatedSim = Sim.updater(sid).setStatus("deactivated")
							.update();
					vo.setCondition("sid ='" + sid + "'");
					vo.setCardStatus("0");
					ServiceBean.getInstance().getPhoneInfoFacade()
							.updateDeviceStatus(vo);
					// active 是设备活跃 inactive 使设备不活跃
					System.out.println("Status: " + updatedSim.getStatus()
							+ "--链接：" + updatedSim.getUrl());
				}
			} else if ("1".equals(company)) {
				System.out.println("爱施德");

				SaleInfo sao = new SaleInfo();
				sao.setCondition("iccid ='" + sid + "' and belong_company='1'");
				@SuppressWarnings("static-access")
				List<DataMap> listSim = ServiceBean.getInstance()
						.getSaleInfoFacade().getSimInfoList(sao);

				String imsi = "";
				if (listSim.size() > 0) {
					imsi = listSim.get(0).get("imsi") + "";
				}
				System.out.println("imsi=" + imsi);

				/*
				 * if("Active".equals(Status)){
				 * 
				 * }else if("Suspended".equals(Status)){ AiShiDeIccidApi
				 * .setIccidStatus(sid, imsi, "Resume"); }else{ AiShiDeIccidApi
				 * .setIccidStatus(iccid, imsi, "Activate"); }
				 */

				// 爱施德
				System.out.println(sid + "-" + imsi);
				String resultResponsee = AiShiDeIccidApi.selectIccidStatus(sid,
						imsi);
				System.out.println("resultResponsee=" + resultResponsee);

				JSONObject resultResponseJsone = JSONObject
						.fromObject(resultResponsee);
				String datae = resultResponseJsone.getString("data");

				String respCode = resultResponseJsone.getString("resp_code");
				System.out.println("respCode=" + respCode);
				if ("1".equals(respCode)) {
					JSONObject dataJsone = JSONObject.fromObject(datae);
					String Status = dataJsone.getString("status");

					if ("1".equals(status)) {
						if ("Active".equals(Status)) {
							String zanting = AiShiDeIccidApi.setIccidStatus(
									sid, imsi, "Suspend");
							System.out.println("暂停操作=" + zanting);
						} else if ("Suspended".equals(Status)) {
							System.out.println("本来就是暂停状态");
						}
						/*
						 * String resultResponse =
						 * AiShiDeIccidApi.setIccidStatus(sid, imsi, "Suspend");
						 * JSONObject resultResponseJson =
						 * JSONObject.fromObject(resultResponse); String
						 * respCode =resultResponseJson.getString("resp_code");
						 * if("1".equals(respCode)){
						 */
						// 1就是注销将状态改为0
						vo.setCondition("iccid ='" + sid
								+ "' and belong_company='1'");
						vo.setCardStatus("0");
						ServiceBean.getInstance().getPhoneInfoFacade()
								.updateDeviceStatus(vo);
						// }
					} else if ("0".equals(status)) {
						if ("Active".equals(Status)) {
							System.out.println("是激活的不进行任何操作");
						} else if ("Suspended".equals(Status)) {
							String res = AiShiDeIccidApi.setIccidStatus(sid,
									imsi, "Resume");
							System.out.println(res);
						} else {
							AiShiDeIccidApi.setIccidStatus(sid, imsi,
									"Activate");
						}

						/*
						 * String resultResponse =
						 * AiShiDeIccidApi.setIccidStatus(sid, imsi,
						 * "Activate"); JSONObject resultResponseJson =
						 * JSONObject.fromObject(resultResponse); String
						 * respCode =resultResponseJson.getString("resp_code");
						 * if("1".equals(respCode)){
						 */
						// 1就是注销将状态改为0
						vo.setCondition("iccid ='" + sid
								+ "' and belong_company='1'");
						vo.setCardStatus("1");
						ServiceBean.getInstance().getPhoneInfoFacade()
								.updateDeviceStatus(vo);
						// }
					}
				}
			}

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryDeviceIccid"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryDeviceIccid"));
			if (e instanceof SystemException) { /* 对已知异常进行解析 */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* 对未知异常进行解析，并全部定义成未知异常 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward queryIccidImsi(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		PhoneInfoFacade info = ServiceBean.getInstance().getPhoneInfoFacade();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}
			// String companyInfoId = loginUser.getCompanyId();
			// String projectInfoId = loginUser.getProjectId();
			PhoneInfoForm form = (PhoneInfoForm) actionForm;
			PhoneInfo vo = new PhoneInfo();
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String serieNo = request.getParameter("serieNo");
			String iccid = request.getParameter("iccid");
			/*
			 * String status = request.getParameter("status"); String
			 * type=request.getParameter("type"); String phoneManageId =
			 * request.getParameter("phoneManageId");
			 */

			form.setOrderBy("p.device_id");
			form.setSort("1");
			if (startTime != null && !"".equals(startTime)) {
				sb.append("substring(p.device_update_time,1,10) >= '"
						+ startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(p.device_update_time,1,10) <= '" + endTime
						+ "'");
			}
			if (serieNo != null && !"".equals(serieNo)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("p.device_imei like '%" + serieNo + "%'");
			}

			if (iccid != null && !"".equals(iccid)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("s.iccid like '%" + iccid + "%'");
			}

			/*
			 * if(phoneManageId != null && !"".equals(phoneManageId)){
			 * if(sb.length() > 0){ sb.append(" and "); }
			 * sb.append("p.phone_manage_id='" + phoneManageId + "'"); }
			 * if(status != null && !"".equals(status)){ if(sb.length() > 0){
			 * sb.append(" and "); } sb.append("p.status ='"+status+"'");
			 * request.setAttribute("status", CommUtils.getStatusSelect(
			 * "status", Integer.parseInt(status))); } if(type != null &&
			 * !"".equals(type)){ if(sb.length() > 0){ sb.append(" and "); }
			 * sb.append("m.type ='"+type+"'"); request.setAttribute("type",
			 * CommUtils.getTypeSelect( "type", Integer.parseInt(type))); }
			 */
			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("serieNo", serieNo);
			request.setAttribute("iccid", iccid);

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			// list = info.getPhoneInfoListByVo(vo);
			// list =
			// info.getWdeviceActiveInfoListByVo(vo);//录入信息表为wdevice_active_info
			list = info.getDeviceIccIdByVo(vo);// 录入信息表为wdevice_active_info
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryDeviceIccid");
	}

	public ActionForward singleImei(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		Result result = new Result();
		try {
			String imei = form.getSerieNo();
			String belongProject = request.getParameter("type");

			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();

			PhoneInfo vo = new PhoneInfo();

			vo.setCondition("device_imei='" + imei + "' limit 1");

			List<DataMap> listHave = df.getWdeviceActiveInfoList(vo);
			/*
			 * SaleInfo sao = new SaleInfo();
			 * 
			 * @SuppressWarnings("static-access") SaleInfoFacade sf =
			 * ServiceBean.getInstance() .getSaleInfoFacade();
			 */
			if (listHave.size() <= 0) {
				vo.setSerieNo(imei);
				// vo.setIccid(list.get(countNum));
				vo.setUploadTime(new Date());
				vo.setBelongProject("1");
				// vo.setCompanyId("1");
				df.insertWdeviceActiveInfo(vo);
			}
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");

	}

	public ActionForward singleImeiIccidImsi(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		Result result = new Result();
		try {
			String imei = form.getSerieNo();
			String iccid = request.getParameter("iccid");
			String imsi = request.getParameter("imsi");
			String belongProject = request.getParameter("type");

			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();

			PhoneInfo vo = new PhoneInfo();

			vo.setCondition("device_imei='" + imei + "' limit 1");

			List<DataMap> listHave = df.getWdeviceActiveInfoList(vo);
			SaleInfo sao = new SaleInfo();
			@SuppressWarnings("static-access")
			SaleInfoFacade sf = ServiceBean.getInstance().getSaleInfoFacade();
			if (listHave.size() <= 0) {
				vo.setSerieNo(imei);
				vo.setIccid("");
				vo.setUploadTime(new Date());
				vo.setCompanyId("");
				vo.setBelongProject("1");
				df.insertWdeviceActiveInfo(vo);

				sao.setCondition("iccid='" + iccid + "'and belong_company='1'");
				List<DataMap> simlist = sf.getSimInfoList(sao);
				if (simlist.size() <= 0) {
					sao.setImei(iccid);
					sao.setImsi(imsi);
					sao.setDateTime(new Date());
					sao.setBelongProject("1");
					sf.insertSimInfo(sao);
				}
				
				vo.setCondition("iccid='" + iccid + "' limit 1");
				List<DataMap> listHavee = df.getWdeviceActiveInfoList(vo);
				if (listHavee.size() <= 0) {
					DeviceActiveInfo ddo = new DeviceActiveInfo();
					ddo.setCondition("device_imei='" + imei + "'");
					ddo.setIccid(iccid);
					ddo.setBelongCompany("1");
					ServiceBean.getInstance().getDeviceActiveInfoFacade()
							.updateDeviceActiveInfonull(ddo);
				}
				
			} else {

			/*	DeviceActiveInfo devo = new DeviceActiveInfo();

				devo.setCondition("device_imei='" + imei + "'");
				devo.setIccid("");
				devo.setBelongProject("1");
				ServiceBean.getInstance().getDeviceActiveInfoFacade()
						.updateDeviceActiveInfo(devo);*/

				sao.setCondition("iccid='" + iccid + "'and belong_company='1'");
				List<DataMap> simlist = sf.getSimInfoList(sao);
				if (simlist.size() <= 0) {
					sao.setImei(iccid);
					sao.setImsi(imsi);
					sao.setDateTime(new Date());
					sao.setBelongProject("1");
					sf.insertSimInfo(sao);
				}
				
				vo.setCondition("iccid='" + iccid + "' limit 1");
				List<DataMap> listHavee = df.getWdeviceActiveInfoList(vo);
				if (listHavee.size() <= 0) {
					DeviceActiveInfo ddo = new DeviceActiveInfo();
					ddo.setCondition("device_imei='" + imei + "'");
					ddo.setIccid(iccid);
					ddo.setBelongCompany("1");
					ServiceBean.getInstance().getDeviceActiveInfoFacade()
							.updateDeviceActiveInfonull(ddo);
				}
			}

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward singleIccidImsi(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		Result result = new Result();
		try {
			// String imei = form.getSerieNo();
			String iccid = request.getParameter("iccid");
			String imsi = request.getParameter("imsi");
			String belongProject = request.getParameter("type");

			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();

			PhoneInfo vo = new PhoneInfo();

			// vo.setCondition("device_imei='" + imei +
			// "' and belong_company='"+belongProject+"'");

			// List<DataMap> listHave = df.getWdeviceActiveInfoList(vo);
			SaleInfo sao = new SaleInfo();
			@SuppressWarnings("static-access")
			SaleInfoFacade sf = ServiceBean.getInstance().getSaleInfoFacade();

			sao.setCondition("iccid='" + iccid + "'and belong_company='1'");
			List<DataMap> simlist = sf.getSimInfoList(sao);
			if (simlist.size() <= 0) {
				sao.setImei(iccid);
				sao.setImsi(imsi);
				sao.setDateTime(new Date());
				sao.setBelongProject("1");
				sf.insertSimInfo(sao);
			}
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward unbindIccid(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Result result = new Result();
		try {
			String imei = request.getParameter("imei");

			DeviceActiveInfo sao = new DeviceActiveInfo();

			sao.setCondition("device_imei='" + imei + "'");
			sao.setIccid("");
			ServiceBean.getInstance().getDeviceActiveInfoFacade()
					.updateDeviceActiveInfo(sao);

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryDeviceIccid"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward singleImeiIccid(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		Result result = new Result();
		try {
			// String imei = form.getSerieNo();
			String imei = request.getParameter("imei");
			String iccid = request.getParameter("iccid");
			String belongCompany = request.getParameter("type");

			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();

			PhoneInfo vo = new PhoneInfo();

			vo.setCondition("device_imei='" + imei + "' limit 1");

			List<DataMap> listHave = df.getWdeviceActiveInfoList(vo);

			SaleInfo sao = new SaleInfo();
			@SuppressWarnings("static-access")
			SaleInfoFacade sf = ServiceBean.getInstance().getSaleInfoFacade();

			if (listHave.size() <= 0) {
				Date inputTime = new Date();
				vo.setInputTime(inputTime);
				vo.setSerieNo(imei);
				vo.setIccid("");
				vo.setUploadTime(new Date());
				vo.setBelongProject("1");
				df.insertWdeviceActiveInfo(vo);

				sao.setCondition("iccid='" + iccid + "'and belong_company='"
						+ belongCompany + "'");
				List<DataMap> simlist = sf.getSimInfoList(sao);
				if (simlist.size() > 0) {
					vo.setCondition("iccid='" + iccid + "' limit 1 ");
					List<DataMap> listHavee = df.getWdeviceActiveInfoList(vo);
					if (listHavee.size() < 0) {
						DeviceActiveInfo ddo = new DeviceActiveInfo();
						ddo.setCondition("device_imei='" + imei + "' limit 1");
						ddo.setIccid(iccid);
						ddo.setBelongCompany(belongCompany);
						ServiceBean.getInstance().getDeviceActiveInfoFacade()
								.updateDeviceActiveInfo(ddo);
					}
				}
			} else {
				sao.setCondition("iccid='" + iccid + "'and belong_company='"
						+ belongCompany + "'");
				List<DataMap> simlist = sf.getSimInfoList(sao);
				if (simlist.size() > 0) {
					vo.setCondition("iccid='" + iccid + "'");
					List<DataMap> listHavee = df.getWdeviceActiveInfoList(vo);
					if (listHavee.size() <= 0) {
						DeviceActiveInfo ddo = new DeviceActiveInfo();
						ddo.setCondition("device_imei='" + imei + "'");
						ddo.setIccid(iccid);
						ddo.setBelongCompany(belongCompany);
						ServiceBean.getInstance().getDeviceActiveInfoFacade()
								.updateDeviceActiveInfonull(ddo);
					}
				}

			}

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}
	
	public ActionForward deactivatePhoneInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		Result result = new Result();
		try {
			String id = request.getParameter("id");
			PhoneInfo vo = new PhoneInfo();
			vo.setCondition("device_id ='" + id + "' limit 1"); // 设置用户账户

			List<DataMap> list = ServiceBean.getInstance().getPhoneInfoFacade().getWdeviceActiveInfoList(vo);
			
			if(list.size()>0){
			String iccid=list.get(0).get("iccid")+"";
			String belongCompany=list.get(0).get("belong_company")+"";
				
			}
			
			
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("deletes");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			if (e instanceof SystemException) { /* 对已知异常进行解析 */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* 对未知异常进行解析，并全部定义成未知异常 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}
	
	public ActionForward excelImeiIccidImsi(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		FormFile file = form.getFile1();
		Result result = new Result();
		String dir = request.getSession(true).getServletContext()
				.getRealPath("/upload");
		try {
			System.err.println("EXCEL-IMEI-ICCID-IMSI 表格录入");
			String path = dir + "/" + file.getFileName();

			OutputStream os = new FileOutputStream(path);
			os.write(file.getFileData(), 0, file.getFileSize());
			os.flush();
			os.close();
			ReadExcelTest read = new ReadExcelTest();
			ArrayList<String> list = read.readExcel(path);
			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();
			PhoneInfo vo = new PhoneInfo();
			String belongProject = "1";
			String belongCompany=request.getParameter("type");
			Integer maxPhoneManage = df.getPhoneManageMaxId(vo);
			if (maxPhoneManage == null) {
				maxPhoneManage = 0;
			}
			Date inputTime = new Date();
			vo.setPhoneManageId(String.valueOf(maxPhoneManage + 1));
			vo.setInputTime(inputTime);
			vo.setBelongProject(belongProject);

			int countNum = 0;
			Long miniNum = 0L;
			Long maxNum = 0L;
			for (String str : list) {
				countNum++;

				if (countNum % 3 == 1) {
					/*System.out.println(str);
					System.out.println(list.get(countNum));
					System.out.println(list.get(countNum+1));*/
					
					Long s = Long.parseLong(str);
					if (miniNum > s) {
						miniNum = s;
					}
					if (maxNum < s) {
						maxNum = s;
					}
					vo.setCondition("device_imei='" + str + "' limit 1");

					List<DataMap> listHave = df.getWdeviceActiveInfoList(vo);
					SaleInfo sao = new SaleInfo();
					@SuppressWarnings("static-access")
					SaleInfoFacade sf = ServiceBean.getInstance()
							.getSaleInfoFacade();
					DeviceActiveInfo ddo = new DeviceActiveInfo();
					if (listHave.size() <= 0) {
						vo.setSerieNo(str);
						vo.setIccid("");
						vo.setUploadTime(new Date());
						vo.setBelongProject(belongProject);
						vo.setCompanyId("");
						df.insertWdeviceActiveInfo(vo);
						
						vo.setCondition("iccid='" + list.get(countNum) + "' limit 1");
						
						List<DataMap> listIccidHave = df.getWdeviceActiveInfoList(vo);
						if(listIccidHave.size()<=0){
							ddo.setCondition("device_imei='" + str + "'");
							ddo.setIccid(list.get(countNum));
							ddo.setBelongCompany(belongCompany);
							ServiceBean.getInstance().getDeviceActiveInfoFacade()
									.updateDeviceActiveInfonull(ddo);
						}
						
						sao.setCondition("iccid='" + list.get(countNum)
								+ "'and belong_company='"+belongCompany+"'and imsi='"+list.get(countNum+1)+"'limit 1");
						List<DataMap> simlist = sf.getSimInfoList(sao);
						if (simlist.size() <= 0) {
							sao.setImei(list.get(countNum));
							sao.setImsi(list.get(countNum+1));
							sao.setDateTime(new Date());
							sao.setBelongProject(belongCompany);
							sao.setCardStatus("0");
							sao.setUpdateTime(new Date());
							sf.insertSimInfo(sao);
							
							/*vo.setCondition("iccid='" + list.get(countNum) + "' limit 1");

							List<DataMap> listHavee = df.getWdeviceActiveInfoList(vo);
							if(listHavee.size()<=0){
							//	DeviceActiveInfo ddo = new DeviceActiveInfo();
								ddo.setCondition("device_imei='" + str + "'");
								ddo.setIccid(list.get(countNum));
								ddo.setBelongCompany(belongCompany);
								ServiceBean.getInstance().getDeviceActiveInfoFacade()
										.updateDeviceActiveInfonull(ddo);
							}*/
						}
					} else {
						
                    vo.setCondition("iccid='" + list.get(countNum) + "' limit 1");
						
						List<DataMap> listIccidHave = df.getWdeviceActiveInfoList(vo);
						if(listIccidHave.size()<=0){
							ddo.setCondition("device_imei='" + str + "'");
							ddo.setIccid(list.get(countNum));
							ddo.setBelongCompany(belongCompany);
							ServiceBean.getInstance().getDeviceActiveInfoFacade()
									.updateDeviceActiveInfonull(ddo);
						}
						
						sao.setCondition("iccid='" + list.get(countNum)
								+ "'and belong_company='"+belongCompany+"'and imsi='"+list.get(countNum+1)+"'limit 1");
						List<DataMap> simlist = sf.getSimInfoList(sao);
						if (simlist.size() <= 0) {
							sao.setImei(list.get(countNum));
							sao.setImsi(list.get(countNum+1));
							sao.setDateTime(new Date());
							sao.setBelongProject(belongCompany);
							sao.setCardStatus("0");
							sao.setUpdateTime(new Date());
							sf.insertSimInfo(sao);
						}
					}
				}
			}


			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}
	
	
	public ActionForward initUpdate(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String id = request.getParameter("id");
		PhoneInfo vo = new PhoneInfo();
		vo.setCondition("device_id='"+id+"'");
		vo.setOrderBy("id");
		vo.setFrom(0);
		vo.setPageSize(1);	
		
		List<DataMap> list = ServiceBean.getInstance().getPhoneInfoFacade().getWdeviceActiveInfoList(vo);
		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		request.setAttribute("phoneInfo", list.get(0));
	
		return mapping.findForward("updatePhoneInfo");
	}
	
	
	public ActionForward updateXinXi(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		
		Result result = new Result();
		try {
			
			//System.err.println(request.getParameter("device_id"));
			//System.err.println(request.getParameter("id"));
			PhoneInfoForm form = (PhoneInfoForm) actionForm;			
			PhoneInfo vo = new PhoneInfo();
			System.out.println(form.getSerieNo());
			//System.err.println("设备id="+form.getId());
			vo.setCondition("device_imei='" + form.getSerieNo() + "'");
		//	BeanUtils.copyProperties(vo, form);
            vo.setTestStatus(form.getTestStatus());
            
			int a=ServiceBean.getInstance().getPhoneInfoFacade().updatePhoneStatusInfo(vo);
	
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
	
	// EXCEL-IMEI-SN 表格录入
	public ActionForward excelImeiSn(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		FormFile file = form.getFile1();
		Result result = new Result();
		String dir = request.getSession(true).getServletContext()
				.getRealPath("/upload");
		try {
			System.err.println("EXCEL-IMEI-SN 表格录入");
			String path = dir + "/" + file.getFileName();

			OutputStream os = new FileOutputStream(path);
			os.write(file.getFileData(), 0, file.getFileSize());
			os.flush();
			os.close();
			ReadExcelTest read = new ReadExcelTest();
			ArrayList<String> list = read.readExcel(path);
			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();
			PhoneInfo vo = new PhoneInfo();
			String belongProject = "1";
			String belongCompany=request.getParameter("type");
			Integer maxPhoneManage = df.getPhoneManageMaxId(vo);
			if (maxPhoneManage == null) {
				maxPhoneManage = 0;
			}
			Date inputTime = new Date();
			vo.setPhoneManageId(String.valueOf(maxPhoneManage + 1));
			vo.setInputTime(inputTime);
			vo.setBelongProject(belongProject);

			int countNum = 0;
			Long miniNum = 0L;
			Long maxNum = 0L;
			for (String str : list) {
				countNum++;

				if (countNum % 2 == 1) {
					Long s = Long.parseLong(str);
					if (miniNum > s) {
						miniNum = s;
					}
					if (maxNum < s) {
						maxNum = s;
					}
					vo.setCondition("device_imei='" + str + "' limit 1");

					List<DataMap> listHave = df.getWdeviceActiveInfoList(vo);
					SaleInfo sao = new SaleInfo();
					@SuppressWarnings("static-access")
					SaleInfoFacade sf = ServiceBean.getInstance()
							.getSaleInfoFacade();
					if (listHave.size() <= 0) {
						vo.setSerieNo(str);
						vo.setIccid("");
						vo.setUploadTime(new Date());
						vo.setBelongProject(belongProject);
						vo.setCompanyId("");
						vo.setSn(list.get(countNum));
						df.insertWdeviceActiveInfo(vo);
					} else {
						DeviceActiveInfo ddo = new DeviceActiveInfo();
						//String id=listHave.get(0).get("device_id")+"";
						ddo.setCondition("device_imei='"+str+"'");
						ddo.setSn(list.get(countNum));
						ServiceBean.getInstance().getDeviceActiveInfoFacade().updateDeviceActiveInfonull(ddo);
					}
				}
			}


			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}
	
	public ActionForward excelPromotion(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PhoneInfoForm form = (PhoneInfoForm) actionForm;
		FormFile file = form.getFile1();
		Result result = new Result();
	
		String type=request.getParameter("type");
		String zhekou=request.getParameter("zhekou");
		String usecount=request.getParameter("usecount");
		System.out.println("type="+type);
		System.out.println("zhekou="+zhekou);
		System.out.println("usecount="+usecount);
		
		String dir = request.getSession(true).getServletContext()
				.getRealPath("/upload");
		try {
			String path = dir + "/" + file.getFileName();

			OutputStream os = new FileOutputStream(path);
			os.write(file.getFileData(), 0, file.getFileSize());
			os.flush();
			os.close();
			ReadExcelTest read = new ReadExcelTest();
			ArrayList<String> list = read.readExcel(path);
			PhoneInfoFacade df = ServiceBean.getInstance().getPhoneInfoFacade();
			PhoneInfo vo = new PhoneInfo();
			//String belongProject = form.getBelongProject();
			Integer maxPhoneManage = df.getPhoneManageMaxId(vo);
			if (maxPhoneManage == null) {
				maxPhoneManage = 0;
			}
			Date inputTime = new Date();
			// vo.setPhoneManageId(String.valueOf(maxPhoneManage + 1));
			

			//int countNum = 0;
			//Long miniNum = 0L;
			for (String str : list) {
				//Long s = Long.parseLong(str);
			String s=str;
			System.out.println(s);	
			vo.setCondition("promotion_code='" + str + "'");
			List<DataMap> listmap=df.getParamtioInfo(vo);
				if(listmap.size()<=0){
					vo.setType(type);
					vo.setCardStatus("1");
					vo.setIccid(s);
					if(type.equals("2")){
						vo.setCenterNum("100");
					}else{
						vo.setCenterNum(zhekou);
					}
					vo.setCompanyId(usecount);
					vo.setInputTime(new Date());
					df.insertParamotioInfo(vo);	
				}
			}

		

			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPhoneInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE);
			if (e instanceof SystemException) {
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else {
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}
	
	public ActionForward initUpdateTime(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String id = request.getParameter("id");
		System.out.println("id="+id);
		PhoneInfo vo = new PhoneInfo();
		Result result = new Result();
		try {
			
			/*PhoneInfoForm form = (PhoneInfoForm) actionForm;			
			System.out.println(form.getSerieNo());*/
			vo.setCondition("device_id='" + id + "'");
            vo.setTestStatus("2016-11-11 00:00:00");
            
			int a=ServiceBean.getInstance().getPhoneInfoFacade().updatePhoneTimeInfo(vo);
	
	
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