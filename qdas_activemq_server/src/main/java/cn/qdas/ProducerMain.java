package cn.qdas;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.commons.io.monitor.FileAlterationMonitor;
import org.apache.commons.io.monitor.FileAlterationObserver;
import org.ini4j.InvalidFileFormatException;
import org.ini4j.Wini;

public class ProducerMain {
	private static List<File> fileList;
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
		
		Producer producer=new Producer(ini.get("connect","userName"),ini.get("connect","password"),ini.get("connect","url"),ini.get("param","city"));
		FileChangeListener fcl=new FileChangeListener(ini,producer);
		String[] folders=ini.get("param","folder").split(",");
		//第一次启动程序
		List<File> fileList=FileScanner.getInitFiles(folders);
		for(int i=0;i<fileList.size();i++) {
			String proPath="";
				for(int j=0;j<folders.length;j++) {
					if(fileList.get(i).getPath().indexOf(folders[j])!=-1) {
						proPath=folders[j];
						break;
					}
				}
				String zipath=fileList.get(i).getPath().substring(proPath.length(), fileList.get(i).getPath().indexOf(fileList.get(i).getName())-1);
			producer.sendMessage("file", fileList.get(i), zipath, ini.get("param","ifBackup"), ini.get("param","backupPath"));
		}
		
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
