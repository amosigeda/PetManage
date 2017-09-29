package com.care.sys.roleinfo.form;

import java.io.Serializable;
import com.godoing.rose.http.PublicFormBean;

/* rose1.2 to files 
 * rose anthor:wlb  1.0 version by time 2005/12/12  
 * rose anthor:wlb  1.1 version by time 2006/06/06  
 * rose anthor:wlb  1.2 version by time 2006/12/27*/
public class RoleInfoForm extends PublicFormBean implements Serializable {

	private static final long serialVersionUID = -5085685652020804833L;

	public RoleInfoForm() {
	}

	private int id;
	private String roleDesc;
	private String roleName;
	private String roleType;
	private String roleCode;
	private String systemFunction;
	private String registBind;
	private String appInteraction;
	private String deviceData;
	private String simInfo;
	
	
	

	public String getSystemFunction() {
		return systemFunction;
	}

	public void setSystemFunction(String systemFunction) {
		this.systemFunction = systemFunction;
	}

	public String getRegistBind() {
		return registBind;
	}

	public void setRegistBind(String registBind) {
		this.registBind = registBind;
	}

	public String getAppInteraction() {
		return appInteraction;
	}

	public void setAppInteraction(String appInteraction) {
		this.appInteraction = appInteraction;
	}

	public String getDeviceData() {
		return deviceData;
	}

	public void setDeviceData(String deviceData) {
		this.deviceData = deviceData;
	}

	public String getSimInfo() {
		return simInfo;
	}

	public void setSimInfo(String simInfo) {
		this.simInfo = simInfo;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}

	public String getRoleDesc() {
		return this.roleDesc;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public String getRoleCode() {
		return this.roleCode;
	}

	public String getRoleType() {
		return roleType;
	}

	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}

}
