package com.care.sys.phoneinfo.domain.logic;

import java.util.List;

import com.care.sys.phoneinfo.domain.PhoneInfo;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;

public interface PhoneInfoFacade {
	
	public List<DataMap> getPhoneInfo(PhoneInfo vo) throws SystemException;
	
	public int insertPhoneInfo(PhoneInfo vo) throws SystemException;
	
	public int updatePhoneInfo(PhoneInfo vo) throws SystemException;
	
	public DataList getPhoneInfoListByVo(PhoneInfo vo) throws SystemException;
	
	public int getPhoneInfoCount(PhoneInfo vo) throws SystemException;
	
	public int insertPhoneManage(PhoneInfo vo) throws SystemException;
	
	public DataList getPhoneManageListByVo(PhoneInfo vo) throws SystemException;
	
	public List<DataMap> getPhoneManagerInfo(PhoneInfo vo) throws SystemException;
	
	public int getPhoneManageCount(PhoneInfo vo) throws SystemException;
	
	public Integer getPhoneManageMaxId(PhoneInfo vo) throws SystemException;
	
	public int getPhoneInfoCountByVo(PhoneInfo vo) throws SystemException;

	public DataList getWdeviceActiveInfoListByVo(PhoneInfo vo)throws SystemException;

	public int insertWdeviceActiveInfo(PhoneInfo vo)throws SystemException;

	public List<DataMap> getWdeviceActiveInfoList(PhoneInfo vo)throws SystemException;

	public DataList getWshareInfoListByVo(PhoneInfo vo)throws SystemException;

	public Integer deletePhoneInfo(PhoneInfo vo)throws SystemException;

	public Integer deleteBindDeviceInfo(PhoneInfo vo)throws SystemException;

	public DataList getDeviceWifiInfoListByVo(PhoneInfo vo)throws SystemException;

	public DataList getWdevicePhotoInfoListByVo(PhoneInfo vo)throws SystemException;

	public DataList getDeviceIccIdByVo(PhoneInfo vo)throws SystemException;

	public int updateDeviceStatus(PhoneInfo vo)throws SystemException;

	public  List<DataMap> getDeviceInfoIsPriority(PhoneInfo vo)throws SystemException;

	public int updateIsPriority(PhoneInfo vo)throws SystemException;

	public int updatePhoneStatusInfo(PhoneInfo vo)throws SystemException;

	public List<DataMap> getParamtioInfo(PhoneInfo vo)throws SystemException;

	public int insertParamotioInfo (PhoneInfo vo) throws SystemException;

}
