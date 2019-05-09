package cn.qdas;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(sdf.format(new Date())+"-----"+"----------------------------------服务开启中----------------------------------");
		ExecutorService threadPool=Executors.newCachedThreadPool();
		Wini ini = null;
		try {
			ini=new Wini(new File(Globals.INI_PATH));
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
		//第一次启动程序
		List<File> fileList=FileScanner.getInitFiles(folders,Integer.parseInt(ini.get("param","maxFileSize")));
		for(int i=0;i<fileList.size();i++) {
			String proPath="";
				for(int j=0;j<folders.length;j++) {
					if(fileList.get(i).getPath().indexOf(folders[j]+"\\")!=-1) {
						proPath=folders[j];
						break;
					}
				}
				String zipath=fileList.get(i).getPath().substring(proPath.length(), fileList.get(i).getPath().indexOf(fileList.get(i).getName())-1);
				try {
					Thread.sleep((long) (Double.parseDouble(ini.get("param","sendInterval"))*1000));
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				if("1".equals(ini.get("param","ifZip"))) {
					File zipFile = null;
					try {
						String zipIndex=ini.get("param","zipFolder").trim();
						String zipPath;
						if("".equals(zipIndex)||zipIndex==null) {
							File tempFile=new File(proPath+"\\temp");
							if(!tempFile.exists()) {
								tempFile.mkdirs();
							}
							zipFile=ZipUtils.zipFile(fileList.get(i).getPath(),proPath+"\\temp\\"+fileList.get(i).getName().substring(0, fileList.get(i).getName().lastIndexOf("."))+".zip");
						}else {
							File tempFile=new File(zipIndex);
							if(!tempFile.exists()) {
								tempFile.mkdirs();
							}
							zipFile=ZipUtils.zipFile(fileList.get(i).getPath(),zipIndex+"\\"+fileList.get(i).getName().substring(0, fileList.get(i).getName().lastIndexOf("."))+".zip");
						}
						//zipFile=ZipUtils.zipFile(fileList.get(i).getPath());
					} catch (IOException e) {
						logUtils.writeLog(fileList.get(i)+"-----压缩文件失败");
						System.out.println(sdf.format(new Date())+"-----"+fileList.get(i)+"-----压缩文件失败");
						e.printStackTrace();
					}
					producer.sendMessage("file",zipFile,zipath,ini.get("param","ifBackup"),ini.get("param","backupPath"));
		            //删除文件
		            if (zipFile.exists()&&zipFile.isFile()){
		            	zipFile.delete();
		            }
				}else {
					producer.sendMessage("file",fileList.get(i),zipath,ini.get("param","ifBackup"),ini.get("param","backupPath"));
				}
				
	            //是否备份文件
	            if("1".equals(ini.get("param","ifBackup"))) {
	            	File backFile=new File(ini.get("param","backupPath")+zipath);
	            	if(!backFile.exists()) {
	            		backFile.mkdirs();
	            	}
	            	fileList.get(i).renameTo(new File(ini.get("param","backupPath")+zipath+"\\"+fileList.get(i).getName()));
	            }
	            //删除文件
	            if (fileList.get(i).exists()&&fileList.get(i).isFile()){
	            	fileList.get(i).delete();
	            }
		}
		
		
	}
	
	

}
