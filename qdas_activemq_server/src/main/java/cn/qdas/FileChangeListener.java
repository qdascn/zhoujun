package cn.qdas;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.commons.io.monitor.FileAlterationListener;
import org.apache.commons.io.monitor.FileAlterationObserver;
import org.ini4j.Wini;

public class FileChangeListener implements FileAlterationListener{
	Wini ini;
	Producer producer;
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
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
		if(file.length()>(Integer.parseInt(ini.get("param","maxFileSize"))*1048576)) {
			System.out.println(sdf.format(new Date())+"-----"+file.getName()+"----------文件过大无法发送");
		}else {
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
			if("1".equals(ini.get("param","ifZip"))) {
				//if("1".equals(ini.get("param","ifZip"))&&!("zip".equals(file.getName().substring(file.getName().lastIndexOf(".")+1)))) {
				File zipFile = null;
				try {
					zipFile=ZipUtils.zipFile(file.getPath());
				} catch (IOException e) {
					logUtils.writeLog(file.getPath()+"-----压缩文件失败");
					System.out.println(sdf.format(new Date())+"-----"+file.getPath()+"-----压缩文件失败");
					e.printStackTrace();
				}
				producer.sendMessage("file",zipFile,zipath,ini.get("param","ifBackup"),ini.get("param","backupPath"));
	            //删除文件
	            if (zipFile.exists()&&zipFile.isFile()){
	            	zipFile.delete();
	            }
			}else {
				producer.sendMessage("file",file,zipath,ini.get("param","ifBackup"),ini.get("param","backupPath"));
			}
			
            //是否备份文件
            if("1".equals(ini.get("param","ifBackup"))) {
            	File backFile=new File(ini.get("param","backupPath")+zipath);
            	if(!backFile.exists()) {
            		backFile.mkdirs();
            	}
            	file.renameTo(new File(ini.get("param","backupPath")+zipath+"\\"+file.getName()));
            }
            //删除文件
            if (file.exists()&&file.isFile()){
                file.delete();
            }
		}
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
