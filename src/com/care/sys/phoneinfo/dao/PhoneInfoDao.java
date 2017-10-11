package com.care.sys.phoneinfo.dao;

import java.util.Collection;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.care.sys.phoneinfo.domain.PhoneInfo;
import com.godoing.rose.lang.DataMap;

public interface PhoneInfoDao {
	
	public int insertPhoneInfo(PhoneInfo vo) throws DataAccessException;
	
	public List<DataMap> getPhoneInfo(PhoneInfo vo) throws DataAccessException;
	
	public int updatePhoneInfo(PhoneInfo vo) throws DataAccessException;
	
	public List<DataMap> getPhoneInfoListByVo(PhoneInfo vo) throws DataAccessException;
	
	public int getPhoneInfoCount(PhoneInfo vo) throws DataAccessException;
	
	public int insertPhoneManage(PhoneInfo vo) throws DataAccessException;
	
	public List<DataMap> getPhoneManageListByVo(PhoneInfo vo) throws DataAccessException;
	
	public int getPhoneManageCount(PhoneInfo vo) throws DataAccessException;
	
	public Integer getPhoneManageMaxId(PhoneInfo vo) throws DataAccessException;
	
	public int getPhoneInfoCountByVo(PhoneInfo vo) throws DataAccessException;

	public  List<DataMap> getWdeviceActiveInfoListByVo(PhoneInfo vo)throws DataAccessException;

	public int getWdeviceActiveInfoCountByVo(PhoneInfo vo)throws DataAccessException;

	public int insertWdeviceActiveInfo(PhoneInfo vo)throws DataAccessException;

	public List<DataMap> getWdeviceActiveInfoList(PhoneInfo vo)throws DataAccessException;

	public List<DataMap> getWshareInfoListByVo(PhoneInfo vo)throws DataAccessException;

	public int getWshareInfoCountByVo(PhoneInfo vo)throws DataAccessException;

	public Integer deletePhoneInfo(PhoneInfo vo)throws DataAccessException;

	public Integer deleteBindDeviceInfo(PhoneInfo vo)throws DataAccessException;

	public List<DataMap> getDeviceWifiInfoListByVo(PhoneInfo vo)throws DataAccessException;

	public int getgetDeviceWifiInfoCount(PhoneInfo vo)throws DataAccessException;

	public List<DataMap> getWdevicePhotoInfoListByVo(PhoneInfo vo)throws DataAccessException;

	public int getgetDevicePhotoInfoCount(PhoneInfo vo)throws DataAccessException;

	public  List<DataMap> getDeviceIccIdByVo(PhoneInfo vo)throws DataAccessException;

	public int getDeviceIccIdCount(PhoneInfo vo)throws DataAccessException;

	public int updateDeviceStatus(PhoneInfo vo)throws DataAccessException;

	public List<DataMap> getDeviceInfoIsPriority(PhoneInfo vo)throws DataAccessException;

	public int updateIsPriority(PhoneInfo vo)throws DataAccessException;

	public int updatePhoneStatusInfo(PhoneInfo vo)throws DataAccessException;

	public List<DataMap> getParamtioInfo(PhoneInfo vo)throws DataAccessException;

	public int insertParamotioInfo(PhoneInfo vo)throws DataAccessException;

	public int updatePhoneTimeInfo(PhoneInfo vo)throws DataAccessException;

}
