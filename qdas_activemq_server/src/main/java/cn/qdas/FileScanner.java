package cn.qdas;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileScanner {
	public static List getInitFiles(String [] paths,int fileSize) {
		List fileList=new ArrayList<File>();
		for(int i=0;i<paths.length;i++) {
			File file=new File(paths[i]);
			findFiles(file,fileList,fileSize);
		}
		return fileList;
	}
	
	public static void findFiles(File file,List fileList,int fileSize) {
		if(!file.isDirectory()&&file.length()<fileSize*1048576) {
			fileList.add(file);
		}
		if(file.isDirectory()) {
			File[] dFile=file.listFiles();
			for(int i=0;i<dFile.length;i++) {
				findFiles(dFile[i],fileList,fileSize);
			}
		}
	}
}
