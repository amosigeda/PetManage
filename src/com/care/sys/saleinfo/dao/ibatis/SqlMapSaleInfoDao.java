package com.care.sys.saleinfo.dao.ibatis;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.care.sys.phoneinfo.domain.PhoneInfo;
import com.care.sys.saleinfo.dao.SaleInfoDao;
import com.care.sys.saleinfo.domain.SaleInfo;
import com.godoing.rose.lang.DataMap;

public class SqlMapSaleInfoDao extends SqlMapClientDaoSupport implements SaleInfoDao{
	
	Log logger = LogFactory.getLog(SqlMapSaleInfoDao.class);

	public int deleteSaleInfo(SaleInfo vo) throws DataAccessException {
		logger.debug("deleteSaleInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().update("deleteSaleInfo", vo);
	}

	public List<DataMap> getSaleInfo(SaleInfo vo) throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("getSaleInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("getSaleInfo", vo);
	}

	public int getSaleInfoCount(SaleInfo vo) throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("getSaleInfoCount(SaleInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("getSaleInfoCount", vo);
	}

	public List<DataMap> getSaleInfoListByVo(SaleInfo vo)
			throws DataAccessException {
		logger.debug("getSaleInfoListByVo(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("getSaleInfoListByVo", vo);
	}

	public int insertSaleInfo(SaleInfo vo) throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("insertSaleInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().update("insertSaleInfo", vo);
	}

	public int updateSaleInfo(SaleInfo vo) throws DataAccessException {
		logger.debug("updateSaleInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().update("updateSaleInfo", vo);
	}

	public int getSaleInfoCountGroupByProvince(SaleInfo vo)
			throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("getSaleInfoCountGroupByProvince(SaleInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("getSaleInfoCountGroupByProvince", vo);
	}

	public List<DataMap> getSaleInfoListGroupByProvince(SaleInfo vo)
			throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("getSaleInfoListGroupByProvince(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("getSaleInfoListGroupByProvince", vo);
	}

	public List<DataMap> getAddDayGroupByTime(SaleInfo vo)
			throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("getAddDayGroupByTime(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("getAddDayGroupByTime", vo);
	}

	public int getCountAddDayGroupByTime(SaleInfo vo)
			throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("getCountAddDayGroupByTime(SaleInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("getCountAddDayGroupByTime", vo);
	}

	public List<DataMap> getSimInfoListByVo(SaleInfo vo)
			throws DataAccessException {
		logger.debug("getSimInfoListByVo(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("getSimInfoListByVo", vo);
	}

	public int getSimInfoCount(SaleInfo vo) throws DataAccessException {
		logger.debug("getSimInfoCount(SaleInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("getSimInfoCount", vo);
	
	}

	public List<DataMap> selectCancelSubInfoListByVo(SaleInfo vo)
			throws DataAccessException {
		logger.debug("selectCancelSubInfoListByVo(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("selectCancelSubInfoListByVo", vo);
	}

	public int selectCancelSubInfoCount(SaleInfo vo) throws DataAccessException {
		logger.debug("selectCancelSubInfoCount(SaleInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("selectCancelSubInfoCount", vo);
	}

	public List<DataMap> selectPayforInfoListByVo(SaleInfo vo)
			throws DataAccessException {
		logger.debug("selectPayforInfoListByVo(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("selectPayforInfoListByVo", vo);
	}

	public int selectPayforInfoCount(SaleInfo vo) throws DataAccessException {
		logger.debug("selectPayforInfoCount(SaleInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("selectPayforInfoCount", vo);
	}

	public int insertSimInfo(SaleInfo sao) throws DataAccessException {
		logger.debug("insertSimInfo(SaleInfo sao)");
		return getSqlMapClientTemplate().update("insertSimInfo", sao);
	}

	public List<DataMap> getSimInfoList(SaleInfo vo)
			throws DataAccessException {
		logger.debug("getSimInfoListByVo(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("getSimInfoList", vo);
	}

	public int updateSimInfo(SaleInfo sao) throws DataAccessException {
		logger.debug("updateSimInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().update("updateSimInfo", sao);
	}

	public int updateCancelSubInfo(SaleInfo vo) throws DataAccessException {
		logger.debug("updateCancelSubInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().update("updateCancelSubInfo", vo);
	}

	public int insertCancelSubLogInfo(SaleInfo vo) throws DataAccessException {
		logger.debug("insertCancelSubLogInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().update("insertCancelSubLogInfo", vo);
	}

	public List<DataMap> selectCancelSubLogInfoListByVo(SaleInfo vo)
			throws DataAccessException {
		logger.debug("selectCancelSubLogInfoListByVo(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("selectCancelSubLogInfoListByVo", vo);
	}

	public int selectCancelSubLogInfoCount(SaleInfo vo)
			throws DataAccessException {
		logger.debug("selectCancelSubLogInfoCount(SaleInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("selectCancelSubLogInfoCount", vo);
	}

	public List<DataMap> getHavingCountOne(SaleInfo vo)
			throws DataAccessException {
		logger.debug("getHavingCountOne(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("getHavingCountOne", vo);
	}

	public int deleteSimInfo(SaleInfo vo) throws DataAccessException {
		logger.debug("deleteSimInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().update("deleteSimInfo", vo);
	}

	public int insertSimBeiFenInfo(SaleInfo vo) throws DataAccessException {
		logger.debug("insertSimBeiFenInfo(SaleInfo sao)");
		return getSqlMapClientTemplate().update("insertSimBeiFenInfo", vo);
	}

	public List<DataMap> getCancelSubInfo(SaleInfo vo)
			throws DataAccessException {
		logger.debug("getCancelSubInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("getCancelSubInfo", vo);
	}

	public List<DataMap> getSimInfo(SaleInfo vo) throws DataAccessException {
		logger.debug("getSimInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("getSimInfo", vo);
	}

	public int insertCancelSubInfo(SaleInfo vo) throws DataAccessException {
		logger.debug("insertCancelSubInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().update("insertCancelSubInfo", vo);
	}

	public List<DataMap> selectPromitionInfoListByVo(SaleInfo vo)
			throws DataAccessException {
		logger.debug("selectPromitionInfoListByVo(SaleInfo vo)");
		return getSqlMapClientTemplate().queryForList("selectPromitionInfoListByVo", vo);
	}

	public int selectPromitionInfoCount(SaleInfo vo) throws DataAccessException {
		// TODO Auto-generated method stub
		logger.debug("selectPromitionInfoCount(SaleInfo vo)");
		return (Integer)getSqlMapClientTemplate().queryForObject("selectPromitionInfoCount", vo);
	}

	public int insertPromitionInfo(SaleInfo vo) throws DataAccessException {
		logger.debug("insertPromitionInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().update("insertPromitionInfo", vo);
	}

	public int updatePromotionInfo(SaleInfo vo) throws DataAccessException {
		logger.debug("updatePromotionInfo(SaleInfo vo)");
		return getSqlMapClientTemplate().update("updatePromotionInfo", vo);
	}

}
