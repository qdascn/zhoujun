package cn.qdas;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;

public class ConsumerMain {

	public static void main(String[] args) {
		System.out.println("----------------------------------服务开启中----------------------------------");
		ExecutorService threadPool=Executors.newCachedThreadPool();
		Wini ini = null;
		try {
			//ini=new Wini(new File(System.getProperty("user.dir")+"/config.ini"));
			ini=new Wini(new File(System.getProperty("user.dir")+"/src\\main\\java\\cn\\qdas/config.ini"));
		} catch (InvalidFileFormatException e1) {
			logUtils.writeLog("读取配置文件失败");
			e1.printStackTrace();
		} catch (IOException e1) {
			logUtils.writeLog("读取配置文件失败");
			e1.printStackTrace();
		}
		Consumer consumer=new Consumer(ini.get("connect","userName"),ini.get("connect","password"),ini.get("connect","url"),ini.get("param","folder"));
		consumer.init();
		threadPool.execute(new Runnable() {
			
			@Override
			public void run() {
				consumer.getMessage("file");
				
			}
		});
	}

}
