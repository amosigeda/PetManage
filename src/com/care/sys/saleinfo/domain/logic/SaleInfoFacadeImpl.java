package com.care.sys.saleinfo.domain.logic;

import java.util.List;

import com.care.sys.phoneinfo.domain.PhoneInfo;
import com.care.sys.saleinfo.dao.SaleInfoDao;
import com.care.sys.saleinfo.domain.SaleInfo;
import com.godoing.rose.lang.DataList;
import com.godoing.rose.lang.DataMap;
import com.godoing.rose.lang.SystemException;

public class SaleInfoFacadeImpl implements SaleInfoFacade{
	
	private SaleInfoDao saleInfoDao;
	
	public SaleInfoFacadeImpl(){
		
	}

	public void setSaleInfoDao(SaleInfoDao saleInfoDao) {
		this.saleInfoDao = saleInfoDao;
	}

	public int deleteSaleInfo(SaleInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		return saleInfoDao.deleteSaleInfo(vo);
	}

	public List<DataMap> getSaleInfo(SaleInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		return saleInfoDao.getSaleInfo(vo);
	}

	public int getSaleInfoCount(SaleInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		return saleInfoDao.getSaleInfoCount(vo);
	}

	public DataList getSaleInfoListByVo(SaleInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		DataList list = new DataList(saleInfoDao.getSaleInfoListByVo(vo));
		list.setTotalSize(saleInfoDao.getSaleInfoCount(vo));
		return list;
	}

	public int insertSaleInfo(SaleInfo vo) throws SystemException {
		return saleInfoDao.insertSaleInfo(vo);
	}

	public int updateSaleInfo(SaleInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		return saleInfoDao.updateSaleInfo(vo);
	}

	public int getSaleInfoCountGroupByProvince(SaleInfo vo)
			throws SystemException {
		// TODO Auto-generated method stub
		return saleInfoDao.getSaleInfoCountGroupByProvince(vo);
	}

	public DataList getSaleInfoListGroupByProvince(SaleInfo vo)
			throws SystemException {
		// TODO Auto-generated method stub
		DataList list = new DataList(saleInfoDao.getSaleInfoListGroupByProvince(vo));
		list.setTotalSize(saleInfoDao.getSaleInfoCountGroupByProvince(vo));
		return list;
	}

	public DataList getAddDayGroupByTime(SaleInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		DataList list = new DataList(saleInfoDao.getAddDayGroupByTime(vo));
		list.setTotalSize(saleInfoDao.getCountAddDayGroupByTime(vo));
		return list;
	}

	public int getCountAddDayGroupByTime(SaleInfo vo) throws SystemException {
		// TODO Auto-generated method stub
		return saleInfoDao.getCountAddDayGroupByTime(vo);
	}

	public DataList getSimInfoListByVo(SaleInfo vo) throws SystemException {
		DataList list = new DataList(saleInfoDao.getSimInfoListByVo(vo));
		list.setTotalSize(saleInfoDao.getSimInfoCount(vo));
		return list;
	}

	public DataList selectCancelSubInfoListByVo(SaleInfo vo)
			throws SystemException {
		DataList list = new DataList(saleInfoDao.selectCancelSubInfoListByVo(vo));
		list.setTotalSize(saleInfoDao.selectCancelSubInfoCount(vo));
		return list;
	}

	public DataList selectPayforInfoListByVo(SaleInfo vo)
			throws SystemException {
		DataList list = new DataList(saleInfoDao.selectPayforInfoListByVo(vo));
		list.setTotalSize(saleInfoDao.selectPayforInfoCount(vo));
		return list;
	}

	public int insertSimInfo(SaleInfo sao) throws SystemException {
		return saleInfoDao.insertSimInfo(sao);
	}

	public List<DataMap> getSimInfoList(SaleInfo sao)
			throws SystemException {
		return saleInfoDao.getSimInfoList(sao);
	}

	public int updateSimInfo(SaleInfo sao) throws SystemException {
		return saleInfoDao.updateSimInfo(sao);
	}

	public int updateCancelSubInfo(SaleInfo vo) throws SystemException {
		return saleInfoDao.updateCancelSubInfo(vo);
	}

	public int insertCancelSubLogInfo(SaleInfo vo) throws SystemException {
		return saleInfoDao.insertCancelSubLogInfo(vo);
	}

	public DataList selectCancelSubLogInfoListByVo(SaleInfo vo)
			throws SystemException {
		DataList list = new DataList(saleInfoDao.selectCancelSubLogInfoListByVo(vo));
		list.setTotalSize(saleInfoDao.selectCancelSubLogInfoCount(vo));
		return list;
	}

	public List<DataMap> getHavingCountOne(SaleInfo vo) throws SystemException {
		return saleInfoDao.getHavingCountOne(vo);
	}

	public int deleteSimInfo(SaleInfo vo) throws SystemException {
		return saleInfoDao.deleteSimInfo(vo);
	}

	public int insertSimBeiFenInfo(SaleInfo vo) throws SystemException {
		return saleInfoDao.insertSimBeiFenInfo(vo);
	}

	public List<DataMap> getCancelSubInfo(SaleInfo vo) throws SystemException {
		return saleInfoDao.getCancelSubInfo(vo);
	}

	public List<DataMap> getSimInfo(SaleInfo vo) throws SystemException {
		return saleInfoDao.getSimInfo(vo);
	}

	public int insertCancelSubInfo(SaleInfo vo) throws SystemException {
		return saleInfoDao.insertCancelSubInfo(vo);
	}

	public DataList selectPromitionInfoListByVo(SaleInfo vo)
			throws SystemException {
		DataList list = new DataList(saleInfoDao.selectPromitionInfoListByVo(vo));
		list.setTotalSize(saleInfoDao.selectPromitionInfoCount(vo));
		return list;
	}

	public int insertPromitionInfo(SaleInfo vo) throws SystemException {
		return saleInfoDao.insertPromitionInfo(vo);
	}

	public int updatePromotionInfo(SaleInfo vo) throws SystemException {
		return saleInfoDao.updatePromotionInfo(vo);
		}

}
