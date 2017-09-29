package com.care.sys.saleinfo.dao;

import java.util.Collection;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.care.sys.phoneinfo.domain.PhoneInfo;
import com.care.sys.saleinfo.domain.SaleInfo;
import com.godoing.rose.lang.DataMap;

public interface SaleInfoDao {
	
	public List<DataMap> getSaleInfo(SaleInfo vo) throws DataAccessException;
	
	public int insertSaleInfo(SaleInfo vo) throws DataAccessException;
	
	public int updateSaleInfo(SaleInfo vo) throws DataAccessException;
	
	public int deleteSaleInfo(SaleInfo vo) throws DataAccessException;
	
	public List<DataMap> getSaleInfoListByVo(SaleInfo vo) throws DataAccessException;
	
	public int getSaleInfoCount(SaleInfo vo) throws DataAccessException;
	
	public List<DataMap> getSaleInfoListGroupByProvince(SaleInfo vo) throws DataAccessException;
	
	public int getSaleInfoCountGroupByProvince(SaleInfo vo) throws DataAccessException;
	
	public List<DataMap> getAddDayGroupByTime(SaleInfo vo) throws DataAccessException;
	
	public int getCountAddDayGroupByTime(SaleInfo vo) throws DataAccessException;

	public List<DataMap> getSimInfoListByVo(SaleInfo vo)throws DataAccessException;

	public int getSimInfoCount(SaleInfo vo) throws DataAccessException;

	public List<DataMap> selectCancelSubInfoListByVo(SaleInfo vo)throws DataAccessException;

	public int selectCancelSubInfoCount(SaleInfo vo)throws DataAccessException;

	public List<DataMap> selectPayforInfoListByVo(SaleInfo vo)throws DataAccessException;

	public int selectPayforInfoCount(SaleInfo vo)throws DataAccessException;

	public int insertSimInfo(SaleInfo sao)throws DataAccessException;

	public List<DataMap> getSimInfoList(SaleInfo vo)throws DataAccessException;

	public int updateSimInfo(SaleInfo sao)throws DataAccessException;

	public int updateCancelSubInfo(SaleInfo vo)throws DataAccessException;

	public int insertCancelSubLogInfo(SaleInfo vo)throws DataAccessException;

	public List<DataMap> selectCancelSubLogInfoListByVo(SaleInfo vo)throws DataAccessException;

	public int selectCancelSubLogInfoCount(SaleInfo vo)throws DataAccessException;

	public List<DataMap> getHavingCountOne(SaleInfo vo)throws DataAccessException;

	public int deleteSimInfo(SaleInfo vo)throws DataAccessException;

	public int insertSimBeiFenInfo(SaleInfo vo)throws DataAccessException;

	public List<DataMap> getCancelSubInfo(SaleInfo vo) throws DataAccessException;

	public List<DataMap> getSimInfo(SaleInfo vo)throws DataAccessException;

	public int insertCancelSubInfo(SaleInfo vo)throws DataAccessException;

	public List<DataMap> selectPromitionInfoListByVo(SaleInfo vo)throws DataAccessException;

	public int selectPromitionInfoCount(SaleInfo vo)throws DataAccessException;

	public int insertPromitionInfo(SaleInfo vo)throws DataAccessException;

	public int updatePromotionInfo(SaleInfo vo)throws DataAccessException;
}
