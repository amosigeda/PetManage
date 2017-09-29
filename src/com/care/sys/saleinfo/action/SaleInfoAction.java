package com.care.sys.saleinfo.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.care.app.LoginUser;
import com.care.common.config.Config;
import com.care.common.config.ServiceBean;
import com.care.common.http.BaseAction;
import com.care.common.lang.CommUtils;
import com.care.sys.appuserinfo.domain.AppUserInfo;
import com.care.sys.appuserinfo.domain.logic.AppUserInfoFacade;
import com.care.sys.appuserinfo.form.AppUserInfoForm;
import com.care.sys.feedbackinfo.domain.FeedBackInfo;
import com.care.sys.feedbackinfo.form.FeedBackInfoForm;
import com.care.sys.phoneinfo.domain.PhoneInfo;
import com.care.sys.projectinfo.domain.ProjectInfo;
import com.care.sys.roleinfo.domain.RoleInfo;
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
import com.twilio.Twilio;
import com.twilio.rest.preview.wireless.Sim;

public class SaleInfoAction extends BaseAction {

	Log logger = LogFactory.getLog(SaleInfoAction.class);

	public ActionForward querySaleInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		SaleInfoFacade info = ServiceBean.getInstance().getSaleInfoFacade();
		try {
			SaleInfoForm form = (SaleInfoForm) actionForm;
			SaleInfo vo = new SaleInfo();
			String userName = request.getParameter("userName");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String projectId = request.getParameter("projectId");

			form.setOrderBy("s.id");
			form.setSort("1");

			if (userName != null && !"".equals(userName)) {
				sb.append("s.user_name like '%" + userName + "%'");
			}
			System.out.println("username--------" + userName);
			if (startTime != null && !"".equals(startTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(s.date_time,1,10) >= '" + startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(s.date_time,1,10)<= '" + endTime + "'");
			}
			if (projectId != null && !"".equals(projectId)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("s.belong_project='" + projectId + "'");
			}
			System.out.println("p.id--------" + projectId);

			ProjectInfo pro = new ProjectInfo();
			List<DataMap> pros = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(pro);
			request.setAttribute("project", pros);

			request.setAttribute("fNow_date", startTime);
			request.setAttribute("now_date", endTime);
			request.setAttribute("userName", userName);
			request.setAttribute("projectId", projectId);

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			list = info.getSaleInfoListByVo(vo);
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
		return mapping.findForward("querySaleInfo");
	}

	public ActionForward querySaleAreaInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		SaleInfoFacade info = ServiceBean.getInstance().getSaleInfoFacade();
		try {
			SaleInfoForm form = (SaleInfoForm) actionForm;
			SaleInfo vo = new SaleInfo();

			// form.setOrderBy("id");
			// form.setSort("1");

			BeanUtils.copyProperties(vo, form);
			list = info.getSaleInfoListGroupByProvince(vo);
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
		return mapping.findForward("querySaleAreaInfo");
	}

	public ActionForward queryDayAddInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		SaleInfoFacade info = ServiceBean.getInstance().getSaleInfoFacade();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}
			String companyInfoId = loginUser.getCompanyId();
			String projectInfoId = loginUser.getProjectId();
			SaleInfoForm form = (SaleInfoForm) actionForm;
			SaleInfo vo = new SaleInfo();

			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String belongProject = request.getParameter("belongProject");

			form.setOrderBy("d.add_time");
			form.setSort("1");
			StringBuffer buffer = new StringBuffer();
			if (!projectInfoId.equals("0")) {
				sb.append("d.belong_project in(" + projectInfoId + ")");
				buffer.append("belong_project in(" + projectInfoId + ")");
			} else {
				if (!"0".equals(companyInfoId)) {
					ProjectInfo pro = new ProjectInfo();
					pro.setCondition("company_id in(" + companyInfoId + ")");
					List<DataMap> proList = ServiceBean.getInstance()
							.getProjectInfoFacade().getProjectInfo(pro);
					if (proList.size() > 0) {
						int num = proList.size();
						String str = "";
						for (int i = 0; i < num; i++) {
							Integer id = (Integer) proList.get(i).getAt("id");
							str += String.valueOf(id);
							if (i != num - 1) {
								str += ",";
							}
						}
						sb.append("d.belong_project in(" + str + ")");
						buffer.append("belong_project in(" + str + ")");
					}
				}
			}
			if (startTime == null && endTime == null) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				String time1 = format.format(new Date());
				String time2 = time1.substring(0, 8) + "01";

