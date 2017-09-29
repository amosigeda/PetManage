package com.jfservice.sys.clock.model;

import com.jfservice.common.bean.weike.PageBean;

public class Clock extends PageBean{

	private Integer id;
	
	private String alarmId; 
	
	private String name;
	
	private Integer did;   //设备id
	
	private String clock; //闹钟
	
	private Integer type;  //类型

	private String remainType;
	
	private String statu;
	
	private String repeatTimes;
	
	private String vibrate;
	
	private String ring;
	
	private String ringId;
	
	private String vol;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getAlarmId() {
		return alarmId;
	}

	public void setAlarmId(String alarmId) {
		this.alarmId = alarmId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getDid() {
		return did;
	}

	public void setDid(Integer did) {
		this.did = did;
	}

	public String getClock() {
		return clock;
	}

	public void setClock(String clock) {
		this.clock = clock;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getRemainType() {
		return remainType;
	}

	public void setRemainType(String remainType) {
		this.remainType = remainType;
	}

	public String getStatu() {
		return statu;
	}

	public void setStatu(String statu) {
		this.statu = statu;
	}

	public String getRepeatTimes() {
		return repeatTimes;
	}

	public void setRepeatTimes(String repeatTimes) {
		this.repeatTimes = repeatTimes;
	}

	public String getVibrate() {
		return vibrate;
	}

	public void setVibrate(String vibrate) {
		this.vibrate = vibrate;
	}

	public String getRing() {
		return ring;
	}

	public void setRing(String ring) {
		this.ring = ring;
	}

	public String getRingId() {
		return ringId;
	}

	public void setRingId(String ringId) {
		this.ringId = ringId;
	}

	public String getVol() {
		return vol;
	}

	public void setVol(String vol) {
		this.vol = vol;
	}	
}
