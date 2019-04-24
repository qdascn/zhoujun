package cn.qdas;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageConsumer;
import javax.jms.Session;

import org.apache.activemq.ActiveMQConnectionFactory;

public class Consumer {
	 private String USERNAME;
	    private String PASSWORD;
	    private String BROKEN_URL;
	    private String folder;
	public Consumer(String userName,String password,String url,String folder) {
		this.USERNAME=userName;
		this.PASSWORD=password;
		this.BROKEN_URL=url;
		this.folder=folder;
	}
	    ConnectionFactory connectionFactory;
	    Connection connection;
	    Session session;
	    ThreadLocal<MessageConsumer> threadLocal = new ThreadLocal<>();
	    /**
	     	* 初始化消息队列消费者连接池、事务
	     */
	    public void init(){
	        try {
	            connectionFactory = new ActiveMQConnectionFactory(USERNAME,PASSWORD,BROKEN_URL);
	            connection  = connectionFactory.createConnection();
	            connection.start();
	            //创建事务
	            session = connection.createSession(false,Session.AUTO_ACKNOWLEDGE);
	            System.out.println("-----------------服务已开启-----------------");
	        } catch (JMSException e) {
	        	logUtils.writeLog("初始化连接出现异常,请检查网络连接,确认网络正常后请重新打开程序");
	        	System.out.println("初始化连接出现异常,请检查网络连接,确认网络正常后请重新打开程序");
	            e.printStackTrace();
	        }
	    }

	    /**
	     * 建立点对点消费者消息队列，通过MessageListener监听消息队列
	     * @param disname
	     * @throws JMSException
	     */
	    public void getMessage(String disname){
	        //创建点对点消息队列
	        Destination queue;
	        MessageConsumer consumer = null;
			try {
				queue = session.createQueue(disname);
		        //设置消息队列消费方式（这里是消息监听器）
		        if (threadLocal.get() != null) {
		            consumer = threadLocal.get();
		        } else {
		            consumer = session.createConsumer(queue);
		            consumer.setMessageListener(new Listener(session,folder));
		            threadLocal.set(consumer);
		        }
			} catch (JMSException e) {
				logUtils.writeLog("消息传输失败,确认网络正常后请重新打开程序");
				System.out.println("消息传输失败,确认网络正常后请重新打开程序");
				e.printStackTrace();
			}
	        
	   }
}
