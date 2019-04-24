package cn.qdas;

import java.io.File;

import org.apache.commons.io.monitor.FileAlterationListener;
import org.apache.commons.io.monitor.FileAlterationObserver;

public class FileChangeListener implements FileAlterationListener{
	public void onStart(final FileAlterationObserver observer) {
		System.out.println("======onStart");
	}
	public void onDirectoryCreate(final File directory) {
		System.out.println(directory.getName()+"======onDirectoryCreate");
    }
	public void onDirectoryChange(final File directory) {
		System.out.println(directory.getName()+"======onDirectoryChange");
	}
	public void onDirectoryDelete(final File directory) {
		System.out.println(directory.getName()+"======onDirectoryDelete");
    }
	public void onFileCreate(final File file) {
		System.out.println(file.getName()+"======onFileCreate");
		System.out.println(file.getPath());
    }
	public void onFileChange(final File file) {
		System.out.println(file.getName()+"======onFileChange");
    }

    public void onFileDelete(final File file) {
    	System.out.println(file.getName()+"======onFileDelete");
    }

    public void onStop(final FileAlterationObserver observer) {
    	System.out.println("======onStop");
    }
}
