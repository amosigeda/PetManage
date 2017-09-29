package com.care.app;

import java.lang.reflect.InvocationTargetException;
import java.net.InetSocketAddress;
import java.util.concurrent.ConcurrentHashMap;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.mina.core.future.WriteFuture;
import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.core.session.IoSession;

import com.care.sys.appuserinfo.domain.AppUserInfo;
import com.care.sys.deviceactiveinfo.domain.DeviceActiveInfo;
import com.care.sys.phoneinfo.domain.PhoneInfo;

public class ServerHandler extends IoHandlerAdapter {
	
	private final static Logger logger = Logger.getLogger(ServerHandler.class);
	/*
	 * private final Set<IoSession> sessions = Collections .synchronizedSet(new
	 * HashSet<IoSession>()); private final Set<String> users = Collections
	 * .synchronizedSet(new HashSet<String>()); MsgServer ms = new MsgServer();
	 * Map<IoSession, MINAClientHandler> clientMap = new HashMap<IoSession,
	 * MINAClientHandler>();
	 */

	@Override
	public void exceptionCaught(IoSession session, Throwable cause) {
		MessageManager.sessionSet.remove(session.getId());
		logger.info(session.getId() + "error");
		logger.error("ServerHandler exception caught:", cause);;
		cause.printStackTrace();

	}

	@Override
	public void sessionCreated(IoSession session) throws Exception {

		String ip = ((InetSocketAddress) session.getRemoteAddress())
				.getAddress().getHostAddress();
		int host = ((InetSocketAddress) session.getRemoteAddress()).getPort();
		logger.info(ip + ":" + host + "sessionId:" + session.getId());
		session.setAttribute("ip", ip);
		MessageManager.sessionSet.put(session.getId(), session);

		ConcurrentHashMap chm = new ConcurrentHashMap();

		// MessageManager.waitingSessions.add(session);
		// Thread th = new Thread(st);
		// sh.start();
		// session.setAttribute("st", st);

	}

	@Override
	public void sessionIdle(IoSession session, IdleStatus status) {
		if(!session.isConnected()){
			logger.info(session.getId() + ",," + "not isConnected");
		}
		
		
		PhoneInfo de = (PhoneInfo) session.getAttribute("device");
		if (de != null) {
			logger.info("sessionIdle de is ==================="+de);
//			DeviceServiceI dsi = new DeviceServiceImpl();
//			DeviceBindEntity bde = dsi.getBindByDeviceId(de.getDevice_id());
//			if (bde != null
//					&& MessageManager.playerSet.containsKey(bde
//							.getUser_id())) {
//				JSONObject jsd = new JSONObject();
//				jsd.put("request", "SERVER_DEVICE_NETWORKSTATUS");
//				jsd.put("status", 2);
//				jsd.put("device_id", de.getId());
//				MessageManager.playerSet.get(bde.getUser_id()).write(jsd);
//			}
			session.setAttribute("NetStatus", null);
			session.setAttribute("device", null);
			MessageManager.tzSet.remove(de.getId());
			session.close(true);
		}else{
			AppUserInfo ue = (AppUserInfo) session.getAttribute("user");
			logger.info("sessionIdle ue is ==================="+ue);
			if(ue==null)
				session.close(true);
		}
	}

