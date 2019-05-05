package cn.qdas;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.ini4j.Wini;


public class logUtils {
	public static void writeLog(String logStr){
		Wini ini = null;
		FileOutputStream fos = null;
		OutputStreamWriter osw = null;
		BufferedWriter write = null;
		try {
			//ini=new Wini(new File(System.getProperty("user.dir")+"/config.ini"));
			ini=new Wini(new File(System.getProperty("user.dir")+"/src\\main\\java\\cn\\qdas/config.ini"));
			File logFile=new File(ini.get("param","logPath")+"/q-das-receiver.log");
			if(!logFile.exists()) {
				logFile.createNewFile();
			}
			fos=new FileOutputStream(logFile,true);
			osw=new OutputStreamWriter(fos, "UTF-8");
			write=new BufferedWriter(osw);
			Date date=new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String fdate=sdf.format(date);
			write.write(fdate+"---"+logStr+"\r\n");
		} catch (IOException e) {
			e.printStackTrace();
			System.err.println("读取配置文件错误");
		}finally {
			try {
				write.close();
				osw.close();
				fos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
