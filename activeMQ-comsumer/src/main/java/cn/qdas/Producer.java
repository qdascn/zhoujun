package cn.qdas;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.jms.BytesMessage;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.ActiveMQSession;

public class Producer {
	//ActiveMq 的默认用户名
    private static final String USERNAME = "admin";
    //ActiveMq 的默认登录密码
    private static final String PASSWORD = "admin";
    //ActiveMQ 的链接地址
    private static final String BROKEN_URL = "tcp://47.93.40.154:61616";
    //链接工厂
    ConnectionFactory connectionFactory;
    //链接对象
    ActiveMQConnection  connection;
    //事务管理
    ActiveMQSession session;
    ThreadLocal<MessageProducer> threadLocal = new ThreadLocal<>();
    ExecutorService threadPool = Executors.newFixedThreadPool(8);
    /**
     * 初始化消息生产者
     * @throws JMSException
     */
    public  void init() throws JMSException {
        try {
            //创建一个链接工厂
            ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(
                    USERNAME,PASSWORD,BROKEN_URL );
            //从工厂中创建一个链接
            connection  = (ActiveMQConnection)connectionFactory.createConnection();
            //开启链接
            connection.start();
            //创建一个事务（这里通过参数可以设置事务的级别）
            session=(ActiveMQSession) connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        } catch (JMSException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 将消息发送至消息队列
     * @param disname
     * @param text
     */
    public void sendMessage(String disname,File file) {
        InputStream is=null;
        try {
            //创建一个点对点消息队列,队列名
            Destination queue = session.createQueue(disname);
            //消息生产者
            MessageProducer messageProducer = null;
            //设置消息生产者
            if(threadLocal.get()!=null){
                messageProducer = threadLocal.get();
            }else{
                messageProducer = session.createProducer(queue);
                threadLocal.set(messageProducer);
            }

           // File file=new File("D:\\listener\\"+text);
            while (!file.renameTo(file)){
                //当该文件正在被操作时
                Thread.sleep(1000);
            }
            MessageProducer producer = session.createProducer(queue);
            BytesMessage bytesMessage=session.createBytesMessage();
            is = new FileInputStream(file);
            // 读取数据到byte数组中
            byte[] buffer=new byte[is.available()];
            is.read(buffer);
            bytesMessage.writeBytes(buffer);

//            //创建一个回执地址
//            Destination reback=session.createQueue("reback");
//            MessageConsumer reConsumer=session.createConsumer(reback);
//            reConsumer.setMessageListener(new reListener(session));
//            //将回执地址写到消息
//            bytesMessage.setJMSReplyTo(reback);
            bytesMessage.setStringProperty("FileName",file.getName());
            producer.send(bytesMessage);
            is.close();
            //删除文件
           /* if (file.exists()&&file.isFile()){
                file.delete();
            }*/
            System.out.println(file.getName()+"发送消息成功！");

        } catch (JMSException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {

        }
    }
}
