package cn.qdas;

import java.io.File;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.commons.io.monitor.FileAlterationListener;
import org.apache.commons.io.monitor.FileAlterationObserver;
import org.ini4j.Wini;

public class FileChangeListener implements FileAlterationListener{
	Wini ini;
	Producer producer;
	public FileChangeListener(Wini ini,Producer producer) {
		this.producer=producer;
		this.ini=ini;
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
		 /*threadPool.execute(new Runnable() {
 			@Override
 			public void run() {
 				String [] proPaths=ini.get("param","folder").split(",");
 				String proPath="";
 				for(int i=0;i<proPaths.length;i++) {
 					if(file.getPath().indexOf(proPaths[i]+"\\")!=-1) {
 						proPath=proPaths[i];
 						break;
 					}
 				}
 				String zipath=file.getPath().substring(proPath.length(), file.getPath().indexOf(file.getName())-1);
 				producer.sendMessage("file", new File(file.getPath()),zipath,ini.get("param","ifBackup"),ini.get("param","backupPath"));
 			}
 		});*/
		String [] proPaths=ini.get("param","folder").split(",");
			String proPath="";
			for(int i=0;i<proPaths.length;i++) {
				if(file.getPath().indexOf(proPaths[i]+"\\")!=-1) {
					proPath=proPaths[i];
					break;
				}
			}
			try {
				Thread.sleep((long) (Double.parseDouble(ini.get("param","sendInterval"))*1000));
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			String zipath=file.getPath().substring(proPath.length(), file.getPath().indexOf(file.getName())-1);
			producer.sendMessage("file", new File(file.getPath()),zipath,ini.get("param","ifBackup"),ini.get("param","backupPath"));
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
