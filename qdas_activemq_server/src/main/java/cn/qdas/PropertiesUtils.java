package cn.qdas;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;

public class PropertiesUtils {
	public static Properties readProperties(String filePath) throws FileNotFoundException, IOException{
		Properties properties=new Properties();
		properties.load(new InputStreamReader(new FileInputStream(new File(filePath)), "utf-8") );
		return properties;
	}
}
