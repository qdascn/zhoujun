package cn.qdas;

import java.io.FileOutputStream;

import javax.jms.BytesMessage;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.Queue;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

public class Comsumer {
	private static final String USERNAME="admin";
	private static final String PASSWORD="admin";
	private static final String BROKEN_URL="tcp://47.93.40.154:61616";
	ConnectionFactory connectionFactory;
	Connection connection;
	Session session;
	public void init(){
        try {
            connectionFactory = new ActiveMQConnectionFactory(USERNAME,PASSWORD,BROKEN_URL);
            connection  = connectionFactory.createConnection();
            connection.start();
            //创建事务
            session = connection.createSession(false,Session.AUTO_ACKNOWLEDGE);
        } catch (JMSException e) {
            e.printStackTrace();
        }
    }

	public String getMessage(String qName) {
		Queue queue;
		String recMsg="";
		try {
			connectionFactory=new ActiveMQConnectionFactory(USERNAME, PASSWORD, BROKEN_URL);
			connection=connectionFactory.createConnection();
			connection.start();
			session=connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
			queue = session.createQueue(qName);
			MessageConsumer consumer=session.createConsumer(queue);
			consumer.setMessageListener(new MessageListener() {
				@Override
				public void onMessage(Message message) {
					if(message instanceof TextMessage) {
						TextMessage textMessage= (TextMessage) message;
						try {
							System.out.println("============"+textMessage.getText());
						} catch (JMSException e) {
							e.printStackTrace();
						}
					}
				}
			});
			/*consumer.close();
			session.close();
			connection.close();*/
		} catch (JMSException e) {
			e.printStackTrace();
		}
		return recMsg;
	}
	public void getFile(String disname) throws JMSException {
        //创建点对点消息队列
        Destination queue = session.createQueue(disname);
        MessageConsumer consumer = session.createConsumer(queue);
        //设置消息队列消费方式（这里是消息监听器）
        consumer.setMessageListener(new MessageListener() {
			
			@Override
			public void onMessage(Message message) {
				String fileName="";
                FileOutputStream out=null;
				try {
					 if (message instanceof BytesMessage) {
	                        BytesMessage bytesMessage= (BytesMessage) message;
	                        fileName=bytesMessage.getStringProperty("FileName");
	                        out=new FileOutputStream("F:\\sink\\"+fileName);
	                        byte[] bytes=new byte[1024];
	                        int len=0;
	                        while ((len=bytesMessage.readBytes(bytes))!=-1){
	                            out.write(bytes,0,len);
	                        }
					 }
				} catch (Exception e) {
					// TODO: handle exception
				}
				
			}
		});
   }
}
