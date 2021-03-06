package cn.qdas;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.jms.BytesMessage;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;

public class Listener implements MessageListener{
	 private Session session;
	 private String folder;
	 Wini ini;
	 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    public Listener(Session session,String folder){
	        this.session=session;
	        this.folder=folder;
	        try {
				ini=new Wini(new File(Globals.INI_PATH));
			} catch (InvalidFileFormatException e) {
				logUtils.writeLog("读取配置文件失败");
				e.printStackTrace();
			} catch (IOException e) {
				logUtils.writeLog("读取配置文件失败");
				e.printStackTrace();
			}
	    }
	    //创建一个可重用固定线程数的线程池，以共享的无界队列方式来运行这些线程。
	   // private ExecutorService threadPool = Executors.newFixedThreadPool(8);
	    ExecutorService threadPool=Executors.newCachedThreadPool();
	    private long startTime=System.currentTimeMillis();
	    @Override
	    public void onMessage(Message message) {
	        threadPool.execute(new Runnable() {
	            @Override
	            public void run() {
	                String fileName="";
	                String filePath="";
	                FileOutputStream out=null;
	                String zipFilePath = "";
	               // FileChannel fc;
	               // FileLock fl = null;
	                try {
	                    if (message instanceof BytesMessage) {
	                        BytesMessage bytesMessage= (BytesMessage) message;
	                        fileName=bytesMessage.getStringProperty("FileName");
	                        filePath=bytesMessage.getStringProperty("ziPath");
	                        if(filePath.length()!=0) {
	                        	File file=new File(folder+filePath);
	                        	if(!file.exists()) {
	                        		file.mkdirs();
	                        	}
	                        }
	                        // sssss
	                        
	                        if("zip".equals(fileName.substring(fileName.lastIndexOf(".")+1))) {
	                        	String zipIndex=ini.get("param","zipFolder").trim();
	        					String zipPath;
	        					if("".equals(zipIndex)||zipIndex==null) {
	        						File tempFile=new File(folder+"\\temp");
	        						if(!tempFile.exists()) {
	        							tempFile.mkdirs();
	        						}
	        						out=new FileOutputStream(folder+"\\temp"+"\\"+fileName);
	      	                       // fc=out.getChannel();
	      	                       // fl=fc.tryLock();
	      	                        byte[] bytes=new byte[1024];
	      	                        int len=0;
	      	                        while ((len=bytesMessage.readBytes(bytes))!=-1){
	      	                            out.write(bytes,0,len);
	      	                        }
	      	                        ZipUtils.unzip(folder+"\\temp"+"\\"+fileName, folder+filePath);
	      	                        zipFilePath=folder+"\\temp"+"\\"+fileName.subSequence(0, fileName.lastIndexOf("."))+".zip";
	        					}else {
	        						File tempFile=new File(zipIndex);
	        						if(!tempFile.exists()) {
	        							tempFile.mkdirs();
	        						}
	        						out=new FileOutputStream(zipIndex+"\\"+fileName);
		      	                       // fc=out.getChannel();
		      	                       // fl=fc.tryLock();
		      	                    byte[] bytes=new byte[1024];
		      	                    int len=0;
		      	                    while ((len=bytesMessage.readBytes(bytes))!=-1){
		      	                         out.write(bytes,0,len);
		      	                    }
		      	                    ZipUtils.unzip(zipIndex+"\\"+fileName, folder+filePath);
	      	                        zipFilePath=zipIndex+"\\"+fileName.subSequence(0, fileName.lastIndexOf("."))+".zip";
	        					}
	                        }else {
	                        	out=new FileOutputStream(folder+filePath+"\\"+fileName);
	  	                       // fc=out.getChannel();
	  	                       // fl=fc.tryLock();
	  	                        byte[] bytes=new byte[1024];
	  	                        int len=0;
	  	                        while ((len=bytesMessage.readBytes(bytes))!=-1){
	  	                            out.write(bytes,0,len);
	  	                        }
	                        }
	                        
	                        //ssss
	                        
	                       
//	                        if("zip".equals(fileName.substring(fileName.lastIndexOf(".")+1))) {
//	                        	ZipUtils.unzip(folder+filePath+"\\"+fileName, folder+filePath);
//	                        	zipFilePath=folder+filePath+"\\"+fileName.subSequence(0, fileName.lastIndexOf("."))+".zip";
//	                        }
	                        System.out.println(sdf.format(new Date())+"-----"+fileName+"接收成功！");
	                        //logUtils.writeLog(folder+filePath+"/"+fileName+"接收成功！");
	                        //获得回执地址
	                        Destination recall_destination = message.getJMSReplyTo();
	                        // 创建回执消息
	                        TextMessage textMessage = session.createTextMessage(fileName+"已处理完毕");
	                        // 以上收到消息之后，从新创建生产者，然后在回执过去
	                        MessageProducer producer = session.createProducer(recall_destination);
	                        producer.send(textMessage);
	                    }
	                } catch (JMSException e) {
	                    //递归
	                    if (System.currentTimeMillis()-startTime<=15000){
	                        onMessage(message);
	                    }
	                    else{
	                    	logUtils.writeLog(fileName+"文件传输失败，有可能是文件过大！");
	                        System.out.println(sdf.format(new Date())+"-----"+fileName+"文件传输失败，有可能是文件过大！");
	                    }
	                } catch (FileNotFoundException e) {
	                	logUtils.writeLog("未找到对应目录");
	                    e.printStackTrace();
	                } catch (IOException e) {
	                	logUtils.writeLog(fileName+"传输失败！可能存储路径配置错误");
	                    System.out.println(sdf.format(new Date())+"-----"+fileName+"传输失败！");
	                }finally {
	                    try {
	                    	//fl.release();
	                        out.close();
	                        File zipFile=new File(zipFilePath);
	                        if (zipFile.exists()&&zipFile.isFile()){
            	            	zipFile.delete();
            	            }
	                    } catch (IOException e) {
	                        e.printStackTrace();
	                    }
	                }
	            }
	        });
	    }
}
