package com.care.wei;

import java.util.Date;
import java.util.List;

import com.care.common.config.ServiceBean;
import com.care.sys.appuserinfo.domain.AppUserInfo;
import com.care.sys.appuserinfo.domain.logic.AppUserInfoFacade;
import com.care.sys.saleinfo.domain.SaleInfo;
import com.care.sys.saleinfo.domain.logic.SaleInfoFacade;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;

public class MyCatTest {

	public static void main(String[] args) {
		selectIccidHavingCount();

		// selectInfo();
		// inserstInfo();
	}

	private static void selectIccidHavingCount() {
		//去掉sim_info表的重复数据的方法
		SaleInfoFacade info = ServiceBean.getInstance().getSaleInfoFacade();
		SaleInfo vo = new SaleInfo();
		try {
			List<DataMap> list = info.getHavingCountOne(vo);
			System.out.println("长度=" + list.size());
			if (list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					String iccid = list.get(i).get("iccid").toString();
					System.out.println("iccid=" + iccid);
					vo.setCondition("iccid='" + iccid + "'");
					List<DataMap> listI = info.getSimInfoList(vo);
					if (listI.size() > 0) {
						String cardStatus = listI.get(0).get("card_status")
								+ "";
						String createTime = listI.get(0).get("create_time")
								+ "";
						String belongCompany = listI.get(0).get(
								"belong_company")
								+ "";
						String imsi = listI.get(0).get("imsi") + "";
						System.out.println("cardStatus=" + cardStatus);
						System.out.println("createTime=" + createTime);
						System.out.println("beklongCompany=" + createTime);
						System.out.println("imsi=" + imsi);

						
						  vo.setCondition("iccid='"+iccid+"'");
						  info.deleteSimInfo(vo);
						 
					/*	(iccid,belong_company,create_time,imsi,card_status) 
						VALUES 
						(#imei#,#belongProject#,#dateTime#,#imsi#,#cardStatus#)*/
					
						  vo.setImei(iccid);
						vo.setBelongProject("1");
						vo.setDateTime(new Date());
						vo.setImsi(listI.get(0).get("imsi") + "");
						vo.setCardStatus(listI.get(0).get("card_status") + "");
						info.insertSimBeiFenInfo(vo);
						info.insertSimInfo(vo);
					}

				}

			}
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static void selectInfo() {
		for (int i = 1; i < 10; i++) {
			AppUserInfoFacade info = ServiceBean.getInstance()
					.getAppUserInfoFacade();
			AppUserInfo vo = new AppUserInfo();

			/*
			 * vo.setCondition("id='"+i+"'"); vo.setNickName(i+"");
			 * 
			 * int b=info.updateTestInfo(vo); if(b>0){
			 * System.out.println(i+"修改成功"); }
			 */

			/*
			 * vo.setNickName("weitechao"+i);
			 * 
			 * try { int a = info.insertTestInfo(vo); if(a>0){
			 * System.out.println(i+"增加成功"); } } catch (SystemException e) { //
			 * TODO Auto-generated catch block e.printStackTrace(); }
			 */

			vo.setCondition("id='1'");

			List<DataMap> list;
			try {
				list = info.selectTestInfo(vo);
				if (list.size() > 0) {
					String name = list.get(0).get("name") + "";
					System.out.println("名字=" + name);
				}
				list = info.selectTestInfo(vo);
				if (list.size() > 0) {
					String name = list.get(0).get("name") + "";
					System.out.println("名字=" + name);
				}
				list = info.selectTestInfo(vo);
				if (list.size() > 0) {
					String name = list.get(0).get("name") + "";
					System.out.println("名字=" + name);
				}
				list = info.selectTestInfo(vo);
				if (list.size() > 0) {
					String name = list.get(0).get("name") + "";
					System.out.println("名字=" + name);
				}
				list = info.selectTestInfo(vo);
				if (list.size() > 0) {
					String name = list.get(0).get("name") + "";
					System.out.println("名字=" + name);
				}
				list = info.selectTestInfo(vo);
				if (list.size() > 0) {
					String name = list.get(0).get("name") + "";
					System.out.println("名字=" + name);
				}
				list = info.selectTestInfo(vo);
				if (list.size() > 0) {
					String name = list.get(0).get("name") + "";
					System.out.println("名字=" + name);
				}
			} catch (SystemException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

	}

	private static void inserstInfo() {
		for (int i = 1; i < 10; i++) {
			AppUserInfoFacade info = ServiceBean.getInstance()
					.getAppUserInfoFacade();
			AppUserInfo vo = new AppUserInfo();

			/*
			 * vo.setCondition("id='"+i+"'"); vo.setNickName(i+"");
			 * 
			 * int b=info.updateTestInfo(vo); if(b>0){
			 * System.out.println(i+"修改成功"); }
			 */

			vo.setNickName("yaaaa--" + i);

			try {
				int a = info.insertTestInfo(vo);
				if (a > 0) {
					System.out.println(i + "增加成功");
				}
			} catch (SystemException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
