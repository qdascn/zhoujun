package cn.qdas;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ConsumerMain {

	public static void main(String[] args) {
		ExecutorService threadPool=Executors.newCachedThreadPool();
		Properties pro = null;
		try {
			pro=PropertiesUtils.readProperties(System.getProperty("user.dir")+"/setting.properties");
			//pro=PropertiesUtils.readProperties(System.getProperty("user.dir")+"/src\\main\\java\\cn\\qdas/setting.properties");
		} catch (FileNotFoundException e1) {
			logUtils.writeLog("读取配置文件失败，未找到文件");
			e1.printStackTrace();
		} catch (IOException e1) {
			logUtils.writeLog("读取配置文件失败");
			e1.printStackTrace();
		}
		Consumer consumer=new Consumer(pro.getProperty("userName"),pro.getProperty("password"),pro.getProperty("url"),pro.getProperty("folder"));
		consumer.init();
		threadPool.execute(new Runnable() {
			
			@Override
			public void run() {
				consumer.getMessage("file");
				
			}
		});
	}

}
