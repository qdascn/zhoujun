package cn.qdas;

import java.io.File;

import org.apache.commons.io.monitor.FileAlterationMonitor;
import org.apache.commons.io.monitor.FileAlterationObserver;

public class TestForld {

	public static void main(String[] args) {
		/*FileChangeListener fcl=new FileChangeListener();
		FileAlterationObserver observer=new FileAlterationObserver("F:\\from");
		observer.addListener(fcl);
		FileAlterationMonitor monitor=new FileAlterationMonitor(1000);
		monitor.addObserver(observer);
		try {
			monitor.start();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		File file=new File("F:\\from\\Testbeispiel 5_201942_215734.PDF");
		file.renameTo(new File("F:\\sink\\Testbeispiel 5_201942_215734.PDF"));
	}

}