				request.setAttribute("fNow_date", time2);
				request.setAttribute("now_date", time1);
				if (sb.length() > 0) {
					sb.append(" and ");
					buffer.append(" and ");
				}
				sb.append("d.add_time >= '" + time2 + "' and d.add_time <= '"
						+ time1 + "'");

				buffer.append("add_time >= '" + time2 + "' and add_time <= '"
						+ time1 + "'");
			}

			if (startTime != null && !"".equals(startTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
					buffer.append(" and ");
				}
				sb.append("d.add_time >= '" + startTime + "'");
				buffer.append("add_time >='" + startTime + "'");

				request.setAttribute("fNow_date", startTime);
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
					buffer.append(" and ");
				}
				sb.append("d.add_time <= '" + endTime + "'");
				buffer.append("add_time <='" + endTime + "'");

				request.setAttribute("now_date", endTime);
			}
			if (belongProject != null && !"".equals(belongProject)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("d.belong_project='" + belongProject + "'");
			}
			ProjectInfo pro = new ProjectInfo();
			List<DataMap> pros = ServiceBean.getInstance()
					.getProjectInfoFacade().getProjectInfo(pro);
			request.setAttribute("project", pros);
			vo.setAddTime(buffer.toString());
			vo.setCondition(sb.toString());
			request.setAttribute("belongProject", belongProject);
			BeanUtils.copyProperties(vo, form);
			list = info.getAddDayGroupByTime(vo);
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
		return mapping.findForward("queryDayAddInfo");
	}

	public ActionForward querySimInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		SaleInfoFacade saleInfoFacade = ServiceBean.getInstance()
				.getSaleInfoFacade();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

			SaleInfoForm form = (SaleInfoForm) actionForm;
			SaleInfo vo = new SaleInfo();

			String email = request.getParameter("email");
			String userName = request.getParameter("user");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String user_id = request.getParameter("user_id");
			String belongProject = request.getParameter("belongProject");
			String iccid = request.getParameter("iccid");

			form.setOrderBy("s.id");
			form.setSort("1");

			if (email != null && !"".equals(email)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("email like '%" + email + "%'");
			}
			if (startTime != null && !"".equals(startTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) >= '" + startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) <= '" + endTime + "'");
			}
			if (userName != null && !"".equals(userName)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.user_name like '%" + userName + "%'");
			}
			if (user_id != null && !"".equals(user_id)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.id = '" + user_id + "'");
			}
			if (belongProject != null && !"".equals(belongProject)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.belong_project='" + belongProject + "'");
			}
			if (iccid != null && !"".equals(iccid)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("s.iccid like '%" + iccid + "%'");
			}
			/*
			 * ProjectInfo pro = new ProjectInfo(); List<DataMap> pros =
			 * ServiceBean
			 * .getInstance().getProjectInfoFacade().getProjectInfo(pro);
			 * request.setAttribute("project", pros);
			 */

			// request.setAttribute("email", email);

			request.setAttribute("iccid", iccid);
			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			list = saleInfoFacade.getSimInfoListByVo(vo);
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /*
													 * ����Ϊ����ҳ�棬���Գ������ת��ϵ
													 * ͳĬ��ҳ��
													 */
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("querySimInfo");
	}

	public ActionForward queryCancelSubInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		SaleInfoFacade saleInfoFacade = ServiceBean.getInstance()
				.getSaleInfoFacade();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

			SaleInfoForm form = (SaleInfoForm) actionForm;
			SaleInfo vo = new SaleInfo();
			String imei = request.getParameter("imei");
			String email = request.getParameter("email");
			String userName = request.getParameter("user");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String user_id = request.getParameter("user_id");
			String belongProject = request.getParameter("belongProject");

			form.setOrderBy("c.id");
			form.setSort("1");

			if (imei != null && !"".equals(imei)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("c.imei like '%" + imei + "%'");
			}
			if (email != null && !"".equals(email)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("email like '%" + email + "%'");
			}
			if (startTime != null && !"".equals(startTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) >= '" + startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) <= '" + endTime + "'");
			}
			if (userName != null && !"".equals(userName)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.user_name like '%" + userName + "%'");
			}
			if (user_id != null && !"".equals(user_id)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.id = '" + user_id + "'");
			}
			if (belongProject != null && !"".equals(belongProject)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.belong_project='" + belongProject + "'");
			}
			/*
			 * ProjectInfo pro = new ProjectInfo(); List<DataMap> pros =
			 * ServiceBean
			 * .getInstance().getProjectInfoFacade().getProjectInfo(pro);
			 * request.setAttribute("project", pros);
			 */

			// request.setAttribute("email", email);

			request.setAttribute("imei", imei);
			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			// list = saleInfoFacade.getSimInfoListByVo(vo);
			list = saleInfoFacade.selectCancelSubInfoListByVo(vo);
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /*
													 * ����Ϊ����ҳ�棬���Գ������ת��ϵ
													 * ͳĬ��ҳ��
													 */
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryCancelSubInfo");
	}

	public ActionForward queryPayForInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		SaleInfoFacade saleInfoFacade = ServiceBean.getInstance()
				.getSaleInfoFacade();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

			SaleInfoForm form = (SaleInfoForm) actionForm;
			SaleInfo vo = new SaleInfo();

			String email = request.getParameter("email");
			String userName = request.getParameter("user");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String user_id = request.getParameter("user_id");
			String belongProject = request.getParameter("belongProject");
			String imei = request.getParameter("imei");
			String receipt = request.getParameter("receipt");
			String iccid = request.getParameter("iccid");
			String youHuiMa = request.getParameter("youhuima");
			String payStatus = request.getParameter("paystatus");

			form.setOrderBy("p.id");
			form.setSort("1");

			if (imei != null && !"".equals(imei)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("p.imei like '%" + imei + "%'");
			}

			if (email != null && !"".equals(email)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("email like '%" + email + "%'");
			}
			if (startTime != null && !"".equals(startTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) >= '" + startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) <= '" + endTime + "'");
			}
			if (userName != null && !"".equals(userName)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.user_name like '%" + userName + "%'");
			}
			if (user_id != null && !"".equals(user_id)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.id = '" + user_id + "'");
			}
			if (belongProject != null && !"".equals(belongProject)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.belong_project='" + belongProject + "'");
			}

			if (receipt != null && !"".equals(receipt)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("p.receipt_number like '%" + receipt + "%'");
			}

			if (iccid != null && !"".equals(iccid)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("p.iccid like '%" + iccid + "%'");
			}
			if (youHuiMa != null && !"".equals(youHuiMa)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("p.promotion_code='" + youHuiMa + "'");
				request.setAttribute("youhuima", youHuiMa);
			}
			if (payStatus != null && !"".equals(payStatus)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("p.pay_status='" + payStatus + "'");
				request.setAttribute("paystatus", payStatus);
			}

			/*
			 * ProjectInfo pro = new ProjectInfo(); List<DataMap> pros =
			 * ServiceBean
			 * .getInstance().getProjectInfoFacade().getProjectInfo(pro);
			 * request.setAttribute("project", pros);
			 */

			// request.setAttribute("email", email);
			request.setAttribute("imei", imei);
			request.setAttribute("receipt", receipt);
			request.setAttribute("iccid", iccid);

			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			// list = saleInfoFacade.selectCancelSubInfoListByVo(vo);
			list = saleInfoFacade.selectPayforInfoListByVo(vo);
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /*
													 * ����Ϊ����ҳ�棬���Գ������ת��ϵ
													 * ͳĬ��ҳ��
													 */
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* ��δ֪�쳣���н�������ȫ�������δ֪�쳣 */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
			request.setAttribute("pageList", list);
			request.setAttribute("PagePys", pys);
		}
		CommUtils.getIntervalTime(start, new Date(), href);
		return mapping.findForward("queryPayForInfo");
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
			logger.info("id=" + sid + "--status=" + status + "--company="
					+ company);
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
				logger.info("爱施德");
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
				logger.info("准备操作的sid和imsi分别为：--" + sid + "-" + imsi);
				String resultResponsee = AiShiDeIccidApi.selectIccidStatus(sid,
						imsi);
				System.out.println("resultResponsee=" + resultResponsee);
				logger.info("resultResponsee=" + resultResponsee);
				JSONObject resultResponseJsone = JSONObject
						.fromObject(resultResponsee);
				String datae = resultResponseJsone.getString("data");

				String respCode = resultResponseJsone.getString("resp_code");
				System.out.println("respCode=" + respCode);
				logger.info("respCode=" + respCode);
				if ("1".equals(respCode)) {
					JSONObject dataJsone = JSONObject.fromObject(datae);
					String Status = dataJsone.getString("status");

					if ("1".equals(status)) {
						if ("Active".equals(Status)) {
							String zanting = AiShiDeIccidApi.setIccidStatus(
									sid, imsi, "Suspend");
							System.out.println("暂停操作=" + zanting);
							logger.info("暂停操作=" + zanting);
						} else if ("Suspended".equals(Status)) {
							System.out.println("本来就是暂停状态");
							logger.info("本来就是暂停状态");
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
							logger.info("是激活的不进行任何操作");
						} else if ("Suspended".equals(Status)) {
							String res = AiShiDeIccidApi.setIccidStatus(sid,
									imsi, "Resume");
							System.out.println(res);
							logger.info(res);
						} else {
							String jihuo = AiShiDeIccidApi.setIccidStatus(sid,
									imsi, "Activate");
							logger.info("激活--=" + jihuo);
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
					"querySimInfo"));
			result.setResultCode("success");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"querySimInfo"));
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

	@SuppressWarnings({ "static-access", "unchecked" })
	public ActionForward initUpdate(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String id = request.getParameter("id");
		SaleInfo vo = new SaleInfo();
		vo.setCondition("id='" + id + "'");
		vo.setOrderBy("id");
		vo.setFrom(0);
		vo.setPageSize(1);

		List<DataMap> list = ServiceBean.getInstance().getSaleInfoFacade()
				.selectCancelSubInfoListByVo(vo);
		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryCancelSubInfo"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		request.setAttribute("cancelsubInfo", list.get(0));

		return mapping.findForward("updateCancelSubInfo");
	}

	@SuppressWarnings({ "static-access", "static-access" })
	public ActionForward updateXinXi(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			String stopTime = request.getParameter("updateTime");

			SaleInfoForm form = (SaleInfoForm) actionForm;
			SaleInfo vo = new SaleInfo();
			vo.setCondition("id='" + form.getId() + "'");
			// BeanUtils.copyProperties(vo, form);
			vo.setUserName(stopTime);

			int a = ServiceBean.getInstance().getSaleInfoFacade()
					.updateCancelSubInfo(vo);
			if (a > 0) {
				vo.setAddTime(stopTime);
				vo.setDateTime(new Date());
				vo.setBelongProject("1");
				vo.setImei(form.getIccid() + "");
				vo.setAppVersion("update");
				ServiceBean.getInstance().getSaleInfoFacade()
						.insertCancelSubLogInfo(vo);
			}
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryCancelSubInfo"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryCancelSubInfo"));
			if (e instanceof SystemException) { /* 锟斤拷锟斤拷知锟届常锟斤拷锟叫斤拷锟斤拷 */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* 锟斤拷未知锟届常锟斤拷锟叫斤拷锟斤拷锟斤拷锟斤拷全锟斤拷锟斤拷锟斤拷锟轿粗拷斐? */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}

	public ActionForward queryCancelSubLogInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		SaleInfoFacade saleInfoFacade = ServiceBean.getInstance()
				.getSaleInfoFacade();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

			SaleInfoForm form = (SaleInfoForm) actionForm;
			SaleInfo vo = new SaleInfo();
			String imei = request.getParameter("imei");
			String email = request.getParameter("email");
			String userName = request.getParameter("user");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String user_id = request.getParameter("user_id");
			String belongProject = request.getParameter("belongProject");

			form.setOrderBy("c.id");
			form.setSort("1");

			if (imei != null && !"".equals(imei)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("c.imei like '%" + imei + "%'");
			}
			if (email != null && !"".equals(email)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("email like '%" + email + "%'");
			}
			if (startTime != null && !"".equals(startTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) >= '" + startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) <= '" + endTime + "'");
			}
			if (userName != null && !"".equals(userName)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.user_name like '%" + userName + "%'");
			}
			if (user_id != null && !"".equals(user_id)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.id = '" + user_id + "'");
			}
			if (belongProject != null && !"".equals(belongProject)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.belong_project='" + belongProject + "'");
			}
			/*
			 * ProjectInfo pro = new ProjectInfo(); List<DataMap> pros =
			 * ServiceBean
			 * .getInstance().getProjectInfoFacade().getProjectInfo(pro);
			 * request.setAttribute("project", pros);
			 */

			// request.setAttribute("email", email);

			request.setAttribute("imei", imei);
			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			// list = saleInfoFacade.getSimInfoListByVo(vo);
			list = saleInfoFacade.selectCancelSubLogInfoListByVo(vo);
			BeanUtils.copyProperties(pys, form);
			pys.setCounts(list.getTotalSize());

		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(Config.ABOUT_PAGE); /*
													 * ����Ϊ����ҳ�棬���Գ������ת��ϵ
													 * ͳĬ��ҳ��
													 */
			if (e instanceof SystemException) { /* ����֪�쳣���н��� */
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
		return mapping.findForward("queryCancelSubLogInfo");
	}

	public ActionForward initInsert(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("insertCancelSubInfo");
	}

	@SuppressWarnings("static-access")
	public ActionForward insertCancelSubInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(
				"yyyy-MM-dd hh:mm:ss");
		SaleInfo vo = new SaleInfo();
		Result result = new Result();
		try {
			String iccid = request.getParameter("iccid");
			String updateTime = request.getParameter("updateTime");
			String redio = request.getParameter("radio");
			String user = request.getParameter("user");
			String remark = request.getParameter("remark");
			vo.setCondition("imei='" + iccid + "'");
			List<DataMap> list = ServiceBean.getInstance().getSaleInfoFacade()
					.getCancelSubInfo(vo);
			if (list.size() > 0) {
				/*result.setBackPage(HttpTools.httpServletPath(request,
						"queryCancelSubInfo"));*/
				result.setResultCode("updateIcon");
			} else {
				vo.setCondition("iccid='" + iccid + "' and belong_company='"
						+ redio + "'");
				List<DataMap> listSim = ServiceBean.getInstance()
						.getSaleInfoFacade().getSimInfo(vo);
				if (listSim.size() <= 0) {
					result.setResultCode("salerDel");
				} else {
					vo.setImei(iccid);
					vo.setImsi(dateFormat.format(new Date()));
					vo.setCardStatus("200");
					vo.setPhone("ok");
					vo.setPhoneModel(user);
					vo.setSysVersion("2");
					vo.setProvince(updateTime);
					vo.setIccid(iccid);
					vo.setBelongProject(redio);
					vo.setIp(remark);
					ServiceBean.getInstance().getSaleInfoFacade()
							.insertCancelSubInfo(vo);
					result.setResultCode("inserts");
				}
			}
			result.setResultType("success");
			result.setBackPage(HttpTools.httpServletPath(request,  //插入成功后，跳转到原先页面
					"queryCancelSubInfo"));
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryCancelSubInfo"));
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
	
	@SuppressWarnings("static-access")
	public ActionForward queryPromotionInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date start = new Date();
		String href = request.getServletPath();
		Result result = new Result();
		PagePys pys = new PagePys();
		DataList list = null;
		StringBuffer sb = new StringBuffer();
		SaleInfoFacade saleInfoFacade = ServiceBean.getInstance()
				.getSaleInfoFacade();
		try {
			LoginUser loginUser = (LoginUser) request.getSession()
					.getAttribute(Config.SystemConfig.LOGINUSER);
			if (loginUser == null) {
				return null;
			}

			SaleInfoForm form = (SaleInfoForm) actionForm;
			SaleInfo vo = new SaleInfo();
			String imei = request.getParameter("imei");
			String email = request.getParameter("email");
			String userName = request.getParameter("user");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String user_id = request.getParameter("user_id");
			String belongProject = request.getParameter("belongProject");
			String promotionCode = request.getParameter("youhuijuan");

			form.setOrderBy("c.id");
			form.setSort("1");
			
			if (promotionCode != null && !"".equals(promotionCode)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("c.promotion_code like '%" + promotionCode + "%'");
			}
			request.setAttribute("youhuijuan", promotionCode);
			
			
			if (imei != null && !"".equals(imei)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("c.imei like '%" + imei + "%'");
			}
			if (email != null && !"".equals(email)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("email like '%" + email + "%'");
			}
			if (startTime != null && !"".equals(startTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) >= '" + startTime + "'");
			}
			if (endTime != null && !"".equals(endTime)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("substring(create_time,1,10) <= '" + endTime + "'");
			}
			if (userName != null && !"".equals(userName)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.user_name like '%" + userName + "%'");
			}
			if (user_id != null && !"".equals(user_id)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.id = '" + user_id + "'");
			}
			if (belongProject != null && !"".equals(belongProject)) {
				if (sb.length() > 0) {
					sb.append(" and ");
				}
				sb.append("a.belong_project='" + belongProject + "'");
			}
			/*
			 * ProjectInfo pro = new ProjectInfo(); List<DataMap> pros =
			 * ServiceBean
			 * .getInstance().getProjectInfoFacade().getProjectInfo(pro);
			 * request.setAttribute("project", pros);
			 */

			// request.setAttribute("email", email);

			
			vo.setCondition(sb.toString());

			BeanUtils.copyProperties(vo, form);
			// list = saleInfoFacade.getSimInfoListByVo(vo);
			list = saleInfoFacade.selectPromitionInfoListByVo(vo);
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
		return mapping.findForward("queryPromotionInfo");
	}
	
	public ActionForward initInsertPromotion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		return mapping.findForward("insertPromotionInfo");
	}
	@SuppressWarnings({ "static-access", "unchecked" })
	public ActionForward insertPromotionInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(
				"yyyy-MM-dd hh:mm:ss");
		SaleInfo vo = new SaleInfo();
		Result result = new Result();
		try {
			String promotionCode = request.getParameter("promotionCode");//优惠券
			String type = request.getParameter("type");//1优惠卡2代金券
			String cardStatus = request.getParameter("cardStatus");//是否使用
			String cardType = request.getParameter("cardType");//券类型 11年2半年3三个月
			String discountRate = request.getParameter("discountRate");
			String useCount = request.getParameter("useCount");
			String user = request.getParameter("user");
			String remark = request.getParameter("remark");
		/*System.out.println("优惠券："+promotionCode+"-"+type+"-"+cardStatus+"-"+cardType+"-"+discountRate+"-"+useCount
				+"-"+user+"-"+remark
				);*/
		vo.setCondition("promotion_code='"+promotionCode+"'");
		vo.setOrderBy("id");
		vo.setSort("1");
		vo.setFrom(0);
		vo.setPageSize(1);
		List<DataMap> list=ServiceBean.getInstance().getSaleInfoFacade().selectPromitionInfoListByVo(vo);
		
		if(list.size()<=0){
			vo.setIccid(promotionCode);
			vo.setAppVersion(type);
			vo.setBelongProject(cardStatus);
		    vo.setCardStatus(cardType);
		    vo.setDeviceType(discountRate);
		    vo.setIp(useCount);
           vo.setImei(user);
           vo.setImsi(remark);
           vo.setDateTime(new Date());
           ServiceBean.getInstance().getSaleInfoFacade().insertPromitionInfo(vo);
		}
		
		    result.setResultCode("inserts");
			result.setResultType("success");
			result.setBackPage(HttpTools.httpServletPath(request,  //插入成功后，跳转到原先页面
					"queryPromotionInfo"));
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPromotionInfo"));
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
	
	@SuppressWarnings({ "static-access", "unchecked" })
	public ActionForward initUpdatePromotion(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String id = request.getParameter("id");
		SaleInfo vo = new SaleInfo();
		vo.setCondition("id='"+id+"'");
		vo.setOrderBy("id");
		vo.setSort("1");
		vo.setFrom(0);
		vo.setPageSize(1);
		List<DataMap> list=ServiceBean.getInstance().getSaleInfoFacade().selectPromitionInfoListByVo(vo);

		if (list == null || list.size() == 0) {
			Result result = new Result();
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPromotionInfo"));
			result.setResultCode("rowDel");
			result.setResultType("success");
			return mapping.findForward("result");
		}
		request.setAttribute("cancelsubInfo", list.get(0));

		return mapping.findForward("updatePromotionInfo");
	}
	
	
	@SuppressWarnings({ "static-access", "static-access" })
	public ActionForward updatePromotionInfo(ActionMapping mapping,
			ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) {

		Result result = new Result();
		try {
			String id=request.getParameter("id");
			String cardStatus=request.getParameter("cardStatus");
			String type=request.getParameter("type");
			String cardType=request.getParameter("cardType");
			String discountRate=request.getParameter("discountRate");
			String useCount=request.getParameter("useCount");
			String remark=request.getParameter("remark");
			

			SaleInfoForm form = (SaleInfoForm) actionForm;
			SaleInfo vo = new SaleInfo();
			vo.setCondition("id='" + form.getId() + "'");
			// BeanUtils.copyProperties(vo, form);
			vo.setAppVersion(cardStatus);
			vo.setBelongProject(type);
			vo.setCardStatus(cardType);
			vo.setDeviceType(discountRate);
			vo.setIccid(useCount);
			vo.setImei(remark);

			int a = ServiceBean.getInstance().getSaleInfoFacade()
					.updatePromotionInfo(vo);
			
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPromotionInfo"));
			result.setResultCode("updates");
			result.setResultType("success");
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(request.getQueryString() + "  " + e);
			result.setBackPage(HttpTools.httpServletPath(request,
					"queryPromotionInfo"));
			if (e instanceof SystemException) { /* 锟斤拷锟斤拷知锟届常锟斤拷锟叫斤拷锟斤拷 */
				result.setResultCode(((SystemException) e).getErrCode());
				result.setResultType(((SystemException) e).getErrType());
			} else { /* 锟斤拷未知锟届常锟斤拷锟叫斤拷锟斤拷锟斤拷锟斤拷全锟斤拷锟斤拷锟斤拷锟轿粗拷斐? */
				result.setResultCode("noKnownException");
				result.setResultType("sysRunException");
			}
		} finally {
			request.setAttribute("result", result);
		}
		return mapping.findForward("result");
	}
}
