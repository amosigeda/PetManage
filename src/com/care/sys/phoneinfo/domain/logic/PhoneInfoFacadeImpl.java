package com.care.sys.phoneinfo.domain.logic;

import java.util.List;

import com.care.sys.phoneinfo.dao.PhoneInfoDao;
import com.care.sys.phoneinfo.domain.PhoneInfo;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;

public class PhoneInfoFacadeImpl implements PhoneInfoFacade{
	private PhoneInfoDao phoneInfoDao;

	public void setPhoneInfoDao(PhoneInfoDao phoneInfoDao) {
		this.phoneInfoDao = phoneInfoDao;
	}
	public PhoneInfoFacadeImpl(){
		
	}
	public List<DataMap> getPhoneInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.getPhoneInfo(vo);
	}
	public int insertPhoneInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.insertPhoneInfo(vo);
	}
	public int updatePhoneInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.updatePhoneInfo(vo);
	}
	public int getPhoneInfoCount(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.getPhoneInfoCount(vo);
	}
	public DataList getPhoneInfoListByVo(PhoneInfo vo) throws SystemException {
		DataList list = new DataList(phoneInfoDao.getPhoneInfoListByVo(vo));
		list.setTotalSize(phoneInfoDao.getPhoneInfoCountByVo(vo));
		return list;
	}
	public DataList getPhoneManageListByVo(PhoneInfo vo) throws SystemException {
		DataList list = new DataList(phoneInfoDao.getPhoneManageListByVo(vo));
		list.setTotalSize(phoneInfoDao.getPhoneManageCount(vo));
		return list;
	}
	public List<DataMap> getPhoneManagerInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.getPhoneManageListByVo(vo);
	}
	public int insertPhoneManage(PhoneInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		return phoneInfoDao.insertPhoneManage(vo);
	}
	public int getPhoneManageCount(PhoneInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		return phoneInfoDao.getPhoneManageCount(vo);
	}
	public Integer getPhoneManageMaxId(PhoneInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		return phoneInfoDao.getPhoneManageMaxId(vo);
	}
	public int getPhoneInfoCountByVo(PhoneInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		return phoneInfoDao.getPhoneInfoCountByVo(vo);
	}
	public DataList getWdeviceActiveInfoListByVo(PhoneInfo vo)
			throws SystemException {
		DataList list = new DataList(phoneInfoDao.getWdeviceActiveInfoListByVo(vo));
		list.setTotalSize(phoneInfoDao.getWdeviceActiveInfoCountByVo(vo));
		return list;
	}
	public int insertWdeviceActiveInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.insertWdeviceActiveInfo(vo);
	}
	public List<DataMap> getWdeviceActiveInfoList(PhoneInfo vo)
			throws SystemException {
		return phoneInfoDao.getWdeviceActiveInfoList(vo);
	}
	public DataList getWshareInfoListByVo(PhoneInfo vo) throws SystemException {
		DataList list = new DataList(phoneInfoDao.getWshareInfoListByVo(vo));
		list.setTotalSize(phoneInfoDao.getWshareInfoCountByVo(vo));
		return list;
	}
	public Integer deletePhoneInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.deletePhoneInfo(vo);
	}
	public Integer deleteBindDeviceInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.deleteBindDeviceInfo(vo);
	}
	public DataList getDeviceWifiInfoListByVo(PhoneInfo vo)
			throws SystemException {
		DataList list = new DataList(phoneInfoDao.getDeviceWifiInfoListByVo(vo));
		list.setTotalSize(phoneInfoDao.getgetDeviceWifiInfoCount(vo));
		return list;
	}
	public DataList getWdevicePhotoInfoListByVo(PhoneInfo vo)
			throws SystemException {
		DataList list = new DataList(phoneInfoDao.getWdevicePhotoInfoListByVo(vo));
		list.setTotalSize(phoneInfoDao.getgetDevicePhotoInfoCount(vo));
		return list;
	}
	public DataList getDeviceIccIdByVo(PhoneInfo vo) throws SystemException {
		DataList list = new DataList(phoneInfoDao.getDeviceIccIdByVo(vo));
		list.setTotalSize(phoneInfoDao.getDeviceIccIdCount(vo));
		return list;
	}
	public int updateDeviceStatus(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.updateDeviceStatus(vo);
	}
	public List<DataMap> getDeviceInfoIsPriority(PhoneInfo vo)
			throws SystemException {
		return  phoneInfoDao.getDeviceInfoIsPriority(vo);
	}
	public int updateIsPriority(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.updateIsPriority(vo);
	}
	public int updatePhoneStatusInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.updatePhoneStatusInfo(vo);
	}
	public List<DataMap> getParamtioInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.getParamtioInfo(vo);
		}
	public int insertParamotioInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.insertParamotioInfo(vo);
		}
	public int updatePhoneTimeInfo(PhoneInfo vo) throws SystemException {
		return phoneInfoDao.updatePhoneTimeInfo(vo);
	}
	

}
