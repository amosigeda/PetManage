package com.care.wei;





import net.sf.json.JSONObject;

public class AiShiDeIccidApi {

	
	//private final static String testUrltest ="https://test24.uyou.com/";
        private final static String testUrl="https://gman.uyou.com/";
	//private static int a=25;
        public static void main(String[] args) throws Exception {
        	//44
        	
        	String iccid="893107061704935408";
        	String imsi="204047914935408";
        	//selectIccidXiangQing()
        String result=selectIccidStatus(iccid,imsi);
  		  System.out.println(result);
        	//System.out.println(iccid+":"+result);
        	/*JSONObject resultResponseJson = JSONObject
  						.fromObject(result);
  				String data=resultResponseJson.getString("data");
  				JSONObject dataJson = JSONObject
  						.fromObject(data);
  				String Status=dataJson.getString("status");
  				System.out.println("Status:"+Status);*/
  			//String aa=setIccidStatus(iccid,imsi,"Suspend");
  		//	System.out.println(aa);	
  			 // setIccidStatus(iccid,imsi,"Resume");
		}
        public static void A() {
        	try {
        		for(int a=25;a<45;a++){
                         //  a=a+i; 
                           String as=a+"";
                         //  System.out.println(as);
        			String iccid="8931070617049344"+as;
        		//	System.out.println(iccid);
        			String imsi="2040479149344"+a;
        			//System.out.println(imsi);
        			
        			 String result=selectIccidStatus(iccid,imsi);
        		   JSONObject resultResponseJson = JSONObject
        						.fromObject(result);
        				String data=resultResponseJson.getString("data");
        				JSONObject dataJson = JSONObject
        						.fromObject(data);
        				String Status=dataJson.getString("status");
        				System.out.println("iccid："+iccid+"--imsi--"+imsi+"--状态--"+Status);
        				 if("Preactive".equals(Status)){
        					 setIccidStatus(iccid,imsi,"Activate");
        				 }else if("Suspended".equals(Status)){
        					 setIccidStatus(iccid,imsi,"Resume");
        				 }
        				
        		}
        		
      // String result=selectIccidStatus("893107051704919148","204047914919148");
       //	 String result=selectIccidStatus("893107061704934427","204047914934427");
        	//	String result=selectIccidStatus("893107061704934438","204047914934438");
     /*	JSONObject resultResponseJson = JSONObject
				.fromObject(result);
		String data=resultResponseJson.getString("data");
		JSONObject dataJson = JSONObject
				.fromObject(data);
		String Status=dataJson.getString("status");
		System.out.println(Status);*/
		
         /*		结果={"resp_desc":"OK","resp_code":"1","data":{"status":{"flag":true,"msg":"Suspended"}}}*/
//String result=setIccidStatus("893107061704934427","893107061704934427","Resume");
         //Activate,Suspend,Resume
			
	//		System.out.println("结果="+result);
        	} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	/*
        	 * 
        	 * https://域名/userver/iotApiController/products/getStatus.do
		try {
			String b=setIccidStatus("11111111111111111111","11111111111111111111","Deactivate");
			System.out.println(b);
			查询sim卡状态
		 * String a = selectIccidStatus("11111111111111111111","11111111111111111111");
			System.out.println(a);
			
			//Activate,Suspend,Deactivate
			String c=selectIccidXiangQing("11111111111111111111","11111111111111111111");
			JSONObject object = JSONObject.fromObject(c);
			System.out.println("啊哈="+object.getString("resp_code"));
			System.out.println(c);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	*/}

	// 查詢卡片狀態
	public static String selectIccidStatus(String iccid,String imsi) throws Exception {
		String url = testUrl+"userver/iotApiController/products/getStatus.do";
	  //  System.out.println(url);
		//https://gman.uyou.com/userver/iotApiController/products/getStatus.do
		JSONObject json = new JSONObject();
		JSONObject json1 = new JSONObject();
		json1.put("iccid", iccid);
		json1.put("imsi", imsi);
		json.put("data", json1);
		json.put("sysPassword", "123456");
		json.put("sysAccount", "SYS_WTWD");
		//System.out.println(json.toString());
		String result = "";
		try {
			String jiami = Des.DesEncrypt(json.toString(),"!@#$%^&*");
		//	System.out.println("加密="+jiami);
			// result = HttpRequest.urlReturnParams(url,jiami);
			//result = Des.sendPost(url, jiami);
			result = Des.sendPostEntity(url, jiami);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Des.DesDecrypt(result,"!@#$%^&*");
	}
	
	//卡片状态设置
	public static String setIccidStatus(String iccid,String imsi,String status) throws Exception{
		String url = testUrl+"userver/iotApiController/products/setStatus.do";
		System.out.println(url);
		//https://域名/ userver /iotApiController/products/setStatus.do
		JSONObject json = new JSONObject();
		JSONObject json1 = new JSONObject();
		json1.put("iccid", iccid);
		json1.put("imsi", imsi);
		json1.put("status", status);
		json.put("data", json1);
		json.put("sysPassword", "123456");
		json.put("sysAccount", "SYS_WTWD");
		System.out.println(json.toString());
		String result = "";
		try {
			String jiami = Des.DesEncrypt(json.toString(),"!@#$%^&*");
			result = Des.sendPostEntity(url, jiami);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(result);
		return Des.DesDecrypt(result,"!@#$%^&*");
	}
	
	
	
	public static String selectIccidXiangQing(String iccid,String imsi) throws Exception {
		String url = testUrl+"userver/iotApiController/products/search.do";
		JSONObject json = new JSONObject();
		JSONObject json1 = new JSONObject();
		json1.put("iccid", iccid);
		json1.put("imsi", imsi);
		json.put("data", json1);
		json.put("sysPassword", "123456");
		json.put("sysAccount", "SYS_WTWD");
		System.out.println(json.toString());
		String result = "";
		try {
			String jiami = Des.DesEncrypt(json.toString(),"!@#$%^&*");
			// result = HttpRequest.urlReturnParams(url,jiami);
			result = Des.sendPost(url, jiami);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Des.DesDecrypt(result,"!@#$%^&*");
	}


}
