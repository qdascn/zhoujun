package cn.qdas;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.commons.io.monitor.FileAlterationMonitor;
import org.apache.commons.io.monitor.FileAlterationObserver;

public class ProducerMain {

	public static void main(String[] args) {
		ExecutorService threadPool=Executors.newCachedThreadPool();
		Properties pro = null;
		try {
			//pro=PropertiesUtils.readProperties(System.getProperty("user.dir")+"/setting.properties");
			pro=PropertiesUtils.readProperties(System.getProperty("user.dir")+"/src\\main\\java\\cn\\qdas/setting.properties");
		} catch (FileNotFoundException e1) {
			logUtils.writeLog("打开配置文件失败，未找到配置文件");
			e1.printStackTrace();
		} catch (IOException e1) {
			logUtils.writeLog("读取配置文件失败");
			e1.printStackTrace();
		}
		Producer producer=new Producer(pro.getProperty("userName"),pro.getProperty("password"),pro.getProperty("url"),pro.getProperty("city"));
		FileChangeListener fcl=new FileChangeListener(pro,producer);
		String[] folders=pro.getProperty("folder").split(",");
		threadPool.execute(new Runnable() {
			
			@Override
			public void run() {
				for(int i=0;i<folders.length;i++) {
					FileAlterationObserver observer=new FileAlterationObserver(folders[i]);
					observer.addListener(fcl);
					FileAlterationMonitor monitor=new FileAlterationMonitor(1000);
					monitor.addObserver(observer);
					try {
						monitor.start();
					} catch (Exception e) {
						logUtils.writeLog("扫描目录失败");
						e.printStackTrace();
					}
				}
			}
		});
	}

}
