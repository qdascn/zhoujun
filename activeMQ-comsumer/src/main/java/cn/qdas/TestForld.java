package cn.qdas;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.monitor.FileAlterationMonitor;
import org.apache.commons.io.monitor.FileAlterationObserver;

public class TestForld {

	public static void main(String[] args) {
		String dest="F:\\backup\\001532++F01R10P878++高压燃油分配管++02++WXP2QMP2++WXP2.DFQ";
		String src="F:\\from";
		File file=new File(dest);
		System.out.println(file.getPath());
		System.out.println(file.getPath().substring(0,file.getPath().lastIndexOf(".")));
	}

}
