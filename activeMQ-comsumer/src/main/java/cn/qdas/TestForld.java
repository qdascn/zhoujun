package cn.qdas;

import java.io.File;
import java.io.IOException;


public class TestForld {

	public static void main(String[] args){
		String dest="F:\\backup\\001531++F01R10P983++高压燃油分配管++01++WXP2QMP2++WXP2.zip";
		String src="F:\\from";
		File file=new File(dest);
		System.out.println(EncodingDetect.getJavaEncode(dest));
		try {
			ZipUtils.unzip(dest, "F:\\backup");
		} catch (IOException e) {
			System.out.println("AAAA");
			e.printStackTrace();
		}
	}

}
