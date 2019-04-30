package cn.qdas;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.jms.BytesMessage;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.ActiveMQSession;

public class Producer {
	 //ActiveMq 的默认用户名
    private String userName;
    //ActiveMq 的默认登录密码
    private String password;
    //ActiveMQ 的链接地址
    private String url;
    //城市名
    private String cityName;
    public Producer(String userName,String password,String url,String cityName) {
		this.userName=userName;
		this.password=password;
		this.url=url;
		this.cityName=cityName;
		this.init();
		this.getReback();
	}
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    //链接工厂
    ConnectionFactory connectionFactory;
    //链接对象
    ActiveMQConnection  connection;
    //事务管理
    ActiveMQSession session;
    ThreadLocal<MessageProducer> threadLocal = new ThreadLocal<>();
   // ExecutorService threadPool = Executors.newFixedThreadPool(8);
    ExecutorService threadPool=Executors.newCachedThreadPool();
    /**
     	* 初始化消息生产者
     */
    public  void init(){
        try {
            //创建一个链接工厂
            ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(userName,password,url );
            //从工厂中创建一个链接
            connection  = (ActiveMQConnection)connectionFactory.createConnection();
            //开启链接
            connection.start();
            //创建一个事务（这里通过参数可以设置事务的级别）
            session=(ActiveMQSession) connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            System.out.println(sdf.format(new Date())+"----------------------------------服务已开启完毕----------------------------------");
        } catch (JMSException e) {
        	logUtils.writeLog("初始化连接出现异常,请检查网络连接,确认网络正常后请重新打开程序");
        	System.out.println(sdf.format(new Date())+"-----"+"初始化连接出现异常,请检查网络连接,确认网络正常后请重新打开程序");
            e.printStackTrace();
        } 
    }

   /**
    * 
    * @param disname  队列名
    * @param file 发送的文件
    * @param ziPath 源目录下的目录
    */
    public void sendMessage(String disname,File file,String ziPath,String ifbackup,String backupPath) {
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

            //创建一个回执地址
            Destination reback=session.createQueue(cityName+"-reback");
           // MessageConsumer reConsumer=session.createConsumer(reback);
          //  reConsumer.setMessageListener(new reListener(session));
            //将回执地址写到消息
            bytesMessage.setJMSReplyTo(reback);
            bytesMessage.setStringProperty("FileName",file.getName());
            bytesMessage.setStringProperty("ziPath","\\"+cityName+ziPath);
            producer.send(bytesMessage);
            is.close();
           // logUtils.writeLog(file.getName()+"发送消息成功！");
            System.out.println(sdf.format(new Date())+"-----"+file.getName()+"发送消息成功！");

        } catch (JMSException e) {
        	logUtils.writeLog("初始化连接出现异常,请检查网络连接,确认网络正常后请重新打开程序");
        	System.out.println(sdf.format(new Date())+"-----"+"初始化连接出现异常,请检查网络连接,确认网络正常后请重新打开程序");
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
    public void getReback() {
    	try {
    		Destination reback=session.createQueue(cityName+"-reback");
            MessageConsumer reConsumer=session.createConsumer(reback);
            reConsumer.setMessageListener(new reListener(session));
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    }
    private class reListener implements MessageListener {
        ActiveMQSession session=null;
        public reListener(ActiveMQSession session) {
            this.session=session;
        }

        @Override
        public void onMessage(Message message) {
            threadPool.execute(new Runnable() {
                @Override
                public void run() {
                    TextMessage tx= (TextMessage) message;
                    try {
                    	//logUtils.writeLog(tx.getText());
                        System.out.println(sdf.format(new Date())+"-----"+tx.getText()+"----");
                    } catch (JMSException e) {
                        e.printStackTrace();
                    }
                }
            });
        }
    }
}
