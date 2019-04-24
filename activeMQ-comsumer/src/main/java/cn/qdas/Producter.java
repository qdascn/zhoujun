package cn.qdas;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Queue;
import javax.jms.Session;
import javax.jms.StreamMessage;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.ActiveMQSession;
import org.fusesource.mqtt.cli.Publisher;

public class Producter {
	private static final String USERNAME="admin";
	private static final String PASSWORD="admin";
	private static final String BROKEN_URL="tcp://47.93.40.154:61616";
	ConnectionFactory connectionFactory;
	Connection connection;
	Session session;
	MessageProducer producer;
	public void sendMessage(String qName,String mess) {
		try {
			connectionFactory=new ActiveMQConnectionFactory(USERNAME, PASSWORD, BROKEN_URL);
			connection=connectionFactory.createConnection();
			connection.start();
			session=connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
			Queue queue=session.createQueue(qName);
			producer=session.createProducer(queue);
			TextMessage msg=session.createTextMessage(mess);
			producer.send(msg);
			//session.commit();
		} catch (JMSException e) {
			e.printStackTrace();
		}finally {
			try {
				producer.close();
				session.close();
				connection.close();
			} catch (JMSException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void sendFile(String qName,File file) throws JMSException, IOException {
		connectionFactory=new ActiveMQConnectionFactory(USERNAME, PASSWORD, BROKEN_URL);
		connection=connectionFactory.createConnection();
		connection.start();
		/*session=connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
		Destination destination = session.createQueue(qName);
		producer = session.createProducer(destination);  
		long time = System.currentTimeMillis();
		
		StreamMessage message=session.createStreamMessage();
		message.setStringProperty("COMMAND", "start");
		producer.send(message);  
		 //开始发送文件  
        byte[] content = new byte[4096];  
        InputStream ins = Publisher.class.getResourceAsStream(file.getName());  
        System.out.println(file.getName());
        BufferedInputStream bins = new BufferedInputStream(ins);  
        while (bins.read(content) > 0) {  
            message = session.createStreamMessage();  
            message.setStringProperty("FILE_NAME", file.getName());  
            message.setStringProperty("COMMAND", "sending");  
            message.clearBody();  
            message.writeBytes(content);  
            producer.send(message);  
        }  
        bins.close();  
        ins.close();  
          
        //通知客户端发送完毕  
        message = session.createStreamMessage();  
        message.setStringProperty("COMMAND", "end");  
        producer.send(message);  
          
        connection.close();  */
		ActiveMQSession asession=(ActiveMQSession) connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
		InputStream in;
		Destination queue=session.createQueue(qName);
		producer=session.createProducer(queue);
				
	}
}
