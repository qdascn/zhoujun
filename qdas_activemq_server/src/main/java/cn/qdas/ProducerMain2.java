package cn.qdas;



public class ProducerMain2 {
	/*public static void main(String[] args) {
		ExecutorService threadPool=Executors.newCachedThreadPool();
		Properties pro = null;
		try {
			//pro=PropertiesUtils.readProperties(System.getProperty("user.dir")+"/setting.properties");
			pro=PropertiesUtils.readProperties(System.getProperty("user.dir")+"/src\\main\\java\\cn\\qdas/setting.properties");
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		Producer producer=new Producer(pro.getProperty("userName"),pro.getProperty("password"),pro.getProperty("url"));
		//producer.init();
		//producer.getReback();
		Path path=Paths.get(pro.getProperty("folder"));
		try(WatchService watchService = FileSystems.getDefault().newWatchService()){
			path.register(watchService, StandardWatchEventKinds.ENTRY_CREATE,
					StandardWatchEventKinds.ENTRY_MODIFY,
                    StandardWatchEventKinds.ENTRY_DELETE);
			 while (true) {
	                final WatchKey key = watchService.take();

	                for (WatchEvent<?> watchEvent : key.pollEvents()) {

	                    final WatchEvent.Kind<?> kind = watchEvent.kind();
	                 // get the filename for the event
	                    final WatchEvent<Path> watchEventPath = (WatchEvent<Path>) watchEvent;
	                    final Path filename = watchEventPath.context();
	                    if (kind == StandardWatchEventKinds.OVERFLOW) {
	                        continue;
	                    }
	                    //创建事件
	                    if (kind == StandardWatchEventKinds.ENTRY_CREATE) {
	                    	System.out.println("发现新文件" + " -> " + path.toString()+"\\"+filename);
	                        threadPool.execute(new Runnable() {
	                			@Override
	                			public void run() {
	                				System.out.println(path.toString()+"\\"+filename);
	                				producer.sendMessage("file", new File(path.toString()+"\\"+filename),"");
	                				
	                			}
	                		});
	                    }
	                    //修改事件
	                    if (kind == StandardWatchEventKinds.ENTRY_MODIFY) {
	                       // System.out.println("修改]");
	                    }
	                    //删除事件
	                    if (kind == StandardWatchEventKinds.ENTRY_DELETE) {
	                        //System.out.println("[删除]");
	                    }
	                }
	                boolean valid = key.reset();
	                if (!valid) {
	                    break;
	                }
	            }
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
			
	}*/
}
