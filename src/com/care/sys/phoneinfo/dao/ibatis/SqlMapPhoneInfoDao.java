package com.care.sys.phoneinfo.dao.ibatis;

import java.util.List;

import org.apache.commons.logging.Log;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.care.sys.phoneinfo.dao.PhoneInfoDao;
import com.care.sys.phoneinfo.domain.PhoneInfo;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.log.LogFactory;

public class SqlMapPhoneInfoDao extends SqlMapClientDaoSupport implements PhoneInfoDao{
	
	Log logger = LogFactory.getLog(SqlMapPhoneInfoDao.class);
	public SqlMapPhoneInfoDao(){
		
	}

	public List<DataMap> getPhoneInfo(PhoneInfo vo) throws DataAccessException {
		logger.debug("getPhoneInfo(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getPhoneInfo", vo);
	}

	public int insertPhoneInfo(PhoneInfo vo) throws DataAccessException {
		logger.debug("insertPhoneInfo(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("insertPhoneInfo", vo);
	}

	public int updatePhoneInfo(PhoneInfo vo) throws DataAccessException {
		logger.debug("updatePhoneInfo(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("updatePhoneInfo", vo);
	}

	public int getPhoneInfoCount(PhoneInfo vo) throws DataAccessException {
		logger.debug("getPhoneInfoCount(PhoneInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("getPhoneInfoCount", vo);
	}

	public List<DataMap> getPhoneInfoListByVo(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getPhoneInfoListByVo(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getPhoneInfoListByVo", vo);
	}

	public List<DataMap> getPhoneManageListByVo(PhoneInfo vo)
			throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("getPhoneManageListByVo(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getPhoneManageListByVo", vo);
	}

	public int insertPhoneManage(PhoneInfo vo) throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("insertPhoneManage(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("insertPhoneManage", vo);
	}

	public int getPhoneManageCount(PhoneInfo vo) throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("getPhoneManageCount(PhoneInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("getPhoneManageCount", vo);
	}

	public Integer getPhoneManageMaxId(PhoneInfo vo) throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("getPhoneManageMaxId(PhoneInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("getPhoneManageMaxId", vo);
	}

	public int getPhoneInfoCountByVo(PhoneInfo vo) throws DataAccessException {
		// TODO Auto-generated method stub
		return (Integer)getSqlMapClientTemplate().queryForObject("getPhoneInfoCountByVo", vo);
	}

	@SuppressWarnings("unchecked")
	public List<DataMap> getWdeviceActiveInfoListByVo(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getWdeviceActiveInfoListByVo(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getWdeviceActiveInfoListByVo", vo);
	
	}

	public int getWdeviceActiveInfoCountByVo(PhoneInfo vo)
			throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("getWdeviceActiveInfoCountByVo", vo);
	}

	public int insertWdeviceActiveInfo(PhoneInfo vo) throws DataAccessException {
		logger.debug("insertWdeviceActiveInfo(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("insertWdeviceActiveInfo", vo);
	}

	public List<DataMap> getWdeviceActiveInfoList(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getWdeviceActiveInfoList(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getWdeviceActiveInfoList", vo);
	}

	public List<DataMap> getWshareInfoListByVo(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getWshareInfoListByVo(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getWshareInfoListByVo", vo);
	}

	public int getWshareInfoCountByVo(PhoneInfo vo) throws DataAccessException {
		return (Integer)getSqlMapClientTemplate().queryForObject("getWshareInfoCountByVo", vo);
		
	}

	public Integer deletePhoneInfo(PhoneInfo vo) throws DataAccessException {
		logger.debug("deletePhoneInfo(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("deletePhoneInfo", vo);
	}

	public Integer deleteBindDeviceInfo(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("deleteBindDeviceInfo(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("deleteBindDeviceInfo", vo);
	}

	public List<DataMap> getDeviceWifiInfoListByVo(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getDeviceWifiInfoListByVo(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getDeviceWifiInfoListByVo", vo);
	}

	public int getgetDeviceWifiInfoCount(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getgetDeviceWifiInfoCount(PhoneInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("getgetDeviceWifiInfoCount", vo);
	
	}

	public List<DataMap> getWdevicePhotoInfoListByVo(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getWdevicePhotoInfoListByVo(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getWdevicePhotoInfoListByVo", vo);
	}

	public int getgetDevicePhotoInfoCount(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getgetDevicePhotoInfoCount(PhoneInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("getgetDevicePhotoInfoCount", vo);
	}

	public List<DataMap> getDeviceIccIdByVo(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getDeviceIccIdByVo(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getDeviceIccIdByVo", vo);
	}

	public int getDeviceIccIdCount(PhoneInfo vo) throws DataAccessException {
		logger.debug("getDeviceIccIdCount(PhoneInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("getDeviceIccIdCount", vo);
	}

	public int updateDeviceStatus(PhoneInfo vo) throws DataAccessException {
		logger.debug("updateDeviceStatus(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("updateDeviceStatus", vo);
	}

	public List<DataMap> getDeviceInfoIsPriority(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getDeviceInfoIsPriority(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getDeviceInfoIsPriority", vo);
	}

	public int updateIsPriority(PhoneInfo vo) throws DataAccessException {
		logger.debug("updateIsPriority(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("updateIsPriority", vo);
	}

	public int updatePhoneStatusInfo(PhoneInfo vo) throws DataAccessException {
		logger.debug("updatePhoneStatusInfo(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("updatePhoneStatusInfo", vo);
	}

	public List<DataMap> getParamtioInfo(PhoneInfo vo)
			throws DataAccessException {
		logger.debug("getParamtioInfo(PhoneInfo vo)");
		return getSqlMapClientTemplate().queryForList("getParamtioInfo", vo);
	}

	public int insertParamotioInfo(PhoneInfo vo) throws DataAccessException {
		logger.debug("insertParamotioInfo(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("insertParamotioInfo", vo);
	}

	public int updatePhoneTimeInfo(PhoneInfo vo) throws DataAccessException {
		logger.debug("updatePhoneTimeInfo(PhoneInfo vo)");
		return getSqlMapClientTemplate().update("updatePhoneTimeInfo", vo);
	}

}
