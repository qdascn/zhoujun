package cn.qdas;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.commons.io.monitor.FileAlterationListener;
import org.apache.commons.io.monitor.FileAlterationObserver;

public class FileChangeListener implements FileAlterationListener{
	Properties properties;
	Producer producer;
	public FileChangeListener(Properties properties,Producer producer) {
		this.producer=producer;
		this.properties=properties;
	}
	ExecutorService threadPool=Executors.newCachedThreadPool();
	
	
	
	public void onStart(final FileAlterationObserver observer) {
		//System.out.println("======onStart");
	}
	public void onDirectoryCreate(final File directory) {
		//System.out.println(directory.getName()+"======onDirectoryCreate");
    }
	public void onDirectoryChange(final File directory) {
		//System.out.println(directory.getName()+"======onDirectoryChange");
	}
	public void onDirectoryDelete(final File directory) {
		//System.out.println(directory.getName()+"======onDirectoryDelete");
    }
	public void onFileCreate(final File file) {
		//System.out.println(file.getPath()+"======onFileCreate");
		 threadPool.execute(new Runnable() {
 			@Override
 			public void run() {
 				String [] proPaths=properties.getProperty("folder").split(",");
 				String proPath="";
 				for(int i=0;i<proPaths.length;i++) {
 					if(file.getPath().indexOf(proPaths[i])!=-1) {
 						proPath=proPaths[i];
 						break;
 					}
 				}
 				String zipath=file.getPath().substring(proPath.length(), file.getPath().indexOf(file.getName())-1);
 				producer.sendMessage("file", new File(file.getPath()),zipath,properties.getProperty("ifBackup"),properties.getProperty("backupPath"));
 			}
 		});
    }
	public void onFileChange(final File file) {
		//System.out.println(file.getName()+"======onFileChange");
    }

    public void onFileDelete(final File file) {
    	//System.out.println(file.getName()+"======onFileDelete");
    }

    public void onStop(final FileAlterationObserver observer) {
    	//System.out.println("======onStop");
    }
}
