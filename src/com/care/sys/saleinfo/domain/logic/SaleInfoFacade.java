package com.care.sys.saleinfo.domain.logic;

import java.util.List;

import com.care.sys.phoneinfo.domain.PhoneInfo;
import com.care.sys.saleinfo.domain.SaleInfo;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;

public interface SaleInfoFacade {
	
	public List<DataMap> getSaleInfo(SaleInfo vo) throws SystemException;
	
	public int insertSaleInfo(SaleInfo vo) throws SystemException;
	
	public int updateSaleInfo(SaleInfo vo) throws SystemException;
	
	public int deleteSaleInfo(SaleInfo vo) throws SystemException;
	
	public DataList getSaleInfoListByVo(SaleInfo vo) throws SystemException;
	
	public int getSaleInfoCount(SaleInfo vo) throws SystemException;
	
	public DataList getSaleInfoListGroupByProvince(SaleInfo vo) throws SystemException;
	
	public int getSaleInfoCountGroupByProvince(SaleInfo vo) throws SystemException;
	
	public DataList getAddDayGroupByTime(SaleInfo vo) throws SystemException;
	
	public int getCountAddDayGroupByTime(SaleInfo vo) throws SystemException;

	public DataList getSimInfoListByVo(SaleInfo vo)throws SystemException;

	public DataList selectCancelSubInfoListByVo(SaleInfo vo)throws SystemException;

	public DataList selectPayforInfoListByVo(SaleInfo vo)throws SystemException;

	public int insertSimInfo(SaleInfo sao)throws SystemException;

	public List<DataMap> getSimInfoList(SaleInfo sao)throws SystemException;

	public int updateSimInfo(SaleInfo sao)throws SystemException;

	public int updateCancelSubInfo(SaleInfo vo)throws SystemException;

	public int insertCancelSubLogInfo(SaleInfo vo)throws SystemException;

	public DataList selectCancelSubLogInfoListByVo(SaleInfo vo)throws SystemException;

	public List<DataMap> getHavingCountOne(SaleInfo vo)throws SystemException;

	public int deleteSimInfo(SaleInfo vo)throws SystemException;

	public int insertSimBeiFenInfo(SaleInfo vo)throws SystemException;

	public List<DataMap> getCancelSubInfo(SaleInfo vo)throws SystemException;

	public List<DataMap> getSimInfo(SaleInfo vo)throws SystemException;

	public int insertCancelSubInfo(SaleInfo vo)throws SystemException;

	public DataList selectPromitionInfoListByVo(SaleInfo vo)throws SystemException;

	public int insertPromitionInfo(SaleInfo vo)throws SystemException;

	public int updatePromotionInfo(SaleInfo vo)throws SystemException;

}