	@Override
	public void messageReceived(IoSession session, Object message) {
		// MessageAdapter.appAdapter();
		logger.info(session.getId() + ",," + message);
		logger.debug(session.getId() + ",," + message);
		logger.info("thread is in messagereceived is ==============="+Thread.currentThread().getId());

		// logger.error("error");

		// JSONObject j=JSONObject.fromObject(message.toString());
		// byte b=(Byte) j.get("b");
		// session.write(message);
		try {
			if(message!=null&&!("").equals(message)) {
				System.out.println("message===================="+message);
				//new MessageManager(session, message.toString()).msgTransfer();
				JSONObject object = JSONObject.fromObject(message);
				JSONObject json = new JSONObject();
			
				Integer type=object.getInt("type");
				System.err.println("TYPE="+type);
				String no=object.getString("no");
				String timeStamp=object.getString("timestamp");
				if(type==9){//心跳
					 /* 请求:
					    {
					      "type": 9,
					      "no": "12312312", 
					      "timestamp": 1501123709
					    }

					    应答:
					    {
					      "type": 0
					      "no":" 12312312"
					      "timestamp":1501123728
					      "status":0
					    }*/
					json.put("type", 0);
					json.put("status", 0);
				}else if(type==1){
					/* 请求:
					    {
					      "type": 1,
					      "no":"12312312",
					      "timestamp":1501123709,
					      "data": {
					        "dv":"", //设备固件版本号
					        "sd":"",  //软件版本号
					      }
					    }

					    应答:
					    {
					      "type": 0,
					      "no":"12312312",
					      "timestamp":1501123709,
					      "status":0
					    }
	*/
					String data=object.getString("data");
					String imei=object.getString("imei");
					JSONObject objectData = JSONObject.fromObject(data);
					String dv=objectData.getString("dv");
					System.out.println("dv="+dv);
					String sd=objectData.getString("sd");
					System.out.println("sd="+sd);
					json.put("type", 0);
					json.put("status", 0);
				}
				json.put("no",no);
				json.put("timestamp", System.currentTimeMillis());
				String resp=json.toString();
				
				session.write(resp+"\r\n");
			}
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} /*catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/

		/*
		 * Logger log = Logger.getLogger(ServerHandler.class);
		 * log.info("received: " + message); JSONObject
		 * js=JSONObject.fromObject(message.toString()); // if(message
		 * instanceof JSONObject) logger.info(js.get("fsdf"));
		 * logger.info(js.get("11")); String theMessage="";
		 * if(js.get("11")!=null) theMessage = js.get("11").toString(); String[]
		 * result = theMessage.split(" ", 2); String theCommand = result[0];
		 */

		/*
		 * MINAClientHandler ch = clientMap.get(session); try { ch.dispatch(js);
		 * }catch (Exception e) { e.printStackTrace(); }
		 */
	}

	@Override
	public void sessionClosed(IoSession session) throws Exception {
		logger.info("in sessionClosed session ===================="+session);
		logger.info("in sessionClosed isConnected==================="+session.isConnected());
		logger.info("in sessionClosed remoteip======================"+session.getRemoteAddress());
		logger.info("in sessionClosed localip======================="+session.getLocalAddress());
		AppUserInfo us = (AppUserInfo) session.getAttribute("user");
		if (us != null) {
			IoSession use = MessageManager.playerSet.get(us.getId());
			logger.info("in sessionClosed use is==================="+use);
			IoSession ust = MessageManager.sessionSet.get(us.getId());
			logger.info("in sessionClosed ust is==================="+ust);
			IoSession usid = MessageManager.sessionSet.get(session.getId());
			logger.info("in sessionClosed usid is==================="+usid);
			String ip1 = (String) session.getAttribute("ip");
			logger.info("sessionClosed ip is ============"+ip1);
			MessageManager.playerSet.remove(us.getId());
//			MessageManager.sessionSet.remove(us.getUser_id());
			MessageManager.sessionSet.remove(session.getId());
//			usi.AddLoginInfo(us.getUser_id(), ip1, 1, 2);
			// MessageManager.playerSet.remove((String)session.getAttribute("roleName"));
		} else {
			DeviceActiveInfo da = (DeviceActiveInfo) session.getAttribute("device");
			logger.info("sessionClosed de is ==================="+da);
			if (da != null) {
				logger.info("sessionClosed device_id is ========================"+da.getId());
//				DeviceServiceI dsi = new DeviceServiceImpl();
//				DeviceBindEntity bde = dsi.getBindByDeviceId(de.getDevice_id());
//				if (bde != null
//						&& MessageManager.playerSet.containsKey(bde
//								.getUser_id())) {
//					JSONObject jsd = new JSONObject();
//					jsd.put("request", "SERVER_DEVICE_NETWORKSTATUS");
//					jsd.put("status", 2);
//					jsd.put("device_id", de.getDevice_id());
//					MessageManager.playerSet.get(bde.getUser_id()).write(jsd);
//				}
				session.setAttribute("NetStatus", null);
				session.setAttribute("device", null);
				MessageManager.playerSet.remove(da.getId());
				MessageManager.tzSet.remove(da.getId());
			}
		}
		session.close(true);
		logger.info(session.getId() + "closed");
		System.out.println("关闭session");
	}

	@Override
	public void messageSent(IoSession session, Object message) {
		System.out.println("SERVER send:" + session.getId() + ","
				+ message.toString());

	}

	public static boolean setMessage(IoSession session, String msg) {
		if (session != null) {
			WriteFuture wf = session.write(msg);
			wf.join();
			if (wf.isWritten()) {
				return true;
			}
		}
		return false;
	}

}
